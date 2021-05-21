[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2016

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t
end

module Anonymous_interface1 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get : t -> string -> 'T [@@js.index_get]

  val set : t -> string -> 'T -> unit [@@js.index_set]
end

module Anonymous_interface2 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get : t -> string -> Property_descriptor.t [@@js.index_get]

  val set : t -> string -> Property_descriptor.t -> unit [@@js.index_set]
end

module Object : sig
  include module type of struct
    include Object
  end

  (* Constructor *)

  val values : (Anonymous_interface1.t, 'T Array.t) union2 -> 'T list
    [@@js.global "Object.values"]

  val values' : Anonymous_interface0.t -> any list [@@js.global "Object.values"]

  val entries :
    (Anonymous_interface1.t, 'T Array.t) union2 -> (string * 'T) list
    [@@js.global "Object.entries"]

  val entries' : Anonymous_interface0.t -> (string * any) list
    [@@js.global "Object.entries"]

  val get_own_property_descriptors :
       'T
    -> ( (* FIXME: unknown type '{[P in keyof T]: TypedPropertyDescriptor<T[P]>}' *)
         any
       , Anonymous_interface2.t )
       intersection2
    [@@js.global "Object.getOwnPropertyDescriptors"]
end

module Object_constructor : sig
  include module type of struct
    include Object_constructor
  end

  val values : t -> (Anonymous_interface1.t, 'T Array.t) union2 -> 'T list
    [@@js.call "values"]

  val values' : t -> Anonymous_interface0.t -> any list [@@js.call "values"]

  val entries :
    t -> (Anonymous_interface1.t, 'T Array.t) union2 -> (string * 'T) list
    [@@js.call "entries"]

  val entries' : t -> Anonymous_interface0.t -> (string * any) list
    [@@js.call "entries"]

  val get_own_property_descriptors :
       t
    -> 'T
    -> ( (* FIXME: unknown type '{[P in keyof T]: TypedPropertyDescriptor<T[P]>}' *)
         any
       , Anonymous_interface2.t )
       intersection2
    [@@js.call "getOwnPropertyDescriptors"]
end
[@@js.scope "ObjectConstructor"]
