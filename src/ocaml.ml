let version sandbox =
  Sandbox.get_command sandbox "ocamlc" [ "--version" ] |> Cmd.output
