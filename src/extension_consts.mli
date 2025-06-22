type 'a command_ref = private
  { id : string
  ; js : 'a Interop.Js.t
  }

module Commands : sig
  val select_sandbox : unit command_ref
  val install_ocaml_lsp_server : unit command_ref
  val upgrade_ocaml_lsp_server : unit command_ref
  val restart_language_server : unit command_ref
  val select_sandbox_and_open_terminal : unit command_ref
  val open_terminal : unit command_ref
  val switch_impl_intf : unit command_ref
  val remove_switch : unit command_ref
  val refresh_switches : unit command_ref
  val refresh_sandbox : unit command_ref
  val upgrade_sandbox : unit command_ref
  val install_sandbox : unit command_ref
  val uninstall_sandbox_package : unit command_ref
  val open_switches_documentation : unit command_ref
  val open_sandbox_documentation : unit command_ref
  val stop_documentation_server : unit command_ref
  val generate_sandbox_documentation : unit command_ref
  val open_current_dune_file : unit command_ref
  val evaluate_selection : unit command_ref
  val open_repl : unit command_ref
  val next_hole : unit command_ref
  val prev_hole : unit command_ref
  val open_ast_explorer_to_the_side : unit command_ref
  val reveal_ast_node : unit command_ref
  val switch_hover_mode : unit command_ref
  val show_preprocessed_document : unit command_ref
  val open_pp_editor_and_ast_explorer : unit command_ref
  val open_ocamllsp_output : unit command_ref
  val open_ocaml_platform_ext_output : unit command_ref
  val open_ocaml_commands_output : unit command_ref
  val start_debugging : unit command_ref
  val goto_closure_code_location : unit command_ref
  val ask_debug_program : string option Promise.t command_ref
  val copy_type_under_cursor : unit command_ref
  val construct : unit command_ref
  val merlin_jump : unit command_ref
  val search_by_type : unit command_ref
  val navigate_typed_holes : unit command_ref
  val type_selection : unit command_ref
  val type_previous_selection : unit command_ref
  val augment_selection_type_verbosity : unit command_ref
end

module Command_errors : sig
  val text_editor_must_be_active : expl:string -> string -> string
end

val execute : 'a command_ref -> Ojs.t list -> 'a Promise.t
