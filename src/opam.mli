module Switch : sig
  type t =
    | Local of Path.t
    | Named of string

  val ofString : string -> t

  val name : t -> string
end

type t

val make : unit -> t option Promise.t

val switchList : t -> Switch.t list Promise.t

val exec : t -> switch:Switch.t -> args:string list -> Cmd.t

val exists : t -> switch:Switch.t -> bool Promise.t
