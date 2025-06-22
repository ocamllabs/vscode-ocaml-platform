type 'a handle = private
  { id : string
  ; js : 'a Interop.Js.t
  }

val execute : 'a handle -> Ojs.t list -> 'a Promise.t
val select_sandbox : unit handle
val install_ocaml_lsp_server : unit handle
val upgrade_ocaml_lsp_server : unit handle
val restart_language_server : unit handle
val select_sandbox_and_open_terminal : unit handle
val open_terminal : unit handle
val switch_impl_intf : unit handle
val remove_switch : unit handle
val refresh_switches : unit handle
val refresh_sandbox : unit handle
val upgrade_sandbox : unit handle
val install_sandbox : unit handle
val uninstall_sandbox_package : unit handle
val open_switches_documentation : unit handle
val open_sandbox_documentation : unit handle
val stop_documentation_server : unit handle
val generate_sandbox_documentation : unit handle
val open_current_dune_file : unit handle
val evaluate_selection : unit handle
val open_repl : unit handle
val next_hole : unit handle
val prev_hole : unit handle
val open_ast_explorer_to_the_side : unit handle
val reveal_ast_node : unit handle
val switch_hover_mode : unit handle
val show_preprocessed_document : unit handle
val open_pp_editor_and_ast_explorer : unit handle
val open_ocamllsp_output : unit handle
val open_ocaml_platform_ext_output : unit handle
val open_ocaml_commands_output : unit handle
val start_debugging : unit handle
val goto_closure_code_location : unit handle
val ask_debug_program : string option Promise.t handle
val copy_type_under_cursor : unit handle
val construct : unit handle
val merlin_jump : unit handle
val search_by_type : unit handle
val navigate_typed_holes : unit handle
val type_selection : unit handle
val type_previous_selection : unit handle
val augment_selection_type_verbosity : unit handle

module Command_errors : sig
  val text_editor_must_be_active : expl:string -> string -> string
end
