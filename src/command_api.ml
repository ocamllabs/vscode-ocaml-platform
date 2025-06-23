type 'a handle =
  { id : string
  ; js : 'a Interop.Js.t
  }

let execute (type a) ({ id; js = (module T) } : a handle) args =
  let open Promise.Syntax in
  let+ result = Vscode.Commands.executeCommand ~command:id ~args in
  [%js.to: T.t] result
;;

let ocaml_prefixed key = "ocaml." ^ key
let unit_command_ref key = { id = ocaml_prefixed key; js = (module Interop.Js.Unit) }
let select_sandbox = unit_command_ref "select-sandbox"
let install_ocaml_lsp_server = unit_command_ref "install-ocaml-lsp-server"
let upgrade_ocaml_lsp_server = unit_command_ref "update-ocaml-lsp-server"
let restart_language_server = unit_command_ref "server.restart"
let select_sandbox_and_open_terminal = unit_command_ref "open-terminal-select"
let open_terminal = unit_command_ref "open-terminal"
let switch_impl_intf = unit_command_ref "switch-impl-intf"
let remove_switch = unit_command_ref "remove-switch"
let refresh_switches = unit_command_ref "refresh-switches"
let refresh_sandbox = unit_command_ref "refresh-sandbox"
let upgrade_sandbox = unit_command_ref "upgrade-sandbox"
let install_sandbox = unit_command_ref "install-sandbox"
let uninstall_sandbox_package = unit_command_ref "uninstall-sandbox-package"
let open_switches_documentation = unit_command_ref "open-switches-documentation"
let open_sandbox_documentation = unit_command_ref "open-sandbox-documentation"
let stop_documentation_server = unit_command_ref "stop-documentation-server"
let generate_sandbox_documentation = unit_command_ref "generate-sandbox-documentation"
let open_current_dune_file = unit_command_ref "current-dune-file"
let evaluate_selection = unit_command_ref "evaluate-selection"
let open_repl = unit_command_ref "open-repl"
let next_hole = unit_command_ref "next-hole"
let prev_hole = unit_command_ref "prev-hole"
let open_ast_explorer_to_the_side = unit_command_ref "open-ast-explorer-to-the-side"
let reveal_ast_node = unit_command_ref "reveal-ast-node"
let switch_hover_mode = unit_command_ref "switch-hover-mode"
let show_preprocessed_document = unit_command_ref "show-preprocessed-document"
let open_pp_editor_and_ast_explorer = unit_command_ref "open-pp-editor-and-ast-explorer"
let open_ocamllsp_output = unit_command_ref "open-ocamllsp-output"
let open_ocaml_platform_ext_output = unit_command_ref "open-ocaml-platform-ext-output"
let open_ocaml_commands_output = unit_command_ref "open-ocaml-commands-output"
let start_debugging = unit_command_ref "start-debugging"
let goto_closure_code_location = unit_command_ref "goto-closure-code-location"

let ask_debug_program =
  { id = ocaml_prefixed "ask-debug-program"
  ; js =
      (module struct
        type t = string option Promise.t [@@js]
      end)
  }
;;

let copy_type_under_cursor = unit_command_ref "copy-type-under-cursor"
let construct = unit_command_ref "construct"
let merlin_jump = unit_command_ref "jump"
let search_by_type = unit_command_ref "search-by-type"
let navigate_typed_holes = unit_command_ref "navigate-typed-holes"
let type_selection = unit_command_ref "type-selection"
let type_previous_selection = unit_command_ref "type-previous-selection"
let augment_selection_type_verbosity = unit_command_ref "augment-selection-type-verbosity"

module Vscode = struct
  let open_ = { id = "vscode.open"; js = (module Interop.Js.Unit) }
  let open_with = { id = "vscode.openWith"; js = (module Interop.Js.Unit) }
  let set_context = { id = "setContext"; js = (module Interop.Js.Unit) }
  let show_hover = { id = "editor.action.showHover"; js = (module Interop.Js.Unit) }
  let show_simple_browser = { id = "simpleBrowser.show"; js = (module Interop.Js.Unit) }
end

module Command_errors = struct
  let text_editor_must_be_active ~expl cmd_name =
    Printf.sprintf
      "The command \"OCaml: %s\" should be run only with a file open in the editor. %s"
      cmd_name
      expl
  ;;
end
