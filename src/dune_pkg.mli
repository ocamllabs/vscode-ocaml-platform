open Import

type t =
  { root : Path.t
  ; bin : Cmd.spawn
  }

module Package : sig
  type t

  val name : t -> string
  val version : t -> string
  val documentation : t -> string option
  val synopsis : t -> string option
  val has_dependencies : t -> bool
  val dependencies : t -> ('a list, string) result Promise.t
end

val detect_dune_lock_dir : Path.t -> unit -> bool Promise.t
val detect_dune_ocamllsp : Path.t -> unit -> bool Promise.t
val exec : t -> args:string list -> Cmd.t
val equal : t -> t -> bool
val make : root:Path.t -> unit -> t option Promise.t
val root : t -> Path.t
