[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - BigInt64Array
  - BigUint64Array
 *)
[@@@js.stop]
module type Missing = sig
  module BigInt64Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module BigUint64Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module BigInt64Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module BigUint64Array : sig
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
      type _Atomics = [`Atomics] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "Atomics"] Atomics : sig
    type t = _Atomics
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val add: t -> typedArray:(BigInt64Array.t_0, BigUint64Array.t_0) union2 -> index:float -> value:bigint -> bigint [@@js.call "add"]
    val and_: t -> typedArray:(BigInt64Array.t_0, BigUint64Array.t_0) union2 -> index:float -> value:bigint -> bigint [@@js.call "and"]
    val compareExchange: t -> typedArray:(BigInt64Array.t_0, BigUint64Array.t_0) union2 -> index:float -> expectedValue:bigint -> replacementValue:bigint -> bigint [@@js.call "compareExchange"]
    val exchange: t -> typedArray:(BigInt64Array.t_0, BigUint64Array.t_0) union2 -> index:float -> value:bigint -> bigint [@@js.call "exchange"]
    val load: t -> typedArray:(BigInt64Array.t_0, BigUint64Array.t_0) union2 -> index:float -> bigint [@@js.call "load"]
    val or_: t -> typedArray:(BigInt64Array.t_0, BigUint64Array.t_0) union2 -> index:float -> value:bigint -> bigint [@@js.call "or"]
    val store: t -> typedArray:(BigInt64Array.t_0, BigUint64Array.t_0) union2 -> index:float -> value:bigint -> bigint [@@js.call "store"]
    val sub: t -> typedArray:(BigInt64Array.t_0, BigUint64Array.t_0) union2 -> index:float -> value:bigint -> bigint [@@js.call "sub"]
    val wait: t -> typedArray:BigInt64Array.t_0 -> index:float -> value:bigint -> ?timeout:float -> unit -> ([`L_s0_not_equal[@js "not-equal"] | `L_s1_ok[@js "ok"] | `L_s2_timed_out[@js "timed-out"]] [@js.enum]) [@@js.call "wait"]
    val notify: t -> typedArray:BigInt64Array.t_0 -> index:float -> ?count:float -> unit -> float [@@js.call "notify"]
    val xor: t -> typedArray:(BigInt64Array.t_0, BigUint64Array.t_0) union2 -> index:float -> value:bigint -> bigint [@@js.call "xor"]
  end
end
