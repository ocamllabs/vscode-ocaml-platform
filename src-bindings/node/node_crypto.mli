[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Crypto : sig
  open Node_stream

  module Binary_like : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Key_object_type : sig
    type t =
      ([ `private_ [@js "private"]
       | `public [@js "public"]
       | `secret [@js "secret"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Key_export_options : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val get_type :
         'T t
      -> ([ `pkcs1 [@js "pkcs1"]
          | `pkcs8 [@js "pkcs8"]
          | `sec1 [@js "sec1"]
          | `spki [@js "spki"]
          ]
         [@js.enum])
      [@@js.get "type"]

    val set_type :
      'T t -> ([ `pkcs1 | `pkcs8 | `sec1 | `spki ][@js.enum]) -> unit
      [@@js.set "type"]

    val get_format : 'T t -> 'T [@@js.get "format"]

    val set_format : 'T t -> 'T -> unit [@@js.set "format"]

    val get_cipher : 'T t -> string [@@js.get "cipher"]

    val set_cipher : 'T t -> string -> unit [@@js.set "cipher"]

    val get_passphrase : 'T t -> Buffer.t or_string [@@js.get "passphrase"]

    val set_passphrase : 'T t -> Buffer.t or_string -> unit
      [@@js.set "passphrase"]
  end
  [@@js.scope "KeyExportOptions"]

  module Key_type : sig
    type t =
      ([ `dsa [@js "dsa"]
       | `ec [@js "ec"]
       | `ed25519 [@js "ed25519"]
       | `ed448 [@js "ed448"]
       | `rsa [@js "rsa"]
       | `x25519 [@js "x25519"]
       | `x448 [@js "x448"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Key_object : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create : unit -> t [@@js.create]

    val get_asymmetric_key_type : t -> Key_type.t [@@js.get "asymmetricKeyType"]

    val set_asymmetric_key_type : t -> Key_type.t -> unit
      [@@js.set "asymmetricKeyType"]

    val get_asymmetric_key_size : t -> int [@@js.get "asymmetricKeySize"]

    val set_asymmetric_key_size : t -> int -> unit
      [@@js.set "asymmetricKeySize"]

    val export :
         t
      -> options:([ `pem ][@js.enum]) Key_export_options.t
      -> Buffer.t or_string
      [@@js.call "export"]

    val export' :
         t
      -> ?options:([ `der ][@js.enum]) Key_export_options.t
      -> unit
      -> Buffer.t
      [@@js.call "export"]

    val get_symmetric_key_size : t -> int [@@js.get "symmetricKeySize"]

    val set_symmetric_key_size : t -> int -> unit [@@js.set "symmetricKeySize"]

    val get_type : t -> Key_object_type.t [@@js.get "type"]

    val set_type : t -> Key_object_type.t -> unit [@@js.set "type"]
  end
  [@@js.scope "KeyObject"]

  module Cipher_key : sig
    type t = (Binary_like.t, Key_object.t) union2

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Certificate : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val export_challenge : t -> spkac:Binary_like.t -> Buffer.t
      [@@js.call "exportChallenge"]

    val export_public_key :
      t -> spkac:Binary_like.t -> ?encoding:string -> unit -> Buffer.t
      [@@js.call "exportPublicKey"]

    val verify_spkac : t -> spkac:Array_buffer_view.t -> bool
      [@@js.call "verifySpkac"]
  end
  [@@js.scope "Certificate"]

  module Anonymous_interface11 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create : t -> Certificate.t [@@js.apply_newable]

    val apply : t -> Certificate.t [@@js.apply]
  end

  val certificate : (Certificate.t, Anonymous_interface11.t) intersection2
    [@@js.global "Certificate"]

  module Constants : sig
    val o_penssl_version_number : int [@@js.global "OPENSSL_VERSION_NUMBER"]

    val ssl_op_all : int [@@js.global "SSL_OP_ALL"]

    val ssl_op_allow_unsafe_legacy_renegotiation : int
      [@@js.global "SSL_OP_ALLOW_UNSAFE_LEGACY_RENEGOTIATION"]

    val ssl_op_cipher_server_preference : int
      [@@js.global "SSL_OP_CIPHER_SERVER_PREFERENCE"]

    val ssl_op_cisco_anyconnect : int [@@js.global "SSL_OP_CISCO_ANYCONNECT"]

    val ssl_op_cookie_exchange : int [@@js.global "SSL_OP_COOKIE_EXCHANGE"]

    val ssl_op_cryptopro_tlsext_bug : int
      [@@js.global "SSL_OP_CRYPTOPRO_TLSEXT_BUG"]

    val ssl_op_dont_insert_empty_fragments : int
      [@@js.global "SSL_OP_DONT_INSERT_EMPTY_FRAGMENTS"]

    val ssl_op_ephemeral_rsa : int [@@js.global "SSL_OP_EPHEMERAL_RSA"]

    val ssl_op_legacy_server_connect : int
      [@@js.global "SSL_OP_LEGACY_SERVER_CONNECT"]

    val ssl_op_microsoft_big_sslv3_BUFFER : int
      [@@js.global "SSL_OP_MICROSOFT_BIG_SSLV3_BUFFER"]

    val ssl_op_microsoft_sess_id_bug : int
      [@@js.global "SSL_OP_MICROSOFT_SESS_ID_BUG"]

    val ssl_op_msie_sslv2_RSA_PADDING : int
      [@@js.global "SSL_OP_MSIE_SSLV2_RSA_PADDING"]

    val ssl_op_netscape_ca_dn_bug : int
      [@@js.global "SSL_OP_NETSCAPE_CA_DN_BUG"]

    val ssl_op_netscape_challenge_bug : int
      [@@js.global "SSL_OP_NETSCAPE_CHALLENGE_BUG"]

    val ssl_op_netscape_demo_cipher_change_bug : int
      [@@js.global "SSL_OP_NETSCAPE_DEMO_CIPHER_CHANGE_BUG"]

    val ssl_op_netscape_reuse_cipher_change_bug : int
      [@@js.global "SSL_OP_NETSCAPE_REUSE_CIPHER_CHANGE_BUG"]

    val ssl_op_no_compression : int [@@js.global "SSL_OP_NO_COMPRESSION"]

    val ssl_op_no_query_mtu : int [@@js.global "SSL_OP_NO_QUERY_MTU"]

    val ssl_op_no_session_resumption_on_renegotiation : int
      [@@js.global "SSL_OP_NO_SESSION_RESUMPTION_ON_RENEGOTIATION"]

    val ssl_op_no_ss_lv2 : int [@@js.global "SSL_OP_NO_SSLv2"]

    val ssl_op_no_ss_lv3 : int [@@js.global "SSL_OP_NO_SSLv3"]

    val ssl_op_no_ticket : int [@@js.global "SSL_OP_NO_TICKET"]

    val ssl_op_no_tl_sv1 : int [@@js.global "SSL_OP_NO_TLSv1"]

    val ssl_op_no_tl_sv1_1 : int [@@js.global "SSL_OP_NO_TLSv1_1"]

    val ssl_op_no_tl_sv1_2 : int [@@js.global "SSL_OP_NO_TLSv1_2"]

    val ssl_op_pkcs1_CHECK_1 : int [@@js.global "SSL_OP_PKCS1_CHECK_1"]

    val ssl_op_pkcs1_CHECK_2 : int [@@js.global "SSL_OP_PKCS1_CHECK_2"]

    val ssl_op_single_dh_use : int [@@js.global "SSL_OP_SINGLE_DH_USE"]

    val ssl_op_single_ecdh_use : int [@@js.global "SSL_OP_SINGLE_ECDH_USE"]

    val ssl_op_ssleay080_CLIENT_DH_BUG : int
      [@@js.global "SSL_OP_SSLEAY_080_CLIENT_DH_BUG"]

    val ssl_op_sslref2_REUSE_CERT_TYPE_BUG : int
      [@@js.global "SSL_OP_SSLREF2_REUSE_CERT_TYPE_BUG"]

    val ssl_op_tls_block_padding_bug : int
      [@@js.global "SSL_OP_TLS_BLOCK_PADDING_BUG"]

    val ssl_op_tls_d5_BUG : int [@@js.global "SSL_OP_TLS_D5_BUG"]

    val ssl_op_tls_rollback_bug : int [@@js.global "SSL_OP_TLS_ROLLBACK_BUG"]

    val engine_method_rsa : int [@@js.global "ENGINE_METHOD_RSA"]

    val engine_method_dsa : int [@@js.global "ENGINE_METHOD_DSA"]

    val engine_method_dh : int [@@js.global "ENGINE_METHOD_DH"]

    val engine_method_rand : int [@@js.global "ENGINE_METHOD_RAND"]

    val engine_method_ec : int [@@js.global "ENGINE_METHOD_EC"]

    val engine_method_ciphers : int [@@js.global "ENGINE_METHOD_CIPHERS"]

    val engine_method_digests : int [@@js.global "ENGINE_METHOD_DIGESTS"]

    val engine_method_pkey_meths : int [@@js.global "ENGINE_METHOD_PKEY_METHS"]

    val engine_method_pkey_asn1_METHS : int
      [@@js.global "ENGINE_METHOD_PKEY_ASN1_METHS"]

    val engine_method_all : int [@@js.global "ENGINE_METHOD_ALL"]

    val engine_method_none : int [@@js.global "ENGINE_METHOD_NONE"]

    val dh_check_p_not_safe_prime : int
      [@@js.global "DH_CHECK_P_NOT_SAFE_PRIME"]

    val dh_check_p_not_prime : int [@@js.global "DH_CHECK_P_NOT_PRIME"]

    val dh_unable_to_check_generator : int
      [@@js.global "DH_UNABLE_TO_CHECK_GENERATOR"]

    val dh_not_suitable_generator : int
      [@@js.global "DH_NOT_SUITABLE_GENERATOR"]

    val alpn_enabled : int [@@js.global "ALPN_ENABLED"]

    val rsa_pkcs1_PADDING : int [@@js.global "RSA_PKCS1_PADDING"]

    val rsa_sslv23_PADDING : int [@@js.global "RSA_SSLV23_PADDING"]

    val rsa_no_padding : int [@@js.global "RSA_NO_PADDING"]

    val rsa_pkcs1_OAEP_PADDING : int [@@js.global "RSA_PKCS1_OAEP_PADDING"]

    val rsa_x931_PADDING : int [@@js.global "RSA_X931_PADDING"]

    val rsa_pkcs1_PSS_PADDING : int [@@js.global "RSA_PKCS1_PSS_PADDING"]

    val rsa_pss_saltlen_digest : int [@@js.global "RSA_PSS_SALTLEN_DIGEST"]

    val rsa_pss_saltlen_max_sign : int [@@js.global "RSA_PSS_SALTLEN_MAX_SIGN"]

    val rsa_pss_saltlen_auto : int [@@js.global "RSA_PSS_SALTLEN_AUTO"]

    val point_conversion_compressed : int
      [@@js.global "POINT_CONVERSION_COMPRESSED"]

    val point_conversion_uncompressed : int
      [@@js.global "POINT_CONVERSION_UNCOMPRESSED"]

    val point_conversion_hybrid : int [@@js.global "POINT_CONVERSION_HYBRID"]

    val default_core_cipher_list : string [@@js.global "defaultCoreCipherList"]

    val default_cipher_list : string [@@js.global "defaultCipherList"]
  end
  [@@js.scope "constants"]

  module Hash_options : sig
    include module type of struct
      include Stream.Transform_options
    end

    val get_output_length : t -> int [@@js.get "outputLength"]

    val set_output_length : t -> int -> unit [@@js.set "outputLength"]
  end
  [@@js.scope "HashOptions"]

  val fips : bool [@@js.global "fips"]

  module Binary_to_text_encoding : sig
    type t =
      ([ `base64 [@js "base64"]
       | `hex [@js "hex"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Character_encoding : sig
    type t =
      ([ `latin1 [@js "latin1"]
       | `utf_8 [@js "utf-8"]
       | `utf16le [@js "utf16le"]
       | `utf8 [@js "utf8"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Legacy_character_encoding : sig
    type t =
      ([ `ascii [@js "ascii"]
       | `binary [@js "binary"]
       | `ucs_2 [@js "ucs-2"]
       | `ucs2 [@js "ucs2"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Encoding : sig
    type t =
      ( ( Binary_to_text_encoding.t
        , Character_encoding.t
        , Legacy_character_encoding.t )
        union3
      , ([ `ascii [@js "ascii"]
         | `base64 [@js "base64"]
         | `binary [@js "binary"]
         | `hex [@js "hex"]
         | `latin1 [@js "latin1"]
         | `ucs_2 [@js "ucs-2"]
         | `ucs2 [@js "ucs2"]
         | `utf_8 [@js "utf-8"]
         | `utf16le [@js "utf16le"]
         | `utf8 [@js "utf8"]
         ]
        [@js.enum]) )
      or_enum

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Ecdh_key_format : sig
    type t =
      ([ `compressed [@js "compressed"]
       | `hybrid [@js "hybrid"]
       | `uncompressed [@js "uncompressed"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Hash : sig
    include module type of struct
      include Stream.Transform
    end

    val create : unit -> t [@@js.create]

    val copy : t -> t [@@js.call "copy"]

    val update : t -> data:Binary_like.t -> t [@@js.call "update"]

    val update' : t -> data:string -> input_encoding:Encoding.t -> t
      [@@js.call "update"]

    val digest : t -> Buffer.t [@@js.call "digest"]

    val digest' : t -> encoding:Binary_to_text_encoding.t -> string
      [@@js.call "digest"]
  end
  [@@js.scope "Hash"]

  module Hmac : sig
    include module type of struct
      include Stream.Transform
    end

    val create : unit -> t [@@js.create]

    val update : t -> data:Binary_like.t -> t [@@js.call "update"]

    val update' : t -> data:string -> input_encoding:Encoding.t -> t
      [@@js.call "update"]

    val digest : t -> Buffer.t [@@js.call "digest"]

    val digest' : t -> encoding:Binary_to_text_encoding.t -> string
      [@@js.call "digest"]
  end
  [@@js.scope "Hmac"]

  val create_hash :
    algorithm:string -> ?options:Hash_options.t -> unit -> Hash.t
    [@@js.global "createHash"]

  val create_hmac :
       algorithm:string
    -> key:(Binary_like.t, Key_object.t) union2
    -> ?options:Stream.Transform_options.t
    -> unit
    -> Hmac.t
    [@@js.global "createHmac"]

  module Cipher_ccm_types : sig
    type t =
      ([ `aes_128_ccm [@js "aes-128-ccm"]
       | `aes_192_ccm [@js "aes-192-ccm"]
       | `aes_256_ccm [@js "aes-256-ccm"]
       | `chacha20_poly1305 [@js "chacha20-poly1305"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Cipher_gcm_types : sig
    type t =
      ([ `aes_128_gcm [@js "aes-128-gcm"]
       | `aes_192_gcm [@js "aes-192-gcm"]
       | `aes_256_gcm [@js "aes-256-gcm"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Cipher_ccm_options : sig
    include module type of struct
      include Stream.Transform_options
    end

    val get_auth_tag_length : t -> int [@@js.get "authTagLength"]

    val set_auth_tag_length : t -> int -> unit [@@js.set "authTagLength"]
  end
  [@@js.scope "CipherCCMOptions"]

  module Cipher_gcm_options : sig
    include module type of struct
      include Stream.Transform_options
    end

    val get_auth_tag_length : t -> int [@@js.get "authTagLength"]

    val set_auth_tag_length : t -> int -> unit [@@js.set "authTagLength"]
  end
  [@@js.scope "CipherGCMOptions"]

  module Cipher : sig
    include module type of struct
      include Stream.Transform
    end

    val create : unit -> t [@@js.create]

    val update : t -> data:Binary_like.t -> Buffer.t [@@js.call "update"]

    val update' : t -> data:string -> input_encoding:Encoding.t -> Buffer.t
      [@@js.call "update"]

    val update'' :
         t
      -> data:Array_buffer_view.t
      -> input_encoding:never or_undefined
      -> output_encoding:Encoding.t
      -> string
      [@@js.call "update"]

    val update''' :
         t
      -> data:string
      -> input_encoding:Encoding.t or_undefined
      -> output_encoding:Encoding.t
      -> string
      [@@js.call "update"]

    val final : t -> Buffer.t [@@js.call "final"]

    val final' : t -> output_encoding:Buffer_encoding.t -> string
      [@@js.call "final"]

    val set_auto_padding : t -> ?auto_padding:bool -> unit -> t
      [@@js.call "setAutoPadding"]
  end
  [@@js.scope "Cipher"]

  module Anonymous_interface0 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_plaintext_length : t -> int [@@js.get "plaintextLength"]

    val set_plaintext_length : t -> int -> unit [@@js.set "plaintextLength"]
  end

  module Cipher_ccm : sig
    include module type of struct
      include Cipher
    end

    val set_aad :
      t -> buffer:Array_buffer_view.t -> options:Anonymous_interface0.t -> t
      [@@js.call "setAAD"]

    val get_auth_tag : t -> Buffer.t [@@js.call "getAuthTag"]
  end
  [@@js.scope "CipherCCM"]

  module Cipher_gcm : sig
    include module type of struct
      include Cipher
    end

    val set_aad :
         t
      -> buffer:Array_buffer_view.t
      -> ?options:Anonymous_interface0.t
      -> unit
      -> t
      [@@js.call "setAAD"]

    val get_auth_tag : t -> Buffer.t [@@js.call "getAuthTag"]
  end
  [@@js.scope "CipherGCM"]

  val create_cipher :
       algorithm:Cipher_ccm_types.t
    -> password:Binary_like.t
    -> options:Cipher_ccm_options.t
    -> Cipher_ccm.t
    [@@js.global "createCipher"]

  val create_cipher :
       algorithm:Cipher_gcm_types.t
    -> password:Binary_like.t
    -> ?options:Cipher_gcm_options.t
    -> unit
    -> Cipher_gcm.t
    [@@js.global "createCipher"]

  val create_cipher :
       algorithm:string
    -> password:Binary_like.t
    -> ?options:Stream.Transform_options.t
    -> unit
    -> Cipher.t
    [@@js.global "createCipher"]

  val create_cipheriv :
       algorithm:Cipher_ccm_types.t
    -> key:Cipher_key.t
    -> iv:Binary_like.t or_null
    -> options:Cipher_ccm_options.t
    -> Cipher_ccm.t
    [@@js.global "createCipheriv"]

  val create_cipheriv :
       algorithm:Cipher_gcm_types.t
    -> key:Cipher_key.t
    -> iv:Binary_like.t or_null
    -> ?options:Cipher_gcm_options.t
    -> unit
    -> Cipher_gcm.t
    [@@js.global "createCipheriv"]

  val create_cipheriv :
       algorithm:string
    -> key:Cipher_key.t
    -> iv:Binary_like.t or_null
    -> ?options:Stream.Transform_options.t
    -> unit
    -> Cipher.t
    [@@js.global "createCipheriv"]

  module Decipher : sig
    include module type of struct
      include Stream.Transform
    end

    val create : unit -> t [@@js.create]

    val update : t -> data:Array_buffer_view.t -> Buffer.t [@@js.call "update"]

    val update' : t -> data:string -> input_encoding:Encoding.t -> Buffer.t
      [@@js.call "update"]

    val update'' :
         t
      -> data:Array_buffer_view.t
      -> input_encoding:never or_undefined
      -> output_encoding:Encoding.t
      -> string
      [@@js.call "update"]

    val update''' :
         t
      -> data:string
      -> input_encoding:Encoding.t or_undefined
      -> output_encoding:Encoding.t
      -> string
      [@@js.call "update"]

    val final : t -> Buffer.t [@@js.call "final"]

    val final' : t -> output_encoding:Buffer_encoding.t -> string
      [@@js.call "final"]

    val set_auto_padding : t -> ?auto_padding:bool -> unit -> t
      [@@js.call "setAutoPadding"]
  end
  [@@js.scope "Decipher"]

  module Decipher_ccm : sig
    include module type of struct
      include Decipher
    end

    val set_auth_tag : t -> buffer:Array_buffer_view.t -> t
      [@@js.call "setAuthTag"]

    val set_aad :
      t -> buffer:Array_buffer_view.t -> options:Anonymous_interface0.t -> t
      [@@js.call "setAAD"]
  end
  [@@js.scope "DecipherCCM"]

  module Decipher_gcm : sig
    include module type of struct
      include Decipher
    end

    val set_auth_tag : t -> buffer:Array_buffer_view.t -> t
      [@@js.call "setAuthTag"]

    val set_aad :
         t
      -> buffer:Array_buffer_view.t
      -> ?options:Anonymous_interface0.t
      -> unit
      -> t
      [@@js.call "setAAD"]
  end
  [@@js.scope "DecipherGCM"]

  val create_decipher :
       algorithm:Cipher_ccm_types.t
    -> password:Binary_like.t
    -> options:Cipher_ccm_options.t
    -> Decipher_ccm.t
    [@@js.global "createDecipher"]

  val create_decipher :
       algorithm:Cipher_gcm_types.t
    -> password:Binary_like.t
    -> ?options:Cipher_gcm_options.t
    -> unit
    -> Decipher_gcm.t
    [@@js.global "createDecipher"]

  val create_decipher :
       algorithm:string
    -> password:Binary_like.t
    -> ?options:Stream.Transform_options.t
    -> unit
    -> Decipher.t
    [@@js.global "createDecipher"]

  val create_decipheriv :
       algorithm:Cipher_ccm_types.t
    -> key:Cipher_key.t
    -> iv:Binary_like.t or_null
    -> options:Cipher_ccm_options.t
    -> Decipher_ccm.t
    [@@js.global "createDecipheriv"]

  val create_decipheriv :
       algorithm:Cipher_gcm_types.t
    -> key:Cipher_key.t
    -> iv:Binary_like.t or_null
    -> ?options:Cipher_gcm_options.t
    -> unit
    -> Decipher_gcm.t
    [@@js.global "createDecipheriv"]

  val create_decipheriv :
       algorithm:string
    -> key:Cipher_key.t
    -> iv:Binary_like.t or_null
    -> ?options:Stream.Transform_options.t
    -> unit
    -> Decipher.t
    [@@js.global "createDecipheriv"]

  module Key_format : sig
    type t =
      ([ `der [@js "der"]
       | `pem [@js "pem"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Private_key_input : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_key : t -> Buffer.t or_string [@@js.get "key"]

    val set_key : t -> Buffer.t or_string -> unit [@@js.set "key"]

    val get_format : t -> Key_format.t [@@js.get "format"]

    val set_format : t -> Key_format.t -> unit [@@js.set "format"]

    val get_type :
         t
      -> ([ `pkcs1 [@js "pkcs1"] | `pkcs8 [@js "pkcs8"] | `sec1 [@js "sec1"] ]
         [@js.enum])
      [@@js.get "type"]

    val set_type : t -> ([ `pkcs1 | `pkcs8 | `sec1 ][@js.enum]) -> unit
      [@@js.set "type"]

    val get_passphrase : t -> Buffer.t or_string [@@js.get "passphrase"]

    val set_passphrase : t -> Buffer.t or_string -> unit [@@js.set "passphrase"]
  end
  [@@js.scope "PrivateKeyInput"]

  module Public_key_input : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_key : t -> Buffer.t or_string [@@js.get "key"]

    val set_key : t -> Buffer.t or_string -> unit [@@js.set "key"]

    val get_format : t -> Key_format.t [@@js.get "format"]

    val set_format : t -> Key_format.t -> unit [@@js.set "format"]

    val get_type :
      t -> ([ `pkcs1 [@js "pkcs1"] | `spki [@js "spki"] ][@js.enum])
      [@@js.get "type"]

    val set_type : t -> ([ `pkcs1 | `spki ][@js.enum]) -> unit [@@js.set "type"]
  end
  [@@js.scope "PublicKeyInput"]

  val create_private_key :
    key:(Buffer.t, Private_key_input.t) union2 or_string -> Key_object.t
    [@@js.global "createPrivateKey"]

  val create_public_key :
       key:
         ( ([ `U_s21_pkcs1 of Public_key_input.t
            | `U_s23_private of Key_object.t
            | `U_s24_public of Key_object.t
            | `U_s27_secret of Key_object.t
            | `U_s28_spki of Public_key_input.t
            ]
           [@js.union on_field "type"])
         , Buffer.t )
         or_
         or_string
    -> Key_object.t
    [@@js.global "createPublicKey"]

  val create_secret_key : key:Array_buffer_view.t -> Key_object.t
    [@@js.global "createSecretKey"]

  module Dsa_encoding : sig
    type t =
      ([ `der [@js "der"]
       | `ieee_p1363 [@js "ieee-p1363"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Signing_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_padding : t -> int [@@js.get "padding"]

    val set_padding : t -> int -> unit [@@js.set "padding"]

    val get_salt_length : t -> int [@@js.get "saltLength"]

    val set_salt_length : t -> int -> unit [@@js.set "saltLength"]

    val get_dsa_encoding : t -> Dsa_encoding.t [@@js.get "dsaEncoding"]

    val set_dsa_encoding : t -> Dsa_encoding.t -> unit [@@js.set "dsaEncoding"]
  end
  [@@js.scope "SigningOptions"]

  module Sign_private_key_input : sig
    include module type of struct
      include Private_key_input
    end

    val cast' : t -> Signing_options.t [@@js.cast]
  end
  [@@js.scope "SignPrivateKeyInput"]

  module Sign_key_object_input : sig
    include module type of struct
      include Signing_options
    end

    val get_key : t -> Key_object.t [@@js.get "key"]

    val set_key : t -> Key_object.t -> unit [@@js.set "key"]
  end
  [@@js.scope "SignKeyObjectInput"]

  module Verify_public_key_input : sig
    include module type of struct
      include Public_key_input
    end

    val cast' : t -> Signing_options.t [@@js.cast]
  end
  [@@js.scope "VerifyPublicKeyInput"]

  module Verify_key_object_input : sig
    include module type of struct
      include Signing_options
    end

    val get_key : t -> Key_object.t [@@js.get "key"]

    val set_key : t -> Key_object.t -> unit [@@js.set "key"]
  end
  [@@js.scope "VerifyKeyObjectInput"]

  module Key_like : sig
    type t = (Buffer.t, Key_object.t) union2 or_string

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Signer : sig
    include module type of struct
      include Stream.Writable
    end

    val create : unit -> t [@@js.create]

    val update : t -> data:Binary_like.t -> t [@@js.call "update"]

    val update' : t -> data:string -> input_encoding:Encoding.t -> t
      [@@js.call "update"]

    val sign :
         t
      -> private_key:
           ( ([ `U_s11_der of Sign_key_object_input.t
              | `U_s18_ieee_p1363 of Sign_key_object_input.t
              ]
             [@js.union on_field "dsaEncoding"])
           , ([ `U_s21_pkcs1 of Sign_private_key_input.t
              | `U_s22_pkcs8 of Sign_private_key_input.t
              | `U_s23_private of Key_like.t
              | `U_s24_public of Key_like.t
              | `U_s26_sec1 of Sign_private_key_input.t
              | `U_s27_secret of Key_like.t
              ]
             [@js.union on_field "type"]) )
           union2
      -> Buffer.t
      [@@js.call "sign"]

    val sign' :
         t
      -> private_key:
           ( ([ `U_s11_der of Sign_key_object_input.t
              | `U_s18_ieee_p1363 of Sign_key_object_input.t
              ]
             [@js.union on_field "dsaEncoding"])
           , ([ `U_s21_pkcs1 of Sign_private_key_input.t
              | `U_s22_pkcs8 of Sign_private_key_input.t
              | `U_s23_private of Key_like.t
              | `U_s24_public of Key_like.t
              | `U_s26_sec1 of Sign_private_key_input.t
              | `U_s27_secret of Key_like.t
              ]
             [@js.union on_field "type"]) )
           union2
      -> output_format:Binary_to_text_encoding.t
      -> string
      [@@js.call "sign"]
  end
  [@@js.scope "Signer"]

  val create_sign :
    algorithm:string -> ?options:Stream.Writable_options.t -> unit -> Signer.t
    [@@js.global "createSign"]

  module Verify : sig
    include module type of struct
      include Stream.Writable
    end

    val create : unit -> t [@@js.create]

    val update : t -> data:Binary_like.t -> t [@@js.call "update"]

    val update' : t -> data:string -> input_encoding:Encoding.t -> t
      [@@js.call "update"]

    val verify :
         t
      -> object_:
           ( ([ `U_s11_der of Verify_key_object_input.t
              | `U_s18_ieee_p1363 of Verify_key_object_input.t
              ]
             [@js.union on_field "dsaEncoding"])
           , ([ `U_s21_pkcs1 of Verify_public_key_input.t
              | `U_s23_private of Key_like.t
              | `U_s24_public of Key_like.t
              | `U_s27_secret of Key_like.t
              | `U_s28_spki of Verify_public_key_input.t
              ]
             [@js.union on_field "type"]) )
           union2
      -> signature:Array_buffer_view.t
      -> bool
      [@@js.call "verify"]

    val verify' :
         t
      -> object_:
           ( ([ `U_s11_der of Verify_key_object_input.t
              | `U_s18_ieee_p1363 of Verify_key_object_input.t
              ]
             [@js.union on_field "dsaEncoding"])
           , ([ `U_s21_pkcs1 of Verify_public_key_input.t
              | `U_s23_private of Key_like.t
              | `U_s24_public of Key_like.t
              | `U_s27_secret of Key_like.t
              | `U_s28_spki of Verify_public_key_input.t
              ]
             [@js.union on_field "type"]) )
           union2
      -> signature:string
      -> ?signature_format:Binary_to_text_encoding.t
      -> unit
      -> bool
      [@@js.call "verify"]
  end
  [@@js.scope "Verify"]

  val create_verify :
    algorithm:string -> ?options:Stream.Writable_options.t -> unit -> Verify.t
    [@@js.global "createVerify"]

  module Diffie_hellman : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create : unit -> t [@@js.create]

    val generate_keys : t -> Buffer.t [@@js.call "generateKeys"]

    val generate_keys' : t -> encoding:Binary_to_text_encoding.t -> string
      [@@js.call "generateKeys"]

    val compute_secret : t -> other_public_key:Array_buffer_view.t -> Buffer.t
      [@@js.call "computeSecret"]

    val compute_secret' :
         t
      -> other_public_key:string
      -> input_encoding:Binary_to_text_encoding.t
      -> Buffer.t
      [@@js.call "computeSecret"]

    val compute_secret'' :
         t
      -> other_public_key:Array_buffer_view.t
      -> output_encoding:Binary_to_text_encoding.t
      -> string
      [@@js.call "computeSecret"]

    val compute_secret''' :
         t
      -> other_public_key:string
      -> input_encoding:Binary_to_text_encoding.t
      -> output_encoding:Binary_to_text_encoding.t
      -> string
      [@@js.call "computeSecret"]

    val get_prime : t -> Buffer.t [@@js.call "getPrime"]

    val get_prime' : t -> encoding:Binary_to_text_encoding.t -> string
      [@@js.call "getPrime"]

    val get_generator : t -> Buffer.t [@@js.call "getGenerator"]

    val get_generator' : t -> encoding:Binary_to_text_encoding.t -> string
      [@@js.call "getGenerator"]

    val get_public_key : t -> Buffer.t [@@js.call "getPublicKey"]

    val get_public_key' : t -> encoding:Binary_to_text_encoding.t -> string
      [@@js.call "getPublicKey"]

    val get_private_key : t -> Buffer.t [@@js.call "getPrivateKey"]

    val get_private_key' : t -> encoding:Binary_to_text_encoding.t -> string
      [@@js.call "getPrivateKey"]

    val set_public_key : t -> public_key:Array_buffer_view.t -> unit
      [@@js.call "setPublicKey"]

    val set_public_key' :
      t -> public_key:string -> encoding:Buffer_encoding.t -> unit
      [@@js.call "setPublicKey"]

    val set_private_key : t -> private_key:Array_buffer_view.t -> unit
      [@@js.call "setPrivateKey"]

    val set_private_key' :
      t -> private_key:string -> encoding:Buffer_encoding.t -> unit
      [@@js.call "setPrivateKey"]

    val get_verify_error : t -> int [@@js.get "verifyError"]

    val set_verify_error : t -> int -> unit [@@js.set "verifyError"]
  end
  [@@js.scope "DiffieHellman"]

  val create_diffie_hellman :
       prime_length:int
    -> ?generator:Array_buffer_view.t or_number
    -> unit
    -> Diffie_hellman.t
    [@@js.global "createDiffieHellman"]

  val create_diffie_hellman : prime:Array_buffer_view.t -> Diffie_hellman.t
    [@@js.global "createDiffieHellman"]

  val create_diffie_hellman :
    prime:string -> prime_encoding:Binary_to_text_encoding.t -> Diffie_hellman.t
    [@@js.global "createDiffieHellman"]

  val create_diffie_hellman :
       prime:string
    -> prime_encoding:Binary_to_text_encoding.t
    -> generator:Array_buffer_view.t or_number
    -> Diffie_hellman.t
    [@@js.global "createDiffieHellman"]

  val create_diffie_hellman :
       prime:string
    -> prime_encoding:Binary_to_text_encoding.t
    -> generator:string
    -> generator_encoding:Binary_to_text_encoding.t
    -> Diffie_hellman.t
    [@@js.global "createDiffieHellman"]

  val get_diffie_hellman : group_name:string -> Diffie_hellman.t
    [@@js.global "getDiffieHellman"]

  val pbkdf2 :
       password:Binary_like.t
    -> salt:Binary_like.t
    -> iterations:int
    -> keylen:int
    -> digest:string
    -> callback:(err:Error.t or_null -> derived_key:Buffer.t -> any)
    -> unit
    [@@js.global "pbkdf2"]

  val pbkdf2Sync :
       password:Binary_like.t
    -> salt:Binary_like.t
    -> iterations:int
    -> keylen:int
    -> digest:string
    -> Buffer.t
    [@@js.global "pbkdf2Sync"]

  val random_bytes : size:int -> Buffer.t [@@js.global "randomBytes"]

  val random_bytes :
    size:int -> callback:(err:Error.t or_null -> buf:Buffer.t -> unit) -> unit
    [@@js.global "randomBytes"]

  val pseudo_random_bytes : size:int -> Buffer.t
    [@@js.global "pseudoRandomBytes"]

  val pseudo_random_bytes :
    size:int -> callback:(err:Error.t or_null -> buf:Buffer.t -> unit) -> unit
    [@@js.global "pseudoRandomBytes"]

  val random_int : max:int -> int [@@js.global "randomInt"]

  val random_int : min:int -> max:int -> int [@@js.global "randomInt"]

  val random_int :
    max:int -> callback:(err:Error.t or_null -> value:int -> unit) -> unit
    [@@js.global "randomInt"]

  val random_int :
       min:int
    -> max:int
    -> callback:(err:Error.t or_null -> value:int -> unit)
    -> unit
    [@@js.global "randomInt"]

  val random_fill_sync : buffer:'T -> ?offset:int -> ?size:int -> unit -> 'T
    [@@js.global "randomFillSync"]

  val random_fill :
    buffer:'T -> callback:(err:Error.t or_null -> buf:'T -> unit) -> unit
    [@@js.global "randomFill"]

  val random_fill :
       buffer:'T
    -> offset:int
    -> callback:(err:Error.t or_null -> buf:'T -> unit)
    -> unit
    [@@js.global "randomFill"]

  val random_fill :
       buffer:'T
    -> offset:int
    -> size:int
    -> callback:(err:Error.t or_null -> buf:'T -> unit)
    -> unit
    [@@js.global "randomFill"]

  module Scrypt_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_cost : t -> int [@@js.get "cost"]

    val set_cost : t -> int -> unit [@@js.set "cost"]

    val get_block_size : t -> int [@@js.get "blockSize"]

    val set_block_size : t -> int -> unit [@@js.set "blockSize"]

    val get_parallelization : t -> int [@@js.get "parallelization"]

    val set_parallelization : t -> int -> unit [@@js.set "parallelization"]

    val get_n : t -> int [@@js.get "N"]

    val set_n : t -> int -> unit [@@js.set "N"]

    val get_r : t -> int [@@js.get "r"]

    val set_r : t -> int -> unit [@@js.set "r"]

    val get_p : t -> int [@@js.get "p"]

    val set_p : t -> int -> unit [@@js.set "p"]

    val get_maxmem : t -> int [@@js.get "maxmem"]

    val set_maxmem : t -> int -> unit [@@js.set "maxmem"]
  end
  [@@js.scope "ScryptOptions"]

  val scrypt :
       password:Binary_like.t
    -> salt:Binary_like.t
    -> keylen:int
    -> callback:(err:Error.t or_null -> derived_key:Buffer.t -> unit)
    -> unit
    [@@js.global "scrypt"]

  val scrypt :
       password:Binary_like.t
    -> salt:Binary_like.t
    -> keylen:int
    -> options:Scrypt_options.t
    -> callback:(err:Error.t or_null -> derived_key:Buffer.t -> unit)
    -> unit
    [@@js.global "scrypt"]

  val scrypt_sync :
       password:Binary_like.t
    -> salt:Binary_like.t
    -> keylen:int
    -> ?options:Scrypt_options.t
    -> unit
    -> Buffer.t
    [@@js.global "scryptSync"]

  module Rsa_public_key : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_key : t -> Key_like.t [@@js.get "key"]

    val set_key : t -> Key_like.t -> unit [@@js.set "key"]

    val get_padding : t -> int [@@js.get "padding"]

    val set_padding : t -> int -> unit [@@js.set "padding"]
  end
  [@@js.scope "RsaPublicKey"]

  module Rsa_private_key : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_key : t -> Key_like.t [@@js.get "key"]

    val set_key : t -> Key_like.t -> unit [@@js.set "key"]

    val get_passphrase : t -> string [@@js.get "passphrase"]

    val set_passphrase : t -> string -> unit [@@js.set "passphrase"]

    val get_oaep_hash : t -> string [@@js.get "oaepHash"]

    val set_oaep_hash : t -> string -> unit [@@js.set "oaepHash"]

    val get_oaep_label : t -> Typed_array.t [@@js.get "oaepLabel"]

    val set_oaep_label : t -> Typed_array.t -> unit [@@js.set "oaepLabel"]

    val get_padding : t -> int [@@js.get "padding"]

    val set_padding : t -> int -> unit [@@js.set "padding"]
  end
  [@@js.scope "RsaPrivateKey"]

  val public_encrypt :
       key:(Key_like.t, Rsa_private_key.t, Rsa_public_key.t) union3
    -> buffer:Array_buffer_view.t
    -> Buffer.t
    [@@js.global "publicEncrypt"]

  val public_decrypt :
       key:(Key_like.t, Rsa_private_key.t, Rsa_public_key.t) union3
    -> buffer:Array_buffer_view.t
    -> Buffer.t
    [@@js.global "publicDecrypt"]

  val private_decrypt :
       private_key:(Key_like.t, Rsa_private_key.t) union2
    -> buffer:Array_buffer_view.t
    -> Buffer.t
    [@@js.global "privateDecrypt"]

  val private_encrypt :
       private_key:(Key_like.t, Rsa_private_key.t) union2
    -> buffer:Array_buffer_view.t
    -> Buffer.t
    [@@js.global "privateEncrypt"]

  val get_ciphers : unit -> string list [@@js.global "getCiphers"]

  val get_curves : unit -> string list [@@js.global "getCurves"]

  val get_fips : unit -> ([ `L_n_0 [@js 0] | `L_n_1 [@js 1] ][@js.enum])
    [@@js.global "getFips"]

  val get_hashes : unit -> string list [@@js.global "getHashes"]

  module Ecdh : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create : unit -> t [@@js.create]

    val convert_key :
         key:Binary_like.t
      -> curve:string
      -> ?input_encoding:Binary_to_text_encoding.t
      -> ?output_encoding:([ `base64 | `hex | `latin1 ][@js.enum])
      -> ?format:([ `compressed | `hybrid | `uncompressed ][@js.enum])
      -> unit
      -> Buffer.t or_string
      [@@js.global "convertKey"]

    val generate_keys : t -> Buffer.t [@@js.call "generateKeys"]

    val generate_keys' :
         t
      -> encoding:Binary_to_text_encoding.t
      -> ?format:Ecdh_key_format.t
      -> unit
      -> string
      [@@js.call "generateKeys"]

    val compute_secret : t -> other_public_key:Array_buffer_view.t -> Buffer.t
      [@@js.call "computeSecret"]

    val compute_secret' :
         t
      -> other_public_key:string
      -> input_encoding:Binary_to_text_encoding.t
      -> Buffer.t
      [@@js.call "computeSecret"]

    val compute_secret'' :
         t
      -> other_public_key:Array_buffer_view.t
      -> output_encoding:Binary_to_text_encoding.t
      -> string
      [@@js.call "computeSecret"]

    val compute_secret''' :
         t
      -> other_public_key:string
      -> input_encoding:Binary_to_text_encoding.t
      -> output_encoding:Binary_to_text_encoding.t
      -> string
      [@@js.call "computeSecret"]

    val get_private_key : t -> Buffer.t [@@js.call "getPrivateKey"]

    val get_private_key' : t -> encoding:Binary_to_text_encoding.t -> string
      [@@js.call "getPrivateKey"]

    val get_public_key : t -> Buffer.t [@@js.call "getPublicKey"]

    val get_public_key' :
         t
      -> encoding:Binary_to_text_encoding.t
      -> ?format:Ecdh_key_format.t
      -> unit
      -> string
      [@@js.call "getPublicKey"]

    val set_private_key : t -> private_key:Array_buffer_view.t -> unit
      [@@js.call "setPrivateKey"]

    val set_private_key' :
      t -> private_key:string -> encoding:Binary_to_text_encoding.t -> unit
      [@@js.call "setPrivateKey"]
  end
  [@@js.scope "ECDH"]

  val create_ecdh : curve_name:string -> Ecdh.t [@@js.global "createECDH"]

  val timing_safe_equal : a:Array_buffer_view.t -> b:Array_buffer_view.t -> bool
    [@@js.global "timingSafeEqual"]

  module Anonymous_interface2 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_public_key : t -> Buffer.t [@@js.get "publicKey"]

    val set_public_key : t -> Buffer.t -> unit [@@js.set "publicKey"]

    val get_private_key : t -> Buffer.t [@@js.get "privateKey"]

    val set_private_key : t -> Buffer.t -> unit [@@js.set "privateKey"]
  end

  module Anonymous_interface3 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_public_key : t -> Buffer.t [@@js.get "publicKey"]

    val set_public_key : t -> Buffer.t -> unit [@@js.set "publicKey"]

    val get_private_key : t -> string [@@js.get "privateKey"]

    val set_private_key : t -> string -> unit [@@js.set "privateKey"]
  end

  module Anonymous_interface4 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_public_key : t -> string [@@js.get "publicKey"]

    val set_public_key : t -> string -> unit [@@js.set "publicKey"]

    val get_private_key : t -> Buffer.t [@@js.get "privateKey"]

    val set_private_key : t -> Buffer.t -> unit [@@js.set "privateKey"]
  end

  module Anonymous_interface5 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_public_key : t -> string [@@js.get "publicKey"]

    val set_public_key : t -> string -> unit [@@js.set "publicKey"]

    val get_private_key : t -> string [@@js.get "privateKey"]

    val set_private_key : t -> string -> unit [@@js.set "privateKey"]
  end

  module Anonymous_interface6 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_type : t -> ([ `pkcs8 [@js "pkcs8"] ][@js.enum]) [@@js.get "type"]

    val set_type : t -> ([ `pkcs8 ][@js.enum]) -> unit [@@js.set "type"]
  end

  module Anonymous_interface7 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_type : t -> ([ `spki [@js "spki"] ][@js.enum]) [@@js.get "type"]

    val set_type : t -> ([ `spki ][@js.enum]) -> unit [@@js.set "type"]

    val get_format : t -> 'PubF [@@js.get "format"]

    val set_format : t -> 'PubF -> unit [@@js.set "format"]
  end

  module Anonymous_interface8 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_type :
      t -> ([ `pkcs1 [@js "pkcs1"] | `pkcs8 [@js "pkcs8"] ][@js.enum])
      [@@js.get "type"]

    val set_type : t -> ([ `pkcs1 | `pkcs8 ][@js.enum]) -> unit
      [@@js.set "type"]
  end

  module Anonymous_interface9 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_type :
      t -> ([ `pkcs1 [@js "pkcs1"] | `spki [@js "spki"] ][@js.enum])
      [@@js.get "type"]

    val set_type : t -> ([ `pkcs1 | `spki ][@js.enum]) -> unit [@@js.set "type"]

    val get_format : t -> 'PubF [@@js.get "format"]

    val set_format : t -> 'PubF -> unit [@@js.set "format"]
  end

  module Anonymous_interface10 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_type :
      t -> ([ `pkcs8 [@js "pkcs8"] | `sec1 [@js "sec1"] ][@js.enum])
      [@@js.get "type"]

    val set_type : t -> ([ `pkcs8 | `sec1 ][@js.enum]) -> unit [@@js.set "type"]
  end

  module Base_private_key_encoding_options : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val get_format : 'T t -> 'T [@@js.get "format"]

    val set_format : 'T t -> 'T -> unit [@@js.set "format"]

    val get_cipher : 'T t -> string [@@js.get "cipher"]

    val set_cipher : 'T t -> string -> unit [@@js.set "cipher"]

    val get_passphrase : 'T t -> string [@@js.get "passphrase"]

    val set_passphrase : 'T t -> string -> unit [@@js.set "passphrase"]
  end
  [@@js.scope "BasePrivateKeyEncodingOptions"]

  module Key_pair_key_object_result : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_public_key : t -> Key_object.t [@@js.get "publicKey"]

    val set_public_key : t -> Key_object.t -> unit [@@js.set "publicKey"]

    val get_private_key : t -> Key_object.t [@@js.get "privateKey"]

    val set_private_key : t -> Key_object.t -> unit [@@js.set "privateKey"]
  end
  [@@js.scope "KeyPairKeyObjectResult"]

  module Ed25519_key_pair_key_object_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Ed448_key_pair_key_object_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module X25519_key_pair_key_object_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module X448_key_pair_key_object_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Ec_key_pair_key_object_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_named_curve : t -> string [@@js.get "namedCurve"]

    val set_named_curve : t -> string -> unit [@@js.set "namedCurve"]
  end
  [@@js.scope "ECKeyPairKeyObjectOptions"]

  module Rsa_key_pair_key_object_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_modulus_length : t -> int [@@js.get "modulusLength"]

    val set_modulus_length : t -> int -> unit [@@js.set "modulusLength"]

    val get_public_exponent : t -> int [@@js.get "publicExponent"]

    val set_public_exponent : t -> int -> unit [@@js.set "publicExponent"]
  end
  [@@js.scope "RSAKeyPairKeyObjectOptions"]

  module Dsa_key_pair_key_object_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_modulus_length : t -> int [@@js.get "modulusLength"]

    val set_modulus_length : t -> int -> unit [@@js.set "modulusLength"]

    val get_divisor_length : t -> int [@@js.get "divisorLength"]

    val set_divisor_length : t -> int -> unit [@@js.set "divisorLength"]
  end
  [@@js.scope "DSAKeyPairKeyObjectOptions"]

  module Rsa_key_pair_options : sig
    type ('PubF, 'PrivF) t

    val t_to_js :
      ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t -> Ojs.t

    val t_of_js :
      (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t

    val get_modulus_length : ('PubF, 'PrivF) t -> int [@@js.get "modulusLength"]

    val set_modulus_length : ('PubF, 'PrivF) t -> int -> unit
      [@@js.set "modulusLength"]

    val get_public_exponent : ('PubF, 'PrivF) t -> int
      [@@js.get "publicExponent"]

    val set_public_exponent : ('PubF, 'PrivF) t -> int -> unit
      [@@js.set "publicExponent"]

    val get_public_key_encoding : ('PubF, 'PrivF) t -> Anonymous_interface9.t
      [@@js.get "publicKeyEncoding"]

    val set_public_key_encoding :
      ('PubF, 'PrivF) t -> Anonymous_interface9.t -> unit
      [@@js.set "publicKeyEncoding"]

    val get_private_key_encoding :
         ('PubF, 'PrivF) t
      -> ( 'PrivF Base_private_key_encoding_options.t
         , Anonymous_interface8.t )
         intersection2
      [@@js.get "privateKeyEncoding"]

    val set_private_key_encoding :
         ('PubF, 'PrivF) t
      -> ( 'PrivF Base_private_key_encoding_options.t
         , Anonymous_interface8.t )
         intersection2
      -> unit
      [@@js.set "privateKeyEncoding"]
  end
  [@@js.scope "RSAKeyPairOptions"]

  module Dsa_key_pair_options : sig
    type ('PubF, 'PrivF) t

    val t_to_js :
      ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t -> Ojs.t

    val t_of_js :
      (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t

    val get_modulus_length : ('PubF, 'PrivF) t -> int [@@js.get "modulusLength"]

    val set_modulus_length : ('PubF, 'PrivF) t -> int -> unit
      [@@js.set "modulusLength"]

    val get_divisor_length : ('PubF, 'PrivF) t -> int [@@js.get "divisorLength"]

    val set_divisor_length : ('PubF, 'PrivF) t -> int -> unit
      [@@js.set "divisorLength"]

    val get_public_key_encoding : ('PubF, 'PrivF) t -> Anonymous_interface7.t
      [@@js.get "publicKeyEncoding"]

    val set_public_key_encoding :
      ('PubF, 'PrivF) t -> Anonymous_interface7.t -> unit
      [@@js.set "publicKeyEncoding"]

    val get_private_key_encoding :
         ('PubF, 'PrivF) t
      -> ( 'PrivF Base_private_key_encoding_options.t
         , Anonymous_interface6.t )
         intersection2
      [@@js.get "privateKeyEncoding"]

    val set_private_key_encoding :
         ('PubF, 'PrivF) t
      -> ( 'PrivF Base_private_key_encoding_options.t
         , Anonymous_interface6.t )
         intersection2
      -> unit
      [@@js.set "privateKeyEncoding"]
  end
  [@@js.scope "DSAKeyPairOptions"]

  module Ec_key_pair_options : sig
    type ('PubF, 'PrivF) t

    val t_to_js :
      ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t -> Ojs.t

    val t_of_js :
      (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t

    val get_named_curve : ('PubF, 'PrivF) t -> string [@@js.get "namedCurve"]

    val set_named_curve : ('PubF, 'PrivF) t -> string -> unit
      [@@js.set "namedCurve"]

    val get_public_key_encoding : ('PubF, 'PrivF) t -> Anonymous_interface9.t
      [@@js.get "publicKeyEncoding"]

    val set_public_key_encoding :
      ('PubF, 'PrivF) t -> Anonymous_interface9.t -> unit
      [@@js.set "publicKeyEncoding"]

    val get_private_key_encoding :
         ('PubF, 'PrivF) t
      -> ( 'PrivF Base_private_key_encoding_options.t
         , Anonymous_interface10.t )
         intersection2
      [@@js.get "privateKeyEncoding"]

    val set_private_key_encoding :
         ('PubF, 'PrivF) t
      -> ( 'PrivF Base_private_key_encoding_options.t
         , Anonymous_interface10.t )
         intersection2
      -> unit
      [@@js.set "privateKeyEncoding"]
  end
  [@@js.scope "ECKeyPairOptions"]

  module Ed25519_key_pair_options : sig
    type ('PubF, 'PrivF) t

    val t_to_js :
      ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t -> Ojs.t

    val t_of_js :
      (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t

    val get_public_key_encoding : ('PubF, 'PrivF) t -> Anonymous_interface7.t
      [@@js.get "publicKeyEncoding"]

    val set_public_key_encoding :
      ('PubF, 'PrivF) t -> Anonymous_interface7.t -> unit
      [@@js.set "publicKeyEncoding"]

    val get_private_key_encoding :
         ('PubF, 'PrivF) t
      -> ( 'PrivF Base_private_key_encoding_options.t
         , Anonymous_interface6.t )
         intersection2
      [@@js.get "privateKeyEncoding"]

    val set_private_key_encoding :
         ('PubF, 'PrivF) t
      -> ( 'PrivF Base_private_key_encoding_options.t
         , Anonymous_interface6.t )
         intersection2
      -> unit
      [@@js.set "privateKeyEncoding"]
  end
  [@@js.scope "ED25519KeyPairOptions"]

  module Ed448_key_pair_options : sig
    type ('PubF, 'PrivF) t

    val t_to_js :
      ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t -> Ojs.t

    val t_of_js :
      (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t

    val get_public_key_encoding : ('PubF, 'PrivF) t -> Anonymous_interface7.t
      [@@js.get "publicKeyEncoding"]

    val set_public_key_encoding :
      ('PubF, 'PrivF) t -> Anonymous_interface7.t -> unit
      [@@js.set "publicKeyEncoding"]

    val get_private_key_encoding :
         ('PubF, 'PrivF) t
      -> ( 'PrivF Base_private_key_encoding_options.t
         , Anonymous_interface6.t )
         intersection2
      [@@js.get "privateKeyEncoding"]

    val set_private_key_encoding :
         ('PubF, 'PrivF) t
      -> ( 'PrivF Base_private_key_encoding_options.t
         , Anonymous_interface6.t )
         intersection2
      -> unit
      [@@js.set "privateKeyEncoding"]
  end
  [@@js.scope "ED448KeyPairOptions"]

  module X25519_key_pair_options : sig
    type ('PubF, 'PrivF) t

    val t_to_js :
      ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t -> Ojs.t

    val t_of_js :
      (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t

    val get_public_key_encoding : ('PubF, 'PrivF) t -> Anonymous_interface7.t
      [@@js.get "publicKeyEncoding"]

    val set_public_key_encoding :
      ('PubF, 'PrivF) t -> Anonymous_interface7.t -> unit
      [@@js.set "publicKeyEncoding"]

    val get_private_key_encoding :
         ('PubF, 'PrivF) t
      -> ( 'PrivF Base_private_key_encoding_options.t
         , Anonymous_interface6.t )
         intersection2
      [@@js.get "privateKeyEncoding"]

    val set_private_key_encoding :
         ('PubF, 'PrivF) t
      -> ( 'PrivF Base_private_key_encoding_options.t
         , Anonymous_interface6.t )
         intersection2
      -> unit
      [@@js.set "privateKeyEncoding"]
  end
  [@@js.scope "X25519KeyPairOptions"]

  module X448_key_pair_options : sig
    type ('PubF, 'PrivF) t

    val t_to_js :
      ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t -> Ojs.t

    val t_of_js :
      (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t

    val get_public_key_encoding : ('PubF, 'PrivF) t -> Anonymous_interface7.t
      [@@js.get "publicKeyEncoding"]

    val set_public_key_encoding :
      ('PubF, 'PrivF) t -> Anonymous_interface7.t -> unit
      [@@js.set "publicKeyEncoding"]

    val get_private_key_encoding :
         ('PubF, 'PrivF) t
      -> ( 'PrivF Base_private_key_encoding_options.t
         , Anonymous_interface6.t )
         intersection2
      [@@js.get "privateKeyEncoding"]

    val set_private_key_encoding :
         ('PubF, 'PrivF) t
      -> ( 'PrivF Base_private_key_encoding_options.t
         , Anonymous_interface6.t )
         intersection2
      -> unit
      [@@js.set "privateKeyEncoding"]
  end
  [@@js.scope "X448KeyPairOptions"]

  module Key_pair_sync_result : sig
    type ('T1, 'T2) t

    val t_to_js : ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T1, 'T2) t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> Ojs.t -> ('T1, 'T2) t

    val get_public_key : ('T1, 'T2) t -> 'T1 [@@js.get "publicKey"]

    val set_public_key : ('T1, 'T2) t -> 'T1 -> unit [@@js.set "publicKey"]

    val get_private_key : ('T1, 'T2) t -> 'T2 [@@js.get "privateKey"]

    val set_private_key : ('T1, 'T2) t -> 'T2 -> unit [@@js.set "privateKey"]
  end
  [@@js.scope "KeyPairSyncResult"]

  val generate_key_pair_sync :
       type_:([ `rsa ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) Rsa_key_pair_options.t
    -> (string, string) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `rsa ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `der ][@js.enum])) Rsa_key_pair_options.t
    -> (string, Buffer.t) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `rsa ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `pem ][@js.enum])) Rsa_key_pair_options.t
    -> (Buffer.t, string) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `rsa ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `der ][@js.enum])) Rsa_key_pair_options.t
    -> (Buffer.t, Buffer.t) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `rsa ][@js.enum])
    -> options:Rsa_key_pair_key_object_options.t
    -> Key_pair_key_object_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `dsa ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) Dsa_key_pair_options.t
    -> (string, string) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `dsa ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `der ][@js.enum])) Dsa_key_pair_options.t
    -> (string, Buffer.t) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `dsa ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `pem ][@js.enum])) Dsa_key_pair_options.t
    -> (Buffer.t, string) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `dsa ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `der ][@js.enum])) Dsa_key_pair_options.t
    -> (Buffer.t, Buffer.t) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `dsa ][@js.enum])
    -> options:Dsa_key_pair_key_object_options.t
    -> Key_pair_key_object_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `ec ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) Ec_key_pair_options.t
    -> (string, string) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `ec ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `der ][@js.enum])) Ec_key_pair_options.t
    -> (string, Buffer.t) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `ec ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `pem ][@js.enum])) Ec_key_pair_options.t
    -> (Buffer.t, string) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `ec ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `der ][@js.enum])) Ec_key_pair_options.t
    -> (Buffer.t, Buffer.t) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `ec ][@js.enum])
    -> options:Ec_key_pair_key_object_options.t
    -> Key_pair_key_object_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `ed25519 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) Ed25519_key_pair_options.t
    -> (string, string) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `ed25519 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `der ][@js.enum])) Ed25519_key_pair_options.t
    -> (string, Buffer.t) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `ed25519 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `pem ][@js.enum])) Ed25519_key_pair_options.t
    -> (Buffer.t, string) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `ed25519 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `der ][@js.enum])) Ed25519_key_pair_options.t
    -> (Buffer.t, Buffer.t) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `ed25519 ][@js.enum])
    -> ?options:Ed25519_key_pair_key_object_options.t
    -> unit
    -> Key_pair_key_object_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `ed448 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) Ed448_key_pair_options.t
    -> (string, string) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `ed448 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `der ][@js.enum])) Ed448_key_pair_options.t
    -> (string, Buffer.t) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `ed448 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `pem ][@js.enum])) Ed448_key_pair_options.t
    -> (Buffer.t, string) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `ed448 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `der ][@js.enum])) Ed448_key_pair_options.t
    -> (Buffer.t, Buffer.t) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `ed448 ][@js.enum])
    -> ?options:Ed448_key_pair_key_object_options.t
    -> unit
    -> Key_pair_key_object_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `x25519 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) X25519_key_pair_options.t
    -> (string, string) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `x25519 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `der ][@js.enum])) X25519_key_pair_options.t
    -> (string, Buffer.t) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `x25519 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `pem ][@js.enum])) X25519_key_pair_options.t
    -> (Buffer.t, string) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `x25519 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `der ][@js.enum])) X25519_key_pair_options.t
    -> (Buffer.t, Buffer.t) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `x25519 ][@js.enum])
    -> ?options:X25519_key_pair_key_object_options.t
    -> unit
    -> Key_pair_key_object_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `x448 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) X448_key_pair_options.t
    -> (string, string) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `x448 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `der ][@js.enum])) X448_key_pair_options.t
    -> (string, Buffer.t) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `x448 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `pem ][@js.enum])) X448_key_pair_options.t
    -> (Buffer.t, string) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `x448 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `der ][@js.enum])) X448_key_pair_options.t
    -> (Buffer.t, Buffer.t) Key_pair_sync_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair_sync :
       type_:([ `x448 ][@js.enum])
    -> ?options:X448_key_pair_key_object_options.t
    -> unit
    -> Key_pair_key_object_result.t
    [@@js.global "generateKeyPairSync"]

  val generate_key_pair :
       type_:([ `rsa ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) Rsa_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:string
          -> private_key:string
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `rsa ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `der ][@js.enum])) Rsa_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:string
          -> private_key:Buffer.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `rsa ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `pem ][@js.enum])) Rsa_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Buffer.t
          -> private_key:string
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `rsa ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `der ][@js.enum])) Rsa_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Buffer.t
          -> private_key:Buffer.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `rsa ][@js.enum])
    -> options:Rsa_key_pair_key_object_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Key_object.t
          -> private_key:Key_object.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `dsa ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) Dsa_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:string
          -> private_key:string
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `dsa ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `der ][@js.enum])) Dsa_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:string
          -> private_key:Buffer.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `dsa ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `pem ][@js.enum])) Dsa_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Buffer.t
          -> private_key:string
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `dsa ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `der ][@js.enum])) Dsa_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Buffer.t
          -> private_key:Buffer.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `dsa ][@js.enum])
    -> options:Dsa_key_pair_key_object_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Key_object.t
          -> private_key:Key_object.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `ec ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) Ec_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:string
          -> private_key:string
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `ec ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `der ][@js.enum])) Ec_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:string
          -> private_key:Buffer.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `ec ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `pem ][@js.enum])) Ec_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Buffer.t
          -> private_key:string
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `ec ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `der ][@js.enum])) Ec_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Buffer.t
          -> private_key:Buffer.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `ec ][@js.enum])
    -> options:Ec_key_pair_key_object_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Key_object.t
          -> private_key:Key_object.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `ed25519 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) Ed25519_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:string
          -> private_key:string
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `ed25519 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `der ][@js.enum])) Ed25519_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:string
          -> private_key:Buffer.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `ed25519 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `pem ][@js.enum])) Ed25519_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Buffer.t
          -> private_key:string
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `ed25519 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `der ][@js.enum])) Ed25519_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Buffer.t
          -> private_key:Buffer.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `ed25519 ][@js.enum])
    -> options:Ed25519_key_pair_key_object_options.t or_undefined
    -> callback:
         (   err:Error.t or_null
          -> public_key:Key_object.t
          -> private_key:Key_object.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `ed448 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) Ed448_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:string
          -> private_key:string
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `ed448 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `der ][@js.enum])) Ed448_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:string
          -> private_key:Buffer.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `ed448 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `pem ][@js.enum])) Ed448_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Buffer.t
          -> private_key:string
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `ed448 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `der ][@js.enum])) Ed448_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Buffer.t
          -> private_key:Buffer.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `ed448 ][@js.enum])
    -> options:Ed448_key_pair_key_object_options.t or_undefined
    -> callback:
         (   err:Error.t or_null
          -> public_key:Key_object.t
          -> private_key:Key_object.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `x25519 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) X25519_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:string
          -> private_key:string
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `x25519 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `der ][@js.enum])) X25519_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:string
          -> private_key:Buffer.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `x25519 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `pem ][@js.enum])) X25519_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Buffer.t
          -> private_key:string
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `x25519 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `der ][@js.enum])) X25519_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Buffer.t
          -> private_key:Buffer.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `x25519 ][@js.enum])
    -> options:X25519_key_pair_key_object_options.t or_undefined
    -> callback:
         (   err:Error.t or_null
          -> public_key:Key_object.t
          -> private_key:Key_object.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `x448 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) X448_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:string
          -> private_key:string
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `x448 ][@js.enum])
    -> options:
         (([ `pem ][@js.enum]), ([ `der ][@js.enum])) X448_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:string
          -> private_key:Buffer.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `x448 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `pem ][@js.enum])) X448_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Buffer.t
          -> private_key:string
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `x448 ][@js.enum])
    -> options:
         (([ `der ][@js.enum]), ([ `der ][@js.enum])) X448_key_pair_options.t
    -> callback:
         (   err:Error.t or_null
          -> public_key:Buffer.t
          -> private_key:Buffer.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  val generate_key_pair :
       type_:([ `x448 ][@js.enum])
    -> options:X448_key_pair_key_object_options.t or_undefined
    -> callback:
         (   err:Error.t or_null
          -> public_key:Key_object.t
          -> private_key:Key_object.t
          -> unit)
    -> unit
    [@@js.global "generateKeyPair"]

  module Generate_key_pair : sig
    val __promisify__ :
         type_:([ `rsa ][@js.enum])
      -> options:
           (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) Rsa_key_pair_options.t
      -> Anonymous_interface5.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `rsa ][@js.enum])
      -> options:
           (([ `pem ][@js.enum]), ([ `der ][@js.enum])) Rsa_key_pair_options.t
      -> Anonymous_interface4.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `rsa ][@js.enum])
      -> options:
           (([ `der ][@js.enum]), ([ `pem ][@js.enum])) Rsa_key_pair_options.t
      -> Anonymous_interface3.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `rsa ][@js.enum])
      -> options:
           (([ `der ][@js.enum]), ([ `der ][@js.enum])) Rsa_key_pair_options.t
      -> Anonymous_interface2.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `rsa ][@js.enum])
      -> options:Rsa_key_pair_key_object_options.t
      -> Key_pair_key_object_result.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `dsa ][@js.enum])
      -> options:
           (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) Dsa_key_pair_options.t
      -> Anonymous_interface5.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `dsa ][@js.enum])
      -> options:
           (([ `pem ][@js.enum]), ([ `der ][@js.enum])) Dsa_key_pair_options.t
      -> Anonymous_interface4.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `dsa ][@js.enum])
      -> options:
           (([ `der ][@js.enum]), ([ `pem ][@js.enum])) Dsa_key_pair_options.t
      -> Anonymous_interface3.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `dsa ][@js.enum])
      -> options:
           (([ `der ][@js.enum]), ([ `der ][@js.enum])) Dsa_key_pair_options.t
      -> Anonymous_interface2.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `dsa ][@js.enum])
      -> options:Dsa_key_pair_key_object_options.t
      -> Key_pair_key_object_result.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `ec ][@js.enum])
      -> options:
           (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) Ec_key_pair_options.t
      -> Anonymous_interface5.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `ec ][@js.enum])
      -> options:
           (([ `pem ][@js.enum]), ([ `der ][@js.enum])) Ec_key_pair_options.t
      -> Anonymous_interface4.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `ec ][@js.enum])
      -> options:
           (([ `der ][@js.enum]), ([ `pem ][@js.enum])) Ec_key_pair_options.t
      -> Anonymous_interface3.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `ec ][@js.enum])
      -> options:
           (([ `der ][@js.enum]), ([ `der ][@js.enum])) Ec_key_pair_options.t
      -> Anonymous_interface2.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `ec ][@js.enum])
      -> options:Ec_key_pair_key_object_options.t
      -> Key_pair_key_object_result.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `ed25519 ][@js.enum])
      -> options:
           ( ([ `pem ][@js.enum])
           , ([ `pem ][@js.enum]) )
           Ed25519_key_pair_options.t
      -> Anonymous_interface5.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `ed25519 ][@js.enum])
      -> options:
           ( ([ `pem ][@js.enum])
           , ([ `der ][@js.enum]) )
           Ed25519_key_pair_options.t
      -> Anonymous_interface4.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `ed25519 ][@js.enum])
      -> options:
           ( ([ `der ][@js.enum])
           , ([ `pem ][@js.enum]) )
           Ed25519_key_pair_options.t
      -> Anonymous_interface3.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `ed25519 ][@js.enum])
      -> options:
           ( ([ `der ][@js.enum])
           , ([ `der ][@js.enum]) )
           Ed25519_key_pair_options.t
      -> Anonymous_interface2.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `ed25519 ][@js.enum])
      -> ?options:Ed25519_key_pair_key_object_options.t
      -> unit
      -> Key_pair_key_object_result.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `ed448 ][@js.enum])
      -> options:
           (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) Ed448_key_pair_options.t
      -> Anonymous_interface5.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `ed448 ][@js.enum])
      -> options:
           (([ `pem ][@js.enum]), ([ `der ][@js.enum])) Ed448_key_pair_options.t
      -> Anonymous_interface4.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `ed448 ][@js.enum])
      -> options:
           (([ `der ][@js.enum]), ([ `pem ][@js.enum])) Ed448_key_pair_options.t
      -> Anonymous_interface3.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `ed448 ][@js.enum])
      -> options:
           (([ `der ][@js.enum]), ([ `der ][@js.enum])) Ed448_key_pair_options.t
      -> Anonymous_interface2.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `ed448 ][@js.enum])
      -> ?options:Ed448_key_pair_key_object_options.t
      -> unit
      -> Key_pair_key_object_result.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `x25519 ][@js.enum])
      -> options:
           ( ([ `pem ][@js.enum])
           , ([ `pem ][@js.enum]) )
           X25519_key_pair_options.t
      -> Anonymous_interface5.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `x25519 ][@js.enum])
      -> options:
           ( ([ `pem ][@js.enum])
           , ([ `der ][@js.enum]) )
           X25519_key_pair_options.t
      -> Anonymous_interface4.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `x25519 ][@js.enum])
      -> options:
           ( ([ `der ][@js.enum])
           , ([ `pem ][@js.enum]) )
           X25519_key_pair_options.t
      -> Anonymous_interface3.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `x25519 ][@js.enum])
      -> options:
           ( ([ `der ][@js.enum])
           , ([ `der ][@js.enum]) )
           X25519_key_pair_options.t
      -> Anonymous_interface2.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `x25519 ][@js.enum])
      -> ?options:X25519_key_pair_key_object_options.t
      -> unit
      -> Key_pair_key_object_result.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `x448 ][@js.enum])
      -> options:
           (([ `pem ][@js.enum]), ([ `pem ][@js.enum])) X448_key_pair_options.t
      -> Anonymous_interface5.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `x448 ][@js.enum])
      -> options:
           (([ `pem ][@js.enum]), ([ `der ][@js.enum])) X448_key_pair_options.t
      -> Anonymous_interface4.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `x448 ][@js.enum])
      -> options:
           (([ `der ][@js.enum]), ([ `pem ][@js.enum])) X448_key_pair_options.t
      -> Anonymous_interface3.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `x448 ][@js.enum])
      -> options:
           (([ `der ][@js.enum]), ([ `der ][@js.enum])) X448_key_pair_options.t
      -> Anonymous_interface2.t Promise.t
      [@@js.global "__promisify__"]

    val __promisify__ :
         type_:([ `x448 ][@js.enum])
      -> ?options:X448_key_pair_key_object_options.t
      -> unit
      -> Key_pair_key_object_result.t Promise.t
      [@@js.global "__promisify__"]
  end
  [@@js.scope "generateKeyPair"]

  val sign :
       algorithm:string or_null_or_undefined
    -> data:Array_buffer_view.t
    -> key:
         ( ([ `U_s11_der of Sign_key_object_input.t
            | `U_s18_ieee_p1363 of Sign_key_object_input.t
            ]
           [@js.union on_field "dsaEncoding"])
         , ([ `U_s21_pkcs1 of Sign_private_key_input.t
            | `U_s22_pkcs8 of Sign_private_key_input.t
            | `U_s23_private of Key_like.t
            | `U_s24_public of Key_like.t
            | `U_s26_sec1 of Sign_private_key_input.t
            | `U_s27_secret of Key_like.t
            ]
           [@js.union on_field "type"]) )
         union2
    -> Buffer.t
    [@@js.global "sign"]

  val verify :
       algorithm:string or_null_or_undefined
    -> data:Array_buffer_view.t
    -> key:
         ( ([ `U_s11_der of Verify_key_object_input.t
            | `U_s18_ieee_p1363 of Verify_key_object_input.t
            ]
           [@js.union on_field "dsaEncoding"])
         , ([ `U_s21_pkcs1 of Verify_public_key_input.t
            | `U_s23_private of Key_like.t
            | `U_s24_public of Key_like.t
            | `U_s27_secret of Key_like.t
            | `U_s28_spki of Verify_public_key_input.t
            ]
           [@js.union on_field "type"]) )
         union2
    -> signature:Array_buffer_view.t
    -> bool
    [@@js.global "verify"]

  module Anonymous_interface1 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_private_key : t -> Key_object.t [@@js.get "privateKey"]

    val set_private_key : t -> Key_object.t -> unit [@@js.set "privateKey"]

    val get_public_key : t -> Key_object.t [@@js.get "publicKey"]

    val set_public_key : t -> Key_object.t -> unit [@@js.set "publicKey"]
  end

  val diffie_hellman : options:Anonymous_interface1.t -> Buffer.t
    [@@js.global "diffieHellman"]
end
[@@js.scope Import.crypto]
