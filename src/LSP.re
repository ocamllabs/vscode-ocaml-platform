open Bindings;

module Server = {
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

  let make: Toolchain.t => Vscode.LanguageClient.serverOptions =
    toolchain => {
      let (command, args) = Toolchain.lsp(toolchain);
      (
        {
          command,
          args,
          options: {
            env: Process.env,
          },
        }: Vscode.LanguageClient.serverOptions
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
