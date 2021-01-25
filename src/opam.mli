(** Provide an interface to Opam.

    The functions in this module either use the result of opam commands, or use
    the filesystem to get the state of opam configurations. *)

(** An Opam switch *)
module Switch : sig
  type t =
    | Local of Path.t
    | Named of string

  (** {4 Constructors} *)

  val of_string : string -> t option

  (** {4 Properties} *)

  val name : t -> string

  (** {4 Utilities} *)

  val equal : t -> t -> bool
end

(** A package installed in an Opam switch *)
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

(** Install new packages in a switch *)
val install : t -> Switch.t -> string list -> Cmd.t

(** Update the opam repository *)
val update : t -> Cmd.t

(** Upgrade packages in a switch *)
val upgrade : t -> Switch.t -> Cmd.t

(* Remove a list of packages from a switch *)
val remove : t -> Switch.t -> string list -> Cmd.t

(** {4 Working with switches} *)

(** Path of the switch on the filesystem.

    If the switch is a local switch, the path is [switch_path ^ _opam],
    otherwise it is the result of [opam var root]. *)
val switch_path : t -> Switch.t -> (Path.t, string) result Promise.t

(** List the opam switches available on the system. *)
val switch_list : t -> Switch.t list Promise.t

(** Checks that the given switch exists. *)
val switch_exists : t -> Switch.t -> bool Promise.t

(** Return the current opam switch. *)
val switch_show : ?cwd:Path.t -> t -> Switch.t option Promise.t

(** Return the compiler version used by the given switch. *)
val switch_compiler : t -> Switch.t -> string option Promise.t

(** Remove the given switch by calling [opam switch remove]. *)
val switch_remove : t -> Switch.t -> Cmd.t

(** {4 Working with packages} *)

(** Return the list of installed packages in the given opam switch. *)
val packages : t -> Switch.t -> (Package.t list, string) result Promise.t

(** Return the list of root packages in the given opam switch.

    Root packages are packages that have been installed by the user, as opposed
    to packages that have been installed as a dependency of another package. *)
val root_packages : t -> Switch.t -> (Package.t list, string) result Promise.t

(** Uninstall a package from a switch by calling [opam uninstall]. *)
val package_remove : t -> Switch.t -> Package.t list -> Cmd.t

(** {4 General utilities} *)

(** Execute an opam sub-command with in the given switch. *)
val exec : t -> Switch.t -> args:string list -> Cmd.t

(** Check that two instances of [Opam] are equal. *)
val equal : t -> t -> bool
