[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2016

module Shared_array_buffer : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_byte_length : t -> int [@@js.get "byteLength"]

  val slice : t -> begin_:int -> ?end_:int -> unit -> t [@@js.call "slice"]

  (* Constructor *)

  val create : byte_length:int -> t [@@js.new "SharedArrayBuffer"]
end

module Shared_array_buffer_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> Shared_array_buffer.t [@@js.get "prototype"]

  val create : t -> byte_length:int -> Shared_array_buffer.t
    [@@js.apply_newable]
end
[@@js.scope "SharedArrayBufferConstructor"]

val shared_array_buffer : Shared_array_buffer_constructor.t
  [@@js.global "SharedArrayBuffer"]

module Array_buffer_types : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_shared_array_buffer : t -> Shared_array_buffer.t
    [@@js.get "SharedArrayBuffer"]

  val set_shared_array_buffer : t -> Shared_array_buffer.t -> unit
    [@@js.set "SharedArrayBuffer"]
end
[@@js.scope "ArrayBufferTypes"]

module Atomics : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val add :
       t
    -> typed_array:
         ( Int16_array.t
         , Int32_array.t
         , Int8_array.t
         , Uint16_array.t
         , Uint32_array.t
         , Uint8_array.t )
         union6
    -> index:int
    -> value:int
    -> int
    [@@js.call "add"]

  val and_ :
       t
    -> typed_array:
         ( Int16_array.t
         , Int32_array.t
         , Int8_array.t
         , Uint16_array.t
         , Uint32_array.t
         , Uint8_array.t )
         union6
    -> index:int
    -> value:int
    -> int
    [@@js.call "and"]

  val compare_exchange :
       t
    -> typed_array:
         ( Int16_array.t
         , Int32_array.t
         , Int8_array.t
         , Uint16_array.t
         , Uint32_array.t
         , Uint8_array.t )
         union6
    -> index:int
    -> expected_value:int
    -> replacement_value:int
    -> int
    [@@js.call "compareExchange"]

  val exchange :
       t
    -> typed_array:
         ( Int16_array.t
         , Int32_array.t
         , Int8_array.t
         , Uint16_array.t
         , Uint32_array.t
         , Uint8_array.t )
         union6
    -> index:int
    -> value:int
    -> int
    [@@js.call "exchange"]

  val is_lock_free : t -> size:int -> bool [@@js.call "isLockFree"]

  val load :
       t
    -> typed_array:
         ( Int16_array.t
         , Int32_array.t
         , Int8_array.t
         , Uint16_array.t
         , Uint32_array.t
         , Uint8_array.t )
         union6
    -> index:int
    -> int
    [@@js.call "load"]

  val or_ :
       t
    -> typed_array:
         ( Int16_array.t
         , Int32_array.t
         , Int8_array.t
         , Uint16_array.t
         , Uint32_array.t
         , Uint8_array.t )
         union6
    -> index:int
    -> value:int
    -> int
    [@@js.call "or"]

  val store :
       t
    -> typed_array:
         ( Int16_array.t
         , Int32_array.t
         , Int8_array.t
         , Uint16_array.t
         , Uint32_array.t
         , Uint8_array.t )
         union6
    -> index:int
    -> value:int
    -> int
    [@@js.call "store"]

  val sub :
       t
    -> typed_array:
         ( Int16_array.t
         , Int32_array.t
         , Int8_array.t
         , Uint16_array.t
         , Uint32_array.t
         , Uint8_array.t )
         union6
    -> index:int
    -> value:int
    -> int
    [@@js.call "sub"]

  val wait :
       t
    -> typed_array:Int32_array.t
    -> index:int
    -> value:int
    -> ?timeout:int
    -> unit
    -> ([ `not_equal [@js "not-equal"]
        | `ok [@js "ok"]
        | `timed_out [@js "timed-out"]
        ]
       [@js.enum])
    [@@js.call "wait"]

  val notify :
    t -> typed_array:Int32_array.t -> index:int -> ?count:int -> unit -> int
    [@@js.call "notify"]

  val xor :
       t
    -> typed_array:
         ( Int16_array.t
         , Int32_array.t
         , Int8_array.t
         , Uint16_array.t
         , Uint32_array.t
         , Uint8_array.t )
         union6
    -> index:int
    -> value:int
    -> int
    [@@js.call "xor"]
end
[@@js.scope "Atomics"]

val atomics : Atomics.t [@@js.global "Atomics"]
