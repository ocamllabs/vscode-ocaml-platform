open Import

type t =
  { cmd : Path.t
  ; env : string Js.Dict.t
  }

type stdout = string

type stderr = string

let pathMissingFromEnv = "'PATH' variable not found in the environment"

let binPath c = c.cmd

let make ?(env = Process.env) ~cmd () =
  if Path.isAbsolute cmd then
    Promise.Result.return { env; cmd }
  else
    match Js.Dict.get env "PATH" with
    | None -> Error pathMissingFromEnv |> Promise.resolve
    | Some path ->
      let cmds =
        match Sys.unix with
        | true -> [| cmd |]
        | false ->
          [| Path.withExt cmd ~ext:".exe"; Path.withExt cmd ~ext:".cmd" |]
      in
      cmds
      |> Array.map (fun cmd ->
             Js.String.split envSep path
             |> Js.Array.map (fun p -> Path.join (Path.ofString p) cmd))
      |> Js.Array.reduce Js.Array.concat [||]
      |> Js.Array.map (fun p ->
             p |> Path.toString |> Fs.exists
             |> Promise.map (fun exists -> (p, exists)))
      |> Promise.all
      |> Promise.map (fun r ->
             match
               r
               |> Js.Array.filter (fun (_p, exists) -> exists)
               |> Array.to_list
             with
             | [] -> Error {j| Command "$cmd" not found |j}
             | (cmd, _exists) :: _rest -> Ok { cmd; env })

let output ~args ?cwd { cmd; env } =
  (* TODO use ChildProcess.spawn to get rid of this pointless concatenation *)
  let shellString =
    Js.Array.joinWith " " (Js.Array.concat args [| Path.toString cmd |])
  in
  Js.Console.info shellString;
  let cwd =
    match cwd with
    | None -> None
    | Some cwd -> Some (Path.toString cwd)
  in
  ChildProcess.exec shellString (ChildProcess.Options.make ?cwd ~env ())
  |> Promise.map (function
       | Error e -> Error e
       | Ok (exitCode, stdout, stderr) ->
         if exitCode = 0 then
           Ok stdout
         else
           Error
             {j| Command $shellString failed:
exitCode: $exitCode
stderr: $stderr
|j})
