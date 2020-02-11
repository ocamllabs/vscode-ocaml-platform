open Bindings;
open Utils;
type t =
  | Esy({readyForDev: bool})
  | Opam
  | Bsb({readyForDev: bool});

module E = {
  type t =
    | UnrecognisedProject
    | WeirdInvariantViolation
    | EsyStatusFailed(int, string, string);

  let toString =
    fun
    | UnrecognisedProject => "Not a valid esy/opam/bsb project"
    | WeirdInvariantViolation => "Weird invariant violation. Why would .vscode/esy exist but not be a valid esy project. TODO"
    | EsyStatusFailed(exitCode, stdout, stderr) => {j|Could not detect project type: esy status failed
exitCode: $exitCode
stdout: $stdout
stderr: $stderr
|j};
};

let detect = folder => {
  Js.Promise.(
    Command.Esy.status(folder)
    |> then_(
         fun
         | Error(e) =>
           (
             switch (e) {
             | Esy.E.CmdFailed(cmd) =>
               Error(
                 E.EsyStatusFailed(
                   -1,
                   "<unknown exec failure>",
                   "<unknown exec failure>",
                 ),
               )
             }
           )
           |> resolve
         | Ok((status: Esy.status)) =>
           if (status.isProject) {
             /* All npm and opam projects are valid esy projects too! Picking
                the right package manager is important - we don't want to run
                `esy` for a user who never intended to. Example: bsb/npm
                users. Similarly, opam users wouldn't want prompts to run
                `esy`. Why is prompting `esy i` even necessary in the first
                place? `esy ocamlmerlin-lsp` needs projects to install/solve deps*/

             let manifestFile =
               switch (Js.Nullable.toOption(status.rootPackageConfigPath)) {
               | Some(x) => x
               | None => ""
               };

             /* Looking for manifest file. If it is not a json file, it's an opam project */
             if (Js.Re.fromString(".json$")->Js.Re.test_(manifestFile)) {
               /* if isProjectReadyForDev is true, it's an esy project. So, there's no need for any setup */
               if (status.isProjectReadyForDev) {
                 /* Definitely an esy project */
                 Ok(Esy({readyForDev: true})) |> resolve;
               } else {
                 /* Could be an esy project withouts deps installed, or a bsb project */
                 /* Looking into the manifest file for more details */
                 Fs.readFile(manifestFile)
                 |> then_(manifest =>
                      Js.Json.(
                        {
                          let manifestJson = parseExn(manifest);
                          let manifestHasEsyConfig =
                            Utils.propertyExists(manifestJson, "esy"); /* ie "esy" exists in a package.json */
                          let manifestIsEsyJSON =
                            Js.Re.fromString("esy.json$")
                            ->Js.Re.test_(manifestFile);
                          if (manifestIsEsyJSON || manifestHasEsyConfig) {
                            /* Definitely an esy project */
                            resolve(
                              Ok(
                                Esy({
                                  readyForDev: status.isProjectReadyForDev,
                                }),
                              ),
                            );
                          } else {
                            /* Must be a bsb project. We install the toolchain using esy */
                            let esyToolChainFolder =
                              Path.join([|folder, ".vscode", "esy"|]);
                            esyToolChainFolder
                            |> Fs.exists
                            |> then_(
                                 fun
                                 | Error(e) => Error(e) |> resolve
                                 | Ok(doesToolChainEsyManifestExist) =>
                                   if (doesToolChainEsyManifestExist) {
                                     Esy.status(esyToolChainFolder)
                                     |> then_(
                                          resolve
                                          << (
                                            fun
                                            | Error(e) =>
                                              switch (e) {
                                              | Esy.E.CmdFailed(cmd) =>
                                                Error(
                                                  E.EsyStatusFailed(
                                                    -1,
                                                    "<unknown exec failure>",
                                                    "<unknown exec failure>",
                                                  ),
                                                )
                                              }
                                            | Ok(
                                                (toolChainStatus: Esy.status),
                                              ) =>
                                              if (!toolChainStatus.isProject) {
                                                Error(
                                                  E.WeirdInvariantViolation,
                                                );
                                              } else {
                                                Ok(
                                                  Bsb({
                                                    readyForDev:
                                                      toolChainStatus.
                                                        isProjectSolved,
                                                  }),
                                                );
                                              }
                                          ),
                                        );
                                   } else {
                                     Ok(Bsb({readyForDev: false})) |> resolve;
                                   },
                               );
                          };
                        }
                      )
                    );
               };
             } else {
               Ok(Opam) |> resolve;
             };
           } else {
             resolve(Error(E.UnrecognisedProject));
           },
       )
  );
};
