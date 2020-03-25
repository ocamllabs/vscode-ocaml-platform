open Utils
open Bindings
module P = Js.Promise

(* Why the are progress percentages hardcoded the way they are?

   Azure's REST API doesn't set the file size of the zip file in the headers.
   This makes it hard to report download progress correctly. We work around this
   by assuming that the download process takes up 80% of the setup time and
   assign some approximate hardcoded time for the rest of the setups *)

module Internal = struct
  type t (* event emitter *)

  external makeEventEmitter : unit -> t = "events" [@@bs.module] [@@bs.new]

  external onProgress' : t -> string -> (float -> unit) -> unit = "on"
    [@@bs.send]

  let onProgress t cb = onProgress' t "progress" cb

  external onEnd' : t -> string -> (unit -> unit) -> unit = "on" [@@bs.send]

  let onEnd t cb = onEnd' t "end" cb

  external onError' : t -> string -> (string -> unit) -> unit = "on" [@@bs.send]

  let onError t cb = onError' t "error" cb

  external reportProgress' : t -> string -> float -> unit = "emit" [@@bs.send]

  let reportProgress t v = reportProgress' t "progress" v

  external reportEnd' : t -> string -> unit = "emit" [@@bs.send]

  let reportEnd t = reportEnd' t "end"

  external reportError' : t -> string -> string -> unit = "emit" [@@bs.send]

  let reportError t errorMsg = reportError' t "error" errorMsg
end

