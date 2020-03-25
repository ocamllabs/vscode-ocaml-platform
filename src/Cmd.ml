open Bindings
open Utils
module P = Promise

type t =
  { cmd : string
  ; env : string Js.Dict.t
  }

type stdout = string

type stderr = string

let pathMissingFromEnv = "'PATH' variable not found in the environment"

let binPath c = c.cmd

let make ~env ~cmd =
  match Js.Dict.get env "PATH" with
  | None -> Error pathMissingFromEnv |> P.resolve
  | Some path ->
    let cmds =
      match Sys.unix with
      | true -> [| cmd |]
      | false -> [| cmd ^ ".exe"; cmd ^ ".cmd" |]
    in
    cmds
    |> Array.map (fun cmd ->
           Js.String.split envSep path
           |> Js.Array.map (fun p -> Filename.concat p cmd))
    |> Js.Array.reduce Js.Array.concat [||]
    |> Js.Array.map (fun p ->
           p |> Fs.exists |> P.then_ (fun exists -> (p, exists) |> P.resolve))
    |> P.all
    |> P.then_ (fun r ->
           match
             r |> Js.Array.filter (fun (_p, exists) -> exists) |> Array.to_list
           with
           | [] -> Error {j| Command "$cmd" not found |j} |> P.resolve
           | (cmd, _exists) :: _rest -> Ok { cmd; env } |> P.resolve)

let output ~args ~cwd { cmd; env } =
  let shellString = Js.Array.concat args [| cmd |] |> Js.Array.joinWith " " in
  Js.Console.info shellString;
  ChildProcess.exec shellString (ChildProcess.Options.make ~cwd ~env ())
  |> P.then_ (function
       | Error e -> Error e |> P.resolve
       | Ok (exitCode, stdout, stderr) ->
         if exitCode = 0 then
           Ok stdout |> P.resolve
         else
           Error
             {j| Command $cmd failed:
exitCode: $exitCode
stderr: $stderr
|j}
           |> P.resolve)
