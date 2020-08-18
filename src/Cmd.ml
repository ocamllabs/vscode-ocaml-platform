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
  Js.String.split envSep path
  |> Promise.Array.findMap (fun p ->
         let p = Path.ofString p in
         Array.map (Path.join p) candidates
         |> Promise.Array.findMap (fun p ->
                let open Promise.O in
                Fs.exists (Path.toString p) >>| function
                | true -> Some p
                | false -> None))

let checkSpawn { bin; args } =
  if Path.isAbsolute bin then
    Promise.Result.return { bin; args }
  else
    match Js.Dict.get Process.env "PATH" with
    | None -> Error pathMissingFromEnv |> Promise.resolve
    | Some path -> (
      let open Promise.O in
      which path bin >>| function
      | None -> Error {j| Command "$bin" not found |j}
      | Some bin -> Ok { bin; args } )

let check t =
  match t with
  | Shell _ -> Promise.Result.return t
  | Spawn spawn ->
    let open Promise.Result.O in
    checkSpawn spawn >>| fun s -> Spawn s

let toSpawn = function
  | Spawn spawn -> spawn
  | Shell commandLine -> (
    match Platform.shell with
    | Sh bin -> { bin; args = [ "-c"; commandLine ] }
    | PowerShell bin -> { bin; args = [ "-c"; "& " ^ commandLine ] } )

let run ?cwd ?stdin = function
  | Spawn { bin; args } ->
    ChildProcess.spawn (Path.toString bin) (Array.of_list args) ?stdin
      (ChildProcess.Options.make ?cwd ())
  | Shell commandLine ->
    ChildProcess.exec commandLine ?stdin (ChildProcess.Options.make ?cwd ())

let log ?(result : ChildProcess.return option) (t : t) =
  let message =
    match result with
    | None -> []
    | Some result -> [ ("result", Log.field result) ]
  in
  let message =
    match t with
    | Spawn { bin; args } ->
      ("bin", Log.field (Path.toString bin))
      :: ("args", Log.field (Json.Encode.list Json.Encode.string args))
      :: message
    | Shell commandLine -> ("shell", Log.field commandLine) :: message
  in
  logJson "external command" message

let output ?stdin (t : t) =
  let open Promise.O in
  run ?stdin t >>| fun (result : ChildProcess.return) ->
  log ~result t;
  if result.exitCode = 0 then
    Ok result.stdout
  else
    let stderr = result.stderr in
    Error
      {j| Command failed with $stderr. See output channel for more details |j}