module Bsb = struct
  include Internal

  let download url file ~progress ~end_ ~error ~data =
    let open Bindings in
    let stream = RequestProgress.requestProgress (Request.request url) in
    RequestProgress.onProgress stream (fun state ->
        progress
          (float_of_int state##size##transferred /. (134. *. 1024. *. 1024.)));
    RequestProgress.onData stream data;
    RequestProgress.onEnd stream end_;
    RequestProgress.onError stream error;
    RequestProgress.pipe stream (Fs.createWriteStream file)

  let dropEsyJSON path = Bindings.Fs.writeFile path Bindings.thisProjectsEsyJson

  let make () = makeEventEmitter ()

  let createEsyFolder ~esyRoot =
    Fs.mkdir ~p:true esyRoot
    |> P.then_ (function
         | Error Fs.E.PathNotFound ->
           Error
             {j| Setup failed with because of invalid path provided to it: $esyRoot |j}
           |> P.resolve
         | Ok () -> Ok () |> P.resolve)

  let writeEsyJson ~esyRoot =
    Filename.concat esyRoot "esy.json"
    |> dropEsyJSON
    |> P.then_ (fun () -> Ok () |> P.resolve)

  let installDepsWithEsy ~esyRoot ~esyCmd =
    Cmd.output esyCmd ~cwd:esyRoot ~args:[| "install"; "-P"; esyRoot |]
    |> P.then_ (function
         | Error msg ->
           Error ("'esy install' failed. Reason: " ^ msg) |> P.resolve
         | Ok _stdout -> Ok () |> P.resolve)

  let getArtifactsUrl ~eventEmitter =
    reportProgress eventEmitter 0.1;
    AzurePipelines.getBuildID ()
    |> P.then_ (function
         | Error msg ->
           Error {j| Azure artifacts cache failure: $msg |j} |> P.resolve
         | Ok id ->
           id |> AzurePipelines.getDownloadURL
           |> P.then_ (function
                | Error msg ->
                  Error {j| Azure artifacts cache failure: $msg |j} |> P.resolve
                | Ok url -> Ok url |> P.resolve))

  let downloadArtifacts ~esyRoot ~eventEmitter url =
    Js.Console.info2 "download" url;
    let lastProgress = ref 0.0 in
    P.make (fun ~resolve ~reject:_ ->
        download url
          (Path.join [| esyRoot; "cache.zip" |])
          ~progress:(fun progressFraction ->
            (* The cache restoration is assumed to take up 80%. More
               explanation at the top *)
            let percent = progressFraction *. 80.0 in
            reportProgress eventEmitter (percent -. !lastProgress);
            lastProgress := percent)
          ~data:(fun _ -> ())
          ~error:(fun _ ->
            (resolve (Error "Azure artifacts cache failure: ") [@bs]))
          ~end_:(fun () ->
            (* See comment at the top explaining 96.66 *)
            reportProgress eventEmitter 93.33;
            (resolve (Ok ()) [@bs])))

  let unzipArtifacts ~esyRoot ~envWithUnzip =
    Cmd.make ~cmd:"unzip" ~env:envWithUnzip
    |> P.then_ (function
         | Error msg -> P.resolve (Error msg)
         | Ok unzip -> Cmd.output unzip ~args:[| "cache.zip" |] ~cwd:esyRoot)
    |> P.then_ (function
         | Error unzipCmdError ->
           Error {j| Azure artifacts cache failure: $unzipCmdError |j}
           |> P.resolve
         | Ok _unzipCmdOutput -> P.resolve (Ok ()))

  let importDownloadedDependencies ~esyRoot ~esyCmd =
    Cmd.output esyCmd ~cwd:esyRoot
      ~args:[| "import-dependencies"; "-P"; esyRoot |]
    |> P.then_ (function
         | Error msg ->
           Error ("'esy import-dependencies' failed. Reason: " ^ msg)
           |> P.resolve
         | Ok _ -> Ok () |> P.resolve)

  let buildDependencies ~esyRoot ~esyCmd ~eventEmitter =
    reportProgress eventEmitter 99.99;
    (* See comment at the top explaining the 99.99 *)
    Cmd.output esyCmd ~cwd:esyRoot ~args:[| "build"; "-P"; esyRoot |]
    |> P.then_ (function
         | Error msg ->
           Error ("'esy build' failed. Reason: " ^ msg) |> P.resolve
         | Ok _esyCmdOutput -> Ok () |> P.resolve)

  let runSetupChain ~esyCmd ~envWithUnzip ~eventEmitter ~folder =
    let open Bindings in
    let esyRoot = Path.join [| folder; ".vscode"; "esy" |] in
    Rimraf.run esyRoot
    |> P.then_ (function
         | Error () ->
           Error {j| Rimraf failed before the bsb toolchain setup: $esyRoot |j}
           |> P.resolve
         | Ok () -> createEsyFolder ~esyRoot)
    |> thenMap (fun () -> writeEsyJson ~esyRoot)
    |> thenMap (fun () -> installDepsWithEsy ~esyRoot ~esyCmd)
    |> thenMap (fun _ -> getArtifactsUrl ~eventEmitter)
    |> thenMap (fun downloadUrl ->
           downloadArtifacts ~esyRoot ~eventEmitter downloadUrl)
    |> thenMap (fun () -> unzipArtifacts ~esyRoot ~envWithUnzip)
    |> thenMap (fun () -> importDownloadedDependencies ~esyRoot ~esyCmd)
    |> thenMap (fun () -> buildDependencies ~esyRoot ~esyCmd ~eventEmitter)

  let run esyCmd esyEnv eventEmitter projectPath =
    let projectPath = Path.join [| projectPath; ".."; ".." |] in
    let manifestPath = Path.join [| projectPath; "package.json" |] in
    Fs.readFile manifestPath
    |> P.then_ (fun manifest ->
           match Json.parse manifest with
           | Some json -> (
             match CheckBucklescriptCompat.run json with
             | Error msg ->
               Error {j| BucklescriptCompatFailure: $msg |j} |> P.resolve
             | Ok () ->
               runSetupChain ~esyCmd ~envWithUnzip:esyEnv ~eventEmitter
                 ~folder:projectPath )
           | None ->
             Error ("Failed to parse manifest at " ^ manifestPath) |> P.resolve)
    |> P.then_ (function
         | Error e -> reportError eventEmitter e |> P.resolve
         | Ok () -> reportEnd eventEmitter |> P.resolve)
end
