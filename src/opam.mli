module Switch : sig
  type t =
    | Local of Path.t
    | Named of string

  val of_string : string -> t option

  val name : t -> string

  val equal : t -> t -> bool
end

module Package : sig
  type t

  val name : t -> string

  val version : t -> string

  val documentation : t -> string option

  val synopsis : t -> string option

  val of_path : Path.t -> t option Promise.t

  val sexp_of_t : t -> Sexplib.Sexp.t

  val t_of_sexp : Sexplib.Sexp.t -> t
end

type t

val make : unit -> t option Promise.t

val switch_list : t -> Switch.t list Promise.t

val switch_show : ?cwd:Path.t -> t -> Switch.t option Promise.t

val exec : t -> switch:Switch.t -> args:string list -> Cmd.t

val exists : t -> switch:Switch.t -> bool Promise.t

val equal : t -> t -> bool

val get_switch_packages :
  t -> Switch.t -> (Package.t list, string) result Promise.t

val get_switch_compiler : t -> Switch.t -> string option Promise.t

val remove_switch : t -> Switch.t -> Cmd.t

val uninstall_package : t -> switch:Switch.t -> package:Package.t -> Cmd.t
