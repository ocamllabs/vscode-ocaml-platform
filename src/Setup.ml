open Bindings
open Js.Promise
module type T  =
  sig
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
module Internal =
  struct
    type t
    external make : unit -> t = "events"[@@bs.module ][@@bs.new ]
    external onProgress' : t -> string -> (float -> unit) -> unit = "on"
    [@@bs.send ]
    let onProgress t cb = onProgress' t "progress" cb
    external onEnd' : t -> string -> (unit -> unit) -> unit = "on"[@@bs.send
                                                                    ]
    let onEnd t cb = onEnd' t "end" cb
    external onError' : t -> string -> (string -> unit) -> unit = "on"
    [@@bs.send ]
    let onError t cb = onError' t "error" cb
    external reportProgress' : t -> string -> float -> unit = "emit"[@@bs.send
                                                                    ]
    let reportProgress t v = reportProgress' t "progress" v
    external reportEnd' : t -> string -> unit = "emit"[@@bs.send ]
    let reportEnd t = reportEnd' t "end"
    external reportError' : t -> string -> string -> unit = "emit"[@@bs.send
                                                                    ]
    let reportError t errorMsg = reportError' t "error" errorMsg
  end
module Esy =
  struct
    open ChildProcess
    include Internal
    let make () = make ()
    let run eventEmitter projectPath =
      reportProgress eventEmitter 0.1;
      (exec "esy" (Options.make ~cwd:projectPath ())) |>
        (then_
           (fun _ ->
              reportProgress eventEmitter 1.;
              reportEnd eventEmitter;
              resolve ()))
  end
module Opam =
  struct
    include Internal
    let make () = make ()
    let run eventEmitter _ =
      reportProgress eventEmitter 1.; reportEnd eventEmitter; resolve ()
  end
