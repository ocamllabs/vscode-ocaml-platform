open Import

type t

val make : unit -> t option Promise.t

type discover =
  { file : Path.t
  ; status : (unit, string) result
  }

val discover : dir:Path.t -> discover list Promise.t

val find_manifest_in_dir : Path.t -> Path.t option Promise.t

val exec : t -> manifest:Path.t -> args:string list -> Cmd.t

val setup_toolchain : t -> manifest:Path.t -> unit Or_error.t Promise.t

val equal : t -> t -> bool
