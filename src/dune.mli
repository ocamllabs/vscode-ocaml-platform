(** Provide an interface to Dune pkg management.*)
open Import

module Dune_version : sig
  type t

  val to_string : t -> string
  val from_string : string -> t option
  val is_valid : t -> bool
end

val construct_dune_path : string -> Path.t

type t =
  { root : Path.t
  ; bin : Cmd.spawn
  ; opam_switch : Opam.Switch.t option
  }

(** Check if dune package management is enable. *)
val is_dpm_enabled : t -> bool Promise.t

(** Generic function to execute dune commands *)
val command : t -> args:string list -> Cmd.t

(** Generic function to execute dune exec commands *)
val exec : target:string -> ?args:string list -> t -> Cmd.t

(** Run specific `dune pkg <foo> commands` *)
val exec_pkg : cmd:string -> ?args:string list -> t -> Cmd.t

(** Get command to upgrade dune to the latest version *)
val get_upgrade_dune_cmd : t -> (string, string) result Promise.t

(** Run `dune tools <exec/which>` *)
val tools
  :  tool:string
  -> ?args:string list
  -> t
  -> [< `Exec_ | `Which | `Install ]
  -> Cmd.t

(** Run `dune tools env` *)
val env : t -> Cmd.t

(** Check if the dune project has ocamllsp server as a dev-tool. *)
val is_ocamllsp_present : t -> bool Promise.t

(** Check if amy two instances of dune pkg management projects are equal *)
val equal : t -> t -> bool

val make
  :  working_dir:Path.t
  -> dune_path:Path.t
  -> ?opam_switch:Opam.Switch.t
  -> unit
  -> t option Promise.t

val get_opam_dunes
  :  Opam.t option
  -> (string * Opam.Switch.t * Dune_version.t) list Promise.t

val get_system_dune_path : unit -> (string * Dune_version.t) option Promise.t

(** Get the path of the project root directory *)
val root : t -> Path.t

val dune_path : t -> Path.t
val opam_switch : t -> Opam.Switch.t option
val is_opam : t -> bool
