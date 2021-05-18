[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - ArrayLike<T1>
  - PropertyDescriptor
  - PropertyKey
 *)
[@@@js.stop]
module type Missing = sig
  module ArrayLike : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module PropertyDescriptor : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module PropertyKey : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module ArrayLike : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module PropertyDescriptor : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module PropertyKey : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
  end
]
module Make (M: Missing) : sig
  open M
  module Internal : sig
    module AnonymousInterfaces : sig
      
    end
    module Types : sig
      open AnonymousInterfaces
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "Reflect"] Reflect : sig
    val apply_: target:untyped_function -> thisArgument:any -> argumentsList:any ArrayLike.t_1 -> any [@@js.global "apply"]
    val construct: target:untyped_function -> argumentsList:any ArrayLike.t_1 -> ?newTarget:untyped_function -> unit -> any [@@js.global "construct"]
    val defineProperty: target:untyped_object -> propertyKey:PropertyKey.t_0 -> attributes:PropertyDescriptor.t_0 -> bool [@@js.global "defineProperty"]
    val deleteProperty: target:untyped_object -> propertyKey:PropertyKey.t_0 -> bool [@@js.global "deleteProperty"]
    val get_: target:untyped_object -> propertyKey:PropertyKey.t_0 -> ?receiver:any -> unit -> any [@@js.global "get"]
    val getOwnPropertyDescriptor: target:untyped_object -> propertyKey:PropertyKey.t_0 -> PropertyDescriptor.t_0 or_undefined [@@js.global "getOwnPropertyDescriptor"]
    val getPrototypeOf: target:untyped_object -> untyped_object or_null [@@js.global "getPrototypeOf"]
    val has: target:untyped_object -> propertyKey:PropertyKey.t_0 -> bool [@@js.global "has"]
    val isExtensible: target:untyped_object -> bool [@@js.global "isExtensible"]
    val ownKeys: target:untyped_object -> symbol or_string list [@@js.global "ownKeys"]
    val preventExtensions: target:untyped_object -> bool [@@js.global "preventExtensions"]
    val set_: target:untyped_object -> propertyKey:PropertyKey.t_0 -> value:any -> ?receiver:any -> unit -> bool [@@js.global "set"]
    val setPrototypeOf: target:untyped_object -> proto:untyped_object or_null -> bool [@@js.global "setPrototypeOf"]
  end
end
