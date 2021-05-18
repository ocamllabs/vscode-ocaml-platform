[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - ArrayLike<T1>
  - PropertyDescriptor
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
  end
]
module Make (M: Missing) : sig
  open M
  module Internal : sig
    module AnonymousInterfaces : sig
      type anonymous_interface_0 = [`anonymous_interface_0] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
    module Types : sig
      open AnonymousInterfaces
      type _ProxyConstructor = [`ProxyConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T _ProxyHandler = [`ProxyHandler of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module AnonymousInterface0 : sig
    type t = anonymous_interface_0
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_proxy: t -> 'T [@@js.get "proxy"]
    val set_proxy: t -> 'T -> unit [@@js.set "proxy"]
    val revoke: t -> unit [@@js.call "revoke"]
  end
  module[@js.scope "ProxyHandler"] ProxyHandler : sig
    type 'T t = 'T _ProxyHandler
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    val apply_: 'T t -> target:'T -> thisArg:any -> argArray:any list -> any [@@js.call "apply"]
    val construct: 'T t -> target:'T -> argArray:any list -> newTarget:untyped_function -> untyped_object [@@js.call "construct"]
    val defineProperty: 'T t -> target:'T -> p:symbol or_string -> attributes:PropertyDescriptor.t_0 -> bool [@@js.call "defineProperty"]
    val deleteProperty: 'T t -> target:'T -> p:symbol or_string -> bool [@@js.call "deleteProperty"]
    val get_: 'T t -> target:'T -> p:symbol or_string -> receiver:any -> any [@@js.call "get"]
    val getOwnPropertyDescriptor: 'T t -> target:'T -> p:symbol or_string -> PropertyDescriptor.t_0 or_undefined [@@js.call "getOwnPropertyDescriptor"]
    val getPrototypeOf: 'T t -> target:'T -> untyped_object or_null [@@js.call "getPrototypeOf"]
    val has: 'T t -> target:'T -> p:symbol or_string -> bool [@@js.call "has"]
    val isExtensible: 'T t -> target:'T -> bool [@@js.call "isExtensible"]
    val ownKeys: 'T t -> target:'T -> symbol or_string ArrayLike.t_1 [@@js.call "ownKeys"]
    val preventExtensions: 'T t -> target:'T -> bool [@@js.call "preventExtensions"]
    val set_: 'T t -> target:'T -> p:symbol or_string -> value:any -> receiver:any -> bool [@@js.call "set"]
    val setPrototypeOf: 'T t -> target:'T -> v:untyped_object or_null -> bool [@@js.call "setPrototypeOf"]
  end
  module[@js.scope "ProxyConstructor"] ProxyConstructor : sig
    type t = _ProxyConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val revocable: t -> target:'T -> handler:'T _ProxyHandler -> anonymous_interface_0 [@@js.call "revocable"]
    val create: t -> target:'T -> handler:'T _ProxyHandler -> 'T [@@js.apply_newable]
  end
  val proxy: _ProxyConstructor [@@js.global "Proxy"]
end
