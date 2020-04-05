open Import

type t

val make : unit -> t option Promise.t

val discover : dir:Path.t -> Path.t list Promise.t

val env : t -> manifest:Path.t -> string Js.Dict.t Or_error.t Promise.t

val exec : t -> manifest:Path.t -> args:string array -> string * string array

val setupToolchain :
  t -> manifest:Path.t -> projectRoot:Path.t -> unit Or_error.t Promise.t
