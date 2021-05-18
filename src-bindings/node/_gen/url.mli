[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - Iterable<T1>
  - IterableIterator<T1>
  - NodeJS.Dict<T1>
  - ParsedUrlQuery
  - ParsedUrlQueryInput
 *)
[@@@js.stop]
module type Missing = sig
  module Iterable : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module IterableIterator : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module NodeJS : sig
    module Dict : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
  end
  module ParsedUrlQuery : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module ParsedUrlQueryInput : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module Iterable : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module IterableIterator : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module NodeJS : sig
      module Dict : sig
        type 'T1 t_1
        val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
        val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
      end
    end
    module ParsedUrlQuery : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ParsedUrlQueryInput : sig
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
      type url_URL = [`Url_URL] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and url_URLFormatOptions = [`Url_URLFormatOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and url_URLSearchParams = [`Url_URLSearchParams] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and url_Url = [`Url_Url] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and url_UrlObject = [`Url_UrlObject] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and url_UrlWithParsedQuery = [`Url_UrlWithParsedQuery | `Url_Url] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and url_UrlWithStringQuery = [`Url_UrlWithStringQuery | `Url_Url] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "node:url"] Node_url : sig
    (* export * from 'url'; *)
  end
  module[@js.scope "url"] Url : sig
    (* import { ParsedUrlQuery, ParsedUrlQueryInput } from 'node:querystring'; *)
    module[@js.scope "UrlObject"] UrlObject : sig
      type t = url_UrlObject
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_auth: t -> string or_null [@@js.get "auth"]
      val set_auth: t -> string or_null -> unit [@@js.set "auth"]
      val get_hash: t -> string or_null [@@js.get "hash"]
      val set_hash: t -> string or_null -> unit [@@js.set "hash"]
      val get_host: t -> string or_null [@@js.get "host"]
      val set_host: t -> string or_null -> unit [@@js.set "host"]
      val get_hostname: t -> string or_null [@@js.get "hostname"]
      val set_hostname: t -> string or_null -> unit [@@js.set "hostname"]
      val get_href: t -> string or_null [@@js.get "href"]
      val set_href: t -> string or_null -> unit [@@js.set "href"]
      val get_pathname: t -> string or_null [@@js.get "pathname"]
      val set_pathname: t -> string or_null -> unit [@@js.set "pathname"]
      val get_protocol: t -> string or_null [@@js.get "protocol"]
      val set_protocol: t -> string or_null -> unit [@@js.set "protocol"]
      val get_search: t -> string or_null [@@js.get "search"]
      val set_search: t -> string or_null -> unit [@@js.set "search"]
      val get_slashes: t -> bool or_null [@@js.get "slashes"]
      val set_slashes: t -> bool or_null -> unit [@@js.set "slashes"]
      val get_port: t -> string or_number or_null [@@js.get "port"]
      val set_port: t -> string or_number or_null -> unit [@@js.set "port"]
      val get_query: t -> ParsedUrlQueryInput.t_0 or_string or_null [@@js.get "query"]
      val set_query: t -> ParsedUrlQueryInput.t_0 or_string or_null -> unit [@@js.set "query"]
    end
    module[@js.scope "Url"] Url : sig
      type t = url_Url
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_auth: t -> string or_null [@@js.get "auth"]
      val set_auth: t -> string or_null -> unit [@@js.set "auth"]
      val get_hash: t -> string or_null [@@js.get "hash"]
      val set_hash: t -> string or_null -> unit [@@js.set "hash"]
      val get_host: t -> string or_null [@@js.get "host"]
      val set_host: t -> string or_null -> unit [@@js.set "host"]
      val get_hostname: t -> string or_null [@@js.get "hostname"]
      val set_hostname: t -> string or_null -> unit [@@js.set "hostname"]
      val get_href: t -> string [@@js.get "href"]
      val set_href: t -> string -> unit [@@js.set "href"]
      val get_path: t -> string or_null [@@js.get "path"]
      val set_path: t -> string or_null -> unit [@@js.set "path"]
      val get_pathname: t -> string or_null [@@js.get "pathname"]
      val set_pathname: t -> string or_null -> unit [@@js.set "pathname"]
      val get_protocol: t -> string or_null [@@js.get "protocol"]
      val set_protocol: t -> string or_null -> unit [@@js.set "protocol"]
      val get_search: t -> string or_null [@@js.get "search"]
      val set_search: t -> string or_null -> unit [@@js.set "search"]
      val get_slashes: t -> bool or_null [@@js.get "slashes"]
      val set_slashes: t -> bool or_null -> unit [@@js.set "slashes"]
      val get_port: t -> string or_null [@@js.get "port"]
      val set_port: t -> string or_null -> unit [@@js.set "port"]
      val get_query: t -> ParsedUrlQuery.t_0 or_string or_null [@@js.get "query"]
      val set_query: t -> ParsedUrlQuery.t_0 or_string or_null -> unit [@@js.set "query"]
    end
    module[@js.scope "UrlWithParsedQuery"] UrlWithParsedQuery : sig
      type t = url_UrlWithParsedQuery
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_query: t -> ParsedUrlQuery.t_0 [@@js.get "query"]
      val set_query: t -> ParsedUrlQuery.t_0 -> unit [@@js.set "query"]
      val cast: t -> url_Url [@@js.cast]
    end
    module[@js.scope "UrlWithStringQuery"] UrlWithStringQuery : sig
      type t = url_UrlWithStringQuery
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_query: t -> string or_null [@@js.get "query"]
      val set_query: t -> string or_null -> unit [@@js.set "query"]
      val cast: t -> url_Url [@@js.cast]
    end
    val parse: urlStr:string -> url_UrlWithStringQuery [@@js.global "parse"]
    val parse: urlStr:string -> parseQueryString:([`L_b_false] [@js.enum]) or_undefined -> ?slashesDenoteHost:bool -> unit -> url_UrlWithStringQuery [@@js.global "parse"]
    val parse: urlStr:string -> parseQueryString:([`L_b_true] [@js.enum]) -> ?slashesDenoteHost:bool -> unit -> url_UrlWithParsedQuery [@@js.global "parse"]
    val parse: urlStr:string -> parseQueryString:bool -> ?slashesDenoteHost:bool -> unit -> url_Url [@@js.global "parse"]
    val format: uRL:url_URL -> ?options:url_URLFormatOptions -> unit -> string [@@js.global "format"]
    val format: urlObject:url_UrlObject or_string -> string [@@js.global "format"]
    val resolve: from:string -> to_:string -> string [@@js.global "resolve"]
    val domainToASCII: domain:string -> string [@@js.global "domainToASCII"]
    val domainToUnicode: domain:string -> string [@@js.global "domainToUnicode"]
    val fileURLToPath: url:url_URL or_string -> string [@@js.global "fileURLToPath"]
    val pathToFileURL: url:string -> url_URL [@@js.global "pathToFileURL"]
    module[@js.scope "URLFormatOptions"] URLFormatOptions : sig
      type t = url_URLFormatOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_auth: t -> bool [@@js.get "auth"]
      val set_auth: t -> bool -> unit [@@js.set "auth"]
      val get_fragment: t -> bool [@@js.get "fragment"]
      val set_fragment: t -> bool -> unit [@@js.set "fragment"]
      val get_search: t -> bool [@@js.get "search"]
      val set_search: t -> bool -> unit [@@js.set "search"]
      val get_unicode: t -> bool [@@js.get "unicode"]
      val set_unicode: t -> bool -> unit [@@js.set "unicode"]
    end
    module[@js.scope "URL"] URL : sig
      type t = url_URL
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: input:string -> ?base:t or_string -> unit -> t [@@js.create]
      val get_hash: t -> string [@@js.get "hash"]
      val set_hash: t -> string -> unit [@@js.set "hash"]
      val get_host: t -> string [@@js.get "host"]
      val set_host: t -> string -> unit [@@js.set "host"]
      val get_hostname: t -> string [@@js.get "hostname"]
      val set_hostname: t -> string -> unit [@@js.set "hostname"]
      val get_href: t -> string [@@js.get "href"]
      val set_href: t -> string -> unit [@@js.set "href"]
      val get_origin: t -> string [@@js.get "origin"]
      val get_password: t -> string [@@js.get "password"]
      val set_password: t -> string -> unit [@@js.set "password"]
      val get_pathname: t -> string [@@js.get "pathname"]
      val set_pathname: t -> string -> unit [@@js.set "pathname"]
      val get_port: t -> string [@@js.get "port"]
      val set_port: t -> string -> unit [@@js.set "port"]
      val get_protocol: t -> string [@@js.get "protocol"]
      val set_protocol: t -> string -> unit [@@js.set "protocol"]
      val get_search: t -> string [@@js.get "search"]
      val set_search: t -> string -> unit [@@js.set "search"]
      val get_searchParams: t -> url_URLSearchParams [@@js.get "searchParams"]
      val get_username: t -> string [@@js.get "username"]
      val set_username: t -> string -> unit [@@js.set "username"]
      val toString: t -> string [@@js.call "toString"]
      val toJSON: t -> string [@@js.call "toJSON"]
    end
    module[@js.scope "URLSearchParams"] URLSearchParams : sig
      type t = url_URLSearchParams
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: ?init:(t, (string * string) Iterable.t_1, string list or_string NodeJS.Dict.t_1, (string * string) list) union4 or_string -> unit -> t [@@js.create]
      val append: t -> name:string -> value:string -> unit [@@js.call "append"]
      val delete: t -> name:string -> unit [@@js.call "delete"]
      val entries: t -> (string * string) IterableIterator.t_1 [@@js.call "entries"]
      val forEach: t -> callback:(value:string -> name:string -> searchParams:t -> unit) -> unit [@@js.call "forEach"]
      val get_: t -> name:string -> string or_null [@@js.call "get"]
      val getAll: t -> name:string -> string list [@@js.call "getAll"]
      val has: t -> name:string -> bool [@@js.call "has"]
      val keys: t -> string IterableIterator.t_1 [@@js.call "keys"]
      val set_: t -> name:string -> value:string -> unit [@@js.call "set"]
      val sort: t -> unit [@@js.call "sort"]
      val toString: t -> string [@@js.call "toString"]
      val values: t -> string IterableIterator.t_1 [@@js.call "values"]
      val _Symbol_iterator_: t -> (string * string) IterableIterator.t_1 [@@js.call "[Symbol.iterator]"]
      val cast: t -> (string * string) Iterable.t_1 [@@js.cast]
    end
  end
end
