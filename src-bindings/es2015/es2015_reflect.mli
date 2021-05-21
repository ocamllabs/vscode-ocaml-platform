[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es5

module Reflect : sig
  val apply :
       target:untyped_function
    -> this_argument:any
    -> arguments_list:any Array.t
    -> any
    [@@js.global "apply"]

  val construct :
       target:untyped_function
    -> arguments_list:any Array.t
    -> ?new_target:untyped_function
    -> unit
    -> any
    [@@js.global "construct"]

  val define_property :
       target:untyped_object
    -> property_key:Property_key.t
    -> attributes:Property_descriptor.t
    -> bool
    [@@js.global "defineProperty"]

  val delete_property :
    target:untyped_object -> property_key:Property_key.t -> bool
    [@@js.global "deleteProperty"]

  val get :
       target:untyped_object
    -> property_key:Property_key.t
    -> ?receiver:any
    -> unit
    -> any
    [@@js.global "get"]

  val get_own_property_descriptor :
       target:untyped_object
    -> property_key:Property_key.t
    -> Property_descriptor.t or_undefined
    [@@js.global "getOwnPropertyDescriptor"]

  val get_prototype_of : target:untyped_object -> untyped_object or_null
    [@@js.global "getPrototypeOf"]

  val has : target:untyped_object -> property_key:Property_key.t -> bool
    [@@js.global "has"]

  val is_extensible : target:untyped_object -> bool [@@js.global "isExtensible"]

  val own_keys : target:untyped_object -> symbol or_string list
    [@@js.global "ownKeys"]

  val prevent_extensions : target:untyped_object -> bool
    [@@js.global "preventExtensions"]

  val set :
       target:untyped_object
    -> property_key:Property_key.t
    -> value:any
    -> ?receiver:any
    -> unit
    -> bool
    [@@js.global "set"]

  val set_prototype_of :
    target:untyped_object -> proto:untyped_object or_null -> bool
    [@@js.global "setPrototypeOf"]
end
[@@js.scope "Reflect"]
