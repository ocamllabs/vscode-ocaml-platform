[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2018

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get : t -> string -> 'T [@@js.index_get]

  val set : t -> string -> 'T -> unit [@@js.index_set]
end

module Object : sig
  include module type of struct
    include Object
  end

  val from_entries :
    entries:(Property_key.t * 'T) Iterable.t -> Anonymous_interface0.t
    [@@js.global "Object.fromEntries"]

  val from_entries' : entries:any list Iterable.t -> any
    [@@js.global "Object.fromEntries"]
end

module Object_constructor : sig
  include module type of struct
    include Object_constructor
  end

  val from_entries :
    t -> entries:(Property_key.t * 'T) Iterable.t -> Anonymous_interface0.t
    [@@js.call "fromEntries"]

  val from_entries' : t -> entries:any list Iterable.t -> any
    [@@js.call "fromEntries"]
end
[@@js.scope "ObjectConstructor"]
