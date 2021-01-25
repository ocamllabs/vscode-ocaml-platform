(** Provide an interface to Esy.

    The functions in this module either use the result of esy commands, or use
    the filesystem to get the state of esy configurations. *)

open Import

module Manifest : sig
  type t

  val equal : t -> t -> bool

  val path : t -> Path.t

  val of_path : Path.t -> t
end

(** A package installed in an Esy sandbox *)
module Package : sig
  type t

  (** {4 Properties} *)

  val name : t -> string

  val version : t -> string

  val documentation : t -> string option

  val synopsis : t -> string option

  val has_dependencies : t -> bool

  val dependencies : t -> (t list, string) result Promise.t
end

type t

val make : unit -> t option Promise.t

type discover =
  { manifest : Manifest.t
  ; status : (unit, string) result
  }

val discover : dir:Path.t -> discover list Promise.t

val find_manifest_in_dir : Path.t -> Manifest.t option Promise.t

val setup_sandbox : t -> Manifest.t -> unit Or_error.t Promise.t

(** {4 Working with packages} *)

(** Return the list of installed packages in the given opam switch. *)
val packages : t -> Manifest.t -> (Package.t list, string) result Promise.t

(** Return the list of root packages in the given opam switch.

    Root packages are packages that have been installed by the user, as opposed
    to packages that have been installed as a dependency of another package. *)
val root_packages : t -> Manifest.t -> (Package.t list, string) result Promise.t

(** {4 General utilities} *)

(** Execute an esy sub-command with in the given sandbox. *)
val exec : t -> Manifest.t -> args:string list -> Cmd.t

(** Check that two instances of [Esy] are equal. *)
val equal : t -> t -> bool
