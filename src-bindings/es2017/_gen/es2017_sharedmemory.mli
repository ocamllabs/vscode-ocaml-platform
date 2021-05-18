[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - Int16Array
  - Int32Array
  - Int8Array
  - Uint16Array
  - Uint32Array
  - Uint8Array
 *)
[@@@js.stop]
module type Missing = sig
  module Int16Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Int32Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Int8Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Uint16Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Uint32Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Uint8Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module Int16Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Int32Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Int8Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Uint16Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Uint32Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Uint8Array : sig
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
      type _ArrayBufferTypes = [`ArrayBufferTypes] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Atomics = [`Atomics] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _SharedArrayBuffer = [`SharedArrayBuffer] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _SharedArrayBufferConstructor = [`SharedArrayBufferConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "SharedArrayBuffer"] SharedArrayBuffer : sig
    type t = _SharedArrayBuffer
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_byteLength: t -> float [@@js.get "byteLength"]
    val slice: t -> begin_:float -> ?end_:float -> unit -> t [@@js.call "slice"]
    val get__Symbol_species_: t -> t [@@js.get "[Symbol.species]"]
    val get__Symbol_toStringTag_: t -> ([`L_s1_SharedArrayBuffer[@js "SharedArrayBuffer"]] [@js.enum]) [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "SharedArrayBufferConstructor"] SharedArrayBufferConstructor : sig
    type t = _SharedArrayBufferConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_prototype: t -> _SharedArrayBuffer [@@js.get "prototype"]
    val create: t -> byteLength:float -> _SharedArrayBuffer [@@js.apply_newable]
  end
  val sharedArrayBuffer: _SharedArrayBufferConstructor [@@js.global "SharedArrayBuffer"]
  module[@js.scope "ArrayBufferTypes"] ArrayBufferTypes : sig
    type t = _ArrayBufferTypes
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_SharedArrayBuffer: t -> _SharedArrayBuffer [@@js.get "SharedArrayBuffer"]
    val set_SharedArrayBuffer: t -> _SharedArrayBuffer -> unit [@@js.set "SharedArrayBuffer"]
  end
  module[@js.scope "Atomics"] Atomics : sig
    type t = _Atomics
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val add: t -> typedArray:(Int16Array.t_0, Int32Array.t_0, Int8Array.t_0, Uint16Array.t_0, Uint32Array.t_0, Uint8Array.t_0) union6 -> index:float -> value:float -> float [@@js.call "add"]
    val and_: t -> typedArray:(Int16Array.t_0, Int32Array.t_0, Int8Array.t_0, Uint16Array.t_0, Uint32Array.t_0, Uint8Array.t_0) union6 -> index:float -> value:float -> float [@@js.call "and"]
    val compareExchange: t -> typedArray:(Int16Array.t_0, Int32Array.t_0, Int8Array.t_0, Uint16Array.t_0, Uint32Array.t_0, Uint8Array.t_0) union6 -> index:float -> expectedValue:float -> replacementValue:float -> float [@@js.call "compareExchange"]
    val exchange: t -> typedArray:(Int16Array.t_0, Int32Array.t_0, Int8Array.t_0, Uint16Array.t_0, Uint32Array.t_0, Uint8Array.t_0) union6 -> index:float -> value:float -> float [@@js.call "exchange"]
    val isLockFree: t -> size:float -> bool [@@js.call "isLockFree"]
    val load: t -> typedArray:(Int16Array.t_0, Int32Array.t_0, Int8Array.t_0, Uint16Array.t_0, Uint32Array.t_0, Uint8Array.t_0) union6 -> index:float -> float [@@js.call "load"]
    val or_: t -> typedArray:(Int16Array.t_0, Int32Array.t_0, Int8Array.t_0, Uint16Array.t_0, Uint32Array.t_0, Uint8Array.t_0) union6 -> index:float -> value:float -> float [@@js.call "or"]
    val store: t -> typedArray:(Int16Array.t_0, Int32Array.t_0, Int8Array.t_0, Uint16Array.t_0, Uint32Array.t_0, Uint8Array.t_0) union6 -> index:float -> value:float -> float [@@js.call "store"]
    val sub: t -> typedArray:(Int16Array.t_0, Int32Array.t_0, Int8Array.t_0, Uint16Array.t_0, Uint32Array.t_0, Uint8Array.t_0) union6 -> index:float -> value:float -> float [@@js.call "sub"]
    val wait: t -> typedArray:Int32Array.t_0 -> index:float -> value:float -> ?timeout:float -> unit -> ([`L_s2_not_equal[@js "not-equal"] | `L_s3_ok[@js "ok"] | `L_s4_timed_out[@js "timed-out"]] [@js.enum]) [@@js.call "wait"]
    val notify: t -> typedArray:Int32Array.t_0 -> index:float -> ?count:float -> unit -> float [@@js.call "notify"]
    val xor: t -> typedArray:(Int16Array.t_0, Int32Array.t_0, Int8Array.t_0, Uint16Array.t_0, Uint32Array.t_0, Uint8Array.t_0) union6 -> index:float -> value:float -> float [@@js.call "xor"]
    val get__Symbol_toStringTag_: t -> ([`L_s0_Atomics[@js "Atomics"]] [@js.enum]) [@@js.get "[Symbol.toStringTag]"]
  end
  val atomics: _Atomics [@@js.global "Atomics"]
end
