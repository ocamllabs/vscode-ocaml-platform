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

let path_missing_from_env = "'PATH' variable not found in the environment"

let append { bin; args = args1 } args2 = { bin; args = args1 @ args2 }

let candidates bin =
  let bin_ext ext = Path.with_ext bin ~ext in
  match Platform.t with
  | Win32 -> [ bin_ext ".exe"; bin_ext ".cmd" ]
  | _ -> [ bin ]

let which path_env_var bin =
  String.split ~on:Path.delimiter path_env_var
  |> Promise.List.find_map (fun p ->
         let p = Path.of_string p in
         candidates bin
         |> List.map ~f:(Path.join p)
         |> Promise.List.find_map (fun p ->
                let open Promise.Syntax in
                let+ exists = Fs.exists (Path.to_string p) in
                if exists then
                  Some p
                else
                  None))

let check_spawn { bin; args } =
  if Path.is_absolute bin then
    Promise.Result.return { bin; args }
  else
    match Process.Env.get "PATH" with
    | None -> Error path_missing_from_env |> Promise.resolve
    | Some path -> (
      let open Promise.Syntax in
      let+ which_path = which path bin in
      match which_path with
      | None ->
        Error (Printf.sprintf "Command %s not found" (Path.to_string bin))
      | Some bin -> Ok { bin; args } )

let check t =
  match t with
  | Shell _ -> Promise.Result.return t
  | Spawn spawn ->
    let open Promise.Result.Syntax in
    let+ s = check_spawn spawn in
    Spawn s

let run ?cwd ?stdin = function
  | Spawn { bin; args } ->
    ChildProcess.spawn (Path.to_string bin) (Array.of_list args) ?stdin
      (ChildProcess.Options.create ?cwd ())
  | Shell command_line ->
    ChildProcess.exec command_line ?stdin (ChildProcess.Options.create ?cwd ())

let log ?(result : ChildProcess.return option) (t : t) =
  let open Jsonoo.Encode in
  let message =
    match result with
    | None -> []
    | Some result ->
      [ ( "result"
        , object_
            [ ("exitCode", int result.exitCode)
            ; ("stdout", string result.stdout)
            ; ("stderr", string result.stderr)
            ] )
      ]
  in
  let message =
    match t with
    | Spawn { bin; args } ->
      ("bin", string (Path.to_string bin))
      :: ("args", list string args)
      :: message
    | Shell command_line -> ("shell", string command_line) :: message
  in
  log_json "external command" message

let output ?stdin (t : t) =
  let open Promise.Syntax in
  let+ (result : ChildProcess.return) = run ?stdin t in
  log ~result t;
  if result.exitCode = 0 then
    Ok result.stdout
  else
    Error
      (Printf.sprintf
         "Command failed with %s See output channel for more details"
         result.stderr)
