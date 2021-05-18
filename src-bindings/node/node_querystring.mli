[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Querystring : sig
  module Stringify_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val encode_uri_component : t -> str:string -> string
      [@@js.call "encodeURIComponent"]
  end
  [@@js.scope "StringifyOptions"]

  module Parse_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_max_keys : t -> int [@@js.get "maxKeys"]

    val set_max_keys : t -> int -> unit [@@js.set "maxKeys"]

    val decode_uri_component : t -> str:string -> string
      [@@js.call "decodeURIComponent"]
  end
  [@@js.scope "ParseOptions"]

  module Parsed_url_query : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val cast : t -> string list Dict.t [@@js.cast]
  end

  module Parsed_url_query_input : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val cast :
         t
      -> (string list, bool list, int list) union3 or_boolean or_string
         or_number
         or_null
         Dict.t
      [@@js.cast]
  end
  [@@js.scope "ParsedUrlQueryInput"]

  val stringify :
       ?obj:Parsed_url_query_input.t
    -> ?sep:string
    -> ?eq:string
    -> ?options:Stringify_options.t
    -> unit
    -> string
    [@@js.global "stringify"]

  val parse :
       str:string
    -> ?sep:string
    -> ?eq:string
    -> ?options:Parse_options.t
    -> unit
    -> Parsed_url_query.t
    [@@js.global "parse"]

  val encode :
       ?obj:Parsed_url_query_input.t
    -> ?sep:string
    -> ?eq:string
    -> ?options:Stringify_options.t
    -> unit
    -> string
    [@@js.global "encode"]

  val decode :
       str:string
    -> ?sep:string
    -> ?eq:string
    -> ?options:Parse_options.t
    -> unit
    -> Parsed_url_query.t
    [@@js.global "decode"]

  val escape : str:string -> string [@@js.global "escape"]

  val unescape : str:string -> string [@@js.global "unescape"]
end
[@@js.scope Import.querystring]
