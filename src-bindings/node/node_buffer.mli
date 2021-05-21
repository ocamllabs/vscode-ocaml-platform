[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_max_length : t -> int [@@js.get "MAX_LENGTH"]

  val set_max_length : t -> int -> unit [@@js.set "MAX_LENGTH"]

  val get_max_string_length : t -> int [@@js.get "MAX_STRING_LENGTH"]

  val set_max_string_length : t -> int -> unit [@@js.set "MAX_STRING_LENGTH"]
end

module Anonymous_interface1 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create : t -> size:int -> Buffer.t [@@js.apply_newable]

  val get_prototype : t -> Buffer.t [@@js.get "prototype"]

  val set_prototype : t -> Buffer.t -> unit [@@js.set "prototype"]
end

module Buffer : sig
  val inspect_max_bytes : int [@@js.global "INSPECT_MAX_BYTES"]

  val k_max_length : int [@@js.global "kMaxLength"]

  val k_string_max_length : int [@@js.global "kStringMaxLength"]

  val constants : Anonymous_interface0.t [@@js.global "constants"]

  val buff_type : (* FIXME: unknown type 'typeof Buffer' *) any
    [@@js.global "BuffType"]

  module Transcode_encoding : sig
    type t =
      ([ `ascii [@js "ascii"]
       | `binary [@js "binary"]
       | `latin1 [@js "latin1"]
       | `ucs2 [@js "ucs2"]
       | `utf16le [@js "utf16le"]
       | `utf8 [@js "utf8"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  val transcode :
       source:Uint8_array.t
    -> from_enc:Transcode_encoding.t
    -> to_enc:Transcode_encoding.t
    -> Buffer.t
    [@@js.global "transcode"]

  val slow_buffer : Anonymous_interface1.t [@@js.global "SlowBuffer"]
  (* export { BuffType as Buffer }; *)
end
[@@js.scope Import.buffer]
