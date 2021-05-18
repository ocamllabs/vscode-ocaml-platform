[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - Iterable<T1>
  - Promise<T1>
 *)
[@@@js.stop]
module type Missing = sig
  module Iterable : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module Promise : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module Iterable : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module Promise : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
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
      type _PromiseConstructor = [`PromiseConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T _PromiseFulfilledResult = [`PromiseFulfilledResult of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and _PromiseRejectedResult = [`PromiseRejectedResult] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T _PromiseSettledResult = ([`U_s0_fulfilled of 'T _PromiseFulfilledResult [@js "fulfilled"] | `U_s1_rejected of _PromiseRejectedResult [@js "rejected"]] [@js.union on_field "status"])
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "PromiseFulfilledResult"] PromiseFulfilledResult : sig
    type 'T t = 'T _PromiseFulfilledResult
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    val get_status: 'T t -> ([`L_s0_fulfilled[@js "fulfilled"]] [@js.enum]) [@@js.get "status"]
    val set_status: 'T t -> ([`L_s0_fulfilled] [@js.enum]) -> unit [@@js.set "status"]
    val get_value: 'T t -> 'T [@@js.get "value"]
    val set_value: 'T t -> 'T -> unit [@@js.set "value"]
  end
  module[@js.scope "PromiseRejectedResult"] PromiseRejectedResult : sig
    type t = _PromiseRejectedResult
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_status: t -> ([`L_s1_rejected[@js "rejected"]] [@js.enum]) [@@js.get "status"]
    val set_status: t -> ([`L_s1_rejected] [@js.enum]) -> unit [@@js.set "status"]
    val get_reason: t -> any [@@js.get "reason"]
    val set_reason: t -> any -> unit [@@js.set "reason"]
  end
  module PromiseSettledResult : sig
    type 'T t = 'T _PromiseSettledResult
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
  end
  module[@js.scope "PromiseConstructor"] PromiseConstructor : sig
    type t = _PromiseConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val allSettled: t -> values:'T -> (* FIXME: unknown type '{ -readonly [P in keyof T]: PromiseSettledResult<T[P] extends PromiseLike<infer U> ? U : T[P]> }' *)any Promise.t_1 [@@js.call "allSettled"]
    val allSettled': t -> values:'T Iterable.t_1 -> (* FIXME: unknown type 'T extends PromiseLike<infer U> ? U : T' *)any _PromiseSettledResult list Promise.t_1 [@@js.call "allSettled"]
  end
end
