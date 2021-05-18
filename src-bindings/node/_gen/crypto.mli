[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - Buffer
  - BufferEncoding
  - Error
  - NodeJS.ArrayBufferView
  - NodeJS.TypedArray
  - Promise<T1>
  - stream.Transform
  - stream.TransformOptions
  - stream.Writable
  - stream.WritableOptions
 *)
[@@@js.stop]
module type Missing = sig
  module Buffer : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module BufferEncoding : sig
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
    module ArrayBufferView : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module TypedArray : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
  end
  module Promise : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module stream : sig
    module Transform : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module TransformOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Writable : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module WritableOptions : sig
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
    module BufferEncoding : sig
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
      module ArrayBufferView : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module TypedArray : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
    end
    module Promise : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module stream : sig
      module Transform : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module TransformOptions : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module Writable : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module WritableOptions : sig
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
      type anonymous_interface_1 = [`anonymous_interface_1] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_2 = [`anonymous_interface_2] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_3 = [`anonymous_interface_3] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_4 = [`anonymous_interface_4] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_5 = [`anonymous_interface_5] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_6 = [`anonymous_interface_6] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_7 = [`anonymous_interface_7] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_8 = [`anonymous_interface_8] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_9 = [`anonymous_interface_9] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_10 = [`anonymous_interface_10] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_11 = [`anonymous_interface_11] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
    module Types : sig
      open AnonymousInterfaces
      type 'T crypto_BasePrivateKeyEncodingOptions = [`Crypto_BasePrivateKeyEncodingOptions of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and crypto_BinaryLike = NodeJS.ArrayBufferView.t_0 or_string
      and crypto_BinaryToTextEncoding = ([`L_s7_base64[@js "base64"] | `L_s16_hex[@js "hex"]] [@js.enum])
      and crypto_Certificate = [`Crypto_Certificate] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_CharacterEncoding = ([`L_s19_latin1[@js "latin1"] | `L_s32_utf_8[@js "utf-8"] | `L_s33_utf16le[@js "utf16le"] | `L_s34_utf8[@js "utf8"]] [@js.enum])
      and crypto_Cipher = [`Crypto_Cipher] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_CipherCCM = [`Crypto_CipherCCM | `Crypto_Cipher] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_CipherCCMOptions = [`Crypto_CipherCCMOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_CipherCCMTypes = ([`L_s0_aes_128_ccm[@js "aes-128-ccm"] | `L_s2_aes_192_ccm[@js "aes-192-ccm"] | `L_s4_aes_256_ccm[@js "aes-256-ccm"] | `L_s9_chacha20_poly1305[@js "chacha20-poly1305"]] [@js.enum])
      and crypto_CipherGCM = [`Crypto_CipherGCM | `Crypto_Cipher] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_CipherGCMOptions = [`Crypto_CipherGCMOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_CipherGCMTypes = ([`L_s1_aes_128_gcm[@js "aes-128-gcm"] | `L_s3_aes_192_gcm[@js "aes-192-gcm"] | `L_s5_aes_256_gcm[@js "aes-256-gcm"]] [@js.enum])
      and crypto_CipherKey = (crypto_BinaryLike, crypto_KeyObject) union2
      and crypto_DSAEncoding = ([`L_s11_der[@js "der"] | `L_s18_ieee_p1363[@js "ieee-p1363"]] [@js.enum])
      and crypto_DSAKeyPairKeyObjectOptions = [`Crypto_DSAKeyPairKeyObjectOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and ('PubF, 'PrivF) crypto_DSAKeyPairOptions = [`Crypto_DSAKeyPairOptions of ('PubF * 'PrivF)] intf
      [@@js.custom { of_js=(fun _PubF _PrivF -> Obj.magic); to_js=(fun _PubF _PrivF -> Obj.magic) }]
      and crypto_Decipher = [`Crypto_Decipher] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_DecipherCCM = [`Crypto_DecipherCCM | `Crypto_Decipher] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_DecipherGCM = [`Crypto_DecipherGCM | `Crypto_Decipher] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_DiffieHellman = [`Crypto_DiffieHellman] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_ECDH = [`Crypto_ECDH] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_ECDHKeyFormat = ([`L_s10_compressed[@js "compressed"] | `L_s17_hybrid[@js "hybrid"] | `L_s31_uncompressed[@js "uncompressed"]] [@js.enum])
      and crypto_ECKeyPairKeyObjectOptions = [`Crypto_ECKeyPairKeyObjectOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and ('PubF, 'PrivF) crypto_ECKeyPairOptions = [`Crypto_ECKeyPairOptions of ('PubF * 'PrivF)] intf
      [@@js.custom { of_js=(fun _PubF _PrivF -> Obj.magic); to_js=(fun _PubF _PrivF -> Obj.magic) }]
      and crypto_ED25519KeyPairKeyObjectOptions = [`Crypto_ED25519KeyPairKeyObjectOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and ('PubF, 'PrivF) crypto_ED25519KeyPairOptions = [`Crypto_ED25519KeyPairOptions of ('PubF * 'PrivF)] intf
      [@@js.custom { of_js=(fun _PubF _PrivF -> Obj.magic); to_js=(fun _PubF _PrivF -> Obj.magic) }]
      and crypto_ED448KeyPairKeyObjectOptions = [`Crypto_ED448KeyPairKeyObjectOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and ('PubF, 'PrivF) crypto_ED448KeyPairOptions = [`Crypto_ED448KeyPairOptions of ('PubF * 'PrivF)] intf
      [@@js.custom { of_js=(fun _PubF _PrivF -> Obj.magic); to_js=(fun _PubF _PrivF -> Obj.magic) }]
      and crypto_Encoding = ((crypto_BinaryToTextEncoding, crypto_CharacterEncoding, crypto_LegacyCharacterEncoding) union3, ([`L_s6_ascii[@js "ascii"] | `L_s7_base64[@js "base64"] | `L_s8_binary[@js "binary"] | `L_s16_hex[@js "hex"] | `L_s19_latin1[@js "latin1"] | `L_s29_ucs_2[@js "ucs-2"] | `L_s30_ucs2[@js "ucs2"] | `L_s32_utf_8[@js "utf-8"] | `L_s33_utf16le[@js "utf16le"] | `L_s34_utf8[@js "utf8"]] [@js.enum])) or_enum
      and crypto_Hash = [`Crypto_Hash] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_HashOptions = [`Crypto_HashOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_Hmac = [`Crypto_Hmac] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T crypto_KeyExportOptions = [`Crypto_KeyExportOptions of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and crypto_KeyFormat = ([`L_s11_der[@js "der"] | `L_s20_pem[@js "pem"]] [@js.enum])
      and crypto_KeyLike = (Buffer.t_0, crypto_KeyObject) union2 or_string
      and crypto_KeyObject = [`Crypto_KeyObject] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_KeyObjectType = ([`L_s23_private[@js "private"] | `L_s24_public[@js "public"] | `L_s27_secret[@js "secret"]] [@js.enum])
      and crypto_KeyPairKeyObjectResult = [`Crypto_KeyPairKeyObjectResult] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and ('T1, 'T2) crypto_KeyPairSyncResult = [`Crypto_KeyPairSyncResult of ('T1 * 'T2)] intf
      [@@js.custom { of_js=(fun _T1 _T2 -> Obj.magic); to_js=(fun _T1 _T2 -> Obj.magic) }]
      and crypto_KeyType = ([`L_s12_dsa[@js "dsa"] | `L_s13_ec[@js "ec"] | `L_s14_ed25519[@js "ed25519"] | `L_s15_ed448[@js "ed448"] | `L_s25_rsa[@js "rsa"] | `L_s35_x25519[@js "x25519"] | `L_s36_x448[@js "x448"]] [@js.enum])
      and crypto_LegacyCharacterEncoding = ([`L_s6_ascii[@js "ascii"] | `L_s8_binary[@js "binary"] | `L_s29_ucs_2[@js "ucs-2"] | `L_s30_ucs2[@js "ucs2"]] [@js.enum])
      and crypto_PrivateKeyInput = [`Crypto_PrivateKeyInput] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_PublicKeyInput = [`Crypto_PublicKeyInput] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_RSAKeyPairKeyObjectOptions = [`Crypto_RSAKeyPairKeyObjectOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and ('PubF, 'PrivF) crypto_RSAKeyPairOptions = [`Crypto_RSAKeyPairOptions of ('PubF * 'PrivF)] intf
      [@@js.custom { of_js=(fun _PubF _PrivF -> Obj.magic); to_js=(fun _PubF _PrivF -> Obj.magic) }]
      and crypto_RsaPrivateKey = [`Crypto_RsaPrivateKey] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_RsaPublicKey = [`Crypto_RsaPublicKey] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_ScryptOptions = [`Crypto_ScryptOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_SignKeyObjectInput = [`Crypto_SignKeyObjectInput | `Crypto_SigningOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_SignPrivateKeyInput = [`Crypto_SignPrivateKeyInput | `Crypto_PrivateKeyInput | `Crypto_SigningOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_Signer = [`Crypto_Signer] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_SigningOptions = [`Crypto_SigningOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_Verify = [`Crypto_Verify] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_VerifyKeyObjectInput = [`Crypto_VerifyKeyObjectInput | `Crypto_SigningOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_VerifyPublicKeyInput = [`Crypto_VerifyPublicKeyInput | `Crypto_PublicKeyInput | `Crypto_SigningOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and crypto_X25519KeyPairKeyObjectOptions = [`Crypto_X25519KeyPairKeyObjectOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and ('PubF, 'PrivF) crypto_X25519KeyPairOptions = [`Crypto_X25519KeyPairOptions of ('PubF * 'PrivF)] intf
      [@@js.custom { of_js=(fun _PubF _PrivF -> Obj.magic); to_js=(fun _PubF _PrivF -> Obj.magic) }]
      and crypto_X448KeyPairKeyObjectOptions = [`Crypto_X448KeyPairKeyObjectOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and ('PubF, 'PrivF) crypto_X448KeyPairOptions = [`Crypto_X448KeyPairOptions of ('PubF * 'PrivF)] intf
      [@@js.custom { of_js=(fun _PubF _PrivF -> Obj.magic); to_js=(fun _PubF _PrivF -> Obj.magic) }]
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
    val get_plaintextLength: t -> float [@@js.get "plaintextLength"]
    val set_plaintextLength: t -> float -> unit [@@js.set "plaintextLength"]
  end
  module AnonymousInterface1 : sig
    type t = anonymous_interface_1
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_privateKey: t -> crypto_KeyObject [@@js.get "privateKey"]
    val set_privateKey: t -> crypto_KeyObject -> unit [@@js.set "privateKey"]
    val get_publicKey: t -> crypto_KeyObject [@@js.get "publicKey"]
    val set_publicKey: t -> crypto_KeyObject -> unit [@@js.set "publicKey"]
  end
  module AnonymousInterface2 : sig
    type t = anonymous_interface_2
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_publicKey: t -> Buffer.t_0 [@@js.get "publicKey"]
    val set_publicKey: t -> Buffer.t_0 -> unit [@@js.set "publicKey"]
    val get_privateKey: t -> Buffer.t_0 [@@js.get "privateKey"]
    val set_privateKey: t -> Buffer.t_0 -> unit [@@js.set "privateKey"]
  end
  module AnonymousInterface3 : sig
    type t = anonymous_interface_3
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_publicKey: t -> Buffer.t_0 [@@js.get "publicKey"]
    val set_publicKey: t -> Buffer.t_0 -> unit [@@js.set "publicKey"]
    val get_privateKey: t -> string [@@js.get "privateKey"]
    val set_privateKey: t -> string -> unit [@@js.set "privateKey"]
  end
  module AnonymousInterface4 : sig
    type t = anonymous_interface_4
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_publicKey: t -> string [@@js.get "publicKey"]
    val set_publicKey: t -> string -> unit [@@js.set "publicKey"]
    val get_privateKey: t -> Buffer.t_0 [@@js.get "privateKey"]
    val set_privateKey: t -> Buffer.t_0 -> unit [@@js.set "privateKey"]
  end
  module AnonymousInterface5 : sig
    type t = anonymous_interface_5
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_publicKey: t -> string [@@js.get "publicKey"]
    val set_publicKey: t -> string -> unit [@@js.set "publicKey"]
    val get_privateKey: t -> string [@@js.get "privateKey"]
    val set_privateKey: t -> string -> unit [@@js.set "privateKey"]
  end
  module AnonymousInterface6 : sig
    type t = anonymous_interface_6
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_type: t -> ([`L_s22_pkcs8[@js "pkcs8"]] [@js.enum]) [@@js.get "type"]
    val set_type: t -> ([`L_s22_pkcs8] [@js.enum]) -> unit [@@js.set "type"]
  end
  module AnonymousInterface7 : sig
    type t = anonymous_interface_7
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_type: t -> ([`L_s28_spki[@js "spki"]] [@js.enum]) [@@js.get "type"]
    val set_type: t -> ([`L_s28_spki] [@js.enum]) -> unit [@@js.set "type"]
    val get_format: t -> 'PubF [@@js.get "format"]
    val set_format: t -> 'PubF -> unit [@@js.set "format"]
  end
  module AnonymousInterface8 : sig
    type t = anonymous_interface_8
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_type: t -> ([`L_s21_pkcs1[@js "pkcs1"] | `L_s22_pkcs8[@js "pkcs8"]] [@js.enum]) [@@js.get "type"]
    val set_type: t -> ([`L_s21_pkcs1 | `L_s22_pkcs8] [@js.enum]) -> unit [@@js.set "type"]
  end
  module AnonymousInterface9 : sig
    type t = anonymous_interface_9
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_type: t -> ([`L_s21_pkcs1[@js "pkcs1"] | `L_s28_spki[@js "spki"]] [@js.enum]) [@@js.get "type"]
    val set_type: t -> ([`L_s21_pkcs1 | `L_s28_spki] [@js.enum]) -> unit [@@js.set "type"]
    val get_format: t -> 'PubF [@@js.get "format"]
    val set_format: t -> 'PubF -> unit [@@js.set "format"]
  end
  module AnonymousInterface10 : sig
    type t = anonymous_interface_10
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_type: t -> ([`L_s22_pkcs8[@js "pkcs8"] | `L_s26_sec1[@js "sec1"]] [@js.enum]) [@@js.get "type"]
    val set_type: t -> ([`L_s22_pkcs8 | `L_s26_sec1] [@js.enum]) -> unit [@@js.set "type"]
  end
  module AnonymousInterface11 : sig
    type t = anonymous_interface_11
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> crypto_Certificate [@@js.apply_newable]
    val apply: t -> crypto_Certificate [@@js.apply]
  end
  module[@js.scope "node:crypto"] Node_crypto : sig
    (* export * from 'crypto'; *)
  end
  module[@js.scope "crypto"] Crypto : sig
    (* import * as stream from 'node:stream'; *)
    module[@js.scope "Certificate"] Certificate : sig
      type t = crypto_Certificate
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val exportChallenge: t -> spkac:crypto_BinaryLike -> Buffer.t_0 [@@js.call "exportChallenge"]
      val exportPublicKey: t -> spkac:crypto_BinaryLike -> ?encoding:string -> unit -> Buffer.t_0 [@@js.call "exportPublicKey"]
      val verifySpkac: t -> spkac:NodeJS.ArrayBufferView.t_0 -> bool [@@js.call "verifySpkac"]
    end
    val certificate: (crypto_Certificate, anonymous_interface_11) intersection2 [@@js.global "Certificate"]
    module[@js.scope "constants"] Constants : sig
      val oPENSSL_VERSION_NUMBER: float [@@js.global "OPENSSL_VERSION_NUMBER"]
      val sSL_OP_ALL: float [@@js.global "SSL_OP_ALL"]
      val sSL_OP_ALLOW_UNSAFE_LEGACY_RENEGOTIATION: float [@@js.global "SSL_OP_ALLOW_UNSAFE_LEGACY_RENEGOTIATION"]
      val sSL_OP_CIPHER_SERVER_PREFERENCE: float [@@js.global "SSL_OP_CIPHER_SERVER_PREFERENCE"]
      val sSL_OP_CISCO_ANYCONNECT: float [@@js.global "SSL_OP_CISCO_ANYCONNECT"]
      val sSL_OP_COOKIE_EXCHANGE: float [@@js.global "SSL_OP_COOKIE_EXCHANGE"]
      val sSL_OP_CRYPTOPRO_TLSEXT_BUG: float [@@js.global "SSL_OP_CRYPTOPRO_TLSEXT_BUG"]
      val sSL_OP_DONT_INSERT_EMPTY_FRAGMENTS: float [@@js.global "SSL_OP_DONT_INSERT_EMPTY_FRAGMENTS"]
      val sSL_OP_EPHEMERAL_RSA: float [@@js.global "SSL_OP_EPHEMERAL_RSA"]
      val sSL_OP_LEGACY_SERVER_CONNECT: float [@@js.global "SSL_OP_LEGACY_SERVER_CONNECT"]
      val sSL_OP_MICROSOFT_BIG_SSLV3_BUFFER: float [@@js.global "SSL_OP_MICROSOFT_BIG_SSLV3_BUFFER"]
      val sSL_OP_MICROSOFT_SESS_ID_BUG: float [@@js.global "SSL_OP_MICROSOFT_SESS_ID_BUG"]
      val sSL_OP_MSIE_SSLV2_RSA_PADDING: float [@@js.global "SSL_OP_MSIE_SSLV2_RSA_PADDING"]
      val sSL_OP_NETSCAPE_CA_DN_BUG: float [@@js.global "SSL_OP_NETSCAPE_CA_DN_BUG"]
      val sSL_OP_NETSCAPE_CHALLENGE_BUG: float [@@js.global "SSL_OP_NETSCAPE_CHALLENGE_BUG"]
      val sSL_OP_NETSCAPE_DEMO_CIPHER_CHANGE_BUG: float [@@js.global "SSL_OP_NETSCAPE_DEMO_CIPHER_CHANGE_BUG"]
      val sSL_OP_NETSCAPE_REUSE_CIPHER_CHANGE_BUG: float [@@js.global "SSL_OP_NETSCAPE_REUSE_CIPHER_CHANGE_BUG"]
      val sSL_OP_NO_COMPRESSION: float [@@js.global "SSL_OP_NO_COMPRESSION"]
      val sSL_OP_NO_QUERY_MTU: float [@@js.global "SSL_OP_NO_QUERY_MTU"]
      val sSL_OP_NO_SESSION_RESUMPTION_ON_RENEGOTIATION: float [@@js.global "SSL_OP_NO_SESSION_RESUMPTION_ON_RENEGOTIATION"]
      val sSL_OP_NO_SSLv2: float [@@js.global "SSL_OP_NO_SSLv2"]
      val sSL_OP_NO_SSLv3: float [@@js.global "SSL_OP_NO_SSLv3"]
      val sSL_OP_NO_TICKET: float [@@js.global "SSL_OP_NO_TICKET"]
      val sSL_OP_NO_TLSv1: float [@@js.global "SSL_OP_NO_TLSv1"]
      val sSL_OP_NO_TLSv1_1: float [@@js.global "SSL_OP_NO_TLSv1_1"]
      val sSL_OP_NO_TLSv1_2: float [@@js.global "SSL_OP_NO_TLSv1_2"]
      val sSL_OP_PKCS1_CHECK_1: float [@@js.global "SSL_OP_PKCS1_CHECK_1"]
      val sSL_OP_PKCS1_CHECK_2: float [@@js.global "SSL_OP_PKCS1_CHECK_2"]
      val sSL_OP_SINGLE_DH_USE: float [@@js.global "SSL_OP_SINGLE_DH_USE"]
      val sSL_OP_SINGLE_ECDH_USE: float [@@js.global "SSL_OP_SINGLE_ECDH_USE"]
      val sSL_OP_SSLEAY_080_CLIENT_DH_BUG: float [@@js.global "SSL_OP_SSLEAY_080_CLIENT_DH_BUG"]
      val sSL_OP_SSLREF2_REUSE_CERT_TYPE_BUG: float [@@js.global "SSL_OP_SSLREF2_REUSE_CERT_TYPE_BUG"]
      val sSL_OP_TLS_BLOCK_PADDING_BUG: float [@@js.global "SSL_OP_TLS_BLOCK_PADDING_BUG"]
      val sSL_OP_TLS_D5_BUG: float [@@js.global "SSL_OP_TLS_D5_BUG"]
      val sSL_OP_TLS_ROLLBACK_BUG: float [@@js.global "SSL_OP_TLS_ROLLBACK_BUG"]
      val eNGINE_METHOD_RSA: float [@@js.global "ENGINE_METHOD_RSA"]
      val eNGINE_METHOD_DSA: float [@@js.global "ENGINE_METHOD_DSA"]
      val eNGINE_METHOD_DH: float [@@js.global "ENGINE_METHOD_DH"]
      val eNGINE_METHOD_RAND: float [@@js.global "ENGINE_METHOD_RAND"]
      val eNGINE_METHOD_EC: float [@@js.global "ENGINE_METHOD_EC"]
      val eNGINE_METHOD_CIPHERS: float [@@js.global "ENGINE_METHOD_CIPHERS"]
      val eNGINE_METHOD_DIGESTS: float [@@js.global "ENGINE_METHOD_DIGESTS"]
      val eNGINE_METHOD_PKEY_METHS: float [@@js.global "ENGINE_METHOD_PKEY_METHS"]
      val eNGINE_METHOD_PKEY_ASN1_METHS: float [@@js.global "ENGINE_METHOD_PKEY_ASN1_METHS"]
      val eNGINE_METHOD_ALL: float [@@js.global "ENGINE_METHOD_ALL"]
      val eNGINE_METHOD_NONE: float [@@js.global "ENGINE_METHOD_NONE"]
      val dH_CHECK_P_NOT_SAFE_PRIME: float [@@js.global "DH_CHECK_P_NOT_SAFE_PRIME"]
      val dH_CHECK_P_NOT_PRIME: float [@@js.global "DH_CHECK_P_NOT_PRIME"]
      val dH_UNABLE_TO_CHECK_GENERATOR: float [@@js.global "DH_UNABLE_TO_CHECK_GENERATOR"]
      val dH_NOT_SUITABLE_GENERATOR: float [@@js.global "DH_NOT_SUITABLE_GENERATOR"]
      val aLPN_ENABLED: float [@@js.global "ALPN_ENABLED"]
      val rSA_PKCS1_PADDING: float [@@js.global "RSA_PKCS1_PADDING"]
      val rSA_SSLV23_PADDING: float [@@js.global "RSA_SSLV23_PADDING"]
      val rSA_NO_PADDING: float [@@js.global "RSA_NO_PADDING"]
      val rSA_PKCS1_OAEP_PADDING: float [@@js.global "RSA_PKCS1_OAEP_PADDING"]
      val rSA_X931_PADDING: float [@@js.global "RSA_X931_PADDING"]
      val rSA_PKCS1_PSS_PADDING: float [@@js.global "RSA_PKCS1_PSS_PADDING"]
      val rSA_PSS_SALTLEN_DIGEST: float [@@js.global "RSA_PSS_SALTLEN_DIGEST"]
      val rSA_PSS_SALTLEN_MAX_SIGN: float [@@js.global "RSA_PSS_SALTLEN_MAX_SIGN"]
      val rSA_PSS_SALTLEN_AUTO: float [@@js.global "RSA_PSS_SALTLEN_AUTO"]
      val pOINT_CONVERSION_COMPRESSED: float [@@js.global "POINT_CONVERSION_COMPRESSED"]
      val pOINT_CONVERSION_UNCOMPRESSED: float [@@js.global "POINT_CONVERSION_UNCOMPRESSED"]
      val pOINT_CONVERSION_HYBRID: float [@@js.global "POINT_CONVERSION_HYBRID"]
      val defaultCoreCipherList: string [@@js.global "defaultCoreCipherList"]
      val defaultCipherList: string [@@js.global "defaultCipherList"]
    end
    module[@js.scope "HashOptions"] HashOptions : sig
      type t = crypto_HashOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_outputLength: t -> float [@@js.get "outputLength"]
      val set_outputLength: t -> float -> unit [@@js.set "outputLength"]
      val cast: t -> Stream.TransformOptions.t_0 [@@js.cast]
    end
    val fips: bool [@@js.global "fips"]
    val createHash: algorithm:string -> ?options:crypto_HashOptions -> unit -> crypto_Hash [@@js.global "createHash"]
    val createHmac: algorithm:string -> key:(crypto_BinaryLike, crypto_KeyObject) union2 -> ?options:Stream.TransformOptions.t_0 -> unit -> crypto_Hmac [@@js.global "createHmac"]
    module BinaryToTextEncoding : sig
      type t = crypto_BinaryToTextEncoding
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module CharacterEncoding : sig
      type t = crypto_CharacterEncoding
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module LegacyCharacterEncoding : sig
      type t = crypto_LegacyCharacterEncoding
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Encoding : sig
      type t = crypto_Encoding
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ECDHKeyFormat : sig
      type t = crypto_ECDHKeyFormat
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "Hash"] Hash : sig
      type t = crypto_Hash
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: unit -> t [@@js.create]
      val copy: t -> t [@@js.call "copy"]
      val update: t -> data:crypto_BinaryLike -> t [@@js.call "update"]
      val update': t -> data:string -> input_encoding:crypto_Encoding -> t [@@js.call "update"]
      val digest: t -> Buffer.t_0 [@@js.call "digest"]
      val digest': t -> encoding:crypto_BinaryToTextEncoding -> string [@@js.call "digest"]
      val cast: t -> Stream.Transform.t_0 [@@js.cast]
    end
    module[@js.scope "Hmac"] Hmac : sig
      type t = crypto_Hmac
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: unit -> t [@@js.create]
      val update: t -> data:crypto_BinaryLike -> t [@@js.call "update"]
      val update': t -> data:string -> input_encoding:crypto_Encoding -> t [@@js.call "update"]
      val digest: t -> Buffer.t_0 [@@js.call "digest"]
      val digest': t -> encoding:crypto_BinaryToTextEncoding -> string [@@js.call "digest"]
      val cast: t -> Stream.Transform.t_0 [@@js.cast]
    end
    module KeyObjectType : sig
      type t = crypto_KeyObjectType
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "KeyExportOptions"] KeyExportOptions : sig
      type 'T t = 'T crypto_KeyExportOptions
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val get_type: 'T t -> ([`L_s21_pkcs1[@js "pkcs1"] | `L_s22_pkcs8[@js "pkcs8"] | `L_s26_sec1[@js "sec1"] | `L_s28_spki[@js "spki"]] [@js.enum]) [@@js.get "type"]
      val set_type: 'T t -> ([`L_s21_pkcs1 | `L_s22_pkcs8 | `L_s26_sec1 | `L_s28_spki] [@js.enum]) -> unit [@@js.set "type"]
      val get_format: 'T t -> 'T [@@js.get "format"]
      val set_format: 'T t -> 'T -> unit [@@js.set "format"]
      val get_cipher: 'T t -> string [@@js.get "cipher"]
      val set_cipher: 'T t -> string -> unit [@@js.set "cipher"]
      val get_passphrase: 'T t -> Buffer.t_0 or_string [@@js.get "passphrase"]
      val set_passphrase: 'T t -> Buffer.t_0 or_string -> unit [@@js.set "passphrase"]
    end
    module[@js.scope "KeyObject"] KeyObject : sig
      type t = crypto_KeyObject
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: unit -> t [@@js.create]
      val get_asymmetricKeyType: t -> crypto_KeyType [@@js.get "asymmetricKeyType"]
      val set_asymmetricKeyType: t -> crypto_KeyType -> unit [@@js.set "asymmetricKeyType"]
      val get_asymmetricKeySize: t -> float [@@js.get "asymmetricKeySize"]
      val set_asymmetricKeySize: t -> float -> unit [@@js.set "asymmetricKeySize"]
      val export: t -> options:([`L_s20_pem] [@js.enum]) crypto_KeyExportOptions -> Buffer.t_0 or_string [@@js.call "export"]
      val export': t -> ?options:([`L_s11_der] [@js.enum]) crypto_KeyExportOptions -> unit -> Buffer.t_0 [@@js.call "export"]
      val get_symmetricKeySize: t -> float [@@js.get "symmetricKeySize"]
      val set_symmetricKeySize: t -> float -> unit [@@js.set "symmetricKeySize"]
      val get_type: t -> crypto_KeyObjectType [@@js.get "type"]
      val set_type: t -> crypto_KeyObjectType -> unit [@@js.set "type"]
    end
    module CipherCCMTypes : sig
      type t = crypto_CipherCCMTypes
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module CipherGCMTypes : sig
      type t = crypto_CipherGCMTypes
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module BinaryLike : sig
      type t = crypto_BinaryLike
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module CipherKey : sig
      type t = crypto_CipherKey
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "CipherCCMOptions"] CipherCCMOptions : sig
      type t = crypto_CipherCCMOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_authTagLength: t -> float [@@js.get "authTagLength"]
      val set_authTagLength: t -> float -> unit [@@js.set "authTagLength"]
      val cast: t -> Stream.TransformOptions.t_0 [@@js.cast]
    end
    module[@js.scope "CipherGCMOptions"] CipherGCMOptions : sig
      type t = crypto_CipherGCMOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_authTagLength: t -> float [@@js.get "authTagLength"]
      val set_authTagLength: t -> float -> unit [@@js.set "authTagLength"]
      val cast: t -> Stream.TransformOptions.t_0 [@@js.cast]
    end
    val createCipher: algorithm:crypto_CipherCCMTypes -> password:crypto_BinaryLike -> options:crypto_CipherCCMOptions -> crypto_CipherCCM [@@js.global "createCipher"]
    val createCipher: algorithm:crypto_CipherGCMTypes -> password:crypto_BinaryLike -> ?options:crypto_CipherGCMOptions -> unit -> crypto_CipherGCM [@@js.global "createCipher"]
    val createCipher: algorithm:string -> password:crypto_BinaryLike -> ?options:Stream.TransformOptions.t_0 -> unit -> crypto_Cipher [@@js.global "createCipher"]
    val createCipheriv: algorithm:crypto_CipherCCMTypes -> key:crypto_CipherKey -> iv:crypto_BinaryLike or_null -> options:crypto_CipherCCMOptions -> crypto_CipherCCM [@@js.global "createCipheriv"]
    val createCipheriv: algorithm:crypto_CipherGCMTypes -> key:crypto_CipherKey -> iv:crypto_BinaryLike or_null -> ?options:crypto_CipherGCMOptions -> unit -> crypto_CipherGCM [@@js.global "createCipheriv"]
    val createCipheriv: algorithm:string -> key:crypto_CipherKey -> iv:crypto_BinaryLike or_null -> ?options:Stream.TransformOptions.t_0 -> unit -> crypto_Cipher [@@js.global "createCipheriv"]
    module[@js.scope "Cipher"] Cipher : sig
      type t = crypto_Cipher
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: unit -> t [@@js.create]
      val update: t -> data:crypto_BinaryLike -> Buffer.t_0 [@@js.call "update"]
      val update': t -> data:string -> input_encoding:crypto_Encoding -> Buffer.t_0 [@@js.call "update"]
      val update'': t -> data:NodeJS.ArrayBufferView.t_0 -> input_encoding:never or_undefined -> output_encoding:crypto_Encoding -> string [@@js.call "update"]
      val update''': t -> data:string -> input_encoding:crypto_Encoding or_undefined -> output_encoding:crypto_Encoding -> string [@@js.call "update"]
      val final: t -> Buffer.t_0 [@@js.call "final"]
      val final': t -> output_encoding:BufferEncoding.t_0 -> string [@@js.call "final"]
      val setAutoPadding: t -> ?auto_padding:bool -> unit -> t [@@js.call "setAutoPadding"]
      val cast: t -> Stream.Transform.t_0 [@@js.cast]
    end
    module[@js.scope "CipherCCM"] CipherCCM : sig
      type t = crypto_CipherCCM
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val setAAD: t -> buffer:NodeJS.ArrayBufferView.t_0 -> options:anonymous_interface_0 -> t [@@js.call "setAAD"]
      val getAuthTag: t -> Buffer.t_0 [@@js.call "getAuthTag"]
      val cast: t -> crypto_Cipher [@@js.cast]
    end
    module[@js.scope "CipherGCM"] CipherGCM : sig
      type t = crypto_CipherGCM
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val setAAD: t -> buffer:NodeJS.ArrayBufferView.t_0 -> ?options:anonymous_interface_0 -> unit -> t [@@js.call "setAAD"]
      val getAuthTag: t -> Buffer.t_0 [@@js.call "getAuthTag"]
      val cast: t -> crypto_Cipher [@@js.cast]
    end
    val createDecipher: algorithm:crypto_CipherCCMTypes -> password:crypto_BinaryLike -> options:crypto_CipherCCMOptions -> crypto_DecipherCCM [@@js.global "createDecipher"]
    val createDecipher: algorithm:crypto_CipherGCMTypes -> password:crypto_BinaryLike -> ?options:crypto_CipherGCMOptions -> unit -> crypto_DecipherGCM [@@js.global "createDecipher"]
    val createDecipher: algorithm:string -> password:crypto_BinaryLike -> ?options:Stream.TransformOptions.t_0 -> unit -> crypto_Decipher [@@js.global "createDecipher"]
    val createDecipheriv: algorithm:crypto_CipherCCMTypes -> key:crypto_CipherKey -> iv:crypto_BinaryLike or_null -> options:crypto_CipherCCMOptions -> crypto_DecipherCCM [@@js.global "createDecipheriv"]
    val createDecipheriv: algorithm:crypto_CipherGCMTypes -> key:crypto_CipherKey -> iv:crypto_BinaryLike or_null -> ?options:crypto_CipherGCMOptions -> unit -> crypto_DecipherGCM [@@js.global "createDecipheriv"]
    val createDecipheriv: algorithm:string -> key:crypto_CipherKey -> iv:crypto_BinaryLike or_null -> ?options:Stream.TransformOptions.t_0 -> unit -> crypto_Decipher [@@js.global "createDecipheriv"]
    module[@js.scope "Decipher"] Decipher : sig
      type t = crypto_Decipher
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: unit -> t [@@js.create]
      val update: t -> data:NodeJS.ArrayBufferView.t_0 -> Buffer.t_0 [@@js.call "update"]
      val update': t -> data:string -> input_encoding:crypto_Encoding -> Buffer.t_0 [@@js.call "update"]
      val update'': t -> data:NodeJS.ArrayBufferView.t_0 -> input_encoding:never or_undefined -> output_encoding:crypto_Encoding -> string [@@js.call "update"]
      val update''': t -> data:string -> input_encoding:crypto_Encoding or_undefined -> output_encoding:crypto_Encoding -> string [@@js.call "update"]
      val final: t -> Buffer.t_0 [@@js.call "final"]
      val final': t -> output_encoding:BufferEncoding.t_0 -> string [@@js.call "final"]
      val setAutoPadding: t -> ?auto_padding:bool -> unit -> t [@@js.call "setAutoPadding"]
      val cast: t -> Stream.Transform.t_0 [@@js.cast]
    end
    module[@js.scope "DecipherCCM"] DecipherCCM : sig
      type t = crypto_DecipherCCM
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val setAuthTag: t -> buffer:NodeJS.ArrayBufferView.t_0 -> t [@@js.call "setAuthTag"]
      val setAAD: t -> buffer:NodeJS.ArrayBufferView.t_0 -> options:anonymous_interface_0 -> t [@@js.call "setAAD"]
      val cast: t -> crypto_Decipher [@@js.cast]
    end
    module[@js.scope "DecipherGCM"] DecipherGCM : sig
      type t = crypto_DecipherGCM
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val setAuthTag: t -> buffer:NodeJS.ArrayBufferView.t_0 -> t [@@js.call "setAuthTag"]
      val setAAD: t -> buffer:NodeJS.ArrayBufferView.t_0 -> ?options:anonymous_interface_0 -> unit -> t [@@js.call "setAAD"]
      val cast: t -> crypto_Decipher [@@js.cast]
    end
    module[@js.scope "PrivateKeyInput"] PrivateKeyInput : sig
      type t = crypto_PrivateKeyInput
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_key: t -> Buffer.t_0 or_string [@@js.get "key"]
      val set_key: t -> Buffer.t_0 or_string -> unit [@@js.set "key"]
      val get_format: t -> crypto_KeyFormat [@@js.get "format"]
      val set_format: t -> crypto_KeyFormat -> unit [@@js.set "format"]
      val get_type: t -> ([`L_s21_pkcs1[@js "pkcs1"] | `L_s22_pkcs8[@js "pkcs8"] | `L_s26_sec1[@js "sec1"]] [@js.enum]) [@@js.get "type"]
      val set_type: t -> ([`L_s21_pkcs1 | `L_s22_pkcs8 | `L_s26_sec1] [@js.enum]) -> unit [@@js.set "type"]
      val get_passphrase: t -> Buffer.t_0 or_string [@@js.get "passphrase"]
      val set_passphrase: t -> Buffer.t_0 or_string -> unit [@@js.set "passphrase"]
    end
    module[@js.scope "PublicKeyInput"] PublicKeyInput : sig
      type t = crypto_PublicKeyInput
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_key: t -> Buffer.t_0 or_string [@@js.get "key"]
      val set_key: t -> Buffer.t_0 or_string -> unit [@@js.set "key"]
      val get_format: t -> crypto_KeyFormat [@@js.get "format"]
      val set_format: t -> crypto_KeyFormat -> unit [@@js.set "format"]
      val get_type: t -> ([`L_s21_pkcs1[@js "pkcs1"] | `L_s28_spki[@js "spki"]] [@js.enum]) [@@js.get "type"]
      val set_type: t -> ([`L_s21_pkcs1 | `L_s28_spki] [@js.enum]) -> unit [@@js.set "type"]
    end
    val createPrivateKey: key:(Buffer.t_0, crypto_PrivateKeyInput) union2 or_string -> crypto_KeyObject [@@js.global "createPrivateKey"]
    val createPublicKey: key:(([`U_s21_pkcs1 of crypto_PublicKeyInput  | `U_s23_private of crypto_KeyObject  | `U_s24_public of crypto_KeyObject  | `U_s27_secret of crypto_KeyObject  | `U_s28_spki of crypto_PublicKeyInput ] [@js.union on_field "type"]), Buffer.t_0) or_ or_string -> crypto_KeyObject [@@js.global "createPublicKey"]
    val createSecretKey: key:NodeJS.ArrayBufferView.t_0 -> crypto_KeyObject [@@js.global "createSecretKey"]
    val createSign: algorithm:string -> ?options:Stream.WritableOptions.t_0 -> unit -> crypto_Signer [@@js.global "createSign"]
    module DSAEncoding : sig
      type t = crypto_DSAEncoding
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "SigningOptions"] SigningOptions : sig
      type t = crypto_SigningOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_padding: t -> float [@@js.get "padding"]
      val set_padding: t -> float -> unit [@@js.set "padding"]
      val get_saltLength: t -> float [@@js.get "saltLength"]
      val set_saltLength: t -> float -> unit [@@js.set "saltLength"]
      val get_dsaEncoding: t -> crypto_DSAEncoding [@@js.get "dsaEncoding"]
      val set_dsaEncoding: t -> crypto_DSAEncoding -> unit [@@js.set "dsaEncoding"]
    end
    module[@js.scope "SignPrivateKeyInput"] SignPrivateKeyInput : sig
      type t = crypto_SignPrivateKeyInput
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val cast: t -> crypto_PrivateKeyInput [@@js.cast]
      val cast': t -> crypto_SigningOptions [@@js.cast]
    end
    module[@js.scope "SignKeyObjectInput"] SignKeyObjectInput : sig
      type t = crypto_SignKeyObjectInput
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_key: t -> crypto_KeyObject [@@js.get "key"]
      val set_key: t -> crypto_KeyObject -> unit [@@js.set "key"]
      val cast: t -> crypto_SigningOptions [@@js.cast]
    end
    module[@js.scope "VerifyPublicKeyInput"] VerifyPublicKeyInput : sig
      type t = crypto_VerifyPublicKeyInput
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val cast: t -> crypto_PublicKeyInput [@@js.cast]
      val cast': t -> crypto_SigningOptions [@@js.cast]
    end
    module[@js.scope "VerifyKeyObjectInput"] VerifyKeyObjectInput : sig
      type t = crypto_VerifyKeyObjectInput
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_key: t -> crypto_KeyObject [@@js.get "key"]
      val set_key: t -> crypto_KeyObject -> unit [@@js.set "key"]
      val cast: t -> crypto_SigningOptions [@@js.cast]
    end
    module KeyLike : sig
      type t = crypto_KeyLike
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "Signer"] Signer : sig
      type t = crypto_Signer
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: unit -> t [@@js.create]
      val update: t -> data:crypto_BinaryLike -> t [@@js.call "update"]
      val update': t -> data:string -> input_encoding:crypto_Encoding -> t [@@js.call "update"]
      val sign: t -> private_key:(([`U_s11_der of crypto_SignKeyObjectInput  | `U_s18_ieee_p1363 of crypto_SignKeyObjectInput ] [@js.union on_field "dsaEncoding"]), ([`U_s21_pkcs1 of crypto_SignPrivateKeyInput  | `U_s22_pkcs8 of crypto_SignPrivateKeyInput  | `U_s23_private of crypto_KeyLike  | `U_s24_public of crypto_KeyLike  | `U_s26_sec1 of crypto_SignPrivateKeyInput  | `U_s27_secret of crypto_KeyLike ] [@js.union on_field "type"])) union2 -> Buffer.t_0 [@@js.call "sign"]
      val sign': t -> private_key:(([`U_s11_der of crypto_SignKeyObjectInput  | `U_s18_ieee_p1363 of crypto_SignKeyObjectInput ] [@js.union on_field "dsaEncoding"]), ([`U_s21_pkcs1 of crypto_SignPrivateKeyInput  | `U_s22_pkcs8 of crypto_SignPrivateKeyInput  | `U_s23_private of crypto_KeyLike  | `U_s24_public of crypto_KeyLike  | `U_s26_sec1 of crypto_SignPrivateKeyInput  | `U_s27_secret of crypto_KeyLike ] [@js.union on_field "type"])) union2 -> output_format:crypto_BinaryToTextEncoding -> string [@@js.call "sign"]
      val cast: t -> Stream.Writable.t_0 [@@js.cast]
    end
    val createVerify: algorithm:string -> ?options:Stream.WritableOptions.t_0 -> unit -> crypto_Verify [@@js.global "createVerify"]
    module[@js.scope "Verify"] Verify : sig
      type t = crypto_Verify
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: unit -> t [@@js.create]
      val update: t -> data:crypto_BinaryLike -> t [@@js.call "update"]
      val update': t -> data:string -> input_encoding:crypto_Encoding -> t [@@js.call "update"]
      val verify: t -> object_:(([`U_s11_der of crypto_VerifyKeyObjectInput  | `U_s18_ieee_p1363 of crypto_VerifyKeyObjectInput ] [@js.union on_field "dsaEncoding"]), ([`U_s21_pkcs1 of crypto_VerifyPublicKeyInput  | `U_s23_private of crypto_KeyLike  | `U_s24_public of crypto_KeyLike  | `U_s27_secret of crypto_KeyLike  | `U_s28_spki of crypto_VerifyPublicKeyInput ] [@js.union on_field "type"])) union2 -> signature:NodeJS.ArrayBufferView.t_0 -> bool [@@js.call "verify"]
      val verify': t -> object_:(([`U_s11_der of crypto_VerifyKeyObjectInput  | `U_s18_ieee_p1363 of crypto_VerifyKeyObjectInput ] [@js.union on_field "dsaEncoding"]), ([`U_s21_pkcs1 of crypto_VerifyPublicKeyInput  | `U_s23_private of crypto_KeyLike  | `U_s24_public of crypto_KeyLike  | `U_s27_secret of crypto_KeyLike  | `U_s28_spki of crypto_VerifyPublicKeyInput ] [@js.union on_field "type"])) union2 -> signature:string -> ?signature_format:crypto_BinaryToTextEncoding -> unit -> bool [@@js.call "verify"]
      val cast: t -> Stream.Writable.t_0 [@@js.cast]
    end
    val createDiffieHellman: prime_length:float -> ?generator:NodeJS.ArrayBufferView.t_0 or_number -> unit -> crypto_DiffieHellman [@@js.global "createDiffieHellman"]
    val createDiffieHellman: prime:NodeJS.ArrayBufferView.t_0 -> crypto_DiffieHellman [@@js.global "createDiffieHellman"]
    val createDiffieHellman: prime:string -> prime_encoding:crypto_BinaryToTextEncoding -> crypto_DiffieHellman [@@js.global "createDiffieHellman"]
    val createDiffieHellman: prime:string -> prime_encoding:crypto_BinaryToTextEncoding -> generator:NodeJS.ArrayBufferView.t_0 or_number -> crypto_DiffieHellman [@@js.global "createDiffieHellman"]
    val createDiffieHellman: prime:string -> prime_encoding:crypto_BinaryToTextEncoding -> generator:string -> generator_encoding:crypto_BinaryToTextEncoding -> crypto_DiffieHellman [@@js.global "createDiffieHellman"]
    module[@js.scope "DiffieHellman"] DiffieHellman : sig
      type t = crypto_DiffieHellman
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: unit -> t [@@js.create]
      val generateKeys: t -> Buffer.t_0 [@@js.call "generateKeys"]
      val generateKeys': t -> encoding:crypto_BinaryToTextEncoding -> string [@@js.call "generateKeys"]
      val computeSecret: t -> other_public_key:NodeJS.ArrayBufferView.t_0 -> Buffer.t_0 [@@js.call "computeSecret"]
      val computeSecret': t -> other_public_key:string -> input_encoding:crypto_BinaryToTextEncoding -> Buffer.t_0 [@@js.call "computeSecret"]
      val computeSecret'': t -> other_public_key:NodeJS.ArrayBufferView.t_0 -> output_encoding:crypto_BinaryToTextEncoding -> string [@@js.call "computeSecret"]
      val computeSecret''': t -> other_public_key:string -> input_encoding:crypto_BinaryToTextEncoding -> output_encoding:crypto_BinaryToTextEncoding -> string [@@js.call "computeSecret"]
      val getPrime: t -> Buffer.t_0 [@@js.call "getPrime"]
      val getPrime': t -> encoding:crypto_BinaryToTextEncoding -> string [@@js.call "getPrime"]
      val getGenerator: t -> Buffer.t_0 [@@js.call "getGenerator"]
      val getGenerator': t -> encoding:crypto_BinaryToTextEncoding -> string [@@js.call "getGenerator"]
      val getPublicKey: t -> Buffer.t_0 [@@js.call "getPublicKey"]
      val getPublicKey': t -> encoding:crypto_BinaryToTextEncoding -> string [@@js.call "getPublicKey"]
      val getPrivateKey: t -> Buffer.t_0 [@@js.call "getPrivateKey"]
      val getPrivateKey': t -> encoding:crypto_BinaryToTextEncoding -> string [@@js.call "getPrivateKey"]
      val setPublicKey: t -> public_key:NodeJS.ArrayBufferView.t_0 -> unit [@@js.call "setPublicKey"]
      val setPublicKey': t -> public_key:string -> encoding:BufferEncoding.t_0 -> unit [@@js.call "setPublicKey"]
      val setPrivateKey: t -> private_key:NodeJS.ArrayBufferView.t_0 -> unit [@@js.call "setPrivateKey"]
      val setPrivateKey': t -> private_key:string -> encoding:BufferEncoding.t_0 -> unit [@@js.call "setPrivateKey"]
      val get_verifyError: t -> float [@@js.get "verifyError"]
      val set_verifyError: t -> float -> unit [@@js.set "verifyError"]
    end
    val getDiffieHellman: group_name:string -> crypto_DiffieHellman [@@js.global "getDiffieHellman"]
    val pbkdf2: password:crypto_BinaryLike -> salt:crypto_BinaryLike -> iterations:float -> keylen:float -> digest:string -> callback:(err:Error.t_0 or_null -> derivedKey:Buffer.t_0 -> any) -> unit [@@js.global "pbkdf2"]
    val pbkdf2Sync: password:crypto_BinaryLike -> salt:crypto_BinaryLike -> iterations:float -> keylen:float -> digest:string -> Buffer.t_0 [@@js.global "pbkdf2Sync"]
    val randomBytes: size:float -> Buffer.t_0 [@@js.global "randomBytes"]
    val randomBytes: size:float -> callback:(err:Error.t_0 or_null -> buf:Buffer.t_0 -> unit) -> unit [@@js.global "randomBytes"]
    val pseudoRandomBytes: size:float -> Buffer.t_0 [@@js.global "pseudoRandomBytes"]
    val pseudoRandomBytes: size:float -> callback:(err:Error.t_0 or_null -> buf:Buffer.t_0 -> unit) -> unit [@@js.global "pseudoRandomBytes"]
    val randomInt: max:float -> float [@@js.global "randomInt"]
    val randomInt: min:float -> max:float -> float [@@js.global "randomInt"]
    val randomInt: max:float -> callback:(err:Error.t_0 or_null -> value:float -> unit) -> unit [@@js.global "randomInt"]
    val randomInt: min:float -> max:float -> callback:(err:Error.t_0 or_null -> value:float -> unit) -> unit [@@js.global "randomInt"]
    val randomFillSync: buffer:'T -> ?offset:float -> ?size:float -> unit -> 'T [@@js.global "randomFillSync"]
    val randomFill: buffer:'T -> callback:(err:Error.t_0 or_null -> buf:'T -> unit) -> unit [@@js.global "randomFill"]
    val randomFill: buffer:'T -> offset:float -> callback:(err:Error.t_0 or_null -> buf:'T -> unit) -> unit [@@js.global "randomFill"]
    val randomFill: buffer:'T -> offset:float -> size:float -> callback:(err:Error.t_0 or_null -> buf:'T -> unit) -> unit [@@js.global "randomFill"]
    module[@js.scope "ScryptOptions"] ScryptOptions : sig
      type t = crypto_ScryptOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_cost: t -> float [@@js.get "cost"]
      val set_cost: t -> float -> unit [@@js.set "cost"]
      val get_blockSize: t -> float [@@js.get "blockSize"]
      val set_blockSize: t -> float -> unit [@@js.set "blockSize"]
      val get_parallelization: t -> float [@@js.get "parallelization"]
      val set_parallelization: t -> float -> unit [@@js.set "parallelization"]
      val get_N: t -> float [@@js.get "N"]
      val set_N: t -> float -> unit [@@js.set "N"]
      val get_r: t -> float [@@js.get "r"]
      val set_r: t -> float -> unit [@@js.set "r"]
      val get_p: t -> float [@@js.get "p"]
      val set_p: t -> float -> unit [@@js.set "p"]
      val get_maxmem: t -> float [@@js.get "maxmem"]
      val set_maxmem: t -> float -> unit [@@js.set "maxmem"]
    end
    val scrypt: password:crypto_BinaryLike -> salt:crypto_BinaryLike -> keylen:float -> callback:(err:Error.t_0 or_null -> derivedKey:Buffer.t_0 -> unit) -> unit [@@js.global "scrypt"]
    val scrypt: password:crypto_BinaryLike -> salt:crypto_BinaryLike -> keylen:float -> options:crypto_ScryptOptions -> callback:(err:Error.t_0 or_null -> derivedKey:Buffer.t_0 -> unit) -> unit [@@js.global "scrypt"]
    val scryptSync: password:crypto_BinaryLike -> salt:crypto_BinaryLike -> keylen:float -> ?options:crypto_ScryptOptions -> unit -> Buffer.t_0 [@@js.global "scryptSync"]
    module[@js.scope "RsaPublicKey"] RsaPublicKey : sig
      type t = crypto_RsaPublicKey
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_key: t -> crypto_KeyLike [@@js.get "key"]
      val set_key: t -> crypto_KeyLike -> unit [@@js.set "key"]
      val get_padding: t -> float [@@js.get "padding"]
      val set_padding: t -> float -> unit [@@js.set "padding"]
    end
    module[@js.scope "RsaPrivateKey"] RsaPrivateKey : sig
      type t = crypto_RsaPrivateKey
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_key: t -> crypto_KeyLike [@@js.get "key"]
      val set_key: t -> crypto_KeyLike -> unit [@@js.set "key"]
      val get_passphrase: t -> string [@@js.get "passphrase"]
      val set_passphrase: t -> string -> unit [@@js.set "passphrase"]
      val get_oaepHash: t -> string [@@js.get "oaepHash"]
      val set_oaepHash: t -> string -> unit [@@js.set "oaepHash"]
      val get_oaepLabel: t -> NodeJS.TypedArray.t_0 [@@js.get "oaepLabel"]
      val set_oaepLabel: t -> NodeJS.TypedArray.t_0 -> unit [@@js.set "oaepLabel"]
      val get_padding: t -> float [@@js.get "padding"]
      val set_padding: t -> float -> unit [@@js.set "padding"]
    end
    val publicEncrypt: key:(crypto_KeyLike, crypto_RsaPrivateKey, crypto_RsaPublicKey) union3 -> buffer:NodeJS.ArrayBufferView.t_0 -> Buffer.t_0 [@@js.global "publicEncrypt"]
    val publicDecrypt: key:(crypto_KeyLike, crypto_RsaPrivateKey, crypto_RsaPublicKey) union3 -> buffer:NodeJS.ArrayBufferView.t_0 -> Buffer.t_0 [@@js.global "publicDecrypt"]
    val privateDecrypt: private_key:(crypto_KeyLike, crypto_RsaPrivateKey) union2 -> buffer:NodeJS.ArrayBufferView.t_0 -> Buffer.t_0 [@@js.global "privateDecrypt"]
    val privateEncrypt: private_key:(crypto_KeyLike, crypto_RsaPrivateKey) union2 -> buffer:NodeJS.ArrayBufferView.t_0 -> Buffer.t_0 [@@js.global "privateEncrypt"]
    val getCiphers: unit -> string list [@@js.global "getCiphers"]
    val getCurves: unit -> string list [@@js.global "getCurves"]
    val getFips: unit -> ([`L_n_0[@js 0] | `L_n_1[@js 1]] [@js.enum]) [@@js.global "getFips"]
    val getHashes: unit -> string list [@@js.global "getHashes"]
    module[@js.scope "ECDH"] ECDH : sig
      type t = crypto_ECDH
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: unit -> t [@@js.create]
      val convertKey: key:crypto_BinaryLike -> curve:string -> ?inputEncoding:crypto_BinaryToTextEncoding -> ?outputEncoding:([`L_s7_base64 | `L_s16_hex | `L_s19_latin1] [@js.enum]) -> ?format:([`L_s10_compressed | `L_s17_hybrid | `L_s31_uncompressed] [@js.enum]) -> unit -> Buffer.t_0 or_string [@@js.global "convertKey"]
      val generateKeys: t -> Buffer.t_0 [@@js.call "generateKeys"]
      val generateKeys': t -> encoding:crypto_BinaryToTextEncoding -> ?format:crypto_ECDHKeyFormat -> unit -> string [@@js.call "generateKeys"]
      val computeSecret: t -> other_public_key:NodeJS.ArrayBufferView.t_0 -> Buffer.t_0 [@@js.call "computeSecret"]
      val computeSecret': t -> other_public_key:string -> input_encoding:crypto_BinaryToTextEncoding -> Buffer.t_0 [@@js.call "computeSecret"]
      val computeSecret'': t -> other_public_key:NodeJS.ArrayBufferView.t_0 -> output_encoding:crypto_BinaryToTextEncoding -> string [@@js.call "computeSecret"]
      val computeSecret''': t -> other_public_key:string -> input_encoding:crypto_BinaryToTextEncoding -> output_encoding:crypto_BinaryToTextEncoding -> string [@@js.call "computeSecret"]
      val getPrivateKey: t -> Buffer.t_0 [@@js.call "getPrivateKey"]
      val getPrivateKey': t -> encoding:crypto_BinaryToTextEncoding -> string [@@js.call "getPrivateKey"]
      val getPublicKey: t -> Buffer.t_0 [@@js.call "getPublicKey"]
      val getPublicKey': t -> encoding:crypto_BinaryToTextEncoding -> ?format:crypto_ECDHKeyFormat -> unit -> string [@@js.call "getPublicKey"]
      val setPrivateKey: t -> private_key:NodeJS.ArrayBufferView.t_0 -> unit [@@js.call "setPrivateKey"]
      val setPrivateKey': t -> private_key:string -> encoding:crypto_BinaryToTextEncoding -> unit [@@js.call "setPrivateKey"]
    end
    val createECDH: curve_name:string -> crypto_ECDH [@@js.global "createECDH"]
    val timingSafeEqual: a:NodeJS.ArrayBufferView.t_0 -> b:NodeJS.ArrayBufferView.t_0 -> bool [@@js.global "timingSafeEqual"]
    val dEFAULT_ENCODING: BufferEncoding.t_0 [@@js.global "DEFAULT_ENCODING"]
    module KeyType : sig
      type t = crypto_KeyType
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module KeyFormat : sig
      type t = crypto_KeyFormat
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "BasePrivateKeyEncodingOptions"] BasePrivateKeyEncodingOptions : sig
      type 'T t = 'T crypto_BasePrivateKeyEncodingOptions
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val get_format: 'T t -> 'T [@@js.get "format"]
      val set_format: 'T t -> 'T -> unit [@@js.set "format"]
      val get_cipher: 'T t -> string [@@js.get "cipher"]
      val set_cipher: 'T t -> string -> unit [@@js.set "cipher"]
      val get_passphrase: 'T t -> string [@@js.get "passphrase"]
      val set_passphrase: 'T t -> string -> unit [@@js.set "passphrase"]
    end
    module[@js.scope "KeyPairKeyObjectResult"] KeyPairKeyObjectResult : sig
      type t = crypto_KeyPairKeyObjectResult
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_publicKey: t -> crypto_KeyObject [@@js.get "publicKey"]
      val set_publicKey: t -> crypto_KeyObject -> unit [@@js.set "publicKey"]
      val get_privateKey: t -> crypto_KeyObject [@@js.get "privateKey"]
      val set_privateKey: t -> crypto_KeyObject -> unit [@@js.set "privateKey"]
    end
    module ED25519KeyPairKeyObjectOptions : sig
      type t = crypto_ED25519KeyPairKeyObjectOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ED448KeyPairKeyObjectOptions : sig
      type t = crypto_ED448KeyPairKeyObjectOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module X25519KeyPairKeyObjectOptions : sig
      type t = crypto_X25519KeyPairKeyObjectOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module X448KeyPairKeyObjectOptions : sig
      type t = crypto_X448KeyPairKeyObjectOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "ECKeyPairKeyObjectOptions"] ECKeyPairKeyObjectOptions : sig
      type t = crypto_ECKeyPairKeyObjectOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_namedCurve: t -> string [@@js.get "namedCurve"]
      val set_namedCurve: t -> string -> unit [@@js.set "namedCurve"]
    end
    module[@js.scope "RSAKeyPairKeyObjectOptions"] RSAKeyPairKeyObjectOptions : sig
      type t = crypto_RSAKeyPairKeyObjectOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_modulusLength: t -> float [@@js.get "modulusLength"]
      val set_modulusLength: t -> float -> unit [@@js.set "modulusLength"]
      val get_publicExponent: t -> float [@@js.get "publicExponent"]
      val set_publicExponent: t -> float -> unit [@@js.set "publicExponent"]
    end
    module[@js.scope "DSAKeyPairKeyObjectOptions"] DSAKeyPairKeyObjectOptions : sig
      type t = crypto_DSAKeyPairKeyObjectOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_modulusLength: t -> float [@@js.get "modulusLength"]
      val set_modulusLength: t -> float -> unit [@@js.set "modulusLength"]
      val get_divisorLength: t -> float [@@js.get "divisorLength"]
      val set_divisorLength: t -> float -> unit [@@js.set "divisorLength"]
    end
    module[@js.scope "RSAKeyPairOptions"] RSAKeyPairOptions : sig
      type ('PubF, 'PrivF) t = ('PubF, 'PrivF) crypto_RSAKeyPairOptions
      val t_to_js: ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t -> Ojs.t
      val t_of_js: (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t
      type ('PubF, 'PrivF) t_2 = ('PubF, 'PrivF) t
      val t_2_to_js: ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t_2 -> Ojs.t
      val t_2_of_js: (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t_2
      val get_modulusLength: ('PubF, 'PrivF) t -> float [@@js.get "modulusLength"]
      val set_modulusLength: ('PubF, 'PrivF) t -> float -> unit [@@js.set "modulusLength"]
      val get_publicExponent: ('PubF, 'PrivF) t -> float [@@js.get "publicExponent"]
      val set_publicExponent: ('PubF, 'PrivF) t -> float -> unit [@@js.set "publicExponent"]
      val get_publicKeyEncoding: ('PubF, 'PrivF) t -> anonymous_interface_9 [@@js.get "publicKeyEncoding"]
      val set_publicKeyEncoding: ('PubF, 'PrivF) t -> anonymous_interface_9 -> unit [@@js.set "publicKeyEncoding"]
      val get_privateKeyEncoding: ('PubF, 'PrivF) t -> ('PrivF crypto_BasePrivateKeyEncodingOptions, anonymous_interface_8) intersection2 [@@js.get "privateKeyEncoding"]
      val set_privateKeyEncoding: ('PubF, 'PrivF) t -> ('PrivF crypto_BasePrivateKeyEncodingOptions, anonymous_interface_8) intersection2 -> unit [@@js.set "privateKeyEncoding"]
    end
    module[@js.scope "DSAKeyPairOptions"] DSAKeyPairOptions : sig
      type ('PubF, 'PrivF) t = ('PubF, 'PrivF) crypto_DSAKeyPairOptions
      val t_to_js: ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t -> Ojs.t
      val t_of_js: (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t
      type ('PubF, 'PrivF) t_2 = ('PubF, 'PrivF) t
      val t_2_to_js: ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t_2 -> Ojs.t
      val t_2_of_js: (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t_2
      val get_modulusLength: ('PubF, 'PrivF) t -> float [@@js.get "modulusLength"]
      val set_modulusLength: ('PubF, 'PrivF) t -> float -> unit [@@js.set "modulusLength"]
      val get_divisorLength: ('PubF, 'PrivF) t -> float [@@js.get "divisorLength"]
      val set_divisorLength: ('PubF, 'PrivF) t -> float -> unit [@@js.set "divisorLength"]
      val get_publicKeyEncoding: ('PubF, 'PrivF) t -> anonymous_interface_7 [@@js.get "publicKeyEncoding"]
      val set_publicKeyEncoding: ('PubF, 'PrivF) t -> anonymous_interface_7 -> unit [@@js.set "publicKeyEncoding"]
      val get_privateKeyEncoding: ('PubF, 'PrivF) t -> ('PrivF crypto_BasePrivateKeyEncodingOptions, anonymous_interface_6) intersection2 [@@js.get "privateKeyEncoding"]
      val set_privateKeyEncoding: ('PubF, 'PrivF) t -> ('PrivF crypto_BasePrivateKeyEncodingOptions, anonymous_interface_6) intersection2 -> unit [@@js.set "privateKeyEncoding"]
    end
    module[@js.scope "ECKeyPairOptions"] ECKeyPairOptions : sig
      type ('PubF, 'PrivF) t = ('PubF, 'PrivF) crypto_ECKeyPairOptions
      val t_to_js: ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t -> Ojs.t
      val t_of_js: (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t
      type ('PubF, 'PrivF) t_2 = ('PubF, 'PrivF) t
      val t_2_to_js: ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t_2 -> Ojs.t
      val t_2_of_js: (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t_2
      val get_namedCurve: ('PubF, 'PrivF) t -> string [@@js.get "namedCurve"]
      val set_namedCurve: ('PubF, 'PrivF) t -> string -> unit [@@js.set "namedCurve"]
      val get_publicKeyEncoding: ('PubF, 'PrivF) t -> anonymous_interface_9 [@@js.get "publicKeyEncoding"]
      val set_publicKeyEncoding: ('PubF, 'PrivF) t -> anonymous_interface_9 -> unit [@@js.set "publicKeyEncoding"]
      val get_privateKeyEncoding: ('PubF, 'PrivF) t -> ('PrivF crypto_BasePrivateKeyEncodingOptions, anonymous_interface_10) intersection2 [@@js.get "privateKeyEncoding"]
      val set_privateKeyEncoding: ('PubF, 'PrivF) t -> ('PrivF crypto_BasePrivateKeyEncodingOptions, anonymous_interface_10) intersection2 -> unit [@@js.set "privateKeyEncoding"]
    end
    module[@js.scope "ED25519KeyPairOptions"] ED25519KeyPairOptions : sig
      type ('PubF, 'PrivF) t = ('PubF, 'PrivF) crypto_ED25519KeyPairOptions
      val t_to_js: ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t -> Ojs.t
      val t_of_js: (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t
      type ('PubF, 'PrivF) t_2 = ('PubF, 'PrivF) t
      val t_2_to_js: ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t_2 -> Ojs.t
      val t_2_of_js: (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t_2
      val get_publicKeyEncoding: ('PubF, 'PrivF) t -> anonymous_interface_7 [@@js.get "publicKeyEncoding"]
      val set_publicKeyEncoding: ('PubF, 'PrivF) t -> anonymous_interface_7 -> unit [@@js.set "publicKeyEncoding"]
      val get_privateKeyEncoding: ('PubF, 'PrivF) t -> ('PrivF crypto_BasePrivateKeyEncodingOptions, anonymous_interface_6) intersection2 [@@js.get "privateKeyEncoding"]
      val set_privateKeyEncoding: ('PubF, 'PrivF) t -> ('PrivF crypto_BasePrivateKeyEncodingOptions, anonymous_interface_6) intersection2 -> unit [@@js.set "privateKeyEncoding"]
    end
    module[@js.scope "ED448KeyPairOptions"] ED448KeyPairOptions : sig
      type ('PubF, 'PrivF) t = ('PubF, 'PrivF) crypto_ED448KeyPairOptions
      val t_to_js: ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t -> Ojs.t
      val t_of_js: (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t
      type ('PubF, 'PrivF) t_2 = ('PubF, 'PrivF) t
      val t_2_to_js: ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t_2 -> Ojs.t
      val t_2_of_js: (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t_2
      val get_publicKeyEncoding: ('PubF, 'PrivF) t -> anonymous_interface_7 [@@js.get "publicKeyEncoding"]
      val set_publicKeyEncoding: ('PubF, 'PrivF) t -> anonymous_interface_7 -> unit [@@js.set "publicKeyEncoding"]
      val get_privateKeyEncoding: ('PubF, 'PrivF) t -> ('PrivF crypto_BasePrivateKeyEncodingOptions, anonymous_interface_6) intersection2 [@@js.get "privateKeyEncoding"]
      val set_privateKeyEncoding: ('PubF, 'PrivF) t -> ('PrivF crypto_BasePrivateKeyEncodingOptions, anonymous_interface_6) intersection2 -> unit [@@js.set "privateKeyEncoding"]
    end
    module[@js.scope "X25519KeyPairOptions"] X25519KeyPairOptions : sig
      type ('PubF, 'PrivF) t = ('PubF, 'PrivF) crypto_X25519KeyPairOptions
      val t_to_js: ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t -> Ojs.t
      val t_of_js: (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t
      type ('PubF, 'PrivF) t_2 = ('PubF, 'PrivF) t
      val t_2_to_js: ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t_2 -> Ojs.t
      val t_2_of_js: (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t_2
      val get_publicKeyEncoding: ('PubF, 'PrivF) t -> anonymous_interface_7 [@@js.get "publicKeyEncoding"]
      val set_publicKeyEncoding: ('PubF, 'PrivF) t -> anonymous_interface_7 -> unit [@@js.set "publicKeyEncoding"]
      val get_privateKeyEncoding: ('PubF, 'PrivF) t -> ('PrivF crypto_BasePrivateKeyEncodingOptions, anonymous_interface_6) intersection2 [@@js.get "privateKeyEncoding"]
      val set_privateKeyEncoding: ('PubF, 'PrivF) t -> ('PrivF crypto_BasePrivateKeyEncodingOptions, anonymous_interface_6) intersection2 -> unit [@@js.set "privateKeyEncoding"]
    end
    module[@js.scope "X448KeyPairOptions"] X448KeyPairOptions : sig
      type ('PubF, 'PrivF) t = ('PubF, 'PrivF) crypto_X448KeyPairOptions
      val t_to_js: ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t -> Ojs.t
      val t_of_js: (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t
      type ('PubF, 'PrivF) t_2 = ('PubF, 'PrivF) t
      val t_2_to_js: ('PubF -> Ojs.t) -> ('PrivF -> Ojs.t) -> ('PubF, 'PrivF) t_2 -> Ojs.t
      val t_2_of_js: (Ojs.t -> 'PubF) -> (Ojs.t -> 'PrivF) -> Ojs.t -> ('PubF, 'PrivF) t_2
      val get_publicKeyEncoding: ('PubF, 'PrivF) t -> anonymous_interface_7 [@@js.get "publicKeyEncoding"]
      val set_publicKeyEncoding: ('PubF, 'PrivF) t -> anonymous_interface_7 -> unit [@@js.set "publicKeyEncoding"]
      val get_privateKeyEncoding: ('PubF, 'PrivF) t -> ('PrivF crypto_BasePrivateKeyEncodingOptions, anonymous_interface_6) intersection2 [@@js.get "privateKeyEncoding"]
      val set_privateKeyEncoding: ('PubF, 'PrivF) t -> ('PrivF crypto_BasePrivateKeyEncodingOptions, anonymous_interface_6) intersection2 -> unit [@@js.set "privateKeyEncoding"]
    end
    module[@js.scope "KeyPairSyncResult"] KeyPairSyncResult : sig
      type ('T1, 'T2) t = ('T1, 'T2) crypto_KeyPairSyncResult
      val t_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T1, 'T2) t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> Ojs.t -> ('T1, 'T2) t
      type ('T1, 'T2) t_2 = ('T1, 'T2) t
      val t_2_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T1, 'T2) t_2 -> Ojs.t
      val t_2_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> Ojs.t -> ('T1, 'T2) t_2
      val get_publicKey: ('T1, 'T2) t -> 'T1 [@@js.get "publicKey"]
      val set_publicKey: ('T1, 'T2) t -> 'T1 -> unit [@@js.set "publicKey"]
      val get_privateKey: ('T1, 'T2) t -> 'T2 [@@js.get "privateKey"]
      val set_privateKey: ('T1, 'T2) t -> 'T2 -> unit [@@js.set "privateKey"]
    end
    val generateKeyPairSync: type_:([`L_s25_rsa] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_RSAKeyPairOptions -> (string, string) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s25_rsa] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_RSAKeyPairOptions -> (string, Buffer.t_0) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s25_rsa] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_RSAKeyPairOptions -> (Buffer.t_0, string) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s25_rsa] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_RSAKeyPairOptions -> (Buffer.t_0, Buffer.t_0) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s25_rsa] [@js.enum]) -> options:crypto_RSAKeyPairKeyObjectOptions -> crypto_KeyPairKeyObjectResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s12_dsa] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_DSAKeyPairOptions -> (string, string) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s12_dsa] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_DSAKeyPairOptions -> (string, Buffer.t_0) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s12_dsa] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_DSAKeyPairOptions -> (Buffer.t_0, string) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s12_dsa] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_DSAKeyPairOptions -> (Buffer.t_0, Buffer.t_0) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s12_dsa] [@js.enum]) -> options:crypto_DSAKeyPairKeyObjectOptions -> crypto_KeyPairKeyObjectResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s13_ec] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ECKeyPairOptions -> (string, string) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s13_ec] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ECKeyPairOptions -> (string, Buffer.t_0) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s13_ec] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ECKeyPairOptions -> (Buffer.t_0, string) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s13_ec] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ECKeyPairOptions -> (Buffer.t_0, Buffer.t_0) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s13_ec] [@js.enum]) -> options:crypto_ECKeyPairKeyObjectOptions -> crypto_KeyPairKeyObjectResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s14_ed25519] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ED25519KeyPairOptions -> (string, string) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s14_ed25519] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ED25519KeyPairOptions -> (string, Buffer.t_0) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s14_ed25519] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ED25519KeyPairOptions -> (Buffer.t_0, string) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s14_ed25519] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ED25519KeyPairOptions -> (Buffer.t_0, Buffer.t_0) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s14_ed25519] [@js.enum]) -> ?options:crypto_ED25519KeyPairKeyObjectOptions -> unit -> crypto_KeyPairKeyObjectResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s15_ed448] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ED448KeyPairOptions -> (string, string) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s15_ed448] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ED448KeyPairOptions -> (string, Buffer.t_0) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s15_ed448] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ED448KeyPairOptions -> (Buffer.t_0, string) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s15_ed448] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ED448KeyPairOptions -> (Buffer.t_0, Buffer.t_0) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s15_ed448] [@js.enum]) -> ?options:crypto_ED448KeyPairKeyObjectOptions -> unit -> crypto_KeyPairKeyObjectResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s35_x25519] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_X25519KeyPairOptions -> (string, string) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s35_x25519] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_X25519KeyPairOptions -> (string, Buffer.t_0) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s35_x25519] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_X25519KeyPairOptions -> (Buffer.t_0, string) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s35_x25519] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_X25519KeyPairOptions -> (Buffer.t_0, Buffer.t_0) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s35_x25519] [@js.enum]) -> ?options:crypto_X25519KeyPairKeyObjectOptions -> unit -> crypto_KeyPairKeyObjectResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s36_x448] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_X448KeyPairOptions -> (string, string) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s36_x448] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_X448KeyPairOptions -> (string, Buffer.t_0) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s36_x448] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_X448KeyPairOptions -> (Buffer.t_0, string) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s36_x448] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_X448KeyPairOptions -> (Buffer.t_0, Buffer.t_0) crypto_KeyPairSyncResult [@@js.global "generateKeyPairSync"]
    val generateKeyPairSync: type_:([`L_s36_x448] [@js.enum]) -> ?options:crypto_X448KeyPairKeyObjectOptions -> unit -> crypto_KeyPairKeyObjectResult [@@js.global "generateKeyPairSync"]
    val generateKeyPair: type_:([`L_s25_rsa] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_RSAKeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:string -> privateKey:string -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s25_rsa] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_RSAKeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:string -> privateKey:Buffer.t_0 -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s25_rsa] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_RSAKeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:Buffer.t_0 -> privateKey:string -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s25_rsa] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_RSAKeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:Buffer.t_0 -> privateKey:Buffer.t_0 -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s25_rsa] [@js.enum]) -> options:crypto_RSAKeyPairKeyObjectOptions -> callback:(err:Error.t_0 or_null -> publicKey:crypto_KeyObject -> privateKey:crypto_KeyObject -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s12_dsa] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_DSAKeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:string -> privateKey:string -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s12_dsa] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_DSAKeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:string -> privateKey:Buffer.t_0 -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s12_dsa] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_DSAKeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:Buffer.t_0 -> privateKey:string -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s12_dsa] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_DSAKeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:Buffer.t_0 -> privateKey:Buffer.t_0 -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s12_dsa] [@js.enum]) -> options:crypto_DSAKeyPairKeyObjectOptions -> callback:(err:Error.t_0 or_null -> publicKey:crypto_KeyObject -> privateKey:crypto_KeyObject -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s13_ec] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ECKeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:string -> privateKey:string -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s13_ec] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ECKeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:string -> privateKey:Buffer.t_0 -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s13_ec] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ECKeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:Buffer.t_0 -> privateKey:string -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s13_ec] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ECKeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:Buffer.t_0 -> privateKey:Buffer.t_0 -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s13_ec] [@js.enum]) -> options:crypto_ECKeyPairKeyObjectOptions -> callback:(err:Error.t_0 or_null -> publicKey:crypto_KeyObject -> privateKey:crypto_KeyObject -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s14_ed25519] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ED25519KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:string -> privateKey:string -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s14_ed25519] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ED25519KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:string -> privateKey:Buffer.t_0 -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s14_ed25519] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ED25519KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:Buffer.t_0 -> privateKey:string -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s14_ed25519] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ED25519KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:Buffer.t_0 -> privateKey:Buffer.t_0 -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s14_ed25519] [@js.enum]) -> options:crypto_ED25519KeyPairKeyObjectOptions or_undefined -> callback:(err:Error.t_0 or_null -> publicKey:crypto_KeyObject -> privateKey:crypto_KeyObject -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s15_ed448] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ED448KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:string -> privateKey:string -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s15_ed448] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ED448KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:string -> privateKey:Buffer.t_0 -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s15_ed448] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ED448KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:Buffer.t_0 -> privateKey:string -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s15_ed448] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ED448KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:Buffer.t_0 -> privateKey:Buffer.t_0 -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s15_ed448] [@js.enum]) -> options:crypto_ED448KeyPairKeyObjectOptions or_undefined -> callback:(err:Error.t_0 or_null -> publicKey:crypto_KeyObject -> privateKey:crypto_KeyObject -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s35_x25519] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_X25519KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:string -> privateKey:string -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s35_x25519] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_X25519KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:string -> privateKey:Buffer.t_0 -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s35_x25519] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_X25519KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:Buffer.t_0 -> privateKey:string -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s35_x25519] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_X25519KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:Buffer.t_0 -> privateKey:Buffer.t_0 -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s35_x25519] [@js.enum]) -> options:crypto_X25519KeyPairKeyObjectOptions or_undefined -> callback:(err:Error.t_0 or_null -> publicKey:crypto_KeyObject -> privateKey:crypto_KeyObject -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s36_x448] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_X448KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:string -> privateKey:string -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s36_x448] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_X448KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:string -> privateKey:Buffer.t_0 -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s36_x448] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_X448KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:Buffer.t_0 -> privateKey:string -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s36_x448] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_X448KeyPairOptions -> callback:(err:Error.t_0 or_null -> publicKey:Buffer.t_0 -> privateKey:Buffer.t_0 -> unit) -> unit [@@js.global "generateKeyPair"]
    val generateKeyPair: type_:([`L_s36_x448] [@js.enum]) -> options:crypto_X448KeyPairKeyObjectOptions or_undefined -> callback:(err:Error.t_0 or_null -> publicKey:crypto_KeyObject -> privateKey:crypto_KeyObject -> unit) -> unit [@@js.global "generateKeyPair"]
    module[@js.scope "generateKeyPair"] GenerateKeyPair : sig
      val __promisify__: type_:([`L_s25_rsa] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_RSAKeyPairOptions -> anonymous_interface_5 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s25_rsa] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_RSAKeyPairOptions -> anonymous_interface_4 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s25_rsa] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_RSAKeyPairOptions -> anonymous_interface_3 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s25_rsa] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_RSAKeyPairOptions -> anonymous_interface_2 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s25_rsa] [@js.enum]) -> options:crypto_RSAKeyPairKeyObjectOptions -> crypto_KeyPairKeyObjectResult Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s12_dsa] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_DSAKeyPairOptions -> anonymous_interface_5 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s12_dsa] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_DSAKeyPairOptions -> anonymous_interface_4 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s12_dsa] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_DSAKeyPairOptions -> anonymous_interface_3 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s12_dsa] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_DSAKeyPairOptions -> anonymous_interface_2 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s12_dsa] [@js.enum]) -> options:crypto_DSAKeyPairKeyObjectOptions -> crypto_KeyPairKeyObjectResult Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s13_ec] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ECKeyPairOptions -> anonymous_interface_5 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s13_ec] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ECKeyPairOptions -> anonymous_interface_4 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s13_ec] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ECKeyPairOptions -> anonymous_interface_3 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s13_ec] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ECKeyPairOptions -> anonymous_interface_2 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s13_ec] [@js.enum]) -> options:crypto_ECKeyPairKeyObjectOptions -> crypto_KeyPairKeyObjectResult Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s14_ed25519] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ED25519KeyPairOptions -> anonymous_interface_5 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s14_ed25519] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ED25519KeyPairOptions -> anonymous_interface_4 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s14_ed25519] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ED25519KeyPairOptions -> anonymous_interface_3 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s14_ed25519] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ED25519KeyPairOptions -> anonymous_interface_2 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s14_ed25519] [@js.enum]) -> ?options:crypto_ED25519KeyPairKeyObjectOptions -> unit -> crypto_KeyPairKeyObjectResult Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s15_ed448] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ED448KeyPairOptions -> anonymous_interface_5 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s15_ed448] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ED448KeyPairOptions -> anonymous_interface_4 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s15_ed448] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_ED448KeyPairOptions -> anonymous_interface_3 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s15_ed448] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_ED448KeyPairOptions -> anonymous_interface_2 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s15_ed448] [@js.enum]) -> ?options:crypto_ED448KeyPairKeyObjectOptions -> unit -> crypto_KeyPairKeyObjectResult Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s35_x25519] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_X25519KeyPairOptions -> anonymous_interface_5 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s35_x25519] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_X25519KeyPairOptions -> anonymous_interface_4 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s35_x25519] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_X25519KeyPairOptions -> anonymous_interface_3 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s35_x25519] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_X25519KeyPairOptions -> anonymous_interface_2 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s35_x25519] [@js.enum]) -> ?options:crypto_X25519KeyPairKeyObjectOptions -> unit -> crypto_KeyPairKeyObjectResult Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s36_x448] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_X448KeyPairOptions -> anonymous_interface_5 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s36_x448] [@js.enum]) -> options:(([`L_s20_pem] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_X448KeyPairOptions -> anonymous_interface_4 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s36_x448] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s20_pem] [@js.enum])) crypto_X448KeyPairOptions -> anonymous_interface_3 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s36_x448] [@js.enum]) -> options:(([`L_s11_der] [@js.enum]), ([`L_s11_der] [@js.enum])) crypto_X448KeyPairOptions -> anonymous_interface_2 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: type_:([`L_s36_x448] [@js.enum]) -> ?options:crypto_X448KeyPairKeyObjectOptions -> unit -> crypto_KeyPairKeyObjectResult Promise.t_1 [@@js.global "__promisify__"]
    end
    val sign: algorithm:string or_null_or_undefined -> data:NodeJS.ArrayBufferView.t_0 -> key:(([`U_s11_der of crypto_SignKeyObjectInput  | `U_s18_ieee_p1363 of crypto_SignKeyObjectInput ] [@js.union on_field "dsaEncoding"]), ([`U_s21_pkcs1 of crypto_SignPrivateKeyInput  | `U_s22_pkcs8 of crypto_SignPrivateKeyInput  | `U_s23_private of crypto_KeyLike  | `U_s24_public of crypto_KeyLike  | `U_s26_sec1 of crypto_SignPrivateKeyInput  | `U_s27_secret of crypto_KeyLike ] [@js.union on_field "type"])) union2 -> Buffer.t_0 [@@js.global "sign"]
    val verify: algorithm:string or_null_or_undefined -> data:NodeJS.ArrayBufferView.t_0 -> key:(([`U_s11_der of crypto_VerifyKeyObjectInput  | `U_s18_ieee_p1363 of crypto_VerifyKeyObjectInput ] [@js.union on_field "dsaEncoding"]), ([`U_s21_pkcs1 of crypto_VerifyPublicKeyInput  | `U_s23_private of crypto_KeyLike  | `U_s24_public of crypto_KeyLike  | `U_s27_secret of crypto_KeyLike  | `U_s28_spki of crypto_VerifyPublicKeyInput ] [@js.union on_field "type"])) union2 -> signature:NodeJS.ArrayBufferView.t_0 -> bool [@@js.global "verify"]
    val diffieHellman: options:anonymous_interface_1 -> Buffer.t_0 [@@js.global "diffieHellman"]
  end
end
