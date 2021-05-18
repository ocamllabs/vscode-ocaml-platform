[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - NodeJS.Dict<T1>
 *)
[@@@js.stop]
module type Missing = sig
  module NodeJS : sig
    module Dict : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module NodeJS : sig
      module Dict : sig
        type 'T1 t_1
        val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
        val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
      end
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
      type querystring_ParseOptions = [`Querystring_ParseOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and querystring_ParsedUrlQuery = [`Querystring_ParsedUrlQuery] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and querystring_ParsedUrlQueryInput = [`Querystring_ParsedUrlQueryInput] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and querystring_StringifyOptions = [`Querystring_StringifyOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "node:querystring"] Node_querystring : sig
    (* export * from 'querystring'; *)
  end
  module[@js.scope "querystring"] Querystring : sig
    module[@js.scope "StringifyOptions"] StringifyOptions : sig
      type t = querystring_StringifyOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val encodeURIComponent: t -> str:string -> string [@@js.call "encodeURIComponent"]
    end
    module[@js.scope "ParseOptions"] ParseOptions : sig
      type t = querystring_ParseOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_maxKeys: t -> float [@@js.get "maxKeys"]
      val set_maxKeys: t -> float -> unit [@@js.set "maxKeys"]
      val decodeURIComponent: t -> str:string -> string [@@js.call "decodeURIComponent"]
    end
    module[@js.scope "ParsedUrlQuery"] ParsedUrlQuery : sig
      type t = querystring_ParsedUrlQuery
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val cast: t -> string list or_string NodeJS.Dict.t_1 [@@js.cast]
    end
    module[@js.scope "ParsedUrlQueryInput"] ParsedUrlQueryInput : sig
      type t = querystring_ParsedUrlQueryInput
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val cast: t -> (string list, bool list, float list) union3 or_boolean or_string or_number or_null NodeJS.Dict.t_1 [@@js.cast]
    end
    val stringify: ?obj:querystring_ParsedUrlQueryInput -> ?sep:string -> ?eq:string -> ?options:querystring_StringifyOptions -> unit -> string [@@js.global "stringify"]
    val parse: str:string -> ?sep:string -> ?eq:string -> ?options:querystring_ParseOptions -> unit -> querystring_ParsedUrlQuery [@@js.global "parse"]
    val encode: ?obj:querystring_ParsedUrlQueryInput -> ?sep:string -> ?eq:string -> ?options:querystring_StringifyOptions -> unit -> string [@@js.global "encode"]
    val decode: str:string -> ?sep:string -> ?eq:string -> ?options:querystring_ParseOptions -> unit -> querystring_ParsedUrlQuery [@@js.global "decode"]
    val escape: str:string -> string [@@js.global "escape"]
    val unescape: str:string -> string [@@js.global "unescape"]
  end
end
