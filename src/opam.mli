open Import

module Switch : sig
  type t =
    | Local of Path.t
    | Named of string

  val ofString : string -> t

  val toString : t -> string
end

type t

val make : unit -> t option Promise.t

val switchList : t -> Switch.t list Promise.t

val env : t -> switch:Switch.t -> string Js.Dict.t Or_error.t Promise.t

val exec : t -> switch:Switch.t -> args:string list -> [> Cmd.spawn ]

val exists : t -> switch:Switch.t -> bool Promise.t
