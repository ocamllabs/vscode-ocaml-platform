open Import

type spawn = [ `Spawn of Path.t * string list ]

type shell = [ `Shell of string ]

type t =
  [ spawn
  | shell
  ]

type stdout = string

type stderr = string

let pathMissingFromEnv = "'PATH' variable not found in the environment"

let append (`Spawn (bin, args1)) args2 = `Spawn (bin, args1 @ args2)

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

let check t =
  match t with
  | `Shell _ -> Promise.Result.return t
  | `Spawn (bin, args) -> (
    if Path.isAbsolute bin then
      Promise.Result.return t
    else
      match Js.Dict.get Process.env "PATH" with
      | None -> Error pathMissingFromEnv |> Promise.resolve
      | Some path -> (
        let open Promise.O in
        which path bin >>| function
        | None -> Error {j| Command "$bin" not found |j}
        | Some bin -> Ok (`Spawn (bin, args)) ) )

let toSpawn = function
  | `Spawn (bin, args) -> `Spawn (bin, args)
  | `Shell commandLine ->
    let shell = Path.ofString (Env.shell ()) in
    let args =
      match Path.basename shell with
      | "cmd.exe" -> [ "/d"; "/s"; "c"; commandLine ]
      | _ -> [ "-c"; commandLine ]
    in
    `Spawn (shell, args)

let run ?cwd ?stdin = function
  | `Spawn (bin, args) ->
    ChildProcess.spawn (Path.toString bin) (Array.of_list args) ?stdin
      (ChildProcess.Options.make ?cwd ())
  | `Shell commandLine ->
    ChildProcess.exec commandLine ?stdin (ChildProcess.Options.make ?cwd ())

let log ?(cwd : string option) ?(result : ChildProcess.return option) (t : t) =
  let message =
    match t with
    | `Spawn (bin, args) ->
      [ ("bin", Log.field (Path.toString bin))
      ; ("args", Log.field (Json.Encode.list Json.Encode.string args))
      ]
    | `Shell commandLine -> [ ("shell", Log.field commandLine) ]
  in
  let message =
    match cwd with
    | None -> message
    | Some cwd -> ("cwd", Log.field cwd) :: message
  in
  let message =
    match result with
    | None -> message
    | Some result -> ("result", Log.field result) :: message
  in
  logJson "external command" message

let output ?cwd ?stdin (t : t) =
  let cwd = Option.map cwd Path.toString in
  let open Promise.O in
  run ?cwd ?stdin t >>| fun (result : ChildProcess.return) ->
  log ?cwd ~result t;
  if result.exitCode = 0 then
    Ok result.stdout
  else
    let stderr = result.stderr in
    Error
      {j| Command failed with $stderr. See output channel for more details |j}
