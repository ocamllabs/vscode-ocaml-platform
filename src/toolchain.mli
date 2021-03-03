(** Manages OCaml Platform toolchain

    The toolchain is installed in a private sandbox, managed by VSCode only,
    where the tools we depend on are installed automatically.

    The sandbox uses Opam, but it does not conflict with users who use Esy as
    their package managers, since the tools are separated from the project. *)

type t

val setup : ?project_sandbox:Sandbox.t -> unit -> (t, string) result Promise.t

val upgrade : t -> (unit, string) result Promise.t

(* Helper utils *)

(** Extract lsp command and arguments *)
val get_lsp_command : ?args:string list -> t -> Cmd.t Promise.t

(** Extract a dune command *)
val get_dune_command : ?args:string list -> t -> Cmd.t Promise.t

(** Extract a ocamlformat command and arguments *)
val get_ocamlformat_command : ?args:string list -> t -> Cmd.t Promise.t

val to_pretty_string : t -> string
