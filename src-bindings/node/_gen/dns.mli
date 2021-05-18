[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - NodeJS.ErrnoException
  - Promise<T1>
 *)
[@@@js.stop]
module type Missing = sig
  module NodeJS : sig
    module ErrnoException : sig
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
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module NodeJS : sig
      module ErrnoException : sig
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
      type dns_AnyARecord = [`Dns_AnyARecord | `Dns_RecordWithTtl] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_AnyAaaaRecord = [`Dns_AnyAaaaRecord | `Dns_RecordWithTtl] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_AnyCnameRecord = [`Dns_AnyCnameRecord] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_AnyMxRecord = [`Dns_AnyMxRecord | `Dns_MxRecord] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_AnyNaptrRecord = [`Dns_AnyNaptrRecord | `Dns_NaptrRecord] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_AnyNsRecord = [`Dns_AnyNsRecord] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_AnyPtrRecord = [`Dns_AnyPtrRecord] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_AnyRecord = ([`U_s0_A of dns_AnyARecord [@js "A"] | `U_s1_AAAA of dns_AnyAaaaRecord [@js "AAAA"] | `U_s3_CNAME of dns_AnyCnameRecord [@js "CNAME"] | `U_s4_MX of dns_AnyMxRecord [@js "MX"] | `U_s5_NAPTR of dns_AnyNaptrRecord [@js "NAPTR"] | `U_s6_NS of dns_AnyNsRecord [@js "NS"] | `U_s7_PTR of dns_AnyPtrRecord [@js "PTR"] | `U_s8_SOA of dns_AnySoaRecord [@js "SOA"] | `U_s9_SRV of dns_AnySrvRecord [@js "SRV"] | `U_s10_TXT of dns_AnyTxtRecord [@js "TXT"]] [@js.union on_field "type"])
      and dns_AnyRecordWithTtl = ([`U_s0_A of dns_AnyARecord [@js "A"] | `U_s1_AAAA of dns_AnyAaaaRecord [@js "AAAA"]] [@js.union on_field "type"])
      and dns_AnySoaRecord = [`Dns_AnySoaRecord | `Dns_SoaRecord] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_AnySrvRecord = [`Dns_AnySrvRecord | `Dns_SrvRecord] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_AnyTxtRecord = [`Dns_AnyTxtRecord] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_LookupAddress = [`Dns_LookupAddress] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_LookupAllOptions = [`Dns_LookupAllOptions | `Dns_LookupOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_LookupOneOptions = [`Dns_LookupOneOptions | `Dns_LookupOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_LookupOptions = [`Dns_LookupOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_MxRecord = [`Dns_MxRecord] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_NaptrRecord = [`Dns_NaptrRecord] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_RecordWithTtl = [`Dns_RecordWithTtl] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_ResolveOptions = [`Dns_ResolveOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_ResolveWithTtlOptions = [`Dns_ResolveWithTtlOptions | `Dns_ResolveOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_Resolver = [`Dns_Resolver] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_ResolverOptions = [`Dns_ResolverOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_SoaRecord = [`Dns_SoaRecord] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_SrvRecord = [`Dns_SrvRecord] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and dns_promises_Resolver = [`Dns_promises_Resolver] intf
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
    val get_hostname: t -> string [@@js.get "hostname"]
    val set_hostname: t -> string -> unit [@@js.set "hostname"]
    val get_service: t -> string [@@js.get "service"]
    val set_service: t -> string -> unit [@@js.set "service"]
  end
  module[@js.scope "node:dns"] Node_dns : sig
    (* export * from 'dns'; *)
  end
  module[@js.scope "dns"] Dns : sig
    val aDDRCONFIG: float [@@js.global "ADDRCONFIG"]
    val v4MAPPED: float [@@js.global "V4MAPPED"]
    val aLL: float [@@js.global "ALL"]
    module[@js.scope "LookupOptions"] LookupOptions : sig
      type t = dns_LookupOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_family: t -> float [@@js.get "family"]
      val set_family: t -> float -> unit [@@js.set "family"]
      val get_hints: t -> float [@@js.get "hints"]
      val set_hints: t -> float -> unit [@@js.set "hints"]
      val get_all: t -> bool [@@js.get "all"]
      val set_all: t -> bool -> unit [@@js.set "all"]
      val get_verbatim: t -> bool [@@js.get "verbatim"]
      val set_verbatim: t -> bool -> unit [@@js.set "verbatim"]
    end
    module[@js.scope "LookupOneOptions"] LookupOneOptions : sig
      type t = dns_LookupOneOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_all: t -> ([`L_b_false[@js false]] [@js.enum]) [@@js.get "all"]
      val set_all: t -> ([`L_b_false] [@js.enum]) -> unit [@@js.set "all"]
      val cast: t -> dns_LookupOptions [@@js.cast]
    end
    module[@js.scope "LookupAllOptions"] LookupAllOptions : sig
      type t = dns_LookupAllOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_all: t -> ([`L_b_true[@js true]] [@js.enum]) [@@js.get "all"]
      val set_all: t -> ([`L_b_true] [@js.enum]) -> unit [@@js.set "all"]
      val cast: t -> dns_LookupOptions [@@js.cast]
    end
    module[@js.scope "LookupAddress"] LookupAddress : sig
      type t = dns_LookupAddress
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_address: t -> string [@@js.get "address"]
      val set_address: t -> string -> unit [@@js.set "address"]
      val get_family: t -> float [@@js.get "family"]
      val set_family: t -> float -> unit [@@js.set "family"]
    end
    val lookup: hostname:string -> family:float -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> address:string -> family:float -> unit) -> unit [@@js.global "lookup"]
    val lookup: hostname:string -> options:dns_LookupOneOptions -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> address:string -> family:float -> unit) -> unit [@@js.global "lookup"]
    val lookup: hostname:string -> options:dns_LookupAllOptions -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_LookupAddress list -> unit) -> unit [@@js.global "lookup"]
    val lookup: hostname:string -> options:dns_LookupOptions -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> address:dns_LookupAddress list or_string -> family:float -> unit) -> unit [@@js.global "lookup"]
    val lookup: hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> address:string -> family:float -> unit) -> unit [@@js.global "lookup"]
    module[@js.scope "lookup"] Lookup : sig
      val __promisify__: hostname:string -> options:dns_LookupAllOptions -> dns_LookupAddress list Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: hostname:string -> ?options:dns_LookupOneOptions or_number -> unit -> dns_LookupAddress Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: hostname:string -> options:dns_LookupOptions -> (dns_LookupAddress, dns_LookupAddress) or_array Promise.t_1 [@@js.global "__promisify__"]
    end
    val lookupService: address:string -> port:float -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> hostname:string -> service:string -> unit) -> unit [@@js.global "lookupService"]
    module[@js.scope "lookupService"] LookupService : sig
      val __promisify__: address:string -> port:float -> anonymous_interface_0 Promise.t_1 [@@js.global "__promisify__"]
    end
    module[@js.scope "ResolveOptions"] ResolveOptions : sig
      type t = dns_ResolveOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_ttl: t -> bool [@@js.get "ttl"]
      val set_ttl: t -> bool -> unit [@@js.set "ttl"]
    end
    module[@js.scope "ResolveWithTtlOptions"] ResolveWithTtlOptions : sig
      type t = dns_ResolveWithTtlOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_ttl: t -> ([`L_b_true[@js true]] [@js.enum]) [@@js.get "ttl"]
      val set_ttl: t -> ([`L_b_true] [@js.enum]) -> unit [@@js.set "ttl"]
      val cast: t -> dns_ResolveOptions [@@js.cast]
    end
    module[@js.scope "RecordWithTtl"] RecordWithTtl : sig
      type t = dns_RecordWithTtl
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_address: t -> string [@@js.get "address"]
      val set_address: t -> string -> unit [@@js.set "address"]
      val get_ttl: t -> float [@@js.get "ttl"]
      val set_ttl: t -> float -> unit [@@js.set "ttl"]
    end
    module AnyRecordWithTtl : sig
      type t = dns_AnyRecordWithTtl
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "AnyARecord"] AnyARecord : sig
      type t = dns_AnyARecord
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> ([`L_s0_A[@js "A"]] [@js.enum]) [@@js.get "type"]
      val set_type: t -> ([`L_s0_A] [@js.enum]) -> unit [@@js.set "type"]
      val cast: t -> dns_RecordWithTtl [@@js.cast]
    end
    module[@js.scope "AnyAaaaRecord"] AnyAaaaRecord : sig
      type t = dns_AnyAaaaRecord
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> ([`L_s1_AAAA[@js "AAAA"]] [@js.enum]) [@@js.get "type"]
      val set_type: t -> ([`L_s1_AAAA] [@js.enum]) -> unit [@@js.set "type"]
      val cast: t -> dns_RecordWithTtl [@@js.cast]
    end
    module[@js.scope "MxRecord"] MxRecord : sig
      type t = dns_MxRecord
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_priority: t -> float [@@js.get "priority"]
      val set_priority: t -> float -> unit [@@js.set "priority"]
      val get_exchange: t -> string [@@js.get "exchange"]
      val set_exchange: t -> string -> unit [@@js.set "exchange"]
    end
    module[@js.scope "AnyMxRecord"] AnyMxRecord : sig
      type t = dns_AnyMxRecord
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> ([`L_s4_MX[@js "MX"]] [@js.enum]) [@@js.get "type"]
      val set_type: t -> ([`L_s4_MX] [@js.enum]) -> unit [@@js.set "type"]
      val cast: t -> dns_MxRecord [@@js.cast]
    end
    module[@js.scope "NaptrRecord"] NaptrRecord : sig
      type t = dns_NaptrRecord
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_flags: t -> string [@@js.get "flags"]
      val set_flags: t -> string -> unit [@@js.set "flags"]
      val get_service: t -> string [@@js.get "service"]
      val set_service: t -> string -> unit [@@js.set "service"]
      val get_regexp: t -> string [@@js.get "regexp"]
      val set_regexp: t -> string -> unit [@@js.set "regexp"]
      val get_replacement: t -> string [@@js.get "replacement"]
      val set_replacement: t -> string -> unit [@@js.set "replacement"]
      val get_order: t -> float [@@js.get "order"]
      val set_order: t -> float -> unit [@@js.set "order"]
      val get_preference: t -> float [@@js.get "preference"]
      val set_preference: t -> float -> unit [@@js.set "preference"]
    end
    module[@js.scope "AnyNaptrRecord"] AnyNaptrRecord : sig
      type t = dns_AnyNaptrRecord
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> ([`L_s5_NAPTR[@js "NAPTR"]] [@js.enum]) [@@js.get "type"]
      val set_type: t -> ([`L_s5_NAPTR] [@js.enum]) -> unit [@@js.set "type"]
      val cast: t -> dns_NaptrRecord [@@js.cast]
    end
    module[@js.scope "SoaRecord"] SoaRecord : sig
      type t = dns_SoaRecord
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_nsname: t -> string [@@js.get "nsname"]
      val set_nsname: t -> string -> unit [@@js.set "nsname"]
      val get_hostmaster: t -> string [@@js.get "hostmaster"]
      val set_hostmaster: t -> string -> unit [@@js.set "hostmaster"]
      val get_serial: t -> float [@@js.get "serial"]
      val set_serial: t -> float -> unit [@@js.set "serial"]
      val get_refresh: t -> float [@@js.get "refresh"]
      val set_refresh: t -> float -> unit [@@js.set "refresh"]
      val get_retry: t -> float [@@js.get "retry"]
      val set_retry: t -> float -> unit [@@js.set "retry"]
      val get_expire: t -> float [@@js.get "expire"]
      val set_expire: t -> float -> unit [@@js.set "expire"]
      val get_minttl: t -> float [@@js.get "minttl"]
      val set_minttl: t -> float -> unit [@@js.set "minttl"]
    end
    module[@js.scope "AnySoaRecord"] AnySoaRecord : sig
      type t = dns_AnySoaRecord
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> ([`L_s8_SOA[@js "SOA"]] [@js.enum]) [@@js.get "type"]
      val set_type: t -> ([`L_s8_SOA] [@js.enum]) -> unit [@@js.set "type"]
      val cast: t -> dns_SoaRecord [@@js.cast]
    end
    module[@js.scope "SrvRecord"] SrvRecord : sig
      type t = dns_SrvRecord
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_priority: t -> float [@@js.get "priority"]
      val set_priority: t -> float -> unit [@@js.set "priority"]
      val get_weight: t -> float [@@js.get "weight"]
      val set_weight: t -> float -> unit [@@js.set "weight"]
      val get_port: t -> float [@@js.get "port"]
      val set_port: t -> float -> unit [@@js.set "port"]
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
    end
    module[@js.scope "AnySrvRecord"] AnySrvRecord : sig
      type t = dns_AnySrvRecord
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> ([`L_s9_SRV[@js "SRV"]] [@js.enum]) [@@js.get "type"]
      val set_type: t -> ([`L_s9_SRV] [@js.enum]) -> unit [@@js.set "type"]
      val cast: t -> dns_SrvRecord [@@js.cast]
    end
    module[@js.scope "AnyTxtRecord"] AnyTxtRecord : sig
      type t = dns_AnyTxtRecord
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> ([`L_s10_TXT[@js "TXT"]] [@js.enum]) [@@js.get "type"]
      val set_type: t -> ([`L_s10_TXT] [@js.enum]) -> unit [@@js.set "type"]
      val get_entries: t -> string list [@@js.get "entries"]
      val set_entries: t -> string list -> unit [@@js.set "entries"]
    end
    module[@js.scope "AnyNsRecord"] AnyNsRecord : sig
      type t = dns_AnyNsRecord
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> ([`L_s6_NS[@js "NS"]] [@js.enum]) [@@js.get "type"]
      val set_type: t -> ([`L_s6_NS] [@js.enum]) -> unit [@@js.set "type"]
      val get_value: t -> string [@@js.get "value"]
      val set_value: t -> string -> unit [@@js.set "value"]
    end
    module[@js.scope "AnyPtrRecord"] AnyPtrRecord : sig
      type t = dns_AnyPtrRecord
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> ([`L_s7_PTR[@js "PTR"]] [@js.enum]) [@@js.get "type"]
      val set_type: t -> ([`L_s7_PTR] [@js.enum]) -> unit [@@js.set "type"]
      val get_value: t -> string [@@js.get "value"]
      val set_value: t -> string -> unit [@@js.set "value"]
    end
    module[@js.scope "AnyCnameRecord"] AnyCnameRecord : sig
      type t = dns_AnyCnameRecord
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_type: t -> ([`L_s3_CNAME[@js "CNAME"]] [@js.enum]) [@@js.get "type"]
      val set_type: t -> ([`L_s3_CNAME] [@js.enum]) -> unit [@@js.set "type"]
      val get_value: t -> string [@@js.get "value"]
      val set_value: t -> string -> unit [@@js.set "value"]
    end
    module AnyRecord : sig
      type t = dns_AnyRecord
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    val resolve: hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.global "resolve"]
    val resolve: hostname:string -> rrtype:([`L_s0_A] [@js.enum]) -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.global "resolve"]
    val resolve: hostname:string -> rrtype:([`L_s1_AAAA] [@js.enum]) -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.global "resolve"]
    val resolve: hostname:string -> rrtype:([`L_s2_ANY] [@js.enum]) -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_AnyRecord list -> unit) -> unit [@@js.global "resolve"]
    val resolve: hostname:string -> rrtype:([`L_s3_CNAME] [@js.enum]) -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.global "resolve"]
    val resolve: hostname:string -> rrtype:([`L_s4_MX] [@js.enum]) -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_MxRecord list -> unit) -> unit [@@js.global "resolve"]
    val resolve: hostname:string -> rrtype:([`L_s5_NAPTR] [@js.enum]) -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_NaptrRecord list -> unit) -> unit [@@js.global "resolve"]
    val resolve: hostname:string -> rrtype:([`L_s6_NS] [@js.enum]) -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.global "resolve"]
    val resolve: hostname:string -> rrtype:([`L_s7_PTR] [@js.enum]) -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.global "resolve"]
    val resolve: hostname:string -> rrtype:([`L_s8_SOA] [@js.enum]) -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_SoaRecord -> unit) -> unit [@@js.global "resolve"]
    val resolve: hostname:string -> rrtype:([`L_s9_SRV] [@js.enum]) -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_SrvRecord list -> unit) -> unit [@@js.global "resolve"]
    val resolve: hostname:string -> rrtype:([`L_s10_TXT] [@js.enum]) -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list list -> unit) -> unit [@@js.global "resolve"]
    val resolve: hostname:string -> rrtype:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:(dns_SoaRecord, ((dns_AnyRecord, dns_MxRecord, dns_NaptrRecord, dns_SrvRecord) union4, string) or_array or_string) or_array -> unit) -> unit [@@js.global "resolve"]
    module[@js.scope "resolve"] Resolve : sig
      val __promisify__: hostname:string -> ?rrtype:([`L_s0_A | `L_s1_AAAA | `L_s3_CNAME | `L_s6_NS | `L_s7_PTR] [@js.enum]) -> unit -> string list Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: hostname:string -> rrtype:([`L_s2_ANY] [@js.enum]) -> dns_AnyRecord list Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: hostname:string -> rrtype:([`L_s4_MX] [@js.enum]) -> dns_MxRecord list Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: hostname:string -> rrtype:([`L_s5_NAPTR] [@js.enum]) -> dns_NaptrRecord list Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: hostname:string -> rrtype:([`L_s8_SOA] [@js.enum]) -> dns_SoaRecord Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: hostname:string -> rrtype:([`L_s9_SRV] [@js.enum]) -> dns_SrvRecord list Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: hostname:string -> rrtype:([`L_s10_TXT] [@js.enum]) -> string list list Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: hostname:string -> rrtype:string -> (dns_SoaRecord, ((dns_AnyRecord, dns_MxRecord, dns_NaptrRecord, dns_SrvRecord) union4, string) or_array or_string) or_array Promise.t_1 [@@js.global "__promisify__"]
    end
    val resolve4: hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.global "resolve4"]
    val resolve4: hostname:string -> options:dns_ResolveWithTtlOptions -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_RecordWithTtl list -> unit) -> unit [@@js.global "resolve4"]
    val resolve4: hostname:string -> options:dns_ResolveOptions -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_RecordWithTtl or_string list -> unit) -> unit [@@js.global "resolve4"]
    module[@js.scope "resolve4"] Resolve4 : sig
      val __promisify__: hostname:string -> string list Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: hostname:string -> options:dns_ResolveWithTtlOptions -> dns_RecordWithTtl list Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: hostname:string -> ?options:dns_ResolveOptions -> unit -> dns_RecordWithTtl or_string list Promise.t_1 [@@js.global "__promisify__"]
    end
    val resolve6: hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.global "resolve6"]
    val resolve6: hostname:string -> options:dns_ResolveWithTtlOptions -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_RecordWithTtl list -> unit) -> unit [@@js.global "resolve6"]
    val resolve6: hostname:string -> options:dns_ResolveOptions -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_RecordWithTtl or_string list -> unit) -> unit [@@js.global "resolve6"]
    module[@js.scope "resolve6"] Resolve6 : sig
      val __promisify__: hostname:string -> string list Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: hostname:string -> options:dns_ResolveWithTtlOptions -> dns_RecordWithTtl list Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: hostname:string -> ?options:dns_ResolveOptions -> unit -> dns_RecordWithTtl or_string list Promise.t_1 [@@js.global "__promisify__"]
    end
    val resolveCname: hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.global "resolveCname"]
    module[@js.scope "resolveCname"] ResolveCname : sig
      val __promisify__: hostname:string -> string list Promise.t_1 [@@js.global "__promisify__"]
    end
    val resolveMx: hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_MxRecord list -> unit) -> unit [@@js.global "resolveMx"]
    module[@js.scope "resolveMx"] ResolveMx : sig
      val __promisify__: hostname:string -> dns_MxRecord list Promise.t_1 [@@js.global "__promisify__"]
    end
    val resolveNaptr: hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_NaptrRecord list -> unit) -> unit [@@js.global "resolveNaptr"]
    module[@js.scope "resolveNaptr"] ResolveNaptr : sig
      val __promisify__: hostname:string -> dns_NaptrRecord list Promise.t_1 [@@js.global "__promisify__"]
    end
    val resolveNs: hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.global "resolveNs"]
    module[@js.scope "resolveNs"] ResolveNs : sig
      val __promisify__: hostname:string -> string list Promise.t_1 [@@js.global "__promisify__"]
    end
    val resolvePtr: hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.global "resolvePtr"]
    module[@js.scope "resolvePtr"] ResolvePtr : sig
      val __promisify__: hostname:string -> string list Promise.t_1 [@@js.global "__promisify__"]
    end
    val resolveSoa: hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> address:dns_SoaRecord -> unit) -> unit [@@js.global "resolveSoa"]
    module[@js.scope "resolveSoa"] ResolveSoa : sig
      val __promisify__: hostname:string -> dns_SoaRecord Promise.t_1 [@@js.global "__promisify__"]
    end
    val resolveSrv: hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_SrvRecord list -> unit) -> unit [@@js.global "resolveSrv"]
    module[@js.scope "resolveSrv"] ResolveSrv : sig
      val __promisify__: hostname:string -> dns_SrvRecord list Promise.t_1 [@@js.global "__promisify__"]
    end
    val resolveTxt: hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list list -> unit) -> unit [@@js.global "resolveTxt"]
    module[@js.scope "resolveTxt"] ResolveTxt : sig
      val __promisify__: hostname:string -> string list list Promise.t_1 [@@js.global "__promisify__"]
    end
    val resolveAny: hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_AnyRecord list -> unit) -> unit [@@js.global "resolveAny"]
    module[@js.scope "resolveAny"] ResolveAny : sig
      val __promisify__: hostname:string -> dns_AnyRecord list Promise.t_1 [@@js.global "__promisify__"]
    end
    val reverse: ip:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> hostnames:string list -> unit) -> unit [@@js.global "reverse"]
    val setServers: servers:string list -> unit [@@js.global "setServers"]
    val getServers: unit -> string list [@@js.global "getServers"]
    val nODATA: string [@@js.global "NODATA"]
    val fORMERR: string [@@js.global "FORMERR"]
    val sERVFAIL: string [@@js.global "SERVFAIL"]
    val nOTFOUND: string [@@js.global "NOTFOUND"]
    val nOTIMP: string [@@js.global "NOTIMP"]
    val rEFUSED: string [@@js.global "REFUSED"]
    val bADQUERY: string [@@js.global "BADQUERY"]
    val bADNAME: string [@@js.global "BADNAME"]
    val bADFAMILY: string [@@js.global "BADFAMILY"]
    val bADRESP: string [@@js.global "BADRESP"]
    val cONNREFUSED: string [@@js.global "CONNREFUSED"]
    val tIMEOUT: string [@@js.global "TIMEOUT"]
    val eOF: string [@@js.global "EOF"]
    val fILE: string [@@js.global "FILE"]
    val nOMEM: string [@@js.global "NOMEM"]
    val dESTRUCTION: string [@@js.global "DESTRUCTION"]
    val bADSTR: string [@@js.global "BADSTR"]
    val bADFLAGS: string [@@js.global "BADFLAGS"]
    val nONAME: string [@@js.global "NONAME"]
    val bADHINTS: string [@@js.global "BADHINTS"]
    val nOTINITIALIZED: string [@@js.global "NOTINITIALIZED"]
    val lOADIPHLPAPI: string [@@js.global "LOADIPHLPAPI"]
    val aDDRGETNETWORKPARAMS: string [@@js.global "ADDRGETNETWORKPARAMS"]
    val cANCELLED: string [@@js.global "CANCELLED"]
    module[@js.scope "ResolverOptions"] ResolverOptions : sig
      type t = dns_ResolverOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_timeout: t -> float [@@js.get "timeout"]
      val set_timeout: t -> float -> unit [@@js.set "timeout"]
    end
    module[@js.scope "Resolver"] Resolver : sig
      type t = dns_Resolver
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: ?options:dns_ResolverOptions -> unit -> t [@@js.create]
      val cancel: t -> unit [@@js.call "cancel"]
      val getServers: t -> string list [@@js.call "getServers"]
      val resolve: t -> hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.call "resolve"]
      val resolve4: t -> hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.call "resolve4"]
      val resolve6: t -> hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.call "resolve6"]
      val resolveAny: t -> hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_AnyRecord list -> unit) -> unit [@@js.call "resolveAny"]
      val resolveCname: t -> hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.call "resolveCname"]
      val resolveMx: t -> hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_MxRecord list -> unit) -> unit [@@js.call "resolveMx"]
      val resolveNaptr: t -> hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_NaptrRecord list -> unit) -> unit [@@js.call "resolveNaptr"]
      val resolveNs: t -> hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.call "resolveNs"]
      val resolvePtr: t -> hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list -> unit) -> unit [@@js.call "resolvePtr"]
      val resolveSoa: t -> hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> address:dns_SoaRecord -> unit) -> unit [@@js.call "resolveSoa"]
      val resolveSrv: t -> hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:dns_SrvRecord list -> unit) -> unit [@@js.call "resolveSrv"]
      val resolveTxt: t -> hostname:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> addresses:string list list -> unit) -> unit [@@js.call "resolveTxt"]
      val reverse: t -> ip:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> hostnames:string list -> unit) -> unit [@@js.call "reverse"]
      val setLocalAddress: t -> ?ipv4:string -> ?ipv6:string -> unit -> unit [@@js.call "setLocalAddress"]
      val setServers: t -> servers:string list -> unit [@@js.call "setServers"]
    end
    module[@js.scope "promises"] Promises : sig
      val getServers: unit -> string list [@@js.global "getServers"]
      val lookup: hostname:string -> family:float -> dns_LookupAddress Promise.t_1 [@@js.global "lookup"]
      val lookup: hostname:string -> options:dns_LookupOneOptions -> dns_LookupAddress Promise.t_1 [@@js.global "lookup"]
      val lookup: hostname:string -> options:dns_LookupAllOptions -> dns_LookupAddress list Promise.t_1 [@@js.global "lookup"]
      val lookup: hostname:string -> options:dns_LookupOptions -> (dns_LookupAddress, dns_LookupAddress) or_array Promise.t_1 [@@js.global "lookup"]
      val lookup: hostname:string -> dns_LookupAddress Promise.t_1 [@@js.global "lookup"]
      val lookupService: address:string -> port:float -> anonymous_interface_0 Promise.t_1 [@@js.global "lookupService"]
      val resolve: hostname:string -> string list Promise.t_1 [@@js.global "resolve"]
      val resolve: hostname:string -> rrtype:([`L_s0_A] [@js.enum]) -> string list Promise.t_1 [@@js.global "resolve"]
      val resolve: hostname:string -> rrtype:([`L_s1_AAAA] [@js.enum]) -> string list Promise.t_1 [@@js.global "resolve"]
      val resolve: hostname:string -> rrtype:([`L_s2_ANY] [@js.enum]) -> dns_AnyRecord list Promise.t_1 [@@js.global "resolve"]
      val resolve: hostname:string -> rrtype:([`L_s3_CNAME] [@js.enum]) -> string list Promise.t_1 [@@js.global "resolve"]
      val resolve: hostname:string -> rrtype:([`L_s4_MX] [@js.enum]) -> dns_MxRecord list Promise.t_1 [@@js.global "resolve"]
      val resolve: hostname:string -> rrtype:([`L_s5_NAPTR] [@js.enum]) -> dns_NaptrRecord list Promise.t_1 [@@js.global "resolve"]
      val resolve: hostname:string -> rrtype:([`L_s6_NS] [@js.enum]) -> string list Promise.t_1 [@@js.global "resolve"]
      val resolve: hostname:string -> rrtype:([`L_s7_PTR] [@js.enum]) -> string list Promise.t_1 [@@js.global "resolve"]
      val resolve: hostname:string -> rrtype:([`L_s8_SOA] [@js.enum]) -> dns_SoaRecord Promise.t_1 [@@js.global "resolve"]
      val resolve: hostname:string -> rrtype:([`L_s9_SRV] [@js.enum]) -> dns_SrvRecord list Promise.t_1 [@@js.global "resolve"]
      val resolve: hostname:string -> rrtype:([`L_s10_TXT] [@js.enum]) -> string list list Promise.t_1 [@@js.global "resolve"]
      val resolve: hostname:string -> rrtype:string -> (dns_SoaRecord, ((dns_AnyRecord, dns_MxRecord, dns_NaptrRecord, dns_SrvRecord) union4, string) or_array or_string) or_array Promise.t_1 [@@js.global "resolve"]
      val resolve4: hostname:string -> string list Promise.t_1 [@@js.global "resolve4"]
      val resolve4: hostname:string -> options:dns_ResolveWithTtlOptions -> dns_RecordWithTtl list Promise.t_1 [@@js.global "resolve4"]
      val resolve4: hostname:string -> options:dns_ResolveOptions -> dns_RecordWithTtl or_string list Promise.t_1 [@@js.global "resolve4"]
      val resolve6: hostname:string -> string list Promise.t_1 [@@js.global "resolve6"]
      val resolve6: hostname:string -> options:dns_ResolveWithTtlOptions -> dns_RecordWithTtl list Promise.t_1 [@@js.global "resolve6"]
      val resolve6: hostname:string -> options:dns_ResolveOptions -> dns_RecordWithTtl or_string list Promise.t_1 [@@js.global "resolve6"]
      val resolveAny: hostname:string -> dns_AnyRecord list Promise.t_1 [@@js.global "resolveAny"]
      val resolveCname: hostname:string -> string list Promise.t_1 [@@js.global "resolveCname"]
      val resolveMx: hostname:string -> dns_MxRecord list Promise.t_1 [@@js.global "resolveMx"]
      val resolveNaptr: hostname:string -> dns_NaptrRecord list Promise.t_1 [@@js.global "resolveNaptr"]
      val resolveNs: hostname:string -> string list Promise.t_1 [@@js.global "resolveNs"]
      val resolvePtr: hostname:string -> string list Promise.t_1 [@@js.global "resolvePtr"]
      val resolveSoa: hostname:string -> dns_SoaRecord Promise.t_1 [@@js.global "resolveSoa"]
      val resolveSrv: hostname:string -> dns_SrvRecord list Promise.t_1 [@@js.global "resolveSrv"]
      val resolveTxt: hostname:string -> string list list Promise.t_1 [@@js.global "resolveTxt"]
      val reverse: ip:string -> string list Promise.t_1 [@@js.global "reverse"]
      val setServers: servers:string list -> unit [@@js.global "setServers"]
      module[@js.scope "Resolver"] Resolver : sig
        type t = dns_promises_Resolver
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val create: ?options:dns_ResolverOptions -> unit -> t [@@js.create]
        val cancel: t -> unit [@@js.call "cancel"]
        val getServers: t -> string list [@@js.call "getServers"]
        val resolve: t -> hostname:string -> string list Promise.t_1 [@@js.call "resolve"]
        val resolve4: t -> hostname:string -> string list Promise.t_1 [@@js.call "resolve4"]
        val resolve6: t -> hostname:string -> string list Promise.t_1 [@@js.call "resolve6"]
        val resolveAny: t -> hostname:string -> dns_AnyRecord list Promise.t_1 [@@js.call "resolveAny"]
        val resolveCname: t -> hostname:string -> string list Promise.t_1 [@@js.call "resolveCname"]
        val resolveMx: t -> hostname:string -> dns_MxRecord list Promise.t_1 [@@js.call "resolveMx"]
        val resolveNaptr: t -> hostname:string -> dns_NaptrRecord list Promise.t_1 [@@js.call "resolveNaptr"]
        val resolveNs: t -> hostname:string -> string list Promise.t_1 [@@js.call "resolveNs"]
        val resolvePtr: t -> hostname:string -> string list Promise.t_1 [@@js.call "resolvePtr"]
        val resolveSoa: t -> hostname:string -> dns_SoaRecord Promise.t_1 [@@js.call "resolveSoa"]
        val resolveSrv: t -> hostname:string -> dns_SrvRecord list Promise.t_1 [@@js.call "resolveSrv"]
        val resolveTxt: t -> hostname:string -> string list list Promise.t_1 [@@js.call "resolveTxt"]
        val reverse: t -> ip:string -> string list Promise.t_1 [@@js.call "reverse"]
        val setLocalAddress: t -> ?ipv4:string -> ?ipv6:string -> unit -> unit [@@js.call "setLocalAddress"]
        val setServers: t -> servers:string list -> unit [@@js.call "setServers"]
      end
    end
  end
end
