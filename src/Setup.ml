open Js.Promise

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

  let runSetupChain esyCmd envWithUnzip eventEmitter folder =
    let open Bindings in
    let hiddenEsyRoot = Path.join [| folder; ".vscode"; "esy" |] in
    Rimraf.run hiddenEsyRoot
    |> then_ (function
         | Error () ->
           Error
             {j| Rimraf failed before the bsb toolchain setup: $hiddenEsyRoot |j}
           |> resolve
         | Ok () ->
           Fs.mkdir ~p:true hiddenEsyRoot
           |> then_ (function
                | Ok () -> Ok () |> resolve
                | Error Fs.E.PathNotFound ->
                  Error
                    {j| Setup failed with because of invalid path provided to it: $hiddenEsyRoot |j}
                  |> resolve))
    |> then_ (function
         | Error e -> Error e |> resolve
         | Ok () ->
           Filename.concat hiddenEsyRoot "esy.json"
           |> dropAnEsyJSON
           |> then_ (fun () -> resolve (Ok ())))
    |> then_ (function
         | Error e -> Error e |> resolve
         | Ok () ->
           Cmd.output esyCmd ~cwd:hiddenEsyRoot
             ~args:[| "install"; "-P"; hiddenEsyRoot |]
           |> then_ (function
                | Error msg ->
                  Error ("'esy install' failed. Reason: " ^ msg) |> resolve
                | Ok _stdout ->
                  reportProgress eventEmitter 0.1;
                  AzurePipelines.getBuildID ()
                  |> then_ (function
                       | Ok id ->
                         id |> AzurePipelines.getDownloadURL
                         |> Js.Promise.then_ (function
                              | Ok url -> resolve (Ok url)
                              | Error msg ->
                                Error
                                  {j| Azure artifacts cache failure: $msg |j}
                                |> resolve)
                       | Error msg ->
                         Error {j| Azure artifacts cache failure: $msg |j}
                         |> resolve)
                  |> then_ (function
                       | Ok url -> Ok url |> resolve
                       | Error e -> Error e |> resolve)))
    |> then_ (function
         | Ok downloadUrl ->
           Js.log2 "download" downloadUrl;
           let lastProgress = ref 0.0 in
           Js.Promise.make (fun ~resolve ~reject:_ ->
               download downloadUrl
                 (Path.join [| hiddenEsyRoot; "cache.zip" |])
                 ~progress:(fun progressFraction ->
                   let percent = progressFraction *. 80.0 in
                   reportProgress eventEmitter (percent -. !lastProgress);
                   lastProgress := percent)
                 ~data:(fun _ -> ())
                 ~error:(fun _ ->
                   (resolve (Error "Azure artifacts cache failure: ") [@bs]))
                 ~end_:(fun () -> (resolve (Ok ()) [@bs])))
         | Error cacheFailureReason -> resolve (Error cacheFailureReason))
    |> then_ (function
         | Ok () ->
           reportProgress eventEmitter 93.33;
           Cmd.make ~cmd:"unzip" ~env:envWithUnzip
           |> Js.Promise.then_ (function
                | Error msg -> Js.Promise.resolve (Error msg)
                | Ok unzip ->
                  Cmd.output unzip ~args:[| "cache.zip" |] ~cwd:hiddenEsyRoot)
           |> then_ (function
                | Error unzipCmdError ->
                  Error {j| Azure artifacts cache failure: $unzipCmdError |j}
                  |> resolve
                | Ok _unzipCmdOutput -> resolve (Ok ()))
         | Error e -> Error e |> resolve)
    |> then_ (function
         | Ok () ->
           reportProgress eventEmitter 96.66;
           Cmd.output esyCmd ~cwd:hiddenEsyRoot
             ~args:[| "import-dependencies"; "-P"; hiddenEsyRoot |]
           |> then_ (fun r ->
                  resolve
                    ( match r with
                    | Ok _ -> Ok ()
                    | Error msg ->
                      Error ("'esy import-dependencies' failed. Reason: " ^ msg)
                    ))
         | Error e -> resolve (Error e))
    |> then_ (function
         | Error e -> Error e |> resolve
         | Ok () ->
           reportProgress eventEmitter 99.99;
           Cmd.output esyCmd ~cwd:hiddenEsyRoot
             ~args:[| "build"; "-P"; hiddenEsyRoot |]
           |> then_ (fun r ->
                  resolve
                    ( match r with
                    | Ok _esyCmdOutput -> Ok ()
                    | Error msg -> Error ("'esy build' failed. Reason: " ^ msg)
                    )))

  let run esyCmd esyEnv eventEmitter projectPath =
    let open Bindings in
    let projectPath = Path.join [| projectPath; ".."; ".." |] in
    let manifestPath = Path.join [| projectPath; "package.json" |] in
    let open Js.Promise in
    Fs.readFile manifestPath
    |> then_ (fun manifest ->
           match Json.parse manifest with
           | Some json -> (
             match json |> CheckBucklescriptCompat.run with
             | Ok () -> runSetupChain esyCmd esyEnv eventEmitter projectPath
             | Error msg ->
               resolve (Error {j| BucklescriptCompatFailure: $msg |j}) )
           | None ->
             Error ("Failed to parse manifest at " ^ manifestPath)
             |> Js.Promise.resolve)
    |> then_ (function
         | Ok () ->
           reportEnd eventEmitter;
           resolve ()
         | Error e ->
           reportError eventEmitter e;
           resolve ())
end
