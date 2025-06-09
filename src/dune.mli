open Import

type t =
  { root : Path.t
  ; bin : Cmd.spawn
  }

val is_project_locked : t -> bool Promise.t
val is_ocamllsp_present : t -> bool Promise.t
val exec : t -> args:string list -> Cmd.t
val equal : t -> t -> bool
val make : root:Path.t -> unit -> t option Promise.t
val root : t -> Path.t
