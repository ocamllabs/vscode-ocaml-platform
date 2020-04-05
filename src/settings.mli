open Import

type 'a t

val get : 'a t -> 'a option

val set : 'a t -> 'a -> unit Promise.t

val create :
     scope:WorkspaceConfiguration.configurationTarget
  -> key:string
  -> of_string:(string -> 'a Or_error.t)
  -> to_string:('a -> string)
  -> 'a t

val string :
  scope:WorkspaceConfiguration.configurationTarget -> key:string -> string t
