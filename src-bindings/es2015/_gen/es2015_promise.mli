[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - Promise<T1>
  - PromiseLike<T1>
 *)
[@@@js.stop]
module type Missing = sig
  module Promise : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module PromiseLike : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module Promise : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module PromiseLike : sig
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
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "PromiseConstructor"] PromiseConstructor : sig
    type t = _PromiseConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_prototype: t -> any _Promise [@@js.get "prototype"]
    val create: t -> executor:(resolve:(value:('T, 'T PromiseLike.t_1) union2 -> unit) -> reject:(?reason:any -> unit -> unit) -> unit) -> 'T _Promise [@@js.apply_newable]
    val all: t -> values:(('T1, 'T1 PromiseLike.t_1) union2 * ('T2, 'T2 PromiseLike.t_1) union2 * ('T3, 'T3 PromiseLike.t_1) union2 * ('T4, 'T4 PromiseLike.t_1) union2 * ('T5, 'T5 PromiseLike.t_1) union2 * ('T6, 'T6 PromiseLike.t_1) union2 * ('T7, 'T7 PromiseLike.t_1) union2 * ('T8, 'T8 PromiseLike.t_1) union2 * ('T9, 'T9 PromiseLike.t_1) union2 * ('T10, 'T10 PromiseLike.t_1) union2) -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5 * 'T6 * 'T7 * 'T8 * 'T9 * 'T10) _Promise [@@js.call "all"]
    val all': t -> values:(('T1, 'T1 PromiseLike.t_1) union2 * ('T2, 'T2 PromiseLike.t_1) union2 * ('T3, 'T3 PromiseLike.t_1) union2 * ('T4, 'T4 PromiseLike.t_1) union2 * ('T5, 'T5 PromiseLike.t_1) union2 * ('T6, 'T6 PromiseLike.t_1) union2 * ('T7, 'T7 PromiseLike.t_1) union2 * ('T8, 'T8 PromiseLike.t_1) union2 * ('T9, 'T9 PromiseLike.t_1) union2) -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5 * 'T6 * 'T7 * 'T8 * 'T9) _Promise [@@js.call "all"]
    val all'': t -> values:(('T1, 'T1 PromiseLike.t_1) union2 * ('T2, 'T2 PromiseLike.t_1) union2 * ('T3, 'T3 PromiseLike.t_1) union2 * ('T4, 'T4 PromiseLike.t_1) union2 * ('T5, 'T5 PromiseLike.t_1) union2 * ('T6, 'T6 PromiseLike.t_1) union2 * ('T7, 'T7 PromiseLike.t_1) union2 * ('T8, 'T8 PromiseLike.t_1) union2) -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5 * 'T6 * 'T7 * 'T8) _Promise [@@js.call "all"]
    val all''': t -> values:(('T1, 'T1 PromiseLike.t_1) union2 * ('T2, 'T2 PromiseLike.t_1) union2 * ('T3, 'T3 PromiseLike.t_1) union2 * ('T4, 'T4 PromiseLike.t_1) union2 * ('T5, 'T5 PromiseLike.t_1) union2 * ('T6, 'T6 PromiseLike.t_1) union2 * ('T7, 'T7 PromiseLike.t_1) union2) -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5 * 'T6 * 'T7) _Promise [@@js.call "all"]
    val all'''': t -> values:(('T1, 'T1 PromiseLike.t_1) union2 * ('T2, 'T2 PromiseLike.t_1) union2 * ('T3, 'T3 PromiseLike.t_1) union2 * ('T4, 'T4 PromiseLike.t_1) union2 * ('T5, 'T5 PromiseLike.t_1) union2 * ('T6, 'T6 PromiseLike.t_1) union2) -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5 * 'T6) _Promise [@@js.call "all"]
    val all''''': t -> values:(('T1, 'T1 PromiseLike.t_1) union2 * ('T2, 'T2 PromiseLike.t_1) union2 * ('T3, 'T3 PromiseLike.t_1) union2 * ('T4, 'T4 PromiseLike.t_1) union2 * ('T5, 'T5 PromiseLike.t_1) union2) -> ('T1 * 'T2 * 'T3 * 'T4 * 'T5) _Promise [@@js.call "all"]
    val all'''''': t -> values:(('T1, 'T1 PromiseLike.t_1) union2 * ('T2, 'T2 PromiseLike.t_1) union2 * ('T3, 'T3 PromiseLike.t_1) union2 * ('T4, 'T4 PromiseLike.t_1) union2) -> ('T1 * 'T2 * 'T3 * 'T4) _Promise [@@js.call "all"]
    val all''''''': t -> values:(('T1, 'T1 PromiseLike.t_1) union2 * ('T2, 'T2 PromiseLike.t_1) union2 * ('T3, 'T3 PromiseLike.t_1) union2) -> ('T1 * 'T2 * 'T3) _Promise [@@js.call "all"]
    val all'''''''': t -> values:(('T1, 'T1 PromiseLike.t_1) union2 * ('T2, 'T2 PromiseLike.t_1) union2) -> ('T1 * 'T2) _Promise [@@js.call "all"]
    val all''''''''': t -> values:('T, 'T PromiseLike.t_1) union2 list -> 'T list _Promise [@@js.call "all"]
    val race: t -> values:'T list -> (* FIXME: unknown type 'T extends PromiseLike<infer U> ? U : T' *)any _Promise [@@js.call "race"]
    val reject: t -> ?reason:any -> unit -> 'T _Promise [@@js.call "reject"]
    val resolve: t -> unit _Promise [@@js.call "resolve"]
    val resolve': t -> value:('T, 'T PromiseLike.t_1) union2 -> 'T _Promise [@@js.call "resolve"]
  end
  val promise: _PromiseConstructor [@@js.global "Promise"]
end
