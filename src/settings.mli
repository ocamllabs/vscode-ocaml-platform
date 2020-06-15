open Import

type 'a t

val getSection : ?section:string -> 'a t -> 'a option

val setSection : ?section:string -> 'a t -> 'a -> unit Promise.t

val get : 'a t -> 'a option

val set : 'a t -> 'a -> unit Promise.t

val create :
     scope:WorkspaceConfiguration.configurationTarget
  -> key:string
  -> ofJson:(Js.Json.t -> 'a)
  -> toJson:('a -> Js.Json.t)
  -> 'a t

val string :
  scope:WorkspaceConfiguration.configurationTarget -> key:string -> string t
