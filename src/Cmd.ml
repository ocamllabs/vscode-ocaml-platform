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
  let quote arg =
    (* escape double quotes *)
    let escape = Js.String.replaceByRe [%re "/\"/g"] "\\\"" in
    "\"" ^ escape arg ^ "\""
  in
  let cmdString = Path.toString cmd in
  let argString = Js.Array.joinWith " " (Array.map quote args) in
  let cwd =
    match cwd with
    | None -> None
    | Some cwd -> Some (Path.toString cwd)
  in
  ChildProcess.spawn cmdString args ?stdin
    (ChildProcess.Options.make ?cwd ~env ())
  |> Promise.map (fun (result : ChildProcess.return) ->
         let () =
           let message =
             [ ("cmd", Log.field cmdString)
             ; ("args", Log.field argString)
             ; ("result", Log.field result)
             ]
           in
           let message =
             match cwd with
             | None -> message
             | Some cwd -> ("cwd", Log.field cwd) :: message
           in
           logJson "external command" message
         in
         if result.exitCode = 0 then
           Ok result.stdout
         else
           let shellString = String.concat " " [ cmdString; argString ] in
           let stderr = result.stderr in
           Error {j| Command $shellString failed: $stderr |j})
