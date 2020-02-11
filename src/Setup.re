open Bindings;
open Js.Promise;

/* False bindings to emulate EventEmitters. Node.js event emitters
   take unrestricted types on their .emit() methods */
module Internal = {
  type t;
  [@bs.module] [@bs.new] external make: unit => t = "events";
  [@bs.send] external onProgress': (t, string, float => unit) => unit = "on";
  let onProgress = (t, cb) => {
    onProgress'(t, "progress", cb);
  };

  [@bs.send] external onEnd': (t, string, unit => unit) => unit = "on";
  let onEnd = (t, cb) => {
    onEnd'(t, "end", cb);
  };

  [@bs.send] external onError': (t, string, string => unit) => unit = "on";
  let onError = (t, cb) => {
    onError'(t, "error", cb);
  };

  [@bs.send] external reportProgress': (t, string, float) => unit = "emit";
  let reportProgress = (t, v) => {
    reportProgress'(t, "progress", v);
  };

  [@bs.send] external reportEnd': (t, string) => unit = "emit";
  let reportEnd = t => {
    reportEnd'(t, "end");
  };

  [@bs.send] external reportError': (t, string, string) => unit = "emit";
  let reportError = (t, errorMsg) => {
    reportError'(t, "error", errorMsg);
  };
};

module Esy = {
  open ChildProcess;
  include Internal;
  let make = () => make();
  let run = (eventEmitter, projectPath) => {
    reportProgress(eventEmitter, 0.1);
    exec("esy", Options.make(~cwd=projectPath, ()))
    |> then_(_ => {
         reportProgress(eventEmitter, 1.);
         reportEnd(eventEmitter);
         resolve();
       });
  };
};

module Opam = {
  open ChildProcess;
  include Internal;
  let make = () => make();
  let run = (eventEmitter, _) => {
    reportProgress(eventEmitter, 1.);
    reportEnd(eventEmitter);
    resolve();
  };
};

