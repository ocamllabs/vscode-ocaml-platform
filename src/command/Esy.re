/** Esy API **/
type status = {
  isProject: bool,
  isProjectSolved: bool,
  isProjectFetched: bool,
  isProjectReadyForDev: bool,
  rootBuildPath: Js.Nullable.t(string),
  rootInstallPath: Js.Nullable.t(string),
  rootPackageConfigPath: Js.Nullable.t(string),
};

open Bindings;
open Utils;

exception UnexpectedJSONValue(Js.Json.tagged_t);
exception Stderr(string);
exception UnknownError(string);
exception JSError(string);

module E = {
  type t =
    | CmdFailed(string)
    | NonZeroExit(string, int, string, string)
    | UnexpectedJSONValue(Js.Json.tagged_t)
    | JsonParseExn(string)
    | UnknownError;

  let toString =
    fun
    | NonZeroExit(command, exitCode, stdout, stderr) => {j| $command failed:
exitCode: $exitCode
stdout: $stdout
stderr: $stderr |j}
    | JsonParseExn(message) => {j|Error: $message|j}
    | CmdFailed(cmd) => {j| `$cmd` command failed |j}
    | UnexpectedJSONValue(_msg) => {j| Unexpected json value |j}
    | UnknownError => "An unknown error occurred";
};

let bool' =
  Js.Json.(
    fun
    | JSONTrue => true
    | JSONFalse => false
    | _ as x => raise(UnexpectedJSONValue(x))
  );

let raiseIfNone =
  fun
  | Some(x) => x
  | None => failwith("Found None where it was not expected");

let bool_ = x => x |> raiseIfNone |> Js.Json.classify |> bool';

let nullableString' =
  Js.Json.(
    fun
    | JSONString(x) => Js.Nullable.return(x)
    | JSONNull => Js.Nullable.null
    | _ as x => raise(UnexpectedJSONValue(x))
  );

let nullableString =
  fun
  | Some(x) => x |> Js.Json.classify |> nullableString'
  | None => Js.Nullable.null;

open Js.Promise;
let status = path => {
  ChildProcess.exec("esy status", ChildProcess.Options.make(~cwd=path, ()))
  |> then_(
       resolve
       << (
         fun
         | Error(childProcessError) =>
           switch (childProcessError) {
           | ChildProcess.E.ExecFailure => Error(E.CmdFailed("esy status"))
           }
         | Ok((exitCode, statusOutputString, statusErrorString)) =>
           if (statusErrorString == "") {
             Js.Json.(
               try({
                 let json = parseExn(statusOutputString);
                 /* Getting key-value pairs */
                 let dict =
                   switch (Js.Json.classify(json)) {
                   | JSONObject(dict) => dict
                   | _ as x => raise(UnexpectedJSONValue(x))
                   };

                 let isProject = bool_(Js.Dict.get(dict, "isProject"));

                 let isProjectSolved =
                   bool_(Js.Dict.get(dict, "isProjectSolved"));

                 let isProjectFetched =
                   bool_(Js.Dict.get(dict, "isProjectFetched"));

                 let isProjectReadyForDev =
                   bool_(Js.Dict.get(dict, "isProjectReadyForDev"));

                 let rootBuildPath =
                   nullableString(Js.Dict.get(dict, "rootBuildPath"));

                 let rootInstallPath =
                   nullableString(Js.Dict.get(dict, "rootInstallPath"));
                 let rootPackageConfigPath =
                   nullableString(
                     Js.Dict.get(dict, "rootPackageConfigPath"),
                   );

                 Ok({
                   isProject,
                   isProjectSolved,
                   isProjectFetched,
                   isProjectReadyForDev,
                   rootBuildPath,
                   rootInstallPath,
                   rootPackageConfigPath,
                 });
               }) {
               | UnexpectedJSONValue(x) => Error(E.UnexpectedJSONValue(x))
               | Js.Exn.Error(e) =>
                 switch (Js.Exn.message(e)) {
                 | Some(message) => Error(E.JsonParseExn(message))
                 | None => Error(E.UnknownError)
                 }
               }
             );
           } else {
             Error(E.CmdFailed("esy status"));
           }
       ),
     );
};

let prepareProjectPathArgs =
  fun
  | Some(p) => {j|-P $p |j}
  | None => "";

let prepareCommand = a => a |> Js.Array.joinWith(" ");

let subcommand = (c, ~p=?) => {
  let cmd = [|"esy install", prepareProjectPathArgs(p)|] |> prepareCommand;
  ChildProcess.exec(cmd, ChildProcess.Options.make())
  |> then_(
       fun
       | Error(e) => resolve(Error(E.CmdFailed(cmd)))
       | Ok((exitCode, stdout, stderr)) =>
         if (exitCode == 0) {
           resolve(Ok(stdout));
         } else {
           resolve(Error(E.NonZeroExit(cmd, exitCode, stdout, stderr)));
         },
     );
};

type subcommand = (~p: string=?) => Js.Promise.t(result(string, E.t));
let install: subcommand = subcommand("install");
let i: subcommand = subcommand("i");

let importDependencies: subcommand = subcommand("import-dependencies");

let build: subcommand = subcommand("build");
let b: subcommand = subcommand("b");
