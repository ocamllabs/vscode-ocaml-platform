[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_reject_unauthorized : t -> bool [@@js.get "rejectUnauthorized"]

  val set_reject_unauthorized : t -> bool -> unit
    [@@js.set "rejectUnauthorized"]

  val get_request_cert : t -> bool [@@js.get "requestCert"]

  val set_request_cert : t -> bool -> unit [@@js.set "requestCert"]
end

module Tls : sig
  open Node_net

  val client_reneg_limit : int [@@js.global "CLIENT_RENEG_LIMIT"]

  val client_reneg_window : int [@@js.global "CLIENT_RENEG_WINDOW"]

  module Certificate : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_c : t -> string [@@js.get "C"]

    val set_c : t -> string -> unit [@@js.set "C"]

    val get_st : t -> string [@@js.get "ST"]

    val set_st : t -> string -> unit [@@js.set "ST"]

    val get_l : t -> string [@@js.get "L"]

    val set_l : t -> string -> unit [@@js.set "L"]

    val get_o : t -> string [@@js.get "O"]

    val set_o : t -> string -> unit [@@js.set "O"]

    val get_ou : t -> string [@@js.get "OU"]

    val set_ou : t -> string -> unit [@@js.set "OU"]

    val get_cn : t -> string [@@js.get "CN"]

    val set_cn : t -> string -> unit [@@js.set "CN"]
  end
  [@@js.scope "Certificate"]

  module Peer_certificate : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_subject : t -> Certificate.t [@@js.get "subject"]

    val set_subject : t -> Certificate.t -> unit [@@js.set "subject"]

    val get_issuer : t -> Certificate.t [@@js.get "issuer"]

    val set_issuer : t -> Certificate.t -> unit [@@js.set "issuer"]

    val get_subjectaltname : t -> string [@@js.get "subjectaltname"]

    val set_subjectaltname : t -> string -> unit [@@js.set "subjectaltname"]

    val get_info_access : t -> string list Dict.t [@@js.get "infoAccess"]

    val set_info_access : t -> string list Dict.t -> unit
      [@@js.set "infoAccess"]

    val get_modulus : t -> string [@@js.get "modulus"]

    val set_modulus : t -> string -> unit [@@js.set "modulus"]

    val get_exponent : t -> string [@@js.get "exponent"]

    val set_exponent : t -> string -> unit [@@js.set "exponent"]

    val get_valid_from : t -> string [@@js.get "valid_from"]

    val set_valid_from : t -> string -> unit [@@js.set "valid_from"]

    val get_valid_to : t -> string [@@js.get "valid_to"]

    val set_valid_to : t -> string -> unit [@@js.set "valid_to"]

    val get_fingerprint : t -> string [@@js.get "fingerprint"]

    val set_fingerprint : t -> string -> unit [@@js.set "fingerprint"]

    val get_fingerprint256 : t -> string [@@js.get "fingerprint256"]

    val set_fingerprint256 : t -> string -> unit [@@js.set "fingerprint256"]

    val get_ext_key_usage : t -> string list [@@js.get "ext_key_usage"]

    val set_ext_key_usage : t -> string list -> unit [@@js.set "ext_key_usage"]

    val get_serial_number : t -> string [@@js.get "serialNumber"]

    val set_serial_number : t -> string -> unit [@@js.set "serialNumber"]

    val get_raw : t -> Buffer.t [@@js.get "raw"]

    val set_raw : t -> Buffer.t -> unit [@@js.set "raw"]
  end
  [@@js.scope "PeerCertificate"]

  module Detailed_peer_certificate : sig
    include module type of struct
      include Peer_certificate
    end

    val get_issuer_certificate : t -> t [@@js.get "issuerCertificate"]

    val set_issuer_certificate : t -> t -> unit [@@js.set "issuerCertificate"]
  end
  [@@js.scope "DetailedPeerCertificate"]

  module Cipher_name_and_protocol : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]

    val get_version : t -> string [@@js.get "version"]

    val set_version : t -> string -> unit [@@js.set "version"]

    val get_standard_name : t -> string [@@js.get "standardName"]

    val set_standard_name : t -> string -> unit [@@js.set "standardName"]
  end
  [@@js.scope "CipherNameAndProtocol"]

  module Ephemeral_key_info : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_type : t -> string [@@js.get "type"]

    val set_type : t -> string -> unit [@@js.set "type"]

    val get_name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]

    val get_size : t -> int [@@js.get "size"]

    val set_size : t -> int -> unit [@@js.set "size"]
  end
  [@@js.scope "EphemeralKeyInfo"]

  module Key_object : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_pem : t -> Buffer.t or_string [@@js.get "pem"]

    val set_pem : t -> Buffer.t or_string -> unit [@@js.set "pem"]

    val get_passphrase : t -> string [@@js.get "passphrase"]

    val set_passphrase : t -> string -> unit [@@js.set "passphrase"]
  end
  [@@js.scope "KeyObject"]

  module Pxf_object : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_buf : t -> Buffer.t or_string [@@js.get "buf"]

    val set_buf : t -> Buffer.t or_string -> unit [@@js.set "buf"]

    val get_passphrase : t -> string [@@js.get "passphrase"]

    val set_passphrase : t -> string -> unit [@@js.set "passphrase"]
  end
  [@@js.scope "PxfObject"]

  module Secure_version : sig
    type t =
      ([ `TLSv1 [@js "TLSv1"]
       | `TLSv1_1 [@js "TLSv1.1"]
       | `TLSv1_2 [@js "TLSv1.2"]
       | `TLSv1_3 [@js "TLSv1.3"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Secure_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_context : t -> any [@@js.get "context"]

    val set_context : t -> any -> unit [@@js.set "context"]
  end
  [@@js.scope "SecureContext"]

  module Secure_context_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_ca : t -> (Buffer.t, Buffer.t or_string list) union2 or_string
      [@@js.get "ca"]

    val set_ca :
      t -> (Buffer.t, Buffer.t or_string list) union2 or_string -> unit
      [@@js.set "ca"]

    val get_cert : t -> (Buffer.t, Buffer.t or_string list) union2 or_string
      [@@js.get "cert"]

    val set_cert :
      t -> (Buffer.t, Buffer.t or_string list) union2 or_string -> unit
      [@@js.set "cert"]

    val get_sigalgs : t -> string [@@js.get "sigalgs"]

    val set_sigalgs : t -> string -> unit [@@js.set "sigalgs"]

    val get_ciphers : t -> string [@@js.get "ciphers"]

    val set_ciphers : t -> string -> unit [@@js.set "ciphers"]

    val get_client_cert_engine : t -> string [@@js.get "clientCertEngine"]

    val set_client_cert_engine : t -> string -> unit
      [@@js.set "clientCertEngine"]

    val get_crl : t -> (Buffer.t, Buffer.t or_string list) union2 or_string
      [@@js.get "crl"]

    val set_crl :
      t -> (Buffer.t, Buffer.t or_string list) union2 or_string -> unit
      [@@js.set "crl"]

    val get_dhparam : t -> Buffer.t or_string [@@js.get "dhparam"]

    val set_dhparam : t -> Buffer.t or_string -> unit [@@js.set "dhparam"]

    val get_ecdh_curve : t -> string [@@js.get "ecdhCurve"]

    val set_ecdh_curve : t -> string -> unit [@@js.set "ecdhCurve"]

    val get_honor_cipher_order : t -> bool [@@js.get "honorCipherOrder"]

    val set_honor_cipher_order : t -> bool -> unit [@@js.set "honorCipherOrder"]

    val get_key :
      t -> (Buffer.t, (Buffer.t, Key_object.t) union2 list) union2 or_string
      [@@js.get "key"]

    val set_key :
         t
      -> (Buffer.t, (Buffer.t, Key_object.t) union2 list) union2 or_string
      -> unit
      [@@js.set "key"]

    val get_private_key_engine : t -> string [@@js.get "privateKeyEngine"]

    val set_private_key_engine : t -> string -> unit
      [@@js.set "privateKeyEngine"]

    val get_private_key_identifier : t -> string
      [@@js.get "privateKeyIdentifier"]

    val set_private_key_identifier : t -> string -> unit
      [@@js.set "privateKeyIdentifier"]

    val get_max_version : t -> Secure_version.t [@@js.get "maxVersion"]

    val set_max_version : t -> Secure_version.t -> unit [@@js.set "maxVersion"]

    val get_min_version : t -> Secure_version.t [@@js.get "minVersion"]

    val set_min_version : t -> Secure_version.t -> unit [@@js.set "minVersion"]

    val get_passphrase : t -> string [@@js.get "passphrase"]

    val set_passphrase : t -> string -> unit [@@js.set "passphrase"]

    val get_pfx :
         t
      -> (Buffer.t, (Buffer.t, Pxf_object.t) union2 or_string list) union2
         or_string
      [@@js.get "pfx"]

    val set_pfx :
         t
      -> (Buffer.t, (Buffer.t, Pxf_object.t) union2 or_string list) union2
         or_string
      -> unit
      [@@js.set "pfx"]

    val get_secure_options : t -> int [@@js.get "secureOptions"]

    val set_secure_options : t -> int -> unit [@@js.set "secureOptions"]

    val get_secure_protocol : t -> string [@@js.get "secureProtocol"]

    val set_secure_protocol : t -> string -> unit [@@js.set "secureProtocol"]

    val get_session_id_context : t -> string [@@js.get "sessionIdContext"]

    val set_session_id_context : t -> string -> unit
      [@@js.set "sessionIdContext"]

    val get_ticket_keys : t -> Buffer.t [@@js.get "ticketKeys"]

    val set_ticket_keys : t -> Buffer.t -> unit [@@js.set "ticketKeys"]

    val get_session_timeout : t -> int [@@js.get "sessionTimeout"]

    val set_session_timeout : t -> int -> unit [@@js.set "sessionTimeout"]
  end
  [@@js.scope "SecureContextOptions"]

  module Common_connection_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_secure_context : t -> Secure_context.t [@@js.get "secureContext"]

    val set_secure_context : t -> Secure_context.t -> unit
      [@@js.set "secureContext"]

    val get_enable_trace : t -> bool [@@js.get "enableTrace"]

    val set_enable_trace : t -> bool -> unit [@@js.set "enableTrace"]

    val get_request_cert : t -> bool [@@js.get "requestCert"]

    val set_request_cert : t -> bool -> unit [@@js.set "requestCert"]

    val get_alpn_protocols :
      t -> (Uint8_array.t, Uint8_array.t or_string) or_array
      [@@js.get "ALPNProtocols"]

    val set_alpn_protocols :
      t -> (Uint8_array.t, Uint8_array.t or_string) or_array -> unit
      [@@js.set "ALPNProtocols"]

    val s_ni_callback :
         t
      -> servername:string
      -> cb:(err:Error.t or_null -> ctx:Secure_context.t -> unit)
      -> unit
      [@@js.call "SNICallback"]

    val get_reject_unauthorized : t -> bool [@@js.get "rejectUnauthorized"]

    val set_reject_unauthorized : t -> bool -> unit
      [@@js.set "rejectUnauthorized"]
  end
  [@@js.scope "CommonConnectionOptions"]

  module Tls_socket_options : sig
    include module type of Secure_context_options

    val get_secure_context : t -> Secure_context.t [@@js.get "secureContext"]

    val set_secure_context : t -> Secure_context.t -> unit
      [@@js.set "secureContext"]

    val get_enable_trace : t -> bool [@@js.get "enableTrace"]

    val set_enable_trace : t -> bool -> unit [@@js.set "enableTrace"]

    val get_request_cert : t -> bool [@@js.get "requestCert"]

    val set_request_cert : t -> bool -> unit [@@js.set "requestCert"]

    val get_alpn_protocols :
      t -> (Uint8_array.t, Uint8_array.t or_string) or_array
      [@@js.get "ALPNProtocols"]

    val set_alpn_protocols :
      t -> (Uint8_array.t, Uint8_array.t or_string) or_array -> unit
      [@@js.set "ALPNProtocols"]

    val s_ni_callback :
         t
      -> servername:string
      -> cb:(err:Error.t or_null -> ctx:Secure_context.t -> unit)
      -> unit
      [@@js.call "SNICallback"]

    val get_reject_unauthorized : t -> bool [@@js.get "rejectUnauthorized"]

    val set_reject_unauthorized : t -> bool -> unit
      [@@js.set "rejectUnauthorized"]

    val get_is_server : t -> bool [@@js.get "isServer"]

    val set_is_server : t -> bool -> unit [@@js.set "isServer"]

    val get_server : t -> Net.Server.t [@@js.get "server"]

    val set_server : t -> Net.Server.t -> unit [@@js.set "server"]

    val get_session : t -> Buffer.t [@@js.get "session"]

    val set_session : t -> Buffer.t -> unit [@@js.set "session"]

    val get_request_ocsp : t -> bool [@@js.get "requestOCSP"]

    val set_request_ocsp : t -> bool -> unit [@@js.set "requestOCSP"]
  end
  [@@js.scope "TLSSocketOptions"]

  module Tls_socket : sig
    include module type of struct
      include Net.Socket
    end

    val create :
      socket:Net.Socket.t -> ?options:Tls_socket_options.t -> unit -> t
      [@@js.create]

    val get_authorized : t -> bool [@@js.get "authorized"]

    val set_authorized : t -> bool -> unit [@@js.set "authorized"]

    val get_authorization_error : t -> Error.t [@@js.get "authorizationError"]

    val set_authorization_error : t -> Error.t -> unit
      [@@js.set "authorizationError"]

    val get_encrypted : t -> bool [@@js.get "encrypted"]

    val set_encrypted : t -> bool -> unit [@@js.set "encrypted"]

    val get_alpn_protocol : t -> string [@@js.get "alpnProtocol"]

    val set_alpn_protocol : t -> string -> unit [@@js.set "alpnProtocol"]

    val get_certificate :
      t -> (Peer_certificate.t, untyped_object) union2 or_null
      [@@js.call "getCertificate"]

    val get_cipher : t -> Cipher_name_and_protocol.t [@@js.call "getCipher"]

    val get_ephemeral_key_info :
      t -> (Ephemeral_key_info.t, untyped_object) union2 or_null
      [@@js.call "getEphemeralKeyInfo"]

    val get_finished : t -> Buffer.t or_undefined [@@js.call "getFinished"]

    val get_peer_certificate :
      t -> detailed:([ `L_b_true ][@js.enum]) -> Detailed_peer_certificate.t
      [@@js.call "getPeerCertificate"]

    val get_peer_certificate' :
      t -> ?detailed:([ `L_b_false ][@js.enum]) -> unit -> Peer_certificate.t
      [@@js.call "getPeerCertificate"]

    val get_peer_certificate'' :
         t
      -> ?detailed:bool
      -> unit
      -> (Detailed_peer_certificate.t, Peer_certificate.t) union2
      [@@js.call "getPeerCertificate"]

    val get_peer_finished : t -> Buffer.t or_undefined
      [@@js.call "getPeerFinished"]

    val get_protocol : t -> string or_null [@@js.call "getProtocol"]

    val get_session : t -> Buffer.t or_undefined [@@js.call "getSession"]

    val get_shared_sigalgs : t -> string list [@@js.call "getSharedSigalgs"]

    val get_tls_ticket : t -> Buffer.t or_undefined [@@js.call "getTLSTicket"]

    val is_session_reused : t -> bool [@@js.call "isSessionReused"]

    val renegotiate :
         t
      -> options:Anonymous_interface0.t
      -> callback:(err:Error.t or_null -> unit)
      -> bool or_undefined
      [@@js.call "renegotiate"]

    val set_max_send_fragment : t -> size:int -> bool
      [@@js.call "setMaxSendFragment"]

    val disable_renegotiation : t -> unit [@@js.call "disableRenegotiation"]

    val enable_trace : t -> unit [@@js.call "enableTrace"]

    val export_keying_material :
      t -> length:int -> label:string -> context:Buffer.t -> Buffer.t
      [@@js.call "exportKeyingMaterial"]

    val add_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "addListener"]

    val add_listener' :
         t
      -> event:([ `OCSPResponse ][@js.enum])
      -> listener:(response:Buffer.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'' :
      t -> event:([ `secureConnect ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener''' :
         t
      -> event:([ `session ][@js.enum])
      -> listener:(session:Buffer.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'''' :
         t
      -> event:([ `keylog ][@js.enum])
      -> listener:(line:Buffer.t -> unit)
      -> t
      [@@js.call "addListener"]

    val emit :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val emit' :
      t -> event:([ `OCSPResponse ][@js.enum]) -> response:Buffer.t -> bool
      [@@js.call "emit"]

    val emit'' : t -> event:([ `secureConnect ][@js.enum]) -> bool
      [@@js.call "emit"]

    val emit''' :
      t -> event:([ `session ][@js.enum]) -> session:Buffer.t -> bool
      [@@js.call "emit"]

    val emit'''' : t -> event:([ `keylog ][@js.enum]) -> line:Buffer.t -> bool
      [@@js.call "emit"]

    val on :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "on"]

    val on' :
         t
      -> event:([ `OCSPResponse ][@js.enum])
      -> listener:(response:Buffer.t -> unit)
      -> t
      [@@js.call "on"]

    val on'' :
      t -> event:([ `secureConnect ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on''' :
         t
      -> event:([ `session ][@js.enum])
      -> listener:(session:Buffer.t -> unit)
      -> t
      [@@js.call "on"]

    val on'''' :
         t
      -> event:([ `keylog ][@js.enum])
      -> listener:(line:Buffer.t -> unit)
      -> t
      [@@js.call "on"]

    val once :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "once"]

    val once' :
         t
      -> event:([ `OCSPResponse ][@js.enum])
      -> listener:(response:Buffer.t -> unit)
      -> t
      [@@js.call "once"]

    val once'' :
      t -> event:([ `secureConnect ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once''' :
         t
      -> event:([ `session ][@js.enum])
      -> listener:(session:Buffer.t -> unit)
      -> t
      [@@js.call "once"]

    val once'''' :
         t
      -> event:([ `keylog ][@js.enum])
      -> listener:(line:Buffer.t -> unit)
      -> t
      [@@js.call "once"]

    val prepend_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener' :
         t
      -> event:([ `OCSPResponse ][@js.enum])
      -> listener:(response:Buffer.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener'' :
      t -> event:([ `secureConnect ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener''' :
         t
      -> event:([ `session ][@js.enum])
      -> listener:(session:Buffer.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener'''' :
         t
      -> event:([ `keylog ][@js.enum])
      -> listener:(line:Buffer.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_once_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener' :
         t
      -> event:([ `OCSPResponse ][@js.enum])
      -> listener:(response:Buffer.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'' :
      t -> event:([ `secureConnect ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''' :
         t
      -> event:([ `session ][@js.enum])
      -> listener:(session:Buffer.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''' :
         t
      -> event:([ `keylog ][@js.enum])
      -> listener:(line:Buffer.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]
  end
  [@@js.scope "TLSSocket"]

  module Secure_pair : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_encrypted : t -> Tls_socket.t [@@js.get "encrypted"]

    val set_encrypted : t -> Tls_socket.t -> unit [@@js.set "encrypted"]

    val get_cleartext : t -> Tls_socket.t [@@js.get "cleartext"]

    val set_cleartext : t -> Tls_socket.t -> unit [@@js.set "cleartext"]
  end
  [@@js.scope "SecurePair"]

  module Tls_options : sig
    include module type of struct
      include Secure_context_options
    end

    val get_handshake_timeout : t -> int [@@js.get "handshakeTimeout"]

    val set_handshake_timeout : t -> int -> unit [@@js.set "handshakeTimeout"]

    val get_session_timeout : t -> int [@@js.get "sessionTimeout"]

    val set_session_timeout : t -> int -> unit [@@js.set "sessionTimeout"]

    val get_ticket_keys : t -> Buffer.t [@@js.get "ticketKeys"]

    val set_ticket_keys : t -> Buffer.t -> unit [@@js.set "ticketKeys"]

    val psk_callback :
         t
      -> socket:Tls_socket.t
      -> identity:string
      -> (Data_view.t, Typed_array.t) union2 or_null
      [@@js.call "pskCallback"]

    val get_psk_identity_hint : t -> string [@@js.get "pskIdentityHint"]

    val set_psk_identity_hint : t -> string -> unit [@@js.set "pskIdentityHint"]

    val cast' : t -> Common_connection_options.t [@@js.cast]

    val cast'' : t -> Net.Server_opts.t [@@js.cast]
  end
  [@@js.scope "TlsOptions"]

  module Psk_callback_negotation : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_psk : t -> (Data_view.t, Typed_array.t) union2 [@@js.get "psk"]

    val set_psk : t -> (Data_view.t, Typed_array.t) union2 -> unit
      [@@js.set "psk"]

    val get_identity : t -> string [@@js.get "identity"]

    val set_identity : t -> string -> unit [@@js.set "identity"]
  end
  [@@js.scope "PSKCallbackNegotation"]

  module Connection_options : sig
    include module type of struct
      include Secure_context_options
    end

    val get_host : t -> string [@@js.get "host"]

    val set_host : t -> string -> unit [@@js.set "host"]

    val get_port : t -> int [@@js.get "port"]

    val set_port : t -> int -> unit [@@js.set "port"]

    val get_path : t -> string [@@js.get "path"]

    val set_path : t -> string -> unit [@@js.set "path"]

    val get_socket : t -> Net.Socket.t [@@js.get "socket"]

    val set_socket : t -> Net.Socket.t -> unit [@@js.set "socket"]

    val check_server_identity :
      t -> host:string -> cert:Peer_certificate.t -> Error.t or_undefined
      [@@js.call "checkServerIdentity"]

    val get_servername : t -> string [@@js.get "servername"]

    val set_servername : t -> string -> unit [@@js.set "servername"]

    val get_session : t -> Buffer.t [@@js.get "session"]

    val set_session : t -> Buffer.t -> unit [@@js.set "session"]

    val get_min_dh_size : t -> int [@@js.get "minDHSize"]

    val set_min_dh_size : t -> int -> unit [@@js.set "minDHSize"]

    val get_lookup : t -> Net.Lookup_function.t [@@js.get "lookup"]

    val set_lookup : t -> Net.Lookup_function.t -> unit [@@js.set "lookup"]

    val get_timeout : t -> int [@@js.get "timeout"]

    val set_timeout : t -> int -> unit [@@js.set "timeout"]

    val psk_callback :
      t -> hint:string or_null -> Psk_callback_negotation.t or_null
      [@@js.call "pskCallback"]

    val cast' : t -> Common_connection_options.t [@@js.cast]
  end
  [@@js.scope "ConnectionOptions"]

  module Server : sig
    include module type of struct
      include Net.Server
    end

    val create :
      ?secure_connection_listener:(socket:Tls_socket.t -> unit) -> unit -> t
      [@@js.create]

    val create' :
         options:Tls_options.t
      -> ?secure_connection_listener:(socket:Tls_socket.t -> unit)
      -> unit
      -> t
      [@@js.create]

    val add_context :
      t -> host_name:string -> credentials:Secure_context_options.t -> unit
      [@@js.call "addContext"]

    val get_ticket_keys : t -> Buffer.t [@@js.call "getTicketKeys"]

    val set_secure_context : t -> details:Secure_context_options.t -> unit
      [@@js.call "setSecureContext"]

    val set_ticket_keys : t -> keys:Buffer.t -> unit [@@js.call "setTicketKeys"]

    val add_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "addListener"]

    val add_listener' :
         t
      -> event:([ `tlsClientError ][@js.enum])
      -> listener:(err:Error.t -> tls_socket:Tls_socket.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'' :
         t
      -> event:([ `newSession ][@js.enum])
      -> listener:
           (   sessionId:Buffer.t
            -> session_data:Buffer.t
            -> callback:(err:Error.t -> resp:Buffer.t -> unit)
            -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''' :
         t
      -> event:([ `OCSPRequest ][@js.enum])
      -> listener:
           (   certificate:Buffer.t
            -> issuer:Buffer.t
            -> callback:(err:Error.t or_null -> resp:Buffer.t -> unit)
            -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'''' :
         t
      -> event:([ `resumeSession ][@js.enum])
      -> listener:
           (   sessionId:Buffer.t
            -> callback:(err:Error.t -> session_data:Buffer.t -> unit)
            -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''''' :
         t
      -> event:([ `secureConnection ][@js.enum])
      -> listener:(tlsSocket:Tls_socket.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'''''' :
         t
      -> event:([ `keylog ][@js.enum])
      -> listener:(line:Buffer.t -> tls_socket:Tls_socket.t -> unit)
      -> t
      [@@js.call "addListener"]

    val emit :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val emit' :
         t
      -> event:([ `tlsClientError ][@js.enum])
      -> err:Error.t
      -> tls_socket:Tls_socket.t
      -> bool
      [@@js.call "emit"]

    val emit'' :
         t
      -> event:([ `newSession ][@js.enum])
      -> session_id:Buffer.t
      -> session_data:Buffer.t
      -> callback:(err:Error.t -> resp:Buffer.t -> unit)
      -> bool
      [@@js.call "emit"]

    val emit''' :
         t
      -> event:([ `OCSPRequest ][@js.enum])
      -> certificate:Buffer.t
      -> issuer:Buffer.t
      -> callback:(err:Error.t or_null -> resp:Buffer.t -> unit)
      -> bool
      [@@js.call "emit"]

    val emit'''' :
         t
      -> event:([ `resumeSession ][@js.enum])
      -> session_id:Buffer.t
      -> callback:(err:Error.t -> session_data:Buffer.t -> unit)
      -> bool
      [@@js.call "emit"]

    val emit''''' :
         t
      -> event:([ `secureConnection ][@js.enum])
      -> tls_socket:Tls_socket.t
      -> bool
      [@@js.call "emit"]

    val emit'''''' :
         t
      -> event:([ `keylog ][@js.enum])
      -> line:Buffer.t
      -> tls_socket:Tls_socket.t
      -> bool
      [@@js.call "emit"]

    val on :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "on"]

    val on' :
         t
      -> event:([ `tlsClientError ][@js.enum])
      -> listener:(err:Error.t -> tls_socket:Tls_socket.t -> unit)
      -> t
      [@@js.call "on"]

    val on'' :
         t
      -> event:([ `newSession ][@js.enum])
      -> listener:
           (   sessionId:Buffer.t
            -> session_data:Buffer.t
            -> callback:(err:Error.t -> resp:Buffer.t -> unit)
            -> unit)
      -> t
      [@@js.call "on"]

    val on''' :
         t
      -> event:([ `OCSPRequest ][@js.enum])
      -> listener:
           (   certificate:Buffer.t
            -> issuer:Buffer.t
            -> callback:(err:Error.t or_null -> resp:Buffer.t -> unit)
            -> unit)
      -> t
      [@@js.call "on"]

    val on'''' :
         t
      -> event:([ `resumeSession ][@js.enum])
      -> listener:
           (   sessionId:Buffer.t
            -> callback:(err:Error.t -> session_data:Buffer.t -> unit)
            -> unit)
      -> t
      [@@js.call "on"]

    val on''''' :
         t
      -> event:([ `secureConnection ][@js.enum])
      -> listener:(tlsSocket:Tls_socket.t -> unit)
      -> t
      [@@js.call "on"]

    val on'''''' :
         t
      -> event:([ `keylog ][@js.enum])
      -> listener:(line:Buffer.t -> tls_socket:Tls_socket.t -> unit)
      -> t
      [@@js.call "on"]

    val once :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "once"]

    val once' :
         t
      -> event:([ `tlsClientError ][@js.enum])
      -> listener:(err:Error.t -> tls_socket:Tls_socket.t -> unit)
      -> t
      [@@js.call "once"]

    val once'' :
         t
      -> event:([ `newSession ][@js.enum])
      -> listener:
           (   sessionId:Buffer.t
            -> session_data:Buffer.t
            -> callback:(err:Error.t -> resp:Buffer.t -> unit)
            -> unit)
      -> t
      [@@js.call "once"]

    val once''' :
         t
      -> event:([ `OCSPRequest ][@js.enum])
      -> listener:
           (   certificate:Buffer.t
            -> issuer:Buffer.t
            -> callback:(err:Error.t or_null -> resp:Buffer.t -> unit)
            -> unit)
      -> t
      [@@js.call "once"]

    val once'''' :
         t
      -> event:([ `resumeSession ][@js.enum])
      -> listener:
           (   sessionId:Buffer.t
            -> callback:(err:Error.t -> session_data:Buffer.t -> unit)
            -> unit)
      -> t
      [@@js.call "once"]

    val once''''' :
         t
      -> event:([ `secureConnection ][@js.enum])
      -> listener:(tlsSocket:Tls_socket.t -> unit)
      -> t
      [@@js.call "once"]

    val once'''''' :
         t
      -> event:([ `keylog ][@js.enum])
      -> listener:(line:Buffer.t -> tls_socket:Tls_socket.t -> unit)
      -> t
      [@@js.call "once"]

    val prepend_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener' :
         t
      -> event:([ `tlsClientError ][@js.enum])
      -> listener:(err:Error.t -> tls_socket:Tls_socket.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener'' :
         t
      -> event:([ `newSession ][@js.enum])
      -> listener:
           (   sessionId:Buffer.t
            -> session_data:Buffer.t
            -> callback:(err:Error.t -> resp:Buffer.t -> unit)
            -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener''' :
         t
      -> event:([ `OCSPRequest ][@js.enum])
      -> listener:
           (   certificate:Buffer.t
            -> issuer:Buffer.t
            -> callback:(err:Error.t or_null -> resp:Buffer.t -> unit)
            -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener'''' :
         t
      -> event:([ `resumeSession ][@js.enum])
      -> listener:
           (   sessionId:Buffer.t
            -> callback:(err:Error.t -> session_data:Buffer.t -> unit)
            -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener''''' :
         t
      -> event:([ `secureConnection ][@js.enum])
      -> listener:(tlsSocket:Tls_socket.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener'''''' :
         t
      -> event:([ `keylog ][@js.enum])
      -> listener:(line:Buffer.t -> tls_socket:Tls_socket.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_once_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener' :
         t
      -> event:([ `tlsClientError ][@js.enum])
      -> listener:(err:Error.t -> tls_socket:Tls_socket.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'' :
         t
      -> event:([ `newSession ][@js.enum])
      -> listener:
           (   sessionId:Buffer.t
            -> session_data:Buffer.t
            -> callback:(err:Error.t -> resp:Buffer.t -> unit)
            -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''' :
         t
      -> event:([ `OCSPRequest ][@js.enum])
      -> listener:
           (   certificate:Buffer.t
            -> issuer:Buffer.t
            -> callback:(err:Error.t or_null -> resp:Buffer.t -> unit)
            -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''' :
         t
      -> event:([ `resumeSession ][@js.enum])
      -> listener:
           (   sessionId:Buffer.t
            -> callback:(err:Error.t -> session_data:Buffer.t -> unit)
            -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''''' :
         t
      -> event:([ `secureConnection ][@js.enum])
      -> listener:(tlsSocket:Tls_socket.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''''' :
         t
      -> event:([ `keylog ][@js.enum])
      -> listener:(line:Buffer.t -> tls_socket:Tls_socket.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]
  end
  [@@js.scope "Server"]

  val check_server_identity :
    host:string -> cert:Peer_certificate.t -> Error.t or_undefined
    [@@js.global "checkServerIdentity"]

  val create_server :
       ?secure_connection_listener:(socket:Tls_socket.t -> unit)
    -> unit
    -> Server.t
    [@@js.global "createServer"]

  val create_server :
       options:Tls_options.t
    -> ?secure_connection_listener:(socket:Tls_socket.t -> unit)
    -> unit
    -> Server.t
    [@@js.global "createServer"]

  val connect :
       options:Connection_options.t
    -> ?secure_connect_listener:(unit -> unit)
    -> unit
    -> Tls_socket.t
    [@@js.global "connect"]

  val connect :
       port:int
    -> ?host:string
    -> ?options:Connection_options.t
    -> ?secure_connect_listener:(unit -> unit)
    -> unit
    -> Tls_socket.t
    [@@js.global "connect"]

  val connect :
       port:int
    -> ?options:Connection_options.t
    -> ?secure_connect_listener:(unit -> unit)
    -> unit
    -> Tls_socket.t
    [@@js.global "connect"]

  val create_secure_pair :
       ?credentials:Secure_context.t
    -> ?is_server:bool
    -> ?request_cert:bool
    -> ?reject_unauthorized:bool
    -> unit
    -> Secure_pair.t
    [@@js.global "createSecurePair"]

  val create_secure_context :
    ?options:Secure_context_options.t -> unit -> Secure_context.t
    [@@js.global "createSecureContext"]

  val get_ciphers : unit -> string list [@@js.global "getCiphers"]

  val default_ecdh_curve : string [@@js.global "DEFAULT_ECDH_CURVE"]

  val default_max_version : Secure_version.t [@@js.global "DEFAULT_MAX_VERSION"]

  val default_min_version : Secure_version.t [@@js.global "DEFAULT_MIN_VERSION"]

  val root_certificates : string list [@@js.global "rootCertificates"]
end
[@@js.scope Import.tls]
