open Bindings;

module Server = {
  open Js.Promise;
  open ProjectType;
  module type MTYPE = {
    type t;
    let make: unit => t;
    let onProgress: (t, float => unit) => unit;
    let onEnd: (t, unit => unit) => unit;
    let onError: (t, string => unit) => unit;
    let reportProgress: (t, float) => unit;
    let reportEnd: t => unit;
    let reportError: (t, string) => unit;
    let run: (t, string) => Js.Promise.t(unit);
  };
  let setupWithProgressIndicator = (m, folder) => {
    module M = (val m: MTYPE);
    M.(
      Window.withProgress(
        {
          "location": 15, /* Window.(locationToJs(Notification)) */
          "title": "Setting up toolchain...",
        },
        progress => {
          let succeeded = ref(Ok());
          let eventEmitter = make();
          onProgress(eventEmitter, percent => {
            progress.report(. {"increment": int_of_float(percent *. 100.)})
          });
          onEnd(eventEmitter, () => {progress.report(. {"increment": 100})});
          onError(eventEmitter, errorMsg => {succeeded := Error(errorMsg)});
          Js.Promise.(
            run(eventEmitter, folder) |> then_(() => resolve(succeeded^))
          );
        },
      )
    );
  };

  let make:
    string =>
    Js.Promise.t(result(Vscode.LanguageClient.serverOptions, string)) =
    folder => {
      Js.Dict.set(processEnv, "OCAMLRUNPARAM", "b");
      Js.Dict.set(processEnv, "MERLIN_LOG", "-");
      ProjectType.detect(folder)
      |> then_(
           fun
           | Error(e) => Error(ProjectType.E.toString(e)) |> resolve
           | Ok(projectType) => {
               let setupPromise =
                 switch (projectType) {
                 | Esy({readyForDev}) =>
                   if (readyForDev) {
                     resolve(Ok());
                   } else {
                     setupWithProgressIndicator((module Setup.Esy), folder);
                   }
                 | Opam =>
                   setupWithProgressIndicator((module Setup.Opam), folder)
                 | Bsb({readyForDev}) =>
                   if (readyForDev) {
                     resolve(Ok());
                   } else {
                     /* Not ready for dev. Setting up */
                     setupWithProgressIndicator(
                       (module Setup.Bsb),
                       folder,
                     );
                   }
                 };
               setupPromise
               |> then_(r => {
                    switch (r) {
                    | Ok () =>
                      switch (projectType) {
                      | Esy(_) =>
                        Ok(
                          {
                            command:
                              Process.platform == "win32" ? "esy.cmd" : "esy",
                            args: [|
                              "exec-command",
                              "--include-current-env",
                              "ocamllsp",
                            |],
                            options: {
                              env: processEnv,
                            },
                          }: Vscode.LanguageClient.serverOptions,
                        )
                        |> resolve
                      | Opam =>
                        if (processPlatform == "win32") {
                          Error(
                            "Opam workflow for Windows is not supported yet",
                          )
                          |> resolve;
                        } else {
                          Ok(
                            {
                              command: "opam",
                              args: [|"exec", "ocamllsp"|],
                              options: {
                                env: processEnv,
                              },
                            }: Vscode.LanguageClient.serverOptions,
                          )
                          |> resolve;
                        }
                      | Bsb(_) =>
                        Ok(
                          {
                            command:
                              Bindings.processPlatform == "win32"
                                ? "esy.cmd" : "esy",
                            args: [|
                              "-P",
                              Path.join([|folder, ".vscode", "esy"|]),
                              "ocamllsp",
                            |],
                            options: {
                              env: processEnv,
                            },
                          }: Vscode.LanguageClient.serverOptions,
                        )
                        |> resolve
                      }
                    | Error(e) => resolve(Error(e))
                    }
                  });
             },
         );
    };
};

module Client = {
  let make: unit => Vscode.LanguageClient.clientOptions =
    () => {
      {
        documentSelector: [|
          {scheme: "file", language: "ocaml"},
          {scheme: "file", language: "reason"},
        |],
      };
    };
};
