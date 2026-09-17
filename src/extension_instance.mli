open Import

type t

val make : extension_uri:Uri.t -> unit -> t
val sandbox : t -> Sandbox.t
val set_sandbox : t -> Sandbox.t -> unit
val language_client : t -> LanguageClient.t option
val ocaml_lsp : t -> Ocaml_lsp.t option
val check_ocaml_lsp_available : Sandbox.t -> (unit, string) result Promise.t
val show_documentation : t -> path:Path.t -> package_name:string -> unit Promise.t
val lsp_client : t -> (LanguageClient.t * Ocaml_lsp.t) option
val ocaml_version : t -> Ocaml_version.t option
val start_language_server : t -> unit Promise.t
val install_ocaml_lsp_server : Sandbox.t -> unit Promise.t
val upgrade_ocaml_lsp_server : Sandbox.t -> unit Promise.t
val set_configuration : t -> ?standard_hover:bool option -> unit -> unit
val open_terminal : Sandbox.t -> unit
val disposable : t -> Disposable.t
val repl : t -> Terminal_sandbox.t option
val set_repl : t -> Terminal.t -> unit
val close_repl : t -> unit
val ast_editor_state : t -> Ast_editor_state.t
