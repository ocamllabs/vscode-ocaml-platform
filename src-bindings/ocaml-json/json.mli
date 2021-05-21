type t = Es5.Json.t

exception Decode_error of string

(** Try to parse the string into JSON, return [Some] if successful, [None]
    otherwise *)
val try_parse_opt : string -> t option

(** Try to parse the string into JSON, raise {!Decode_error} if it fails *)
val try_parse_exn : string -> t

(** Use [JSON.stringify] to turn JSON into a string. Specify [spaces] to control
    the indentation size. *)
val stringify : ?spaces:int -> t -> string

module Decode : sig
  (** The type for decoder functions which turn JSON into an OCaml value
      functions that are unsuccessful in decoding the JSON raise [Decode_error] *)
  type 'a decoder = t -> 'a

  (** Identity decoder returns its argument unchanged *)
  val id : t decoder

  (** Only decode a JSON [null] *)
  val null : 'a option decoder

  (** Decode [true] or [false] *)
  val bool : bool decoder

  (** Decode a JSON number *)
  val float : float decoder

  (** Decode a finite non-decimal JSON number *)
  val int : int decoder

  (** Decode a JSON string *)
  val string : string decoder

  (** Decode a single-character JSON string *)
  val char : char decoder

  (** Transform a decoder so it decodes nulls as [None] and other decoded values
      as [Some] *)
  val nullable : 'a decoder -> 'a option decoder

  (** Decode a JSON array of values based on the given decoder *)
  val array : 'a decoder -> 'a array decoder

  (** Decode an JSON array of values as a list *)
  val list : 'a decoder -> 'a list decoder

  (** Decode a 2-element JSON array with the given decoders *)
  val pair : 'a decoder -> 'b decoder -> ('a * 'b) decoder

  (** Decode a 2-element JSON array with the given decoders *)
  val tuple2 : 'a decoder -> 'b decoder -> ('a * 'b) decoder

  (** Decode a 3-element JSON array with the given decoders *)
  val tuple3 : 'a decoder -> 'b decoder -> 'c decoder -> ('a * 'b * 'c) decoder

  (** Decode a 4-element JSON array with the given decoders *)
  val tuple4 :
       'a decoder
    -> 'b decoder
    -> 'c decoder
    -> 'd decoder
    -> ('a * 'b * 'c * 'd) decoder

  (** Decode a JSON dictionary as a hash table of strings to decoded values *)
  val dict : 'a decoder -> (string, 'a) Hashtbl.t decoder

  (** Decode an element of a JSON dictionary with the decoder *)
  val field : string -> 'a decoder -> 'a decoder

  (** Follow a list of field names and decode the final element with the decoder *)
  val at : string list -> 'a decoder -> 'a decoder

  (** Catch [Decode_error], return [None] if raised *)
  val try_optional : 'a decoder -> 'a option decoder

  (** Catch [Decode_error], return a default value if raised *)
  val try_default : 'a -> 'a decoder -> 'a decoder

  (** Try a list of decoders until one succeeds, raise [Decode_error] if none
      succeed *)
  val any : 'a decoder list -> 'a decoder

  (** Try two decoders, raise [Decode_error] if neither succeed *)
  val either : 'a decoder -> 'a decoder -> 'a decoder

  (** Apply a function to the result of the decoder *)
  val map : ('a -> 'b) -> 'a decoder -> 'b decoder

  (** Apply the decoder returned from the function *)
  val bind : ('a -> 'b decoder) -> 'a decoder -> 'b decoder
end

module Encode : sig
  (** The type for encoder functions which turn ocaml values into JSON *)
  type 'a encoder = 'a -> t

  (** Identity encoder which returns its argument unchanged *)
  val id : t encoder

  (** The null JSON value *)
  val null : t

  (** Encode a boolean into a JSON boolean *)
  val bool : bool encoder

  (** Encode a float as a JSON number *)
  val float : float encoder

  (** encode an integer as JSON number *)
  val int : int encoder

  (** Encode a string as a JSON string *)
  val string : string encoder

  (** Encode a character as a JSON string *)
  val char : char encoder

  (** Encode a value with the decoder if [Some], return a JSON null if [None] *)
  val nullable : 'a encoder -> 'a option encoder

  (** Encode an array as a JSON array *)
  val array : 'a encoder -> 'a array encoder

  (** Encode a list as a JSON array *)
  val list : 'a encoder -> 'a list encoder

  (** Encode a 2-element tuple as a JSON array *)
  val pair : 'a encoder -> 'b encoder -> ('a * 'b) encoder

  (** Encode a 2-element tuple as a JSON array *)
  val tuple2 : 'a encoder -> 'b encoder -> ('a * 'b) encoder

  (** Encode a 3-element tuple as a JSON array *)
  val tuple3 : 'a encoder -> 'b encoder -> 'c encoder -> ('a * 'b * 'c) encoder

  (** Encode a 4-element tuple as a JSON array *)
  val tuple4 :
       'a encoder
    -> 'b encoder
    -> 'c encoder
    -> 'd encoder
    -> ('a * 'b * 'c * 'd) encoder

  (** Encode a hash table as a JSON dict *)
  val dict : 'a encoder -> (string, 'a) Hashtbl.t encoder

  (** Encode the pairs of keys and values as a JSON dict *)
  val object_ : (string * t) list encoder
end

(** {1 Compatibility with gen_js_api} *)

val t_of_js : Ojs.t -> t

val t_to_js : t -> Ojs.t