module Bsb = {
  module E = {
    type t =
      | SetupChainFailure(string)
      | CacheFailure(string)
      | EsyBuildFailure
      | EsyImportDependenciesFailure
      | EsyInstallFailure
      | BucklescriptCompatFailure(CheckBucklescriptCompat.E.t)
      | InvalidPath(string)
      | Failure(string);
    let toString =
      fun
      | SetupChainFailure(msg) => {j|Setup failed: $msg|j}
      | EsyBuildFailure => "'esy install' failed"
      | EsyImportDependenciesFailure => "'esy import-dependencies' failed"
      | EsyInstallFailure => "'esy install' failed"
      | BucklescriptCompatFailure(e) => {
          let msg = CheckBucklescriptCompat.E.toString(e);
          {j| BucklescriptCompatFailure: $msg |j};
        }
      | CacheFailure(msg) => {j| Azure artifacts cache failure: $msg |j}
      | Failure(reason) => {j| Bsb setup failed. Reason: $reason |j}
      | InvalidPath(p) => {j| Setup failed with because of invalid path provided to it: $p |j};
  };
  open Utils;
  include Internal;
  let download = (url, file, ~progress, ~end_, ~error, ~data) => {
    let stream = RequestProgress.requestProgress(Request.request(url));
    RequestProgress.onProgress(stream, state => {
      progress(
        float_of_int(state##size##transferred) /. (134. *. 1024. *. 1024.),
      )
    });
    RequestProgress.onData(stream, data);
    RequestProgress.onEnd(stream, end_);
    RequestProgress.onError(stream, error);
    RequestProgress.pipe(stream, Fs.createWriteStream(file));
  };

  let dropAnEsyJSON = path => {
    Fs.writeFile(path, thisProjectsEsyJson);
  };

  let make = () => make();
  let run = (eventEmitter, projectPath) => {
    let manifestPath = Path.join([|projectPath, "package.json"|]);
    let runSetupChain = folder => {
      let hiddenEsyRoot = Path.join([|folder, ".vscode", "esy"|]);
      /* let onlyIfOk: */
      /*   ('a => Js.Promise.t(result('b, 'c)), result('c, 'd)) => */
      /*   Js.Promise.t(result('b, 'c)) = */
      /*   f => */
      /*     fun */
      /*     | Ok(x) => f(x) */
      /*     | Error(e) => Js.Promise.resolve(Error(e)); */
      Fs.mkdir(~p=true, hiddenEsyRoot)
      |> then_(
           fun
           | Error(e) => Error(e) |> resolve
           | Ok () => {
               Filename.concat(hiddenEsyRoot, "esy.json")
               |> dropAnEsyJSON
               |> then_(() => resolve(Ok()));
             },
         )
      |> then_(
           fun
           | Error(Fs.E.PathNotFound) =>
             Error(E.InvalidPath(hiddenEsyRoot)) |> resolve
           | Ok () => {
               Command.Esy.install(~p=hiddenEsyRoot)
               |> then_(
                    fun
                    | Error(e) =>
                      Command.Esy.E.(
                        switch (e) {
                        | CmdFailed(_)
                        | NonZeroExit(_, _, _, _)
                        | UnexpectedJSONValue(_) /* TODO: Some of these JSON errors can be encapsulated */
                        | JsonParseExn(_)
                        | UnknownError => Error(E.EsyInstallFailure)
                        }
                      )
                      |> resolve
                    | Ok(_stdout) => {
                        reportProgress(eventEmitter, 0.1);
                        AzurePipelines.getBuildID()
                        |> then_(
                             fun
                             | Ok(id) => AzurePipelines.getDownloadURL(id)
                             | Error(e) => Error(e) |> resolve,
                           )
                        |> then_(
                             fun
                             | Ok(url) => Ok(url) |> resolve
                             | Error(e) =>
                               AzurePipelines.E.(
                                 switch (e) {
                                 | DownloadFailure(_)
                                 | UnsupportedOS
                                 | InvalidJSONType(_)
                                 | MissingField(_)
                                 | InvalidFirstArrayElement
                                 | Failure(_) =>
                                   /* TODO: helpful message saying cache restoration
                                      failed and long build times are to be expected */
                                   resolve(Error(E.CacheFailure("<TODO>")))
                                 }
                               ),
                           );
                      },
                  );
             },
         )
      |> then_(
           fun
           | Ok(downloadUrl) => {
               Js.log2("download", downloadUrl);
               let lastProgress = ref(0.0);
               Js.Promise.make((~resolve, ~reject as _) =>
                 download(
                   downloadUrl,
                   Path.join([|hiddenEsyRoot, "cache.zip"|]),
                   ~progress=
                     progressFraction => {
                       let percent = progressFraction *. 80.0;
                       reportProgress(eventEmitter, percent -. lastProgress^);
                       lastProgress := percent;
                     },
                   ~data=_ => (),
                   ~error=e => resolve(. Error(E.CacheFailure(e##message))),
                   ~end_=() => {resolve(. Ok())},
                 )
               );
             }
           | Error((_thisIsWhereCacheFailureCouldBeReported: E.t)) =>
             resolve(Error(E.CacheFailure("Couldn't compute downloadUrl"))),
         )
      |> then_(
           fun
           | Ok () => {
               reportProgress(eventEmitter, 93.33);
               Command.Unzip.run(~p=hiddenEsyRoot, "cache.zip")
               |> then_(
                    fun
                    | Error(_unzipCmdError) =>
                      Error(
                        E.CacheFailure("Failed to unzip downloaded cache"),
                      )
                      |> resolve
                    | Ok(_unzipCmdOutput) => resolve(Ok()),
                  );
             }
           | Error(e) => Error(e) |> resolve,
         )
      |> then_(
           fun
           | Ok () => {
               reportProgress(eventEmitter, 96.66);
               Command.Esy.importDependencies(~p=hiddenEsyRoot)
               |> then_(
                    resolve
                    << (
                      fun
                      | Ok(_) => Ok()
                      | Error(_) => Error(E.EsyImportDependenciesFailure)
                    ),
                  );
             }
           | Error(e) => resolve(Error(e)),
         )
      |> then_(
           fun
           | Error(e) => Error(e) |> resolve
           | Ok () => {
               reportProgress(eventEmitter, 99.99);
               Command.Esy.build(~p=hiddenEsyRoot)
               |> then_(
                    resolve
                    << (
                      fun
                      | Ok(_esyCmdOutput) => Ok()
                      | Error(_e) => Error(E.EsyBuildFailure)
                    ),
                  );
             },
         );
    };
    Js.Promise.(
      {
        let folder = Filename.dirname(manifestPath);
        Fs.readFile(manifestPath)
        |> then_(manifest => {
             Option.(
               Json.(
                 parse(manifest)
                 >>| CheckBucklescriptCompat.run
                 >>| (
                   fun
                   | Ok () => runSetupChain(folder)
                   | Error(e) =>
                     resolve(Error(E.BucklescriptCompatFailure(e)))
                 )
               )
               |> toPromise(
                    E.SetupChainFailure("Failed to parse manifest file"),
                  )
             )
           })
        |> then_(
             fun
             | Ok () => {
                 reportEnd(eventEmitter);
                 resolve();
               }
             | Error(e) => {
                 reportError(eventEmitter, E.toString(e));
                 resolve();
               },
           );
      }
    );
  };
};
