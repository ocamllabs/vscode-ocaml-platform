(** Interface for running system commands *)

type t

val make : env:string Js.Dict.t -> cmd:string -> (t, string) result Promise.t

type stdout = string

type stderr = string

val output :
  args:string Js.Array.t -> cwd:string -> t -> (stdout, stderr) result Promise.t

val binPath : t -> string
