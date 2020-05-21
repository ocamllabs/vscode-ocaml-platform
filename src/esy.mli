open Import

type t

val make : unit -> t option Promise.t

type discover =
  { file : Path.t
  ; status : (unit, string) result
  }

val discover : dir:Path.t -> discover list Promise.t

val env : t -> manifest:Path.t -> string Js.Dict.t Or_error.t Promise.t

val exec : t -> manifest:Path.t -> args:string array -> Path.t * string array

val setupToolchain : t -> manifest:Path.t -> unit Or_error.t Promise.t
