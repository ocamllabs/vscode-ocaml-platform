open Import

type t

val make : unit -> t

val sandbox : t -> Sandbox.t

val set_sandbox : t -> Sandbox.t -> unit

val language_client : t -> LanguageClient.t option

val ocaml_lsp : t -> Ocaml_lsp.t option

val start_documentation_server :
  t -> path:Path.t -> (Documentation_server.t, unit) result Promise.t

val stop_documentation_server : t -> unit

val lsp_client : t -> (LanguageClient.t * Ocaml_lsp.t) option

val ocaml_version_exn : t -> Ocaml_version.t

val start_language_server : t -> unit Promise.t

val set_configuration :
     t
  -> codelens:bool option
  -> extended_hover:bool option
  -> dune_diagnostics:bool option
  -> syntax_documentation:bool option
  -> unit

val open_terminal : Sandbox.t -> unit

val disposable : t -> Disposable.t

val repl : t -> Terminal_sandbox.t option

val set_repl : t -> Terminal.t -> unit

val close_repl : t -> unit

val repl_prev_eval_text_info :
  t -> TextEditorDecorationType.t option * Range.t option

val set_repl_prev_eval_text_info :
  t -> ty:TextEditorDecorationType.t option -> range:Range.t option -> unit

val update_ocaml_info : t -> unit Promise.t

val ast_editor_state : t -> Ast_editor_state.t
