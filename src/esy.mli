open Import

type t

val make : unit -> t option Promise.t

module Manifest : sig
  type t =
    { root : Path.t
    ; file : string option
    }

  val path : t -> Path.t

  val to_string : t -> string

  val to_pretty_string : t -> string
end

type discover =
  { manifest : Manifest.t
  ; status : (unit, string) result
  }

val discover : dir:Path.t -> discover list Promise.t

val exec : t -> manifest:Manifest.t -> args:string list -> Cmd.t

val setup_toolchain : t -> manifest:Manifest.t -> unit Or_error.t Promise.t
