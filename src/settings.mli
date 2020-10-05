open Import

type 'a t

val get : ?section:string -> 'a t -> 'a option

val set : ?section:string -> 'a t -> 'a -> unit Promise.t

val create :
     scope:ConfigurationTarget.t
  -> key:string
  -> of_json:(Jsonoo.t -> 'a)
  -> to_json:('a -> Jsonoo.t)
  -> 'a t

val string : scope:ConfigurationTarget.t -> key:string -> string t
