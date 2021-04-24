open Import

let ocaml_env_binary = Path.of_string "ocaml-env"

let ocaml_env_setting =
  Settings.create ~scope:Global ~key:"ocaml.useOcamlEnv"
    ~of_json:Jsonoo.Decode.bool ~to_json:Jsonoo.Encode.bool

let use_ocaml_env () =
  match (Platform.t, Settings.get ocaml_env_setting) with
  | Win32, Some true -> true
  | _ -> false

let spawn_ocaml_env args =
  { Cmd.bin = ocaml_env_binary; args = "exec" :: "--" :: args }

let cygwin_home () =
  let open Promise.Syntax in
  let spawn = spawn_ocaml_env [ "cygpath"; "--windows"; "~" ] in
  let+ output = Cmd.output (Cmd.Spawn spawn) in
  match output with
  | Error _ as e -> e
  | Ok output -> (
    let lines = String.split_on_chars ~on:[ '\n' ] output in
    match lines with
    | home :: _ -> Ok home
    | _ ->
      let msg =
        Printf.sprintf "Unexpected output for Cygin home directory: %s" output
      in
      Error msg)
