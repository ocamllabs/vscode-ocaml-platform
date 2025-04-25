open Import

type t = Path.t

module LockDir : sig
  type t = Path.t

  val make : unit -> t option Promise.t
  val detect : Path.t -> unit -> bool Promise.t
  val equal : t -> t -> bool
end

module Package : sig
  type t

  val name : t -> string
  val version : t -> string
  val documentation : t -> string option
  val synopsis : t -> string option
  val has_dependencies : t -> bool
  val dependencies : t -> ('a list, string) result Promise.t
end

val detect_dune_ocamllsp : Path.t -> unit -> bool Promise.t
val exec : args:string list -> Cmd.t
val equal : t -> t -> bool
