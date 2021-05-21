[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2019

module Big_int_to_locale_string_options : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_locale_matcher : t -> string [@@js.get "localeMatcher"]

  val set_locale_matcher : t -> string -> unit [@@js.set "localeMatcher"]

  val get_style : t -> string [@@js.get "style"]

  val set_style : t -> string -> unit [@@js.set "style"]

  val get_numbering_system : t -> string [@@js.get "numberingSystem"]

  val set_numbering_system : t -> string -> unit [@@js.set "numberingSystem"]

  val get_unit : t -> string [@@js.get "unit"]

  val set_unit : t -> string -> unit [@@js.set "unit"]

  val get_unit_display : t -> string [@@js.get "unitDisplay"]

  val set_unit_display : t -> string -> unit [@@js.set "unitDisplay"]

  val get_currency : t -> string [@@js.get "currency"]

  val set_currency : t -> string -> unit [@@js.set "currency"]

  val get_currency_display : t -> string [@@js.get "currencyDisplay"]

  val set_currency_display : t -> string -> unit [@@js.set "currencyDisplay"]

  val get_use_grouping : t -> bool [@@js.get "useGrouping"]

  val set_use_grouping : t -> bool -> unit [@@js.set "useGrouping"]

  val get_minimum_integer_digits :
       t
    -> ([ `L_n_1 [@js 1]
        | `L_n_2 [@js 2]
        | `L_n_3 [@js 3]
        | `L_n_4 [@js 4]
        | `L_n_5 [@js 5]
        | `L_n_6 [@js 6]
        | `L_n_7 [@js 7]
        | `L_n_8 [@js 8]
        | `L_n_9 [@js 9]
        | `L_n_10 [@js 10]
        | `L_n_11 [@js 11]
        | `L_n_12 [@js 12]
        | `L_n_13 [@js 13]
        | `L_n_14 [@js 14]
        | `L_n_15 [@js 15]
        | `L_n_16 [@js 16]
        | `L_n_17 [@js 17]
        | `L_n_18 [@js 18]
        | `L_n_19 [@js 19]
        | `L_n_20 [@js 20]
        | `L_n_21 [@js 21]
        ]
       [@js.enum])
    [@@js.get "minimumIntegerDigits"]

  val set_minimum_integer_digits :
       t
    -> ([ `L_n_1
        | `L_n_2
        | `L_n_3
        | `L_n_4
        | `L_n_5
        | `L_n_6
        | `L_n_7
        | `L_n_8
        | `L_n_9
        | `L_n_10
        | `L_n_11
        | `L_n_12
        | `L_n_13
        | `L_n_14
        | `L_n_15
        | `L_n_16
        | `L_n_17
        | `L_n_18
        | `L_n_19
        | `L_n_20
        | `L_n_21
        ]
       [@js.enum])
    -> unit
    [@@js.set "minimumIntegerDigits"]

  val get_minimum_fraction_digits :
       t
    -> ([ `L_n_0 [@js 0]
        | `L_n_1 [@js 1]
        | `L_n_2 [@js 2]
        | `L_n_3 [@js 3]
        | `L_n_4 [@js 4]
        | `L_n_5 [@js 5]
        | `L_n_6 [@js 6]
        | `L_n_7 [@js 7]
        | `L_n_8 [@js 8]
        | `L_n_9 [@js 9]
        | `L_n_10 [@js 10]
        | `L_n_11 [@js 11]
        | `L_n_12 [@js 12]
        | `L_n_13 [@js 13]
        | `L_n_14 [@js 14]
        | `L_n_15 [@js 15]
        | `L_n_16 [@js 16]
        | `L_n_17 [@js 17]
        | `L_n_18 [@js 18]
        | `L_n_19 [@js 19]
        | `L_n_20 [@js 20]
        ]
       [@js.enum])
    [@@js.get "minimumFractionDigits"]

  val set_minimum_fraction_digits :
       t
    -> ([ `L_n_0
        | `L_n_1
        | `L_n_2
        | `L_n_3
        | `L_n_4
        | `L_n_5
        | `L_n_6
        | `L_n_7
        | `L_n_8
        | `L_n_9
        | `L_n_10
        | `L_n_11
        | `L_n_12
        | `L_n_13
        | `L_n_14
        | `L_n_15
        | `L_n_16
        | `L_n_17
        | `L_n_18
        | `L_n_19
        | `L_n_20
        ]
       [@js.enum])
    -> unit
    [@@js.set "minimumFractionDigits"]

  val get_maximum_fraction_digits :
       t
    -> ([ `L_n_0 [@js 0]
        | `L_n_1 [@js 1]
        | `L_n_2 [@js 2]
        | `L_n_3 [@js 3]
        | `L_n_4 [@js 4]
        | `L_n_5 [@js 5]
        | `L_n_6 [@js 6]
        | `L_n_7 [@js 7]
        | `L_n_8 [@js 8]
        | `L_n_9 [@js 9]
        | `L_n_10 [@js 10]
        | `L_n_11 [@js 11]
        | `L_n_12 [@js 12]
        | `L_n_13 [@js 13]
        | `L_n_14 [@js 14]
        | `L_n_15 [@js 15]
        | `L_n_16 [@js 16]
        | `L_n_17 [@js 17]
        | `L_n_18 [@js 18]
        | `L_n_19 [@js 19]
        | `L_n_20 [@js 20]
        ]
       [@js.enum])
    [@@js.get "maximumFractionDigits"]

  val set_maximum_fraction_digits :
       t
    -> ([ `L_n_0
        | `L_n_1
        | `L_n_2
        | `L_n_3
        | `L_n_4
        | `L_n_5
        | `L_n_6
        | `L_n_7
        | `L_n_8
        | `L_n_9
        | `L_n_10
        | `L_n_11
        | `L_n_12
        | `L_n_13
        | `L_n_14
        | `L_n_15
        | `L_n_16
        | `L_n_17
        | `L_n_18
        | `L_n_19
        | `L_n_20
        ]
       [@js.enum])
    -> unit
    [@@js.set "maximumFractionDigits"]

  val get_minimum_significant_digits :
       t
    -> ([ `L_n_1 [@js 1]
        | `L_n_2 [@js 2]
        | `L_n_3 [@js 3]
        | `L_n_4 [@js 4]
        | `L_n_5 [@js 5]
        | `L_n_6 [@js 6]
        | `L_n_7 [@js 7]
        | `L_n_8 [@js 8]
        | `L_n_9 [@js 9]
        | `L_n_10 [@js 10]
        | `L_n_11 [@js 11]
        | `L_n_12 [@js 12]
        | `L_n_13 [@js 13]
        | `L_n_14 [@js 14]
        | `L_n_15 [@js 15]
        | `L_n_16 [@js 16]
        | `L_n_17 [@js 17]
        | `L_n_18 [@js 18]
        | `L_n_19 [@js 19]
        | `L_n_20 [@js 20]
        | `L_n_21 [@js 21]
        ]
       [@js.enum])
    [@@js.get "minimumSignificantDigits"]

  val set_minimum_significant_digits :
       t
    -> ([ `L_n_1
        | `L_n_2
        | `L_n_3
        | `L_n_4
        | `L_n_5
        | `L_n_6
        | `L_n_7
        | `L_n_8
        | `L_n_9
        | `L_n_10
        | `L_n_11
        | `L_n_12
        | `L_n_13
        | `L_n_14
        | `L_n_15
        | `L_n_16
        | `L_n_17
        | `L_n_18
        | `L_n_19
        | `L_n_20
        | `L_n_21
        ]
       [@js.enum])
    -> unit
    [@@js.set "minimumSignificantDigits"]

  val get_maximum_significant_digits :
       t
    -> ([ `L_n_1 [@js 1]
        | `L_n_2 [@js 2]
        | `L_n_3 [@js 3]
        | `L_n_4 [@js 4]
        | `L_n_5 [@js 5]
        | `L_n_6 [@js 6]
        | `L_n_7 [@js 7]
        | `L_n_8 [@js 8]
        | `L_n_9 [@js 9]
        | `L_n_10 [@js 10]
        | `L_n_11 [@js 11]
        | `L_n_12 [@js 12]
        | `L_n_13 [@js 13]
        | `L_n_14 [@js 14]
        | `L_n_15 [@js 15]
        | `L_n_16 [@js 16]
        | `L_n_17 [@js 17]
        | `L_n_18 [@js 18]
        | `L_n_19 [@js 19]
        | `L_n_20 [@js 20]
        | `L_n_21 [@js 21]
        ]
       [@js.enum])
    [@@js.get "maximumSignificantDigits"]

  val set_maximum_significant_digits :
       t
    -> ([ `L_n_1
        | `L_n_2
        | `L_n_3
        | `L_n_4
        | `L_n_5
        | `L_n_6
        | `L_n_7
        | `L_n_8
        | `L_n_9
        | `L_n_10
        | `L_n_11
        | `L_n_12
        | `L_n_13
        | `L_n_14
        | `L_n_15
        | `L_n_16
        | `L_n_17
        | `L_n_18
        | `L_n_19
        | `L_n_20
        | `L_n_21
        ]
       [@js.enum])
    -> unit
    [@@js.set "maximumSignificantDigits"]

  val get_notation : t -> string [@@js.get "notation"]

  val set_notation : t -> string -> unit [@@js.set "notation"]

  val get_compact_display : t -> string [@@js.get "compactDisplay"]

  val set_compact_display : t -> string -> unit [@@js.set "compactDisplay"]
end
[@@js.scope "BigIntToLocaleStringOptions"]

module Big_int : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val to_string : t -> ?radix:int -> unit -> string [@@js.call "toString"]

  val to_locale_string :
       t
    -> ?locales:string
    -> ?options:Big_int_to_locale_string_options.t
    -> unit
    -> string
    [@@js.call "toLocaleString"]

  val value_of : t -> bigint [@@js.call "valueOf"]

  (* Constructor *)

  val as_int_n : bits:int -> int:bigint -> bigint [@@js.global "BitInt.asIntN"]

  val as_uint_n : bits:int -> int:bigint -> bigint
    [@@js.global "BitInt.asUintN"]
end

module Big_int_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val apply : t -> ?value:any -> unit -> bigint [@@js.apply]

  val get_prototype : t -> Big_int.t [@@js.get "prototype"]

  val as_int_n : t -> bits:int -> int:bigint -> bigint [@@js.call "asIntN"]

  val as_uint_n : t -> bits:int -> int:bigint -> bigint [@@js.call "asUintN"]
end
[@@js.scope "BigIntConstructor"]

val big_int : Big_int_constructor.t [@@js.global "BigInt"]

module Big_int64_array : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val get_buffer : t -> Array_buffer.t [@@js.get "buffer"]

  val get_byte_length : t -> int [@@js.get "byteLength"]

  val get_byte_offset : t -> int [@@js.get "byteOffset"]

  val copy_within : t -> target:int -> start:int -> ?end_:int -> unit -> t
    [@@js.call "copyWithin"]

  val entries : t -> (int * bigint) Iterable_iterator.t [@@js.call "entries"]

  val every :
       t
    -> predicate:(value:bigint -> index:int -> array:t -> bool)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "every"]

  val fill : t -> value:bigint -> ?start:int -> ?end_:int -> unit -> t
    [@@js.call "fill"]

  val filter :
       t
    -> predicate:(value:bigint -> index:int -> array:t -> any)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "filter"]

  val find :
       t
    -> predicate:(value:bigint -> index:int -> array:t -> bool)
    -> ?this_arg:any
    -> unit
    -> bigint or_undefined
    [@@js.call "find"]

  val find_index :
       t
    -> predicate:(value:bigint -> index:int -> array:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int
    [@@js.call "findIndex"]

  val for_each :
       t
    -> callbackfn:(value:bigint -> index:int -> array:t -> unit)
    -> ?this_arg:any
    -> unit
    -> unit
    [@@js.call "forEach"]

  val includes : t -> search_element:bigint -> ?from_index:int -> unit -> bool
    [@@js.call "includes"]

  val index_of : t -> search_element:bigint -> ?from_index:int -> unit -> int
    [@@js.call "indexOf"]

  val join : t -> ?separator:string -> unit -> string [@@js.call "join"]

  val keys : t -> int Iterable_iterator.t [@@js.call "keys"]

  val last_index_of :
    t -> search_element:bigint -> ?from_index:int -> unit -> int
    [@@js.call "lastIndexOf"]

  val get_length : t -> int [@@js.get "length"]

  val map :
       t
    -> callbackfn:(value:bigint -> index:int -> array:t -> bigint)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "map"]

  val reduce :
       t
    -> callbackfn:
         (   previousValue:bigint
          -> current_value:bigint
          -> current_index:int
          -> array:t
          -> bigint)
    -> bigint
    [@@js.call "reduce"]

  val reduce' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:bigint
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduce"]

  val reduce_right :
       t
    -> callbackfn:
         (   previousValue:bigint
          -> current_value:bigint
          -> current_index:int
          -> array:t
          -> bigint)
    -> bigint
    [@@js.call "reduceRight"]

  val reduce_right' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:bigint
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduceRight"]

  val reverse : t -> t [@@js.call "reverse"]

  val set : t -> array:bigint Array.t -> ?offset:int -> unit -> unit
    [@@js.call "set"]

  val slice : t -> ?start:int -> ?end_:int -> unit -> t [@@js.call "slice"]

  val some :
       t
    -> predicate:(value:bigint -> index:int -> array:t -> bool)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "some"]

  val sort :
    t -> ?compare_fn:(a:bigint -> b:bigint -> bigint or_number) -> unit -> t
    [@@js.call "sort"]

  val subarray : t -> ?begin_:int -> ?end_:int -> unit -> t
    [@@js.call "subarray"]

  val to_locale_string : t -> string [@@js.call "toLocaleString"]

  val to_string : t -> string [@@js.call "toString"]

  val value_of : t -> t [@@js.call "valueOf"]

  val values : t -> bigint Iterable_iterator.t [@@js.call "values"]

  val get : t -> int -> bigint [@@js.index_get]

  val set : t -> int -> bigint -> unit [@@js.index_set]

  (* Constructor *)

  val create : ?length:int -> unit -> t [@@js.new "BigInt64Array"]

  val create' : array:bigint Iterable.t -> t [@@js.new "BigInt64Array"]

  val create'' :
    t -> buffer:Array_buffer.t -> ?byte_offset:int -> ?length:int -> unit -> t
    [@@js.new "BigInt64Array"]

  val of_ : items:(bigint list[@js.variadic]) -> t
    [@@js.global "BigInt64Array.of"]

  val from : array:bigint Array.t -> t [@@js.global "BigInt64Array.from"]

  val from' :
       array:'U Array.t
    -> mapfn:(v:'U -> k:int -> bigint)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "BigInt64Array.from"]
end

module Big_int64_array_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> Big_int64_array.t [@@js.get "prototype"]

  val create : t -> ?length:int -> unit -> Big_int64_array.t
    [@@js.apply_newable]

  val create' : t -> array:bigint Iterable.t -> Big_int64_array.t
    [@@js.apply_newable]

  val create'' :
       t
    -> buffer:Array_buffer.t
    -> ?byte_offset:int
    -> ?length:int
    -> unit
    -> Big_int64_array.t
    [@@js.apply_newable]

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val of_ : t -> items:(bigint list[@js.variadic]) -> Big_int64_array.t
    [@@js.call "of"]

  val from : t -> array:bigint Array.t -> Big_int64_array.t [@@js.call "from"]

  val from' :
       t
    -> array:'U Array.t
    -> mapfn:(v:'U -> k:int -> bigint)
    -> ?this_arg:any
    -> unit
    -> Big_int64_array.t
    [@@js.call "from"]
end
[@@js.scope "BigInt64Array.Constructor"]

val big_int64_array : Big_int64_array_constructor.t
  [@@js.global "BigInt64Array"]

module Big_uint64_array : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val get_buffer : t -> Array_buffer.t [@@js.get "buffer"]

  val get_byte_length : t -> int [@@js.get "byteLength"]

  val get_byte_offset : t -> int [@@js.get "byteOffset"]

  val copy_within : t -> target:int -> start:int -> ?end_:int -> unit -> t
    [@@js.call "copyWithin"]

  val entries : t -> (int * bigint) Iterable_iterator.t [@@js.call "entries"]

  val every :
       t
    -> predicate:(value:bigint -> index:int -> array:t -> bool)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "every"]

  val fill : t -> value:bigint -> ?start:int -> ?end_:int -> unit -> t
    [@@js.call "fill"]

  val filter :
       t
    -> predicate:(value:bigint -> index:int -> array:t -> any)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "filter"]

  val find :
       t
    -> predicate:(value:bigint -> index:int -> array:t -> bool)
    -> ?this_arg:any
    -> unit
    -> bigint or_undefined
    [@@js.call "find"]

  val find_index :
       t
    -> predicate:(value:bigint -> index:int -> array:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int
    [@@js.call "findIndex"]

  val for_each :
       t
    -> callbackfn:(value:bigint -> index:int -> array:t -> unit)
    -> ?this_arg:any
    -> unit
    -> unit
    [@@js.call "forEach"]

  val includes : t -> search_element:bigint -> ?from_index:int -> unit -> bool
    [@@js.call "includes"]

  val index_of : t -> search_element:bigint -> ?from_index:int -> unit -> int
    [@@js.call "indexOf"]

  val join : t -> ?separator:string -> unit -> string [@@js.call "join"]

  val keys : t -> int Iterable_iterator.t [@@js.call "keys"]

  val last_index_of :
    t -> search_element:bigint -> ?from_index:int -> unit -> int
    [@@js.call "lastIndexOf"]

  val get_length : t -> int [@@js.get "length"]

  val map :
       t
    -> callbackfn:(value:bigint -> index:int -> array:t -> bigint)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "map"]

  val reduce :
       t
    -> callbackfn:
         (   previousValue:bigint
          -> current_value:bigint
          -> current_index:int
          -> array:t
          -> bigint)
    -> bigint
    [@@js.call "reduce"]

  val reduce' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:bigint
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduce"]

  val reduce_right :
       t
    -> callbackfn:
         (   previousValue:bigint
          -> current_value:bigint
          -> current_index:int
          -> array:t
          -> bigint)
    -> bigint
    [@@js.call "reduceRight"]

  val reduce_right' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:bigint
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduceRight"]

  val reverse : t -> t [@@js.call "reverse"]

  val set : t -> array:bigint Array.t -> ?offset:int -> unit -> unit
    [@@js.call "set"]

  val slice : t -> ?start:int -> ?end_:int -> unit -> t [@@js.call "slice"]

  val some :
       t
    -> predicate:(value:bigint -> index:int -> array:t -> bool)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "some"]

  val sort :
    t -> ?compare_fn:(a:bigint -> b:bigint -> bigint or_number) -> unit -> t
    [@@js.call "sort"]

  val subarray : t -> ?begin_:int -> ?end_:int -> unit -> t
    [@@js.call "subarray"]

  val to_locale_string : t -> string [@@js.call "toLocaleString"]

  val to_string : t -> string [@@js.call "toString"]

  val value_of : t -> t [@@js.call "valueOf"]

  val values : t -> bigint Iterable_iterator.t [@@js.call "values"]

  val get : t -> int -> bigint [@@js.index_get]

  val set : t -> int -> bigint -> unit [@@js.index_set]

  (* Constructor *)

  val create : ?length:int -> unit -> t [@@js.new "BigUint64Array"]

  val create' : array:bigint Iterable.t -> t [@@js.new "BigUint64Array"]

  val create'' :
    t -> buffer:Array_buffer.t -> ?byte_offset:int -> ?length:int -> unit -> t
    [@@js.new "BigUint64Array"]

  val of_ : items:(bigint list[@js.variadic]) -> t
    [@@js.global "BigUint64Array.of"]

  val from : array:bigint Array.t -> t [@@js.global "BigUint64Array.from"]

  val from' :
       array:'U Array.t
    -> mapfn:(v:'U -> k:int -> bigint)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "BigUint64Array.from"]
end

module Big_uint64_array_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> Big_uint64_array.t [@@js.get "prototype"]

  val create : t -> ?length:int -> unit -> Big_uint64_array.t
    [@@js.apply_newable]

  val create' : t -> array:bigint Iterable.t -> Big_uint64_array.t
    [@@js.apply_newable]

  val create'' :
       t
    -> buffer:Array_buffer.t
    -> ?byte_offset:int
    -> ?length:int
    -> unit
    -> Big_uint64_array.t
    [@@js.apply_newable]

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val of_ : t -> items:(bigint list[@js.variadic]) -> Big_uint64_array.t
    [@@js.call "of"]

  val from : t -> array:bigint Array.t -> Big_uint64_array.t [@@js.call "from"]

  val from' :
       t
    -> array:'U Array.t
    -> mapfn:(v:'U -> k:int -> bigint)
    -> ?this_arg:any
    -> unit
    -> Big_uint64_array.t
    [@@js.call "from"]
end
[@@js.scope "BigUint64ArrayConstructor"]

val big_uint64_array : Big_uint64_array_constructor.t
  [@@js.global "BigUint64Array"]

module Data_view : sig
  include module type of struct
    include Data_view
  end

  val get_big_int64 :
    t -> byte_offset:int -> ?little_endian:bool -> unit -> bigint
    [@@js.call "getBigInt64"]

  val get_big_uint64 :
    t -> byte_offset:int -> ?little_endian:bool -> unit -> bigint
    [@@js.call "getBigUint64"]

  val set_big_int64 :
    t -> byte_offset:int -> value:bigint -> ?little_endian:bool -> unit -> unit
    [@@js.call "setBigInt64"]

  val set_big_uint64 :
    t -> byte_offset:int -> value:bigint -> ?little_endian:bool -> unit -> unit
    [@@js.call "setBigUint64"]
end
[@@js.scope "DataView"]

module Intl : sig
  include module type of struct
    include Intl
  end

  module Number_format : sig
    include module type of struct
      include Number_format
    end

    val format : t -> value:bigint or_number -> string [@@js.call "format"]

    val resolved_options : t -> Resolved_number_format_options.t
      [@@js.call "resolvedOptions"]
  end
  [@@js.scope "NumberFormat"]
end
[@@js.scope "Intl"]
