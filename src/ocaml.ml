open Import

type t = Ocaml_version.t

let make sandbox =
  let open Promise.Syntax in
  let+ r = Sandbox.get_command sandbox "ocamlc" [ "--version" ] |> Cmd.output in
  match r with
  | Ok v ->
    Ocaml_version.of_string v
    |> Result.map_error ~f:(function `Msg _ -> `Unable_to_parse_version v)
  | Error e ->
    log_chan ~section:"Ocaml.version_semver" `Warn
      "Error running `ocamlc --version`: %s" e;
    Error `Ocamlc_missing

let version t = t
