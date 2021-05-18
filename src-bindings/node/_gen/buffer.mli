[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - Buffer
  - Uint8Array
 *)
[@@@js.stop]
module type Missing = sig
  module Buffer : sig
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
    module Buffer : sig
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
      type anonymous_interface_0 = [`anonymous_interface_0] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_1 = [`anonymous_interface_1] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
    module Types : sig
      open AnonymousInterfaces
      type buffer_TranscodeEncoding = ([`L_s0_ascii[@js "ascii"] | `L_s1_binary[@js "binary"] | `L_s2_latin1[@js "latin1"] | `L_s3_ucs2[@js "ucs2"] | `L_s4_utf16le[@js "utf16le"] | `L_s5_utf8[@js "utf8"]] [@js.enum])
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
    val get_MAX_LENGTH: t -> float [@@js.get "MAX_LENGTH"]
    val set_MAX_LENGTH: t -> float -> unit [@@js.set "MAX_LENGTH"]
    val get_MAX_STRING_LENGTH: t -> float [@@js.get "MAX_STRING_LENGTH"]
    val set_MAX_STRING_LENGTH: t -> float -> unit [@@js.set "MAX_STRING_LENGTH"]
  end
  module AnonymousInterface1 : sig
    type t = anonymous_interface_1
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> size:float -> Buffer.t_0 [@@js.apply_newable]
    val get_prototype: t -> Buffer.t_0 [@@js.get "prototype"]
    val set_prototype: t -> Buffer.t_0 -> unit [@@js.set "prototype"]
  end
  module[@js.scope "node:buffer"] Node_buffer : sig
    (* export * from 'buffer'; *)
  end
  module[@js.scope "buffer"] Buffer : sig
    val iNSPECT_MAX_BYTES: float [@@js.global "INSPECT_MAX_BYTES"]
    val kMaxLength: float [@@js.global "kMaxLength"]
    val kStringMaxLength: float [@@js.global "kStringMaxLength"]
    val constants: anonymous_interface_0 [@@js.global "constants"]
    val buffType: (* FIXME: unknown type 'typeof Buffer' *)any [@@js.global "BuffType"]
    module TranscodeEncoding : sig
      type t = buffer_TranscodeEncoding
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    val transcode: source:Uint8Array.t_0 -> fromEnc:buffer_TranscodeEncoding -> toEnc:buffer_TranscodeEncoding -> Buffer.t_0 [@@js.global "transcode"]
    val slowBuffer: anonymous_interface_1 [@@js.global "SlowBuffer"]
    
  end
end
