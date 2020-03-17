open Js.Promise

module type T = sig
  type t

  val make : unit -> t

  val onProgress : t -> (float -> unit) -> unit

  val onEnd : t -> (unit -> unit) -> unit

  val onError : t -> (string -> unit) -> unit

  val reportProgress : t -> float -> unit

  val reportEnd : t -> unit

  val reportError : t -> string -> unit

  val run : t -> string -> unit Js.Promise.t
end

module Internal = struct
  type t

  external make : unit -> t = "events" [@@bs.module] [@@bs.new]

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

module Esy = struct
  open Bindings.ChildProcess
  include Internal

  let make () = make ()

  let run eventEmitter projectPath =
    reportProgress eventEmitter 0.1;
    exec "esy" (Options.make ~cwd:projectPath ())
    |> then_ (fun _ ->
           reportProgress eventEmitter 1.;
           reportEnd eventEmitter;
           resolve ())
end

module Opam = struct
  include Internal

  let make () = make ()

  let run eventEmitter _ =
    reportProgress eventEmitter 1.;
    reportEnd eventEmitter;
    resolve ()
end

module Bsb = struct
  module E = struct
    type t =
      | RimrafFailed of string
      | SetupChainFailure of string
      | CacheFailure of string
      | EsyBuildFailure of string
      | EsyImportDependenciesFailure
      | EsyInstallFailure of string
      | BucklescriptCompatFailure of CheckBucklescriptCompat.E.t
      | InvalidPath of string
      | Failure of string

    let toString = function
      | RimrafFailed msg ->
        {j| Rimraf failed before the bsb toolchain setup: $msg |j}
      | SetupChainFailure msg -> {j|Setup failed: $msg|j}
      | EsyBuildFailure msg -> "'esy build' failed. Reason: " ^ msg
      | EsyImportDependenciesFailure -> "'esy import-dependencies' failed"
      | EsyInstallFailure msg -> "'esy install' failed. Reason: " ^ msg
      | BucklescriptCompatFailure e ->
        let msg = CheckBucklescriptCompat.E.toString e in
        {j| BucklescriptCompatFailure: $msg |j}
      | CacheFailure msg -> {j| Azure artifacts cache failure: $msg |j}
      | Failure reason -> {j| Bsb setup failed. Reason: $reason |j}
      | InvalidPath p ->
        {j| Setup failed with because of invalid path provided to it: $p |j}
  end

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

  let make () = make ()

  let runSetupChain eventEmitter folder =
    let open Bindings in
    let hiddenEsyRoot = Path.join [| folder; ".vscode"; "esy" |] in
    Rimraf.run hiddenEsyRoot
    |> then_ (function
         | Error () -> Error (E.RimrafFailed hiddenEsyRoot) |> resolve
         | Ok () ->
           Fs.mkdir ~p:true hiddenEsyRoot
           |> then_ (function
                | Ok () -> Ok () |> resolve
                | Error Fs.E.PathNotFound ->
                  Error (E.InvalidPath hiddenEsyRoot) |> resolve))
    |> then_ (function
         | Error e -> Error e |> resolve
         | Ok () ->
           Filename.concat hiddenEsyRoot "esy.json"
           |> dropAnEsyJSON
           |> then_ (fun () -> resolve (Ok ())))
    |> then_ (function
         | Error e -> Error e |> resolve
         | Ok () ->
           Command.Esy.install ~p:hiddenEsyRoot
           |> then_ (function
                | Error e ->
                  Error (E.EsyInstallFailure (Command.Esy.E.toString e))
                  |> resolve
                | Ok _stdout ->
                  reportProgress eventEmitter 0.1;
                  AzurePipelines.getBuildID ()
                  |> then_ (function
                       | Ok id ->
                         id |> AzurePipelines.getDownloadURL
                         |> Js.Promise.then_ (function
                              | Ok url -> resolve (Ok url)
                              | Error msg ->
                                Error (E.CacheFailure msg) |> resolve)
                       | Error msg -> Error (E.CacheFailure msg) |> resolve)
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
                 ~error:(fun e ->
                   (resolve (Error (E.CacheFailure e##message)) [@bs]))
                 ~end_:(fun () -> (resolve (Ok ()) [@bs])))
         | Error cacheFailureReason -> resolve (Error cacheFailureReason))
    |> then_ (function
         | Ok () ->
           reportProgress eventEmitter 93.33;
           Command.Unzip.run ~p:hiddenEsyRoot "cache.zip"
           |> then_ (function
                | Error _unzipCmdError ->
                  Error (E.CacheFailure "Failed to unzip downloaded cache")
                  |> resolve
                | Ok _unzipCmdOutput -> resolve (Ok ()))
         | Error e -> Error e |> resolve)
    |> then_ (function
         | Ok () ->
           reportProgress eventEmitter 96.66;
           Command.Esy.importDependencies ~p:hiddenEsyRoot
           |> then_ (fun r ->
                  resolve
                    ( match r with
                    | Ok _ -> Ok ()
                    | Error _ -> Error E.EsyImportDependenciesFailure ))
         | Error e -> resolve (Error e))
    |> then_ (function
         | Error e -> Error e |> resolve
         | Ok () ->
           reportProgress eventEmitter 99.99;
           Command.Esy.build ~p:hiddenEsyRoot
           |> then_ (fun r ->
                  resolve
                    ( match r with
                    | Ok _esyCmdOutput -> Ok ()
                    | Error e ->
                      Error (E.EsyBuildFailure (Command.Esy.E.toString e)) )))

  let run eventEmitter projectPath =
    let open Bindings in
    let manifestPath = Path.join [| projectPath; "package.json" |] in
    let open Js.Promise in
    let folder = Filename.dirname manifestPath in
    Fs.readFile manifestPath
    |> then_ (fun manifest ->
           let open Option in
           (let open Json in
           parse manifest >>| CheckBucklescriptCompat.run >>| function
           | Ok () -> runSetupChain eventEmitter folder
           | Error e -> resolve (Error (E.BucklescriptCompatFailure e)))
           |> toPromise (E.SetupChainFailure "Failed to parse manifest file"))
    |> then_ (function
         | Ok () ->
           reportEnd eventEmitter;
           resolve ()
         | Error e ->
           reportError eventEmitter (E.toString e);
           resolve ())
end
