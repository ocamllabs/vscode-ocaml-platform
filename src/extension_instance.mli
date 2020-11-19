open Import

type t =
  { mutable toolchain : Toolchain.t option
  ; mutable client : LanguageClient.t option
  ; mutable ocaml_lsp : Ocaml_lsp.t option
  ; mutable sandbox_info : StatusBarItem.t option
  ; dune_task_provider : Dune_task_provider.t
  }

val create : unit -> t

val start : t -> Toolchain.t -> (unit, string) result Promise.t

val stop : t -> unit

val start_language_server : t -> Toolchain.t -> (unit, string) result Promise.t

val stop_language_server : t -> unit

val open_terminal : Toolchain.t -> unit

val disposable : t -> Disposable.t
