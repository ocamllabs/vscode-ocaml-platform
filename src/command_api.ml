type ('a, 'b) handle =
  { id : string
  ; args_to_js : 'a -> Ojs.t list
  ; args_of_js : Ojs.t list -> 'a
  ; return_type : 'b Interop.Js.t
  }

let execute (type a b) (handle : (a, b) handle) args =
  let (module Return) = handle.return_type in
  let open Promise.Syntax in
  let+ result =
    Vscode.Commands.executeCommand ~command:handle.id ~args:(handle.args_to_js args)
  in
  [%js.to: Return.t] result
;;

module Internal = struct
  let ocaml_prefixed key = "ocaml." ^ key

  let unit_handle id =
    { id = ocaml_prefixed id
    ; args_of_js = Fun.const ()
    ; args_to_js = Fun.const []
    ; return_type = (module Interop.Js.Unit)
    }
  ;;

  let untyped_handle id =
    { id = ocaml_prefixed id
    ; args_to_js = Fun.id
    ; args_of_js = Fun.id
    ; return_type = (module Interop.Js.Unit)
    }
  ;;

  let select_sandbox = unit_handle "select-sandbox"
  let install_ocaml_lsp_server = unit_handle "install-ocaml-lsp-server"
  let upgrade_ocaml_lsp_server = unit_handle "update-ocaml-lsp-server"
  let restart_language_server = unit_handle "server.restart"
  let select_sandbox_and_open_terminal = unit_handle "open-terminal-select"
  let open_terminal = unit_handle "open-terminal"
  let switch_impl_intf = unit_handle "switch-impl-intf"
  let remove_switch = untyped_handle "remove-switch"
  let refresh_switches = unit_handle "refresh-switches"
  let refresh_sandbox = unit_handle "refresh-sandbox"
  let upgrade_sandbox = unit_handle "upgrade-sandbox"
  let install_sandbox = unit_handle "install-sandbox"
  let uninstall_sandbox_package = untyped_handle "uninstall-sandbox-package"
  let open_switches_documentation = untyped_handle "open-switches-documentation"
  let open_sandbox_documentation = untyped_handle "open-sandbox-documentation"
  let stop_documentation_server = unit_handle "stop-documentation-server"
  let generate_sandbox_documentation = untyped_handle "generate-sandbox-documentation"
  let open_current_dune_file = unit_handle "current-dune-file"
  let evaluate_selection = unit_handle "evaluate-selection"
  let open_repl = unit_handle "open-repl"
  let next_hole = untyped_handle "next-hole"
  let prev_hole = untyped_handle "prev-hole"
  let open_ast_explorer_to_the_side = unit_handle "open-ast-explorer-to-the-side"
  let reveal_ast_node = unit_handle "reveal-ast-node"
  let switch_hover_mode = unit_handle "switch-hover-mode"
  let show_preprocessed_document = unit_handle "show-preprocessed-document"
  let open_pp_editor_and_ast_explorer = unit_handle "open-pp-editor-and-ast-explorer"
  let open_ocamllsp_output = unit_handle "open-ocamllsp-output"
  let open_ocaml_platform_ext_output = unit_handle "open-ocaml-platform-ext-output"
  let open_ocaml_commands_output = unit_handle "open-ocaml-commands-output"
  let start_debugging = untyped_handle "start-debugging"
  let goto_closure_code_location = untyped_handle "goto-closure-code-location"

  let ask_debug_program =
    { id = ocaml_prefixed "ask-debug-program"
    ; args_to_js = Fun.const []
    ; args_of_js = Fun.const ()
    ; return_type =
        (module struct
          type t = string option Promise.t [@@js]
        end)
    }
  ;;

  let copy_type_under_cursor = unit_handle "copy-type-under-cursor"
  let construct = unit_handle "construct"
  let merlin_jump = unit_handle "jump"
  let search_by_type = unit_handle "search-by-type"
  let navigate_typed_holes = unit_handle "navigate-typed-holes"
  let type_selection = unit_handle "type-selection"
  let type_previous_selection = unit_handle "type-previous-selection"
  let augment_selection_type_verbosity = unit_handle "augment-selection-type-verbosity"
end

module Vscode = struct
  let external_handle id ~args_to_js ~return_type =
    let args_of_js _ =
      (* These functions are not defined in OCaml, so args_of_js will never be called. *)
      assert false
    in
    { id; args_to_js; args_of_js; return_type }
  ;;

  let unit_external_handle id ~args_to_js =
    external_handle id ~args_to_js ~return_type:(module Interop.Js.Unit)
  ;;

  let open_ =
    let args_to_js uri = [ [%js.of: Vscode.Uri.t] uri ] in
    unit_external_handle "vscode.open" ~args_to_js
  ;;

  let open_with =
    let args_to_js (uri, view_id, column_or_options) =
      [ [%js.of: Vscode.Uri.t] uri
      ; [%js.of: string] view_id
      ; [%js.of: Vscode.ViewColumn.t] column_or_options
      ]
    in
    unit_external_handle "vscode.openWith" ~args_to_js
  ;;

  let set_context =
    let args_to_js (name, value) = [ [%js.of: string] name; [%js.of: bool] value ] in
    unit_external_handle "setContext" ~args_to_js
  ;;

  let show_hover =
    let args_to_js () = [] in
    unit_external_handle "editor.action.showHover" ~args_to_js
  ;;

  let show_simple_browser =
    let args_to_js url = [ [%js.of: string] url ] in
    unit_external_handle "simpleBrowser.show" ~args_to_js
  ;;
end

module Command_errors = struct
  let text_editor_must_be_active ~expl cmd_name =
    Printf.sprintf
      "The command \"OCaml: %s\" should be run only with a file open in the editor. %s"
      cmd_name
      expl
  ;;
end
