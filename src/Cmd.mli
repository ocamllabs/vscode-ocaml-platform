(** Interface for running system commands *)

type t

val make :
  ?env:string Js.Dict.t -> cmd:string -> unit -> (t, string) result Promise.t

type stdout = string

type stderr = string

val output :
     args:string Js.Array.t
  -> ?cwd:Path.t
  -> t
  -> (stdout, stderr) result Promise.t

val binPath : t -> string
