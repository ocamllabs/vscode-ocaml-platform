[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module String_decoder : sig
  module String_decoder : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create : ?encoding:Buffer_encoding.t -> unit -> t [@@js.create]

    val write : t -> buffer:Buffer.t -> string [@@js.call "write"]

    val end_ : t -> ?buffer:Buffer.t -> unit -> string [@@js.call "end"]
  end
  [@@js.scope "StringDecoder"]
end
[@@js.scope Import.string_decoder]
