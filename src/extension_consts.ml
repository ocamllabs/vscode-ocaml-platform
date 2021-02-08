let ocaml_prefixed key = "ocaml." ^ key

module Commands = struct
  let select_sandbox = ocaml_prefixed "select-sandbox"

  let restart_language_server = ocaml_prefixed "server.restart"

  let select_sandbox_and_open_terminal = ocaml_prefixed "open-terminal-select"

  let open_terminal = ocaml_prefixed "open-terminal"

  let switch_impl_intf = ocaml_prefixed "switch-impl-intf"

  let remove_switch = ocaml_prefixed "remove-switch"

  let refresh_switches = ocaml_prefixed "refresh-switches"

  let refresh_sandbox = ocaml_prefixed "refresh-sandbox"

  let upgrade_sandbox = ocaml_prefixed "upgrade-sandbox"

  let install_sandbox = ocaml_prefixed "install-sandbox"

  let uninstall_sandbox_package = ocaml_prefixed "uninstall-sandbox-package"

  let open_switches_documentation = ocaml_prefixed "open-switches-documentation"

  let open_sandbox_documentation = ocaml_prefixed "open-sandbox-documentation"

  let open_current_dune_file = ocaml_prefixed "current-dune-file"

  let evaluate_selection = ocaml_prefixed "evaluate-selection"

  let open_repl = ocaml_prefixed "open-repl"
end

(* TODO: Refactor the code so that we don't need any "constants" module *)
