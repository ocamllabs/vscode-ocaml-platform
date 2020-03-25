open Bindings
module P = Js.Promise

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

  let dropAnEsyJSON path =
    Bindings.Fs.writeFile path Bindings.thisProjectsEsyJson

  let make () = makeEventEmitter ()

  (* Why the are progress percentages hardcoded the way they are?

   Azure's REST API doesn't set the file size of the zip file in the headers.
   This makes it hard to report download progress correctly. We work around this
   by assuming that the download process takes up 80% of the setup time and
   assign some approximate hardcoded time for the rest of the setups *)

  let runSetupChain esyCmd envWithUnzip eventEmitter folder =
    let open Bindings in
    let hiddenEsyRoot = Path.join [| folder; ".vscode"; "esy" |] in
    Rimraf.run hiddenEsyRoot
    |> P.then_ (function
         | Error () ->
           Error
             {j| Rimraf failed before the bsb toolchain setup: $hiddenEsyRoot |j}
           |> P.resolve
         | Ok () ->
           Fs.mkdir ~p:true hiddenEsyRoot
           |> P.then_ (function
                | Ok () -> Ok () |> P.resolve
                | Error Fs.E.PathNotFound ->
                  Error
                    {j| Setup failed with because of invalid path provided to it: $hiddenEsyRoot |j}
                  |> P.resolve))
    |> P.then_ (function
         | Error e -> Error e |> P.resolve
         | Ok () ->
           Filename.concat hiddenEsyRoot "esy.json"
           |> dropAnEsyJSON
           |> P.then_ (fun () -> P.resolve (Ok ())))
    |> P.then_ (function
         | Error e -> Error e |> P.resolve
         | Ok () ->
           Cmd.output esyCmd ~cwd:hiddenEsyRoot
             ~args:[| "install"; "-P"; hiddenEsyRoot |]
           |> P.then_ (function
                | Error msg ->
                  Error ("'esy install' failed. Reason: " ^ msg) |> P.resolve
                | Ok _stdout ->
                  reportProgress eventEmitter 0.1;
                  (* See comment at the bottom *)
                  AzurePipelines.getBuildID ()
                  |> P.then_ (function
                       | Ok id ->
                         id |> AzurePipelines.getDownloadURL
                         |> P.then_ (function
                              | Ok url -> P.resolve (Ok url)
                              | Error msg ->
                                Error
                                  {j| Azure artifacts cache failure: $msg |j}
                                |> P.resolve)
                       | Error msg ->
                         Error {j| Azure artifacts cache failure: $msg |j}
                         |> P.resolve)
                  |> P.then_ (function
                       | Ok url -> Ok url |> P.resolve
                       | Error e -> Error e |> P.resolve)))
    |> P.then_ (function
         | Ok downloadUrl ->
           Js.log2 "download" downloadUrl;
           let lastProgress = ref 0.0 in
           P.make (fun ~resolve ~reject:_ ->
               download downloadUrl
                 (Path.join [| hiddenEsyRoot; "cache.zip" |])
                 ~progress:(fun progressFraction ->
                   let percent = progressFraction *. 80.0 in
                   (* The cache restoration is assumed to take up 80%. More
                      explanation at the bottom *)
                   reportProgress eventEmitter (percent -. !lastProgress);
                   lastProgress := percent)
                 ~data:(fun _ -> ())
                 ~error:(fun _ ->
                   (resolve (Error "Azure artifacts cache failure: ") [@bs]))
                 ~end_:(fun () -> (resolve (Ok ()) [@bs])))
         | Error cacheFailureReason -> P.resolve (Error cacheFailureReason))
    |> P.then_ (function
         | Ok () ->
           reportProgress eventEmitter 93.33;
           (* See comment at the bottom explaining 93.33 *)
           Cmd.make ~cmd:"unzip" ~env:envWithUnzip
           |> P.then_ (function
                | Error msg -> P.resolve (Error msg)
                | Ok unzip ->
                  Cmd.output unzip ~args:[| "cache.zip" |] ~cwd:hiddenEsyRoot)
           |> P.then_ (function
                | Error unzipCmdError ->
                  Error {j| Azure artifacts cache failure: $unzipCmdError |j}
                  |> P.resolve
                | Ok _unzipCmdOutput -> P.resolve (Ok ()))
         | Error e -> Error e |> P.resolve)
    |> P.then_ (function
         | Ok () ->
           reportProgress eventEmitter 96.66;
           (* See comment at the bottom explaining 96.66 *)
           Cmd.output esyCmd ~cwd:hiddenEsyRoot
             ~args:[| "import-dependencies"; "-P"; hiddenEsyRoot |]
           |> P.then_ (fun r ->
                  P.resolve
                    ( match r with
                    | Ok _ -> Ok ()
                    | Error msg ->
                      Error ("'esy import-dependencies' failed. Reason: " ^ msg)
                    ))
         | Error e -> P.resolve (Error e))
    |> P.then_ (function
         | Error e -> Error e |> P.resolve
         | Ok () ->
           reportProgress eventEmitter 99.99;
           (* See comment at the bottom explaining the 99.99 *)
           Cmd.output esyCmd ~cwd:hiddenEsyRoot
             ~args:[| "build"; "-P"; hiddenEsyRoot |]
           |> P.then_ (fun r ->
                  P.resolve
                    ( match r with
                    | Ok _esyCmdOutput -> Ok ()
                    | Error msg -> Error ("'esy build' failed. Reason: " ^ msg)
                    )))

  let run esyCmd esyEnv eventEmitter projectPath =
    let projectPath = Path.join [| projectPath; ".."; ".." |] in
    let manifestPath = Path.join [| projectPath; "package.json" |] in
    Fs.readFile manifestPath
    |> P.then_ (fun manifest ->
           match Json.parse manifest with
           | Some json -> (
             match json |> CheckBucklescriptCompat.run with
             | Ok () -> runSetupChain esyCmd esyEnv eventEmitter projectPath
             | Error msg ->
               P.resolve (Error {j| BucklescriptCompatFailure: $msg |j}) )
           | None ->
             Error ("Failed to parse manifest at " ^ manifestPath) |> P.resolve)
    |> P.then_ (function
         | Ok () ->
           reportEnd eventEmitter;
           P.resolve ()
         | Error e ->
           reportError eventEmitter e;
           P.resolve ())
end
