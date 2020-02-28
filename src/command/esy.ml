type status =
  { isProject : bool
  ; isProjectSolved : bool
  ; isProjectFetched : bool
  ; isProjectReadyForDev : bool
  ; rootBuildPath : string Js.Nullable.t
  ; rootInstallPath : string Js.Nullable.t
  ; rootPackageConfigPath : string Js.Nullable.t
  }
[@@ocaml.doc " Esy API *"]

open Bindings
exception UnexpectedJSONValue of Js.Json.tagged_t

exception Stderr of string

exception UnknownError of string

exception JSError of string

module E = struct
  type t =
    | CmdFailed of string
    | NonZeroExit of string * int * string * string
    | UnexpectedJSONValue of Js.Json.tagged_t
    | JsonParseExn of string
    | UnknownError

  let toString = function
    | NonZeroExit (command, exitCode, stdout, stderr) ->
      {j| $command failed:
exitCode: $exitCode
stdout: $stdout
stderr: $stderr |j}
    | JsonParseExn message -> {j|Error: $message|j}
    | CmdFailed cmd -> {j| `$cmd` command failed |j}
    | UnexpectedJSONValue _msg -> {j| Unexpected json value |j}
    | UnknownError -> "An unknown error occurred"
end

let bool' =
  let open Js.Json in
  function
  | JSONTrue -> true
  | JSONFalse -> false
  | _ as x -> raise (UnexpectedJSONValue x)

let raiseIfNone = function
  | Some x -> x
  | None -> failwith "Found None where it was not expected"

let bool_ x = x |> raiseIfNone |> Js.Json.classify |> bool'

let nullableString' =
  let open Js.Json in
  function
  | JSONString x -> Js.Nullable.return x
  | JSONNull -> Js.Nullable.null
  | _ as x -> raise (UnexpectedJSONValue x)

let nullableString = function
  | Some x -> x |> Js.Json.classify |> nullableString'
  | None -> Js.Nullable.null

open Js.Promise

let status path =
  ChildProcess.exec "esy status" (ChildProcess.Options.make ~cwd:path ())
  |> then_
    (fun r ->
       let r =
         match r with
        | Error childProcessError -> (
          match childProcessError with
          | ChildProcess.E.ExecFailure -> Error (E.CmdFailed "esy status") )
        | Ok (_exitCode, statusOutputString, statusErrorString) ->
          if statusErrorString = "" then
            let open Js.Json in
            try
              let json = parseExn statusOutputString in
              let dict =
                match Js.Json.classify json with
                | JSONObject dict -> dict
                | _ as x -> raise (UnexpectedJSONValue x)
              in
              let isProject = bool_ (Js.Dict.get dict "isProject") in
              let isProjectSolved =
                bool_ (Js.Dict.get dict "isProjectSolved")
              in
              let isProjectFetched =
                bool_ (Js.Dict.get dict "isProjectFetched")
              in
              let isProjectReadyForDev =
                bool_ (Js.Dict.get dict "isProjectReadyForDev")
              in
              let rootBuildPath =
                nullableString (Js.Dict.get dict "rootBuildPath")
              in
              let rootInstallPath =
                nullableString (Js.Dict.get dict "rootInstallPath")
              in
              let rootPackageConfigPath =
                nullableString (Js.Dict.get dict "rootPackageConfigPath")
              in
              Ok
                { isProject
                ; isProjectSolved
                ; isProjectFetched
                ; isProjectReadyForDev
                ; rootBuildPath
                ; rootInstallPath
                ; rootPackageConfigPath
                }
            with
            | UnexpectedJSONValue x -> Error (E.UnexpectedJSONValue x)
            | Js.Exn.Error e -> (
              match Js.Exn.message e with
              | Some message -> Error (E.JsonParseExn message)
              | None -> Error E.UnknownError )
          else
            Error (E.CmdFailed "esy status") in
       resolve r)

let prepareCommand a = a |> Js.Array.joinWith " "

let subcommand ~p c =
  let cmd = [| "esy"; c; {j| -P $p |j} |] |> prepareCommand in
  ChildProcess.exec cmd (ChildProcess.Options.make ())
  |> then_ (function
       | Error _e -> resolve (Error (E.CmdFailed cmd))
       | Ok (exitCode, stdout, stderr) ->
         if exitCode = 0 then
           resolve (Ok stdout)
         else
           resolve (Error (E.NonZeroExit (cmd, exitCode, stdout, stderr))))

type subcommand = p:string -> (string, E.t) result Js.Promise.t

let install = (subcommand "install" : subcommand)

let i = (subcommand "i" : subcommand)

let importDependencies = (subcommand "import-dependencies" : subcommand)

let build = (subcommand "build" : subcommand)

let b = (subcommand "b" : subcommand)
