type resources

val init :
     env:string Js.Dict.t
  -> folder:string
  -> (resources, string) result Js.Promise.t

val setup : resources -> (resources, string) result Js.Promise.t

val getLspCommand : resources -> string * string array
