open Import

type t =
  { root : Path.t
  ; bin : Cmd.spawn
  }

val detect_dune_lock_dir : t -> bool Promise.t
val detect_dune_ocamllsp : t -> bool Promise.t
val exec : t -> args:string list -> Cmd.t
val equal : t -> t -> bool
val make : root:Path.t -> unit -> t option Promise.t
val root : t -> Path.t
