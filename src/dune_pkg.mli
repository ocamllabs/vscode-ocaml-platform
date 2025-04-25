type t = Path.t

val detect_dune_ocamllsp : Path.t -> unit -> bool Promise.t
val exec : args:string list -> Cmd.t
val equal : Path.t -> Path.t -> bool

module Package : sig
  type t = unit

  val name : 'a -> 'b
  val version : 'a -> 'b
  val documentation : 'a -> 'b
  val synopsis : 'a -> 'b
  val has_dependencies : 'a -> 'b
  val dependencies : 'a -> 'b
end

module LockDir : sig
  type t = Path.t

  val make : unit -> t option Promise.t
  val detect : Path.t -> unit -> bool Promise.t
end
