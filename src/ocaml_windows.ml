open Import

let ocaml_env_command = { Cmd.bin = Path.of_string "ocaml-env"; args = [] }

let ocaml_env_setting =
  Settings.create_setting
    ~scope:Global
    ~key:"ocaml.useOcamlEnv"
    ~of_json:Jsonoo.Decode.bool
    ~to_json:Jsonoo.Encode.bool
;;

let use_ocaml_env () =
  match Platform.t, Settings.get ocaml_env_setting with
  | Win32, Some true ->
    let open Promise.Syntax in
    let+ checked = Cmd.check_spawn ocaml_env_command in
    Result.is_ok checked
  | _ -> Promise.return false
;;

let spawn_ocaml_env args = { ocaml_env_command with args = "exec" :: "--" :: args }

let cygwin_home () =
  let open Promise.Syntax in
  let spawn = spawn_ocaml_env [ "cygpath"; "--windows"; "~" ] in
  let+ output = Cmd.output (Cmd.Spawn spawn) in
  match output with
  | Error _ as e -> e
  | Ok output ->
    let lines = String.split_on_chars ~on:[ '\n' ] output in
    (match lines with
     | home :: _ -> Ok home
     | _ ->
       let msg = Printf.sprintf "Unexpected output for Cygin home directory: %s" output in
       Error msg)
;;
