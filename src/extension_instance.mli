open Import

type t

val make : unit -> t

val sandbox : t -> Sandbox.t

val set_sandbox : t -> Sandbox.t -> unit

val language_client : t -> Language_client.t option

val ocaml_lsp : t -> Ocaml_lsp.t option

val lsp_client : t -> (Language_client.t * Ocaml_lsp.t) option

val start_language_server : t -> unit Promise.t

val open_terminal : Sandbox.t -> unit

val disposable : t -> Disposable.t

val repl : t -> Terminal_sandbox.t option

val set_repl : t -> Terminal.t -> unit

val close_repl : t -> unit
