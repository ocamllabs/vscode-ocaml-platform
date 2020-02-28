type t
type resources
val init :
  env:string Js.Dict.t ->
    folder:string -> (resources, string) result Js.Promise.t
val setup : resources -> (t, string) result Js.Promise.t
val lsp : t -> (string * string array)