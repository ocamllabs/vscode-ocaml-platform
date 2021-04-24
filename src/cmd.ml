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

let quote str =
  if String.contains str ' ' then
    "\"" ^ str ^ "\""
  else
    str

let to_string = function
  | Shell cmd -> cmd
  | Spawn { bin; args } ->
    Path.to_string bin :: args |> List.map ~f:quote |> String.concat ~sep:" "

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

let check_spawn ?env { bin; args } =
  if Path.is_absolute bin then
    Promise.Result.return { bin; args }
  else
    let path =
      match env with
      | Some env -> Interop.Dict.find_opt "PATH" env
      | None -> Process.Env.get "PATH"
    in
    match path with
    | None -> Error path_missing_from_env |> Promise.resolve
    | Some path -> (
      let open Promise.Syntax in
      let+ which_path = which path bin in
      match which_path with
      | None ->
        Error (Printf.sprintf "Command %s not found" (Path.to_string bin))
      | Some bin -> Ok { bin; args })

let check ?env t =
  match t with
  | Shell _ -> Promise.Result.return t
  | Spawn spawn ->
    let open Promise.Result.Syntax in
    let+ s = check_spawn ?env spawn in
    Spawn s

let run ?cwd ?env ?stdin cmd =
  let cwd = Option.map cwd ~f:Path.to_string in
  let logger event =
    let (lazy output) = Output.command_output_channel in
    match event with
    | ChildProcess.Spawned ->
      Vscode.OutputChannel.appendLine output ~value:("$ " ^ to_string cmd)
    | Stdout data
    | Stderr data ->
      Vscode.OutputChannel.append output ~value:data
    | Closed -> Vscode.OutputChannel.appendLine output ~value:""
  in
  let options = ChildProcess.Options.create ?cwd ?env () in
  match cmd with
  | Spawn { bin; args } ->
    ChildProcess.spawn (Path.to_string bin) (Array.of_list args) ~logger ?stdin
      ~options
  | Shell command_line -> ChildProcess.exec command_line ~logger ?stdin ~options

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
      :: ("args", list string args) :: message
    | Shell command_line -> ("shell", string command_line) :: message
  in
  match result with
  | None -> log_json "external command" message
  | Some _ -> log_json "external command (finished)" message

let output ?cwd ?env ?stdin (t : t) =
  let open Promise.Syntax in
  log t;
  let+ (result : ChildProcess.return) = run ?stdin ?cwd ?env t in
  log ~result t;
  if result.exitCode = 0 then
    Ok result.stdout
  else
    Error
      (Printf.sprintf
         "Command failed with %s See output channel for more details"
         result.stderr)

let equal_spawn s1 s2 =
  Path.equal s1.bin s2.bin && List.equal String.equal s1.args s2.args
