open Import

type t

val make : Sandbox.t -> t Promise.t

val sandbox : t -> Sandbox.t

val language_client : t -> LanguageClient.t option

val ocaml_lsp : t -> Ocaml_lsp.t option

val lsp_client : t -> (LanguageClient.t * Ocaml_lsp.t) option

val update_on_new_sandbox : t -> Sandbox.t -> (unit, string) result Promise.t

val start_language_server :
  Sandbox.t -> (LanguageClient.t * Ocaml_lsp.t, string) result Promise.t

val restart_language_server : t -> (unit, string) result Promise.t

val open_terminal : Sandbox.t -> unit

val disposable : t -> Disposable.t
