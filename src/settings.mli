open Import

type 'a t

val get : ?section:string -> 'a t -> 'a option

val set : ?section:string -> 'a t -> 'a -> unit Promise.t

val create :
     scope:ConfigurationTarget.t
  -> key:string
  -> ofJson:(Jsonoo.t -> 'a)
  -> toJson:('a -> Jsonoo.t)
  -> 'a t

val string : scope:ConfigurationTarget.t -> key:string -> string t
