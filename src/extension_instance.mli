open Import

type t

val make : Toolchain.t -> (t, string) result Promise.t

val toolchain : t -> Toolchain.t

val language_client : t -> LanguageClient.t

val ocaml_lsp : t -> Ocaml_lsp.t

val update_on_new_toolchain :
  t -> Toolchain.t -> (unit, string) result Promise.t

val start_language_server :
  Toolchain.t -> (LanguageClient.t * Ocaml_lsp.t, string) result Promise.t

val restart_language_server : t -> (unit, string) result Promise.t

val open_terminal : Toolchain.t -> unit

val disposable : t -> Disposable.t
