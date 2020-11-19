open Import

type t =
  { mutable toolchain : Toolchain.t
  ; mutable client : LanguageClient.t
  ; mutable ocaml_lsp : Ocaml_lsp.t
  ; sandbox_info : StatusBarItem.t
  }

val make : Toolchain.t -> (t, string) result Promise.t

val update_on_new_toolchain :
  t -> Toolchain.t -> (unit, string) result Promise.t

val start_language_server :
  Toolchain.t -> (LanguageClient.t * Ocaml_lsp.t, string) result Promise.t

val open_terminal : Toolchain.t -> unit

val disposable : t -> Disposable.t
