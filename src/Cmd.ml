open Import

type t =
  { cmd : string
  ; env : string Js.Dict.t
  }

type stdout = string

type stderr = string

let pathMissingFromEnv = "'PATH' variable not found in the environment"

let binPath c = c.cmd

let make ?(env = Process.env) ~cmd () =
  match Js.Dict.get env "PATH" with
  | None -> Error pathMissingFromEnv |> Promise.resolve
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
           p |> Fs.exists |> Promise.map (fun exists -> (p, exists)))
    |> Promise.all
    |> Promise.map (fun r ->
           match
             r |> Js.Array.filter (fun (_p, exists) -> exists) |> Array.to_list
           with
           | [] -> Error {j| Command "$cmd" not found |j}
           | (cmd, _exists) :: _rest -> Ok { cmd; env })

let output ~args ~cwd { cmd; env } =
  let shellString = Js.Array.concat args [| cmd |] |> Js.Array.joinWith " " in
  Js.Console.info shellString;
  let cwd = Path.toString cwd in
  ChildProcess.exec shellString (ChildProcess.Options.make ~cwd ~env ())
  |> Promise.map (function
       | Error e -> Error e
       | Ok (exitCode, stdout, stderr) ->
         if exitCode = 0 then
           Ok stdout
         else
           Error
             {j| Command $cmd failed:
exitCode: $exitCode
stderr: $stderr
|j})
