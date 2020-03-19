open Bindings
open Utils

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
  | None -> Error pathMissingFromEnv |> Js.Promise.resolve
  | Some path ->
    let cmds =
      match Sys.unix with
      | true -> [| cmd |]
      | false -> [| cmd ^ ".exe"; cmd ^ ".cmd" |]
    in
    cmds
    |> Array.map (fun cmd ->
           Js.String.split env_sep path
           |> Js.Array.map (fun p -> Filename.concat p cmd))
    |> Js.Array.reduce Js.Array.concat [||]
    |> Js.Array.map (fun p ->
           Fs.exists p
           |> Js.Promise.then_ (fun exists -> Js.Promise.resolve (p, exists)))
    |> Js.Promise.all
    |> Js.Promise.then_ (fun r ->
           Js.Promise.resolve (Js.Array.filter (fun (_p, exists) -> exists) r))
    |> Js.Promise.then_ (fun r ->
           let r = Array.to_list r in
           let r =
             match r with
             | [] -> Error {j| Command "$cmd" not found |j}
             | (cmd, _exists) :: _rest -> Ok { cmd; env }
           in
           Js.Promise.resolve r)

let output ~args ~cwd { cmd; env } =
  let shellString = Js.Array.concat args [| cmd |] |> Js.Array.joinWith " " in
  Js.log shellString;
  ChildProcess.exec shellString (ChildProcess.Options.make ~cwd ~env ())
  |> Js.Promise.then_ (fun r ->
         let r =
           match r with
           | Error e -> e |> Result.fail
           | Ok (exitCode, stdout, stderr) ->
             if exitCode = 0 then
               Ok stdout
             else
               Error
                 {j| Command $cmd failed:
exitCode: $exitCode
stderr: $stderr
|j}
         in
         Js.Promise.resolve r)