module Bsb =
  struct
    module E =
      struct
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
        let toString =
          function
          | ((RimrafFailed (msg))[@explicit_arity ]) ->
              {j| Rimraf failed before the bsb toolchain setup: $msg |j}
          | ((SetupChainFailure (msg))[@explicit_arity ]) ->
              {j|Setup failed: $msg|j}
          | ((EsyBuildFailure (msg))[@explicit_arity ]) ->
              "'esy build' failed. Reason: " ^ msg
          | EsyImportDependenciesFailure ->
              "'esy import-dependencies' failed"
          | ((EsyInstallFailure (msg))[@explicit_arity ]) ->
              "'esy install' failed. Reason: " ^ msg
          | ((BucklescriptCompatFailure (e))[@explicit_arity ]) ->
              let msg = CheckBucklescriptCompat.E.toString e in
              {j| BucklescriptCompatFailure: $msg |j}
          | ((CacheFailure (msg))[@explicit_arity ]) ->
              {j| Azure artifacts cache failure: $msg |j}
          | ((Failure (reason))[@explicit_arity ]) ->
              {j| Bsb setup failed. Reason: $reason |j}
          | ((InvalidPath (p))[@explicit_arity ]) ->
              {j| Setup failed with because of invalid path provided to it: $p |j}
      end
    open Utils
    include Internal
    let download url file ~progress  ~end_  ~error  ~data  =
      let stream = RequestProgress.requestProgress (Request.request url) in
      RequestProgress.onProgress stream
        (fun state ->
           progress
             ((float_of_int ((state ## size) ## transferred)) /.
                ((134. *. 1024.) *. 1024.)));
      RequestProgress.onData stream data;
      RequestProgress.onEnd stream end_;
      RequestProgress.onError stream error;
      RequestProgress.pipe stream (Fs.createWriteStream file)
    let dropAnEsyJSON path = Fs.writeFile path thisProjectsEsyJson
    let make () = make ()
    let run eventEmitter projectPath =
      let manifestPath = Path.join [|projectPath;"package.json"|] in
      let runSetupChain folder =
        let hiddenEsyRoot = Path.join [|folder;".vscode";"esy"|] in
        (((((((Rimraf.run hiddenEsyRoot) |>
                (then_
                   (function
                    | ((Error (()))[@explicit_arity ]) ->
                        ((Error
                            (((E.RimrafFailed (hiddenEsyRoot))
                              [@explicit_arity ])))
                          [@explicit_arity ]) |> resolve
                    | ((Ok (()))[@explicit_arity ]) ->
                        (Fs.mkdir ~p:true hiddenEsyRoot) |>
                          (then_
                             (function
                              | ((Ok (()))[@explicit_arity ]) ->
                                  ((Ok (()))[@explicit_arity ]) |> resolve
                              | ((Error
                                  (Fs.E.PathNotFound))[@explicit_arity ]) ->
                                  ((Error
                                      (((E.InvalidPath (hiddenEsyRoot))
                                        [@explicit_arity ])))
                                    [@explicit_arity ]) |> resolve)))))
               |>
               (then_
                  (function
                   | ((Error (e))[@explicit_arity ]) ->
                       ((Error (e))[@explicit_arity ]) |> resolve
                   | ((Ok (()))[@explicit_arity ]) ->
                       ((Filename.concat hiddenEsyRoot "esy.json") |>
                          dropAnEsyJSON)
                         |>
                         (then_
                            (fun () -> resolve ((Ok (()))[@explicit_arity ]))))))
              |>
              (then_
                 (function
                  | ((Error (e))[@explicit_arity ]) ->
                      ((Error (e))[@explicit_arity ]) |> resolve
                  | ((Ok (()))[@explicit_arity ]) ->
                      (Command.Esy.install ~p:hiddenEsyRoot) |>
                        (then_
                           (function
                            | ((Error (e))[@explicit_arity ]) ->
                                ((Error
                                    (((E.EsyInstallFailure
                                         ((Command.Esy.E.toString e)))
                                      [@explicit_arity ])))
                                  [@explicit_arity ]) |> resolve
                            | ((Ok (_stdout))[@explicit_arity ]) ->
                                (reportProgress eventEmitter 0.1;
                                 ((AzurePipelines.getBuildID ()) |>
                                    (then_
                                       (function
                                        | ((Ok (id))[@explicit_arity ]) ->
                                            AzurePipelines.getDownloadURL id
                                        | ((Error (e))[@explicit_arity ]) ->
                                            ((Error (e))[@explicit_arity ])
                                              |> resolve)))
                                   |>
                                   (then_
                                      (function
                                       | ((Ok (url))[@explicit_arity ]) ->
                                           ((Ok (url))[@explicit_arity ]) |>
                                             resolve
                                       | ((Error (e))[@explicit_arity ]) ->
                                           let open AzurePipelines.E in
                                             (match e with
                                              | DownloadFailure _
                                                |UnsupportedOS
                                                |InvalidJSONType _
                                                |MissingField _
                                                |InvalidFirstArrayElement
                                                |Failure _ ->
                                                  resolve
                                                    ((Error
                                                        (((E.CacheFailure
                                                             ("<TODO>"))
                                                          [@explicit_arity ])))
                                                    [@explicit_arity ]))))))))))
             |>
             (then_
                (function
                 | ((Ok (downloadUrl))[@explicit_arity ]) ->
                     (Js.log2 "download" downloadUrl;
                      (let lastProgress = ref 0.0 in
                       Js.Promise.make
                         (fun ~resolve ->
                            fun ~reject:_ ->
                              download downloadUrl
                                (Path.join [|hiddenEsyRoot;"cache.zip"|])
                                ~progress:(fun progressFraction ->
                                             let percent =
                                               progressFraction *. 80.0 in
                                             reportProgress eventEmitter
                                               (percent -. (!lastProgress));
                                             lastProgress := percent)
                                ~data:(fun _ -> ())
                                ~error:(fun e ->
                                          ((resolve
                                              ((Error
                                                  (((E.CacheFailure
                                                       ((e ## message)))
                                                    [@explicit_arity ])))
                                              [@explicit_arity ]))
                                          [@bs ]))
                                ~end_:(fun () ->
                                         ((resolve ((Ok (()))
                                             [@explicit_arity ]))
                                         [@bs ])))))
                 | ((Error
                     ((_thisIsWhereCacheFailureCouldBeReported : E.t)))
                     [@explicit_arity ]) ->
                     resolve
                       ((Error
                           (((E.CacheFailure ("Couldn't compute downloadUrl"))
                             [@explicit_arity ])))[@explicit_arity ]))))
            |>
            (then_
               (function
                | ((Ok (()))[@explicit_arity ]) ->
                    (reportProgress eventEmitter 93.33;
                     (Command.Unzip.run ~p:hiddenEsyRoot "cache.zip") |>
                       (then_
                          (function
                           | ((Error (_unzipCmdError))[@explicit_arity ]) ->
                               ((Error
                                   (((E.CacheFailure
                                        ("Failed to unzip downloaded cache"))
                                     [@explicit_arity ])))
                                 [@explicit_arity ]) |> resolve
                           | ((Ok (_unzipCmdOutput))[@explicit_arity ]) ->
                               resolve ((Ok (()))[@explicit_arity ]))))
                | ((Error (e))[@explicit_arity ]) ->
                    ((Error (e))[@explicit_arity ]) |> resolve)))
           |>
           (then_
              (function
               | ((Ok (()))[@explicit_arity ]) ->
                   (reportProgress eventEmitter 96.66;
                    (Command.Esy.importDependencies ~p:hiddenEsyRoot) |>
                      (then_
                         (resolve <<
                            (function
                             | Ok _ -> ((Ok (()))[@explicit_arity ])
                             | Error _ ->
                                 ((Error (E.EsyImportDependenciesFailure))
                                 [@explicit_arity ])))))
               | ((Error (e))[@explicit_arity ]) ->
                   resolve ((Error (e))[@explicit_arity ]))))
          |>
          (then_
             (function
              | ((Error (e))[@explicit_arity ]) ->
                  ((Error (e))[@explicit_arity ]) |> resolve
              | ((Ok (()))[@explicit_arity ]) ->
                  (reportProgress eventEmitter 99.99;
                   (Command.Esy.build ~p:hiddenEsyRoot) |>
                     (then_
                        (resolve <<
                           (function
                            | ((Ok (_esyCmdOutput))[@explicit_arity ]) ->
                                ((Ok (()))[@explicit_arity ])
                            | ((Error (e))[@explicit_arity ]) ->
                                ((Error
                                    (((E.EsyBuildFailure
                                         ((Command.Esy.E.toString e)))
                                      [@explicit_arity ])))
                                [@explicit_arity ]))))))) in
      let open Js.Promise in
        let folder = Filename.dirname manifestPath in
        ((Fs.readFile manifestPath) |>
           (then_
              (fun manifest ->
                 let open Option in
                   (let open Json in
                      ((parse manifest) >>| CheckBucklescriptCompat.run) >>|
                        (function
                         | ((Ok (()))[@explicit_arity ]) ->
                             runSetupChain folder
                         | ((Error (e))[@explicit_arity ]) ->
                             resolve
                               ((Error
                                   (((E.BucklescriptCompatFailure (e))
                                     [@explicit_arity ])))[@explicit_arity ])))
                     |>
                     (toPromise
                        ((E.SetupChainFailure
                            ("Failed to parse manifest file"))
                        [@explicit_arity ])))))
          |>
          (then_
             (function
              | ((Ok (()))[@explicit_arity ]) ->
                  (reportEnd eventEmitter; resolve ())
              | ((Error (e))[@explicit_arity ]) ->
                  (reportError eventEmitter (E.toString e); resolve ())))
  end