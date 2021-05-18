[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - Buffer
  - DataView
  - Error
  - NodeJS.Dict<T1>
  - NodeJS.TypedArray
  - Uint8Array
  - net.LookupFunction
  - net.Server
  - net.ServerOpts
  - net.Socket
 *)
[@@@js.stop]
module type Missing = sig
  module Buffer : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module DataView : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Error : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module NodeJS : sig
    module Dict : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module TypedArray : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
  end
  module Uint8Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module net : sig
    module LookupFunction : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Server : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ServerOpts : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Socket : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
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
    module DataView : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Error : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module NodeJS : sig
      module Dict : sig
        type 'T1 t_1
        val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
        val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
      end
      module TypedArray : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
    end
    module Uint8Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module net : sig
      module LookupFunction : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module Server : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module ServerOpts : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module Socket : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
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
      type tls_Certificate = [`Tls_Certificate] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_CipherNameAndProtocol = [`Tls_CipherNameAndProtocol] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_CommonConnectionOptions = [`Tls_CommonConnectionOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_ConnectionOptions = [`Tls_ConnectionOptions | `Tls_CommonConnectionOptions | `Tls_SecureContextOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_DetailedPeerCertificate = [`Tls_DetailedPeerCertificate | `Tls_PeerCertificate] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_EphemeralKeyInfo = [`Tls_EphemeralKeyInfo] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_KeyObject = [`Tls_KeyObject] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_PSKCallbackNegotation = [`Tls_PSKCallbackNegotation] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_PeerCertificate = [`Tls_PeerCertificate] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_PxfObject = [`Tls_PxfObject] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_SecureContext = [`Tls_SecureContext] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_SecureContextOptions = [`Tls_SecureContextOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_SecurePair = [`Tls_SecurePair] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_SecureVersion = ([`L_s2_TLSv1[@js "TLSv1"] | `L_s3_TLSv1_1[@js "TLSv1.1"] | `L_s4_TLSv1_2[@js "TLSv1.2"] | `L_s5_TLSv1_3[@js "TLSv1.3"]] [@js.enum])
      and tls_Server = [`Tls_Server] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_TLSSocket = [`Tls_TLSSocket] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_TLSSocketOptions = [`Tls_TLSSocketOptions | `Tls_CommonConnectionOptions | `Tls_SecureContextOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tls_TlsOptions = [`Tls_TlsOptions | `Tls_CommonConnectionOptions | `Tls_SecureContextOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
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
    val get_rejectUnauthorized: t -> bool [@@js.get "rejectUnauthorized"]
    val set_rejectUnauthorized: t -> bool -> unit [@@js.set "rejectUnauthorized"]
    val get_requestCert: t -> bool [@@js.get "requestCert"]
    val set_requestCert: t -> bool -> unit [@@js.set "requestCert"]
  end
  module[@js.scope "node:tls"] Node_tls : sig
    (* export * from 'tls'; *)
  end
  module[@js.scope "tls"] Tls : sig
    (* import * as net from 'node:net'; *)
    val cLIENT_RENEG_LIMIT: float [@@js.global "CLIENT_RENEG_LIMIT"]
    val cLIENT_RENEG_WINDOW: float [@@js.global "CLIENT_RENEG_WINDOW"]
    module[@js.scope "Certificate"] Certificate : sig
      type t = tls_Certificate
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_C: t -> string [@@js.get "C"]
      val set_C: t -> string -> unit [@@js.set "C"]
      val get_ST: t -> string [@@js.get "ST"]
      val set_ST: t -> string -> unit [@@js.set "ST"]
      val get_L: t -> string [@@js.get "L"]
      val set_L: t -> string -> unit [@@js.set "L"]
      val get_O: t -> string [@@js.get "O"]
      val set_O: t -> string -> unit [@@js.set "O"]
      val get_OU: t -> string [@@js.get "OU"]
      val set_OU: t -> string -> unit [@@js.set "OU"]
      val get_CN: t -> string [@@js.get "CN"]
      val set_CN: t -> string -> unit [@@js.set "CN"]
    end
    module[@js.scope "PeerCertificate"] PeerCertificate : sig
      type t = tls_PeerCertificate
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_subject: t -> tls_Certificate [@@js.get "subject"]
      val set_subject: t -> tls_Certificate -> unit [@@js.set "subject"]
      val get_issuer: t -> tls_Certificate [@@js.get "issuer"]
      val set_issuer: t -> tls_Certificate -> unit [@@js.set "issuer"]
      val get_subjectaltname: t -> string [@@js.get "subjectaltname"]
      val set_subjectaltname: t -> string -> unit [@@js.set "subjectaltname"]
      val get_infoAccess: t -> string list NodeJS.Dict.t_1 [@@js.get "infoAccess"]
      val set_infoAccess: t -> string list NodeJS.Dict.t_1 -> unit [@@js.set "infoAccess"]
      val get_modulus: t -> string [@@js.get "modulus"]
      val set_modulus: t -> string -> unit [@@js.set "modulus"]
      val get_exponent: t -> string [@@js.get "exponent"]
      val set_exponent: t -> string -> unit [@@js.set "exponent"]
      val get_valid_from: t -> string [@@js.get "valid_from"]
      val set_valid_from: t -> string -> unit [@@js.set "valid_from"]
      val get_valid_to: t -> string [@@js.get "valid_to"]
      val set_valid_to: t -> string -> unit [@@js.set "valid_to"]
      val get_fingerprint: t -> string [@@js.get "fingerprint"]
      val set_fingerprint: t -> string -> unit [@@js.set "fingerprint"]
      val get_fingerprint256: t -> string [@@js.get "fingerprint256"]
      val set_fingerprint256: t -> string -> unit [@@js.set "fingerprint256"]
      val get_ext_key_usage: t -> string list [@@js.get "ext_key_usage"]
      val set_ext_key_usage: t -> string list -> unit [@@js.set "ext_key_usage"]
      val get_serialNumber: t -> string [@@js.get "serialNumber"]
      val set_serialNumber: t -> string -> unit [@@js.set "serialNumber"]
      val get_raw: t -> Buffer.t_0 [@@js.get "raw"]
      val set_raw: t -> Buffer.t_0 -> unit [@@js.set "raw"]
    end
    module[@js.scope "DetailedPeerCertificate"] DetailedPeerCertificate : sig
      type t = tls_DetailedPeerCertificate
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_issuerCertificate: t -> t [@@js.get "issuerCertificate"]
      val set_issuerCertificate: t -> t -> unit [@@js.set "issuerCertificate"]
      val cast: t -> tls_PeerCertificate [@@js.cast]
    end
    module[@js.scope "CipherNameAndProtocol"] CipherNameAndProtocol : sig
      type t = tls_CipherNameAndProtocol
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_version: t -> string [@@js.get "version"]
      val set_version: t -> string -> unit [@@js.set "version"]
      val get_standardName: t -> string [@@js.get "standardName"]
      val set_standardName: t -> string -> unit [@@js.set "standardName"]
    end
    module[@js.scope "EphemeralKeyInfo"] EphemeralKeyInfo : sig
      type t = tls_EphemeralKeyInfo
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> string [@@js.get "type"]
      val set_type: t -> string -> unit [@@js.set "type"]
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_size: t -> float [@@js.get "size"]
      val set_size: t -> float -> unit [@@js.set "size"]
    end
    module[@js.scope "KeyObject"] KeyObject : sig
      type t = tls_KeyObject
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_pem: t -> Buffer.t_0 or_string [@@js.get "pem"]
      val set_pem: t -> Buffer.t_0 or_string -> unit [@@js.set "pem"]
      val get_passphrase: t -> string [@@js.get "passphrase"]
      val set_passphrase: t -> string -> unit [@@js.set "passphrase"]
    end
    module[@js.scope "PxfObject"] PxfObject : sig
      type t = tls_PxfObject
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_buf: t -> Buffer.t_0 or_string [@@js.get "buf"]
      val set_buf: t -> Buffer.t_0 or_string -> unit [@@js.set "buf"]
      val get_passphrase: t -> string [@@js.get "passphrase"]
      val set_passphrase: t -> string -> unit [@@js.set "passphrase"]
    end
    module[@js.scope "TLSSocketOptions"] TLSSocketOptions : sig
      type t = tls_TLSSocketOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_isServer: t -> bool [@@js.get "isServer"]
      val set_isServer: t -> bool -> unit [@@js.set "isServer"]
      val get_server: t -> Net.Server.t_0 [@@js.get "server"]
      val set_server: t -> Net.Server.t_0 -> unit [@@js.set "server"]
      val get_session: t -> Buffer.t_0 [@@js.get "session"]
      val set_session: t -> Buffer.t_0 -> unit [@@js.set "session"]
      val get_requestOCSP: t -> bool [@@js.get "requestOCSP"]
      val set_requestOCSP: t -> bool -> unit [@@js.set "requestOCSP"]
      val cast: t -> tls_SecureContextOptions [@@js.cast]
      val cast': t -> tls_CommonConnectionOptions [@@js.cast]
    end
    module[@js.scope "TLSSocket"] TLSSocket : sig
      type t = tls_TLSSocket
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: socket:Net.Socket.t_0 -> ?options:tls_TLSSocketOptions -> unit -> t [@@js.create]
      val get_authorized: t -> bool [@@js.get "authorized"]
      val set_authorized: t -> bool -> unit [@@js.set "authorized"]
      val get_authorizationError: t -> Error.t_0 [@@js.get "authorizationError"]
      val set_authorizationError: t -> Error.t_0 -> unit [@@js.set "authorizationError"]
      val get_encrypted: t -> bool [@@js.get "encrypted"]
      val set_encrypted: t -> bool -> unit [@@js.set "encrypted"]
      val get_alpnProtocol: t -> string [@@js.get "alpnProtocol"]
      val set_alpnProtocol: t -> string -> unit [@@js.set "alpnProtocol"]
      val getCertificate: t -> (tls_PeerCertificate, untyped_object) union2 or_null [@@js.call "getCertificate"]
      val getCipher: t -> tls_CipherNameAndProtocol [@@js.call "getCipher"]
      val getEphemeralKeyInfo: t -> (tls_EphemeralKeyInfo, untyped_object) union2 or_null [@@js.call "getEphemeralKeyInfo"]
      val getFinished: t -> Buffer.t_0 or_undefined [@@js.call "getFinished"]
      val getPeerCertificate: t -> detailed:([`L_b_true] [@js.enum]) -> tls_DetailedPeerCertificate [@@js.call "getPeerCertificate"]
      val getPeerCertificate': t -> ?detailed:([`L_b_false] [@js.enum]) -> unit -> tls_PeerCertificate [@@js.call "getPeerCertificate"]
      val getPeerCertificate'': t -> ?detailed:bool -> unit -> (tls_DetailedPeerCertificate, tls_PeerCertificate) union2 [@@js.call "getPeerCertificate"]
      val getPeerFinished: t -> Buffer.t_0 or_undefined [@@js.call "getPeerFinished"]
      val getProtocol: t -> string or_null [@@js.call "getProtocol"]
      val getSession: t -> Buffer.t_0 or_undefined [@@js.call "getSession"]
      val getSharedSigalgs: t -> string list [@@js.call "getSharedSigalgs"]
      val getTLSTicket: t -> Buffer.t_0 or_undefined [@@js.call "getTLSTicket"]
      val isSessionReused: t -> bool [@@js.call "isSessionReused"]
      val renegotiate: t -> options:anonymous_interface_0 -> callback:(err:Error.t_0 or_null -> unit) -> bool or_undefined [@@js.call "renegotiate"]
      val setMaxSendFragment: t -> size:float -> bool [@@js.call "setMaxSendFragment"]
      val disableRenegotiation: t -> unit [@@js.call "disableRenegotiation"]
      val enableTrace: t -> unit [@@js.call "enableTrace"]
      val exportKeyingMaterial: t -> length:float -> label:string -> context:Buffer.t_0 -> Buffer.t_0 [@@js.call "exportKeyingMaterial"]
      val addListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "addListener"]
      val addListener': t -> event:([`L_s1_OCSPResponse] [@js.enum]) -> listener:(response:Buffer.t_0 -> unit) -> t [@@js.call "addListener"]
      val addListener'': t -> event:([`L_s9_secureConnect] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener''': t -> event:([`L_s11_session] [@js.enum]) -> listener:(session:Buffer.t_0 -> unit) -> t [@@js.call "addListener"]
      val addListener'''': t -> event:([`L_s6_keylog] [@js.enum]) -> listener:(line:Buffer.t_0 -> unit) -> t [@@js.call "addListener"]
      val emit: t -> event:symbol or_string -> args:(any list [@js.variadic]) -> bool [@@js.call "emit"]
      val emit': t -> event:([`L_s1_OCSPResponse] [@js.enum]) -> response:Buffer.t_0 -> bool [@@js.call "emit"]
      val emit'': t -> event:([`L_s9_secureConnect] [@js.enum]) -> bool [@@js.call "emit"]
      val emit''': t -> event:([`L_s11_session] [@js.enum]) -> session:Buffer.t_0 -> bool [@@js.call "emit"]
      val emit'''': t -> event:([`L_s6_keylog] [@js.enum]) -> line:Buffer.t_0 -> bool [@@js.call "emit"]
      val on: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "on"]
      val on': t -> event:([`L_s1_OCSPResponse] [@js.enum]) -> listener:(response:Buffer.t_0 -> unit) -> t [@@js.call "on"]
      val on'': t -> event:([`L_s9_secureConnect] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on''': t -> event:([`L_s11_session] [@js.enum]) -> listener:(session:Buffer.t_0 -> unit) -> t [@@js.call "on"]
      val on'''': t -> event:([`L_s6_keylog] [@js.enum]) -> listener:(line:Buffer.t_0 -> unit) -> t [@@js.call "on"]
      val once: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "once"]
      val once': t -> event:([`L_s1_OCSPResponse] [@js.enum]) -> listener:(response:Buffer.t_0 -> unit) -> t [@@js.call "once"]
      val once'': t -> event:([`L_s9_secureConnect] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once''': t -> event:([`L_s11_session] [@js.enum]) -> listener:(session:Buffer.t_0 -> unit) -> t [@@js.call "once"]
      val once'''': t -> event:([`L_s6_keylog] [@js.enum]) -> listener:(line:Buffer.t_0 -> unit) -> t [@@js.call "once"]
      val prependListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependListener"]
      val prependListener': t -> event:([`L_s1_OCSPResponse] [@js.enum]) -> listener:(response:Buffer.t_0 -> unit) -> t [@@js.call "prependListener"]
      val prependListener'': t -> event:([`L_s9_secureConnect] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener''': t -> event:([`L_s11_session] [@js.enum]) -> listener:(session:Buffer.t_0 -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''': t -> event:([`L_s6_keylog] [@js.enum]) -> listener:(line:Buffer.t_0 -> unit) -> t [@@js.call "prependListener"]
      val prependOnceListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener': t -> event:([`L_s1_OCSPResponse] [@js.enum]) -> listener:(response:Buffer.t_0 -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'': t -> event:([`L_s9_secureConnect] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''': t -> event:([`L_s11_session] [@js.enum]) -> listener:(session:Buffer.t_0 -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''': t -> event:([`L_s6_keylog] [@js.enum]) -> listener:(line:Buffer.t_0 -> unit) -> t [@@js.call "prependOnceListener"]
      val cast: t -> Net.Socket.t_0 [@@js.cast]
    end
    module[@js.scope "CommonConnectionOptions"] CommonConnectionOptions : sig
      type t = tls_CommonConnectionOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_secureContext: t -> tls_SecureContext [@@js.get "secureContext"]
      val set_secureContext: t -> tls_SecureContext -> unit [@@js.set "secureContext"]
      val get_enableTrace: t -> bool [@@js.get "enableTrace"]
      val set_enableTrace: t -> bool -> unit [@@js.set "enableTrace"]
      val get_requestCert: t -> bool [@@js.get "requestCert"]
      val set_requestCert: t -> bool -> unit [@@js.set "requestCert"]
      val get_ALPNProtocols: t -> (Uint8Array.t_0, Uint8Array.t_0 or_string) or_array [@@js.get "ALPNProtocols"]
      val set_ALPNProtocols: t -> (Uint8Array.t_0, Uint8Array.t_0 or_string) or_array -> unit [@@js.set "ALPNProtocols"]
      val sNICallback: t -> servername:string -> cb:(err:Error.t_0 or_null -> ctx:tls_SecureContext -> unit) -> unit [@@js.call "SNICallback"]
      val get_rejectUnauthorized: t -> bool [@@js.get "rejectUnauthorized"]
      val set_rejectUnauthorized: t -> bool -> unit [@@js.set "rejectUnauthorized"]
    end
    module[@js.scope "TlsOptions"] TlsOptions : sig
      type t = tls_TlsOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_handshakeTimeout: t -> float [@@js.get "handshakeTimeout"]
      val set_handshakeTimeout: t -> float -> unit [@@js.set "handshakeTimeout"]
      val get_sessionTimeout: t -> float [@@js.get "sessionTimeout"]
      val set_sessionTimeout: t -> float -> unit [@@js.set "sessionTimeout"]
      val get_ticketKeys: t -> Buffer.t_0 [@@js.get "ticketKeys"]
      val set_ticketKeys: t -> Buffer.t_0 -> unit [@@js.set "ticketKeys"]
      val pskCallback: t -> socket:tls_TLSSocket -> identity:string -> (DataView.t_0, NodeJS.TypedArray.t_0) union2 or_null [@@js.call "pskCallback"]
      val get_pskIdentityHint: t -> string [@@js.get "pskIdentityHint"]
      val set_pskIdentityHint: t -> string -> unit [@@js.set "pskIdentityHint"]
      val cast: t -> tls_SecureContextOptions [@@js.cast]
      val cast': t -> tls_CommonConnectionOptions [@@js.cast]
      val cast'': t -> Net.ServerOpts.t_0 [@@js.cast]
    end
    module[@js.scope "PSKCallbackNegotation"] PSKCallbackNegotation : sig
      type t = tls_PSKCallbackNegotation
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_psk: t -> (DataView.t_0, NodeJS.TypedArray.t_0) union2 [@@js.get "psk"]
      val set_psk: t -> (DataView.t_0, NodeJS.TypedArray.t_0) union2 -> unit [@@js.set "psk"]
      val get_identity: t -> string [@@js.get "identity"]
      val set_identity: t -> string -> unit [@@js.set "identity"]
    end
    module[@js.scope "ConnectionOptions"] ConnectionOptions : sig
      type t = tls_ConnectionOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_host: t -> string [@@js.get "host"]
      val set_host: t -> string -> unit [@@js.set "host"]
      val get_port: t -> float [@@js.get "port"]
      val set_port: t -> float -> unit [@@js.set "port"]
      val get_path: t -> string [@@js.get "path"]
      val set_path: t -> string -> unit [@@js.set "path"]
      val get_socket: t -> Net.Socket.t_0 [@@js.get "socket"]
      val set_socket: t -> Net.Socket.t_0 -> unit [@@js.set "socket"]
      val checkServerIdentity: t -> host:string -> cert:tls_PeerCertificate -> Error.t_0 or_undefined [@@js.call "checkServerIdentity"]
      val get_servername: t -> string [@@js.get "servername"]
      val set_servername: t -> string -> unit [@@js.set "servername"]
      val get_session: t -> Buffer.t_0 [@@js.get "session"]
      val set_session: t -> Buffer.t_0 -> unit [@@js.set "session"]
      val get_minDHSize: t -> float [@@js.get "minDHSize"]
      val set_minDHSize: t -> float -> unit [@@js.set "minDHSize"]
      val get_lookup: t -> Net.LookupFunction.t_0 [@@js.get "lookup"]
      val set_lookup: t -> Net.LookupFunction.t_0 -> unit [@@js.set "lookup"]
      val get_timeout: t -> float [@@js.get "timeout"]
      val set_timeout: t -> float -> unit [@@js.set "timeout"]
      val pskCallback: t -> hint:string or_null -> tls_PSKCallbackNegotation or_null [@@js.call "pskCallback"]
      val cast: t -> tls_SecureContextOptions [@@js.cast]
      val cast': t -> tls_CommonConnectionOptions [@@js.cast]
    end
    module[@js.scope "Server"] Server : sig
      type t = tls_Server
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: ?secureConnectionListener:(socket:tls_TLSSocket -> unit) -> unit -> t [@@js.create]
      val create': options:tls_TlsOptions -> ?secureConnectionListener:(socket:tls_TLSSocket -> unit) -> unit -> t [@@js.create]
      val addContext: t -> hostName:string -> credentials:tls_SecureContextOptions -> unit [@@js.call "addContext"]
      val getTicketKeys: t -> Buffer.t_0 [@@js.call "getTicketKeys"]
      val setSecureContext: t -> details:tls_SecureContextOptions -> unit [@@js.call "setSecureContext"]
      val setTicketKeys: t -> keys:Buffer.t_0 -> unit [@@js.call "setTicketKeys"]
      val addListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "addListener"]
      val addListener': t -> event:([`L_s12_tlsClientError] [@js.enum]) -> listener:(err:Error.t_0 -> tlsSocket:tls_TLSSocket -> unit) -> t [@@js.call "addListener"]
      val addListener'': t -> event:([`L_s7_newSession] [@js.enum]) -> listener:(sessionId:Buffer.t_0 -> sessionData:Buffer.t_0 -> callback:(err:Error.t_0 -> resp:Buffer.t_0 -> unit) -> unit) -> t [@@js.call "addListener"]
      val addListener''': t -> event:([`L_s0_OCSPRequest] [@js.enum]) -> listener:(certificate:Buffer.t_0 -> issuer:Buffer.t_0 -> callback:(err:Error.t_0 or_null -> resp:Buffer.t_0 -> unit) -> unit) -> t [@@js.call "addListener"]
      val addListener'''': t -> event:([`L_s8_resumeSession] [@js.enum]) -> listener:(sessionId:Buffer.t_0 -> callback:(err:Error.t_0 -> sessionData:Buffer.t_0 -> unit) -> unit) -> t [@@js.call "addListener"]
      val addListener''''': t -> event:([`L_s10_secureConnection] [@js.enum]) -> listener:(tlsSocket:tls_TLSSocket -> unit) -> t [@@js.call "addListener"]
      val addListener'''''': t -> event:([`L_s6_keylog] [@js.enum]) -> listener:(line:Buffer.t_0 -> tlsSocket:tls_TLSSocket -> unit) -> t [@@js.call "addListener"]
      val emit: t -> event:symbol or_string -> args:(any list [@js.variadic]) -> bool [@@js.call "emit"]
      val emit': t -> event:([`L_s12_tlsClientError] [@js.enum]) -> err:Error.t_0 -> tlsSocket:tls_TLSSocket -> bool [@@js.call "emit"]
      val emit'': t -> event:([`L_s7_newSession] [@js.enum]) -> sessionId:Buffer.t_0 -> sessionData:Buffer.t_0 -> callback:(err:Error.t_0 -> resp:Buffer.t_0 -> unit) -> bool [@@js.call "emit"]
      val emit''': t -> event:([`L_s0_OCSPRequest] [@js.enum]) -> certificate:Buffer.t_0 -> issuer:Buffer.t_0 -> callback:(err:Error.t_0 or_null -> resp:Buffer.t_0 -> unit) -> bool [@@js.call "emit"]
      val emit'''': t -> event:([`L_s8_resumeSession] [@js.enum]) -> sessionId:Buffer.t_0 -> callback:(err:Error.t_0 -> sessionData:Buffer.t_0 -> unit) -> bool [@@js.call "emit"]
      val emit''''': t -> event:([`L_s10_secureConnection] [@js.enum]) -> tlsSocket:tls_TLSSocket -> bool [@@js.call "emit"]
      val emit'''''': t -> event:([`L_s6_keylog] [@js.enum]) -> line:Buffer.t_0 -> tlsSocket:tls_TLSSocket -> bool [@@js.call "emit"]
      val on: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "on"]
      val on': t -> event:([`L_s12_tlsClientError] [@js.enum]) -> listener:(err:Error.t_0 -> tlsSocket:tls_TLSSocket -> unit) -> t [@@js.call "on"]
      val on'': t -> event:([`L_s7_newSession] [@js.enum]) -> listener:(sessionId:Buffer.t_0 -> sessionData:Buffer.t_0 -> callback:(err:Error.t_0 -> resp:Buffer.t_0 -> unit) -> unit) -> t [@@js.call "on"]
      val on''': t -> event:([`L_s0_OCSPRequest] [@js.enum]) -> listener:(certificate:Buffer.t_0 -> issuer:Buffer.t_0 -> callback:(err:Error.t_0 or_null -> resp:Buffer.t_0 -> unit) -> unit) -> t [@@js.call "on"]
      val on'''': t -> event:([`L_s8_resumeSession] [@js.enum]) -> listener:(sessionId:Buffer.t_0 -> callback:(err:Error.t_0 -> sessionData:Buffer.t_0 -> unit) -> unit) -> t [@@js.call "on"]
      val on''''': t -> event:([`L_s10_secureConnection] [@js.enum]) -> listener:(tlsSocket:tls_TLSSocket -> unit) -> t [@@js.call "on"]
      val on'''''': t -> event:([`L_s6_keylog] [@js.enum]) -> listener:(line:Buffer.t_0 -> tlsSocket:tls_TLSSocket -> unit) -> t [@@js.call "on"]
      val once: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "once"]
      val once': t -> event:([`L_s12_tlsClientError] [@js.enum]) -> listener:(err:Error.t_0 -> tlsSocket:tls_TLSSocket -> unit) -> t [@@js.call "once"]
      val once'': t -> event:([`L_s7_newSession] [@js.enum]) -> listener:(sessionId:Buffer.t_0 -> sessionData:Buffer.t_0 -> callback:(err:Error.t_0 -> resp:Buffer.t_0 -> unit) -> unit) -> t [@@js.call "once"]
      val once''': t -> event:([`L_s0_OCSPRequest] [@js.enum]) -> listener:(certificate:Buffer.t_0 -> issuer:Buffer.t_0 -> callback:(err:Error.t_0 or_null -> resp:Buffer.t_0 -> unit) -> unit) -> t [@@js.call "once"]
      val once'''': t -> event:([`L_s8_resumeSession] [@js.enum]) -> listener:(sessionId:Buffer.t_0 -> callback:(err:Error.t_0 -> sessionData:Buffer.t_0 -> unit) -> unit) -> t [@@js.call "once"]
      val once''''': t -> event:([`L_s10_secureConnection] [@js.enum]) -> listener:(tlsSocket:tls_TLSSocket -> unit) -> t [@@js.call "once"]
      val once'''''': t -> event:([`L_s6_keylog] [@js.enum]) -> listener:(line:Buffer.t_0 -> tlsSocket:tls_TLSSocket -> unit) -> t [@@js.call "once"]
      val prependListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependListener"]
      val prependListener': t -> event:([`L_s12_tlsClientError] [@js.enum]) -> listener:(err:Error.t_0 -> tlsSocket:tls_TLSSocket -> unit) -> t [@@js.call "prependListener"]
      val prependListener'': t -> event:([`L_s7_newSession] [@js.enum]) -> listener:(sessionId:Buffer.t_0 -> sessionData:Buffer.t_0 -> callback:(err:Error.t_0 -> resp:Buffer.t_0 -> unit) -> unit) -> t [@@js.call "prependListener"]
      val prependListener''': t -> event:([`L_s0_OCSPRequest] [@js.enum]) -> listener:(certificate:Buffer.t_0 -> issuer:Buffer.t_0 -> callback:(err:Error.t_0 or_null -> resp:Buffer.t_0 -> unit) -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''': t -> event:([`L_s8_resumeSession] [@js.enum]) -> listener:(sessionId:Buffer.t_0 -> callback:(err:Error.t_0 -> sessionData:Buffer.t_0 -> unit) -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''': t -> event:([`L_s10_secureConnection] [@js.enum]) -> listener:(tlsSocket:tls_TLSSocket -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''': t -> event:([`L_s6_keylog] [@js.enum]) -> listener:(line:Buffer.t_0 -> tlsSocket:tls_TLSSocket -> unit) -> t [@@js.call "prependListener"]
      val prependOnceListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener': t -> event:([`L_s12_tlsClientError] [@js.enum]) -> listener:(err:Error.t_0 -> tlsSocket:tls_TLSSocket -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'': t -> event:([`L_s7_newSession] [@js.enum]) -> listener:(sessionId:Buffer.t_0 -> sessionData:Buffer.t_0 -> callback:(err:Error.t_0 -> resp:Buffer.t_0 -> unit) -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''': t -> event:([`L_s0_OCSPRequest] [@js.enum]) -> listener:(certificate:Buffer.t_0 -> issuer:Buffer.t_0 -> callback:(err:Error.t_0 or_null -> resp:Buffer.t_0 -> unit) -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''': t -> event:([`L_s8_resumeSession] [@js.enum]) -> listener:(sessionId:Buffer.t_0 -> callback:(err:Error.t_0 -> sessionData:Buffer.t_0 -> unit) -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''': t -> event:([`L_s10_secureConnection] [@js.enum]) -> listener:(tlsSocket:tls_TLSSocket -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''': t -> event:([`L_s6_keylog] [@js.enum]) -> listener:(line:Buffer.t_0 -> tlsSocket:tls_TLSSocket -> unit) -> t [@@js.call "prependOnceListener"]
      val cast: t -> Net.Server.t_0 [@@js.cast]
    end
    module[@js.scope "SecurePair"] SecurePair : sig
      type t = tls_SecurePair
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_encrypted: t -> tls_TLSSocket [@@js.get "encrypted"]
      val set_encrypted: t -> tls_TLSSocket -> unit [@@js.set "encrypted"]
      val get_cleartext: t -> tls_TLSSocket [@@js.get "cleartext"]
      val set_cleartext: t -> tls_TLSSocket -> unit [@@js.set "cleartext"]
    end
    module SecureVersion : sig
      type t = tls_SecureVersion
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "SecureContextOptions"] SecureContextOptions : sig
      type t = tls_SecureContextOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_ca: t -> (Buffer.t_0, Buffer.t_0 or_string list) union2 or_string [@@js.get "ca"]
      val set_ca: t -> (Buffer.t_0, Buffer.t_0 or_string list) union2 or_string -> unit [@@js.set "ca"]
      val get_cert: t -> (Buffer.t_0, Buffer.t_0 or_string list) union2 or_string [@@js.get "cert"]
      val set_cert: t -> (Buffer.t_0, Buffer.t_0 or_string list) union2 or_string -> unit [@@js.set "cert"]
      val get_sigalgs: t -> string [@@js.get "sigalgs"]
      val set_sigalgs: t -> string -> unit [@@js.set "sigalgs"]
      val get_ciphers: t -> string [@@js.get "ciphers"]
      val set_ciphers: t -> string -> unit [@@js.set "ciphers"]
      val get_clientCertEngine: t -> string [@@js.get "clientCertEngine"]
      val set_clientCertEngine: t -> string -> unit [@@js.set "clientCertEngine"]
      val get_crl: t -> (Buffer.t_0, Buffer.t_0 or_string list) union2 or_string [@@js.get "crl"]
      val set_crl: t -> (Buffer.t_0, Buffer.t_0 or_string list) union2 or_string -> unit [@@js.set "crl"]
      val get_dhparam: t -> Buffer.t_0 or_string [@@js.get "dhparam"]
      val set_dhparam: t -> Buffer.t_0 or_string -> unit [@@js.set "dhparam"]
      val get_ecdhCurve: t -> string [@@js.get "ecdhCurve"]
      val set_ecdhCurve: t -> string -> unit [@@js.set "ecdhCurve"]
      val get_honorCipherOrder: t -> bool [@@js.get "honorCipherOrder"]
      val set_honorCipherOrder: t -> bool -> unit [@@js.set "honorCipherOrder"]
      val get_key: t -> (Buffer.t_0, (Buffer.t_0, tls_KeyObject) union2 list) union2 or_string [@@js.get "key"]
      val set_key: t -> (Buffer.t_0, (Buffer.t_0, tls_KeyObject) union2 list) union2 or_string -> unit [@@js.set "key"]
      val get_privateKeyEngine: t -> string [@@js.get "privateKeyEngine"]
      val set_privateKeyEngine: t -> string -> unit [@@js.set "privateKeyEngine"]
      val get_privateKeyIdentifier: t -> string [@@js.get "privateKeyIdentifier"]
      val set_privateKeyIdentifier: t -> string -> unit [@@js.set "privateKeyIdentifier"]
      val get_maxVersion: t -> tls_SecureVersion [@@js.get "maxVersion"]
      val set_maxVersion: t -> tls_SecureVersion -> unit [@@js.set "maxVersion"]
      val get_minVersion: t -> tls_SecureVersion [@@js.get "minVersion"]
      val set_minVersion: t -> tls_SecureVersion -> unit [@@js.set "minVersion"]
      val get_passphrase: t -> string [@@js.get "passphrase"]
      val set_passphrase: t -> string -> unit [@@js.set "passphrase"]
      val get_pfx: t -> (Buffer.t_0, (Buffer.t_0, tls_PxfObject) union2 or_string list) union2 or_string [@@js.get "pfx"]
      val set_pfx: t -> (Buffer.t_0, (Buffer.t_0, tls_PxfObject) union2 or_string list) union2 or_string -> unit [@@js.set "pfx"]
      val get_secureOptions: t -> float [@@js.get "secureOptions"]
      val set_secureOptions: t -> float -> unit [@@js.set "secureOptions"]
      val get_secureProtocol: t -> string [@@js.get "secureProtocol"]
      val set_secureProtocol: t -> string -> unit [@@js.set "secureProtocol"]
      val get_sessionIdContext: t -> string [@@js.get "sessionIdContext"]
      val set_sessionIdContext: t -> string -> unit [@@js.set "sessionIdContext"]
      val get_ticketKeys: t -> Buffer.t_0 [@@js.get "ticketKeys"]
      val set_ticketKeys: t -> Buffer.t_0 -> unit [@@js.set "ticketKeys"]
      val get_sessionTimeout: t -> float [@@js.get "sessionTimeout"]
      val set_sessionTimeout: t -> float -> unit [@@js.set "sessionTimeout"]
    end
    module[@js.scope "SecureContext"] SecureContext : sig
      type t = tls_SecureContext
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_context: t -> any [@@js.get "context"]
      val set_context: t -> any -> unit [@@js.set "context"]
    end
    val checkServerIdentity: host:string -> cert:tls_PeerCertificate -> Error.t_0 or_undefined [@@js.global "checkServerIdentity"]
    val createServer: ?secureConnectionListener:(socket:tls_TLSSocket -> unit) -> unit -> tls_Server [@@js.global "createServer"]
    val createServer: options:tls_TlsOptions -> ?secureConnectionListener:(socket:tls_TLSSocket -> unit) -> unit -> tls_Server [@@js.global "createServer"]
    val connect: options:tls_ConnectionOptions -> ?secureConnectListener:(unit -> unit) -> unit -> tls_TLSSocket [@@js.global "connect"]
    val connect: port:float -> ?host:string -> ?options:tls_ConnectionOptions -> ?secureConnectListener:(unit -> unit) -> unit -> tls_TLSSocket [@@js.global "connect"]
    val connect: port:float -> ?options:tls_ConnectionOptions -> ?secureConnectListener:(unit -> unit) -> unit -> tls_TLSSocket [@@js.global "connect"]
    val createSecurePair: ?credentials:tls_SecureContext -> ?isServer:bool -> ?requestCert:bool -> ?rejectUnauthorized:bool -> unit -> tls_SecurePair [@@js.global "createSecurePair"]
    val createSecureContext: ?options:tls_SecureContextOptions -> unit -> tls_SecureContext [@@js.global "createSecureContext"]
    val getCiphers: unit -> string list [@@js.global "getCiphers"]
    val dEFAULT_ECDH_CURVE: string [@@js.global "DEFAULT_ECDH_CURVE"]
    val dEFAULT_MAX_VERSION: tls_SecureVersion [@@js.global "DEFAULT_MAX_VERSION"]
    val dEFAULT_MIN_VERSION: tls_SecureVersion [@@js.global "DEFAULT_MIN_VERSION"]
    val rootCertificates: string list [@@js.global "rootCertificates"]
  end
end
