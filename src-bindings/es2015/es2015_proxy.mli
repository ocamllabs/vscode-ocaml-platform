[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es5

module Revocable : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_proxy : t -> 'T [@@js.get "proxy"]

  val set_proxy : t -> 'T -> unit [@@js.set "proxy"]

  val revoke : t -> unit [@@js.call "revoke"]
end

module Proxy_handler : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

  val apply : 'T t -> target:'T -> this_arg:any -> arg_array:any list -> any
    [@@js.call "apply"]

  val construct :
       'T t
    -> target:'T
    -> arg_array:any list
    -> new_target:untyped_function
    -> untyped_object
    [@@js.call "construct"]

  val define_property :
       'T t
    -> target:'T
    -> p:symbol or_string
    -> attributes:Property_descriptor.t
    -> bool
    [@@js.call "defineProperty"]

  val delete_property : 'T t -> target:'T -> p:symbol or_string -> bool
    [@@js.call "deleteProperty"]

  val get : 'T t -> target:'T -> p:symbol or_string -> receiver:any -> any
    [@@js.call "get"]

  val get_own_property_descriptor :
       'T t
    -> target:'T
    -> p:symbol or_string
    -> Property_descriptor.t or_undefined
    [@@js.call "getOwnPropertyDescriptor"]

  val get_prototype_of : 'T t -> target:'T -> untyped_object or_null
    [@@js.call "getPrototypeOf"]

  val has : 'T t -> target:'T -> p:symbol or_string -> bool [@@js.call "has"]

  val is_extensible : 'T t -> target:'T -> bool [@@js.call "isExtensible"]

  val own_keys : 'T t -> target:'T -> symbol or_string Array.t
    [@@js.call "ownKeys"]

  val prevent_extensions : 'T t -> target:'T -> bool
    [@@js.call "preventExtensions"]

  val set :
    'T t -> target:'T -> p:symbol or_string -> value:any -> receiver:any -> bool
    [@@js.call "set"]

  val set_prototype_of : 'T t -> target:'T -> v:untyped_object or_null -> bool
    [@@js.call "setPrototypeOf"]
end
[@@js.scope "ProxyHandler"]

module Proxy_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val revocable : t -> target:'T -> handler:'T Proxy_handler.t -> Revocable.t
    [@@js.call "revocable"]

  val create : t -> target:'T -> handler:'T Proxy_handler.t -> 'T
    [@@js.apply_newable]
end
[@@js.scope "ProxyConstructor"]

val proxy : Proxy_constructor.t [@@js.global "Proxy"]
