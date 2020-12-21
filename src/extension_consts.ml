let ocaml_prefixed key = "ocaml." ^ key

module Commands = struct
  let select_sandbox = ocaml_prefixed "select-sandbox"

  let restart_language_server = ocaml_prefixed "server.restart"

  let select_sandbox_and_open_terminal = ocaml_prefixed "open-terminal-select"

  let open_terminal = ocaml_prefixed "open-terminal"

  let switch_impl_intf = ocaml_prefixed "switch-impl-intf"

  let remove_switch = ocaml_prefixed "remove-switch"

  let refresh_switches = ocaml_prefixed "refresh-switches"
end

(* TODO: Refactor the code so that we don't need any "constants" module *)
