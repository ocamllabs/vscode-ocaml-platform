[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020

module Punycode : sig
  val decode : string:string -> string [@@js.global "decode"]

  val encode : string:string -> string [@@js.global "encode"]

  val to_unicode : domain:string -> string [@@js.global "toUnicode"]

  val to_ascii : domain:string -> string [@@js.global "toASCII"]

  module Ucs2 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val decode : t -> string:string -> int list [@@js.call "decode"]

    val encode : t -> code_points:int list -> string [@@js.call "encode"]
  end
  [@@js.scope "ucs2"]

  val ucs2 : Ucs2.t [@@js.global "ucs2"]

  val version : string [@@js.global "version"]
end
[@@js.scope Import.punycode]
