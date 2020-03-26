open Utils
open Bindings

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

  let cacheFileName = "cache.zip"

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
    |> Promise.map (function
         | Error Fs.E.PathNotFound ->
           Error
             {j| Setup failed with because of invalid path provided to it: $esyRoot |j}
         | Ok () -> Ok ())

  let writeEsyJson ~esyRoot =
    Filename.concat esyRoot "esy.json"
    |> dropEsyJSON
    |> Promise.map (fun () -> Ok ())

  let installDepsWithEsy ~esyRoot ~esyCmd =
    Cmd.output esyCmd ~cwd:esyRoot ~args:[| "install"; "-P"; esyRoot |]
    |> Promise.map (function
         | Error msg -> Error ("'esy install' failed. Reason: " ^ msg)
         | Ok _stdout -> Ok ())

  let getArtifactsUrl ~eventEmitter =
    reportProgress eventEmitter 0.1;
    AzurePipelines.getBuildId ()
    |> Promise.then_ (function
         | Error msg ->
           Error {j| Azure artifacts cache failure: $msg |j} |> Promise.resolve
         | Ok id ->
           id |> AzurePipelines.getDownloadUrl
           |> Promise.map (function
                | Error msg -> Error {j| Azure artifacts cache failure: $msg |j}
                | Ok url -> Ok url))

  let downloadArtifacts ~esyRoot ~eventEmitter url =
    Js.Console.info2 "download" url;
    let lastProgress = ref 0.0 in
    Promise.make (fun ~resolve ~reject:_ ->
        download url
          (Path.join [| esyRoot; cacheFileName |])
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
    |> Promise.Result.bind (fun unzip ->
           Cmd.output unzip ~args:[| cacheFileName |] ~cwd:esyRoot)
    |> Promise.map (function
         | Error unzipCmdError ->
           Error {j| Azure artifacts cache failure: $unzipCmdError |j}
         | Ok _unzipCmdOutput -> Ok ())

  let importDownloadedDependencies ~esyRoot ~esyCmd =
    Cmd.output esyCmd ~cwd:esyRoot
      ~args:[| "import-dependencies"; "-P"; esyRoot |]
    |> Promise.map (function
         | Error msg ->
           Error ("'esy import-dependencies' failed. Reason: " ^ msg)
         | Ok _ -> Ok ())

  let buildDependencies ~esyRoot ~esyCmd ~eventEmitter =
    reportProgress eventEmitter 99.99;
    (* See comment at the top explaining the 99.99 *)
    Cmd.output esyCmd ~cwd:esyRoot ~args:[| "build"; "-P"; esyRoot |]
    |> Promise.map (function
         | Error msg -> Error ("'esy build' failed. Reason: " ^ msg)
         | Ok _esyCmdOutput -> Ok ())

  let runSetupChain ~esyCmd ~envWithUnzip ~eventEmitter ~folder =
    let open Bindings in
    let esyRoot = Fpath.toString (hiddenEsyDir (Fpath.ofString folder)) in
    Rimraf.run esyRoot
    |> Promise.then_ (function
         | Error () ->
           Error {j| Rimraf failed before the bsb toolchain setup: $esyRoot |j}
           |> Promise.resolve
         | Ok () -> createEsyFolder ~esyRoot)
    |> Promise.Result.bind (fun () -> writeEsyJson ~esyRoot)
    |> Promise.Result.bind (fun () -> installDepsWithEsy ~esyRoot ~esyCmd)
    |> Promise.Result.bind (fun _ -> getArtifactsUrl ~eventEmitter)
    |> Promise.Result.bind (fun downloadUrl ->
           downloadArtifacts ~esyRoot ~eventEmitter downloadUrl)
    |> Promise.Result.bind (fun () -> unzipArtifacts ~esyRoot ~envWithUnzip)
    |> Promise.Result.bind (fun () ->
           importDownloadedDependencies ~esyRoot ~esyCmd)
    |> Promise.Result.bind (fun () ->
           buildDependencies ~esyRoot ~esyCmd ~eventEmitter)

  let run esyCmd esyEnv eventEmitter projectPath =
    let projectPath = Path.join [| projectPath; ".."; ".." |] in
    let manifestPath = Path.join [| projectPath; "package.json" |] in
    Fs.readFile manifestPath
    |> Promise.then_ (fun manifest ->
           match Json.parse manifest with
           | Some json -> (
             match CheckBucklescriptCompat.run json with
             | Error msg ->
               Error {j| BucklescriptCompatFailure: $msg |j} |> Promise.resolve
             | Ok () ->
               runSetupChain ~esyCmd ~envWithUnzip:esyEnv ~eventEmitter
                 ~folder:projectPath )
           | None ->
             Error ("Failed to parse manifest at " ^ manifestPath)
             |> Promise.resolve)
    |> Promise.map (function
         | Error e -> reportError eventEmitter e
         | Ok () -> reportEnd eventEmitter)
end
