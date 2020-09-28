open Import

type shell = string

type spawn =
  { bin : Path.t
  ; args : string list
  }

type t =
  | Shell of shell
  | Spawn of spawn

type stdout = string

type stderr = string

let pathMissingFromEnv = "'PATH' variable not found in the environment"

let append { bin; args = args1 } args2 = { bin; args = args1 @ args2 }

let candidateFns =
  if Sys.unix then
    fun x ->
  [| x |]
  else
    fun x ->
  [| ".exe"; ".cmd" |] |> Array.map (fun ext -> Path.withExt x ~ext)

let which path fn =
  let candidates = candidateFns fn in
  Core_kernel.String.split ~on:envSep path
  |> Promise.List.find_map (fun p ->
         let p = Path.ofString p in
         Array.map (Path.join p) candidates
         |> Promise.Array.find_map (fun p ->
                let open Promise.Syntax in
                Fs.exists (Path.toString p) >>| function
                | true -> Some p
                | false -> None))

let checkSpawn { bin; args } =
  if Path.isAbsolute bin then
    Promise.Result.return { bin; args }
  else
    match Core_kernel.Hashtbl.find (Process.env ()) "PATH" with
    | None -> Error pathMissingFromEnv |> Promise.resolve
    | Some path -> (
      let open Promise.Syntax in
      which path bin >>| function
      | None -> Error {j| Command "$bin" not found |j}
      | Some bin -> Ok { bin; args } )

let check t =
  match t with
  | Shell _ -> Promise.Result.return t
  | Spawn spawn ->
    let open Promise.Result.Syntax in
    checkSpawn spawn >>| fun s -> Spawn s

let run ?cwd ?stdin = function
  | Spawn { bin; args } ->
    ChildProcess.spawn (Path.toString bin) (Array.of_list args) ?stdin
      (ChildProcess.Options.create ?cwd ())
  | Shell commandLine ->
    ChildProcess.exec commandLine ?stdin (ChildProcess.Options.create ?cwd ())

let log ?(result : ChildProcess.return option) (t : t) =
  let message =
    match result with
    | None -> []
    | Some result ->
      [ ( "result"
        , Jsonoo.Encode.object_
            [ ("exitCode", Jsonoo.Encode.int result.exitCode)
            ; ("stdout", Jsonoo.Encode.string result.stdout)
            ; ("stderr", Jsonoo.Encode.string result.stderr)
            ] )
      ]
  in
  let message =
    match t with
    | Spawn { bin; args } ->
      ("bin", Jsonoo.Encode.string (Path.toString bin))
      :: ("args", Jsonoo.Encode.list Jsonoo.Encode.string args)
      :: message
    | Shell commandLine ->
      ("shell", Jsonoo.Encode.string commandLine) :: message
  in
  logJson "external command" message

let output ?stdin (t : t) =
  let open Promise.Syntax in
  run ?stdin t >>| fun (result : ChildProcess.return) ->
  log ~result t;
  if result.exitCode = 0 then
    Ok result.stdout
  else
    Error
      (Printf.sprintf
         "Command failed with %s See output channel for more details"
         result.stderr)
