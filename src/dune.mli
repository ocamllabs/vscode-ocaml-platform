(** Provide an interface to Dune pkg management.*)
open Import

module Dune_version : sig
  type t

  val to_string : t -> string
end

type scope =
  | Global
  | Switch

type t =
  { root : Path.t
  ; bin : [ `Global of Cmd.spawn | `Switch of Opam.t * Opam.Switch.t ]
  }

val scope_of_json : Jsonoo.t -> [> `Global | `Switch ]

(** Check if dune package management is enable. *)
val is_dpm_enabled : t -> bool Promise.t

(** Generic function to execute dune commands *)
val command : t -> args:string list -> Cmd.t

(** Generic function to execute dune exec commands *)
val exec : target:string -> ?args:string list -> t -> Cmd.t

(** Run specific `dune pkg <foo> commands*)
val exec_pkg : cmd:string -> ?args:string list -> t -> Cmd.t

(** Run `dune tools <exec/which>` *)
val tools
  :  tool:string
  -> ?args:string list
  -> t
  -> [< `Exec_ | `Which | `Install ]
  -> Cmd.t

(** Check if the dune project has ocamllsp server as a dev-tool. *)
val is_ocamllsp_present : t -> bool Promise.t

(** Check if amy two instances of dune pkg management projects are equal *)
val equal : t -> t -> bool

val make : root:Path.t -> path:string -> [< `Global | `Switch ] -> t option Promise.t

val get_dune_binaries
  :  Path.t option
  -> Opam.t option
  -> unit
  -> ((Cmd.spawn * Dune_version.t) option * (Opam.Switch.t * Dune_version.t) list)
       Promise.t

(** Get the path of the project root directory *)
val root : t -> Path.t

val path_scope : t -> string * scope
