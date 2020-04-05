open Import

module Switch : sig
  type t =
    | Local of Path.t
    | Named of string
end

val switchList : cmd:Cmd.t -> cwd:Path.t -> Switch.t list Or_error.t Promise.t

val env :
     ?switch:string
  -> cmd:Cmd.t
  -> cwd:Path.t
  -> unit
  -> string Js.Dict.t Or_error.t Promise.t
