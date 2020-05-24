open Import

type t =
  { cmd : Path.t
  ; env : string Js.Dict.t
  }

type stdout = string

type stderr = string

let pathMissingFromEnv = "'PATH' variable not found in the environment"

let binPath c = c.cmd

let candidateFns =
  if Sys.unix then
    fun x ->
  [| x |]
  else
    fun x ->
  [| ".exe"; ".cmd" |] |> Array.map (fun ext -> Path.withExt x ~ext)

let which path fn =
  let candidates = candidateFns fn in
  Js.String.split envSep path
  |> Promise.Array.findMap (fun p ->
         let p = Path.ofString p in
         Array.map (Path.join p) candidates
         |> Promise.Array.findMap (fun p ->
                let open Promise.O in
                Fs.exists (Path.toString p) >>| function
                | true -> Some p
                | false -> None))

let make ?(env = Process.env) ~cmd () =
  if Path.isAbsolute cmd then
    Promise.Result.return { env; cmd }
  else
    match Js.Dict.get env "PATH" with
    | None -> Error pathMissingFromEnv |> Promise.resolve
    | Some path -> (
      let open Promise.O in
      which path cmd >>| function
      | None -> Error {j| Command "$cmd" not found |j}
      | Some cmd -> Ok { cmd; env } )

let output ~args ?cwd ?stdin { cmd; env } =
  (* TODO use ChildProcess.spawn to get rid of this pointless concatenation *)
  let shellString =
    Js.Array.joinWith " " (Js.Array.concat args [| Path.toString cmd |])
  in
  let cwd =
    match cwd with
    | None -> None
    | Some cwd -> Some (Path.toString cwd)
  in
  ChildProcess.exec shellString ?stdin (ChildProcess.Options.make ?cwd ~env ())
  |> Promise.map (fun (res : ChildProcess.return) ->
         let () =
           let message =
             [ ("cmd", Log.field (Path.toString cmd))
             ; ("args", Log.field (Js.Array.joinWith " " args))
             ; ("result", Log.field res)
             ]
           in
           let message =
             match cwd with
             | None -> message
             | Some cwd -> ("cwd", Log.field cwd) :: message
           in
           logJson "external command" message
         in
         if res.exitCode = 0 then
           Ok res.stdout
         else
           let stderr = res.stderr in
           Error {j| Command $shellString failed $stderr |j})
