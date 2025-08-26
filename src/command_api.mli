type ('a, 'b) handle = private
  { id : string
  ; args_to_js : 'a -> Ojs.t list
  ; args_of_js : Ojs.t list -> 'a
  ; return_type : 'b Interop.Js.t
  }

val execute : ('a, 'b) handle -> 'a -> 'b Promise.t

module Internal : sig
  val select_sandbox : (unit, unit) handle
  val install_ocaml_lsp_server : (unit, unit) handle
  val upgrade_ocaml_lsp_server : (unit, unit) handle
  val restart_language_server : (unit, unit) handle
  val select_sandbox_and_open_terminal : (unit, unit) handle
  val open_terminal : (unit, unit) handle
  val switch_impl_intf : (unit, unit) handle
  val remove_switch : (Ojs.t, unit) handle
  val refresh_switches : (unit, unit) handle
  val refresh_sandbox : (unit, unit) handle
  val upgrade_sandbox : (unit, unit) handle
  val install_sandbox : (unit, unit) handle
  val uninstall_sandbox_package : (Ojs.t, unit) handle
  val open_switches_documentation : (Ojs.t, unit) handle
  val open_sandbox_documentation : (Ojs.t, unit) handle
  val stop_documentation_server : (unit, unit) handle
  val generate_sandbox_documentation : (Ojs.t, unit) handle
  val open_current_dune_file : (unit, unit) handle
  val evaluate_selection : (unit, unit) handle
  val open_repl : (unit, unit) handle
  val next_hole : (Jsonoo.t option, unit) handle
  val prev_hole : (unit, unit) handle
  val open_ast_explorer_to_the_side : (unit, unit) handle
  val reveal_ast_node : (unit, unit) handle
  val switch_hover_mode : (unit, unit) handle
  val show_preprocessed_document : (unit, unit) handle
  val open_pp_editor_and_ast_explorer : (unit, unit) handle
  val open_ocamllsp_output : (unit, unit) handle
  val open_ocaml_platform_ext_output : (unit, unit) handle
  val open_ocaml_commands_output : (unit, unit) handle
  val start_debugging : (Vscode.Uri.t option, unit) handle
  val goto_closure_code_location : (Jsonoo.t, unit) handle
  val ask_debug_program : (unit, string option Promise.t) handle
  val copy_type_under_cursor : (unit, unit) handle
  val construct : (unit, unit) handle
  val merlin_jump : (unit, unit) handle
  val search_by_type : (unit, unit) handle
  val navigate_typed_holes : (unit, unit) handle
  val type_selection : (unit, unit) handle
  val type_previous_selection : (unit, unit) handle
  val augment_selection_type_verbosity : (unit, unit) handle
  val install_dune_lsp : (unit, unit) handle
  val run_dune_pkg_lock : (unit, unit) handle
  val install_opam : (unit, unit) handle
  val init_opam : (unit, unit) handle
  val install_ocaml_dev : (unit, unit) handle
  val open_utop : (unit, unit) handle
end

module Vscode : sig
  val open_ : (Vscode.Uri.t, unit) handle
  val open_with : (Vscode.Uri.t * string * Vscode.ViewColumn.t, unit) handle
  val set_context : (string * bool, unit) handle
  val show_hover : (unit, unit) handle
  val show_simple_browser : (string, unit) handle
end

module Command_errors : sig
  val text_editor_must_be_active : expl:string -> string -> string
end
