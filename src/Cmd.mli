type t

val make : env:string Js.Dict.t -> cmd:string -> (t, string) result Js.Promise.t

type stdout = string

type stderr = string

val output :
     args:string Js.Array.t
  -> cwd:string
  -> t
  -> (stdout, stderr) result Js.Promise.t

val binPath : t -> string
