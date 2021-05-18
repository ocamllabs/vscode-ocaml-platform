[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - ArrayBufferLike
  - ArrayLike<T1>
  - Iterable<T1>
  - IterableIterator<T1>
  - ResolvedNumberFormatOptions
 *)
[@@@js.stop]
module type Missing = sig
  module ArrayBufferLike : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module ArrayLike : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
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
  module ResolvedNumberFormatOptions : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module ArrayBufferLike : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ArrayLike : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
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
    module ResolvedNumberFormatOptions : sig
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
      type _BigInt = bigint
      and _BigInt64Array = [`BigInt64Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _BigInt64ArrayConstructor = [`BigInt64ArrayConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _BigIntConstructor = [`BigIntConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _BigIntToLocaleStringOptions = [`BigIntToLocaleStringOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _BigUint64Array = [`BigUint64Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _BigUint64ArrayConstructor = [`BigUint64ArrayConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _DataView = [`DataView] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Intl_NumberFormat = [`Intl_NumberFormat] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "BigIntToLocaleStringOptions"] BigIntToLocaleStringOptions : sig
    type t = _BigIntToLocaleStringOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_localeMatcher: t -> string [@@js.get "localeMatcher"]
    val set_localeMatcher: t -> string -> unit [@@js.set "localeMatcher"]
    val get_style: t -> string [@@js.get "style"]
    val set_style: t -> string -> unit [@@js.set "style"]
    val get_numberingSystem: t -> string [@@js.get "numberingSystem"]
    val set_numberingSystem: t -> string -> unit [@@js.set "numberingSystem"]
    val get_unit: t -> string [@@js.get "unit"]
    val set_unit: t -> string -> unit [@@js.set "unit"]
    val get_unitDisplay: t -> string [@@js.get "unitDisplay"]
    val set_unitDisplay: t -> string -> unit [@@js.set "unitDisplay"]
    val get_currency: t -> string [@@js.get "currency"]
    val set_currency: t -> string -> unit [@@js.set "currency"]
    val get_currencyDisplay: t -> string [@@js.get "currencyDisplay"]
    val set_currencyDisplay: t -> string -> unit [@@js.set "currencyDisplay"]
    val get_useGrouping: t -> bool [@@js.get "useGrouping"]
    val set_useGrouping: t -> bool -> unit [@@js.set "useGrouping"]
    val get_minimumIntegerDigits: t -> ([`L_n_1[@js 1] | `L_n_2[@js 2] | `L_n_3[@js 3] | `L_n_4[@js 4] | `L_n_5[@js 5] | `L_n_6[@js 6] | `L_n_7[@js 7] | `L_n_8[@js 8] | `L_n_9[@js 9] | `L_n_10[@js 10] | `L_n_11[@js 11] | `L_n_12[@js 12] | `L_n_13[@js 13] | `L_n_14[@js 14] | `L_n_15[@js 15] | `L_n_16[@js 16] | `L_n_17[@js 17] | `L_n_18[@js 18] | `L_n_19[@js 19] | `L_n_20[@js 20] | `L_n_21[@js 21]] [@js.enum]) [@@js.get "minimumIntegerDigits"]
    val set_minimumIntegerDigits: t -> ([`L_n_1 | `L_n_2 | `L_n_3 | `L_n_4 | `L_n_5 | `L_n_6 | `L_n_7 | `L_n_8 | `L_n_9 | `L_n_10 | `L_n_11 | `L_n_12 | `L_n_13 | `L_n_14 | `L_n_15 | `L_n_16 | `L_n_17 | `L_n_18 | `L_n_19 | `L_n_20 | `L_n_21] [@js.enum]) -> unit [@@js.set "minimumIntegerDigits"]
    val get_minimumFractionDigits: t -> ([`L_n_0[@js 0] | `L_n_1[@js 1] | `L_n_2[@js 2] | `L_n_3[@js 3] | `L_n_4[@js 4] | `L_n_5[@js 5] | `L_n_6[@js 6] | `L_n_7[@js 7] | `L_n_8[@js 8] | `L_n_9[@js 9] | `L_n_10[@js 10] | `L_n_11[@js 11] | `L_n_12[@js 12] | `L_n_13[@js 13] | `L_n_14[@js 14] | `L_n_15[@js 15] | `L_n_16[@js 16] | `L_n_17[@js 17] | `L_n_18[@js 18] | `L_n_19[@js 19] | `L_n_20[@js 20]] [@js.enum]) [@@js.get "minimumFractionDigits"]
    val set_minimumFractionDigits: t -> ([`L_n_0 | `L_n_1 | `L_n_2 | `L_n_3 | `L_n_4 | `L_n_5 | `L_n_6 | `L_n_7 | `L_n_8 | `L_n_9 | `L_n_10 | `L_n_11 | `L_n_12 | `L_n_13 | `L_n_14 | `L_n_15 | `L_n_16 | `L_n_17 | `L_n_18 | `L_n_19 | `L_n_20] [@js.enum]) -> unit [@@js.set "minimumFractionDigits"]
    val get_maximumFractionDigits: t -> ([`L_n_0[@js 0] | `L_n_1[@js 1] | `L_n_2[@js 2] | `L_n_3[@js 3] | `L_n_4[@js 4] | `L_n_5[@js 5] | `L_n_6[@js 6] | `L_n_7[@js 7] | `L_n_8[@js 8] | `L_n_9[@js 9] | `L_n_10[@js 10] | `L_n_11[@js 11] | `L_n_12[@js 12] | `L_n_13[@js 13] | `L_n_14[@js 14] | `L_n_15[@js 15] | `L_n_16[@js 16] | `L_n_17[@js 17] | `L_n_18[@js 18] | `L_n_19[@js 19] | `L_n_20[@js 20]] [@js.enum]) [@@js.get "maximumFractionDigits"]
    val set_maximumFractionDigits: t -> ([`L_n_0 | `L_n_1 | `L_n_2 | `L_n_3 | `L_n_4 | `L_n_5 | `L_n_6 | `L_n_7 | `L_n_8 | `L_n_9 | `L_n_10 | `L_n_11 | `L_n_12 | `L_n_13 | `L_n_14 | `L_n_15 | `L_n_16 | `L_n_17 | `L_n_18 | `L_n_19 | `L_n_20] [@js.enum]) -> unit [@@js.set "maximumFractionDigits"]
    val get_minimumSignificantDigits: t -> ([`L_n_1[@js 1] | `L_n_2[@js 2] | `L_n_3[@js 3] | `L_n_4[@js 4] | `L_n_5[@js 5] | `L_n_6[@js 6] | `L_n_7[@js 7] | `L_n_8[@js 8] | `L_n_9[@js 9] | `L_n_10[@js 10] | `L_n_11[@js 11] | `L_n_12[@js 12] | `L_n_13[@js 13] | `L_n_14[@js 14] | `L_n_15[@js 15] | `L_n_16[@js 16] | `L_n_17[@js 17] | `L_n_18[@js 18] | `L_n_19[@js 19] | `L_n_20[@js 20] | `L_n_21[@js 21]] [@js.enum]) [@@js.get "minimumSignificantDigits"]
    val set_minimumSignificantDigits: t -> ([`L_n_1 | `L_n_2 | `L_n_3 | `L_n_4 | `L_n_5 | `L_n_6 | `L_n_7 | `L_n_8 | `L_n_9 | `L_n_10 | `L_n_11 | `L_n_12 | `L_n_13 | `L_n_14 | `L_n_15 | `L_n_16 | `L_n_17 | `L_n_18 | `L_n_19 | `L_n_20 | `L_n_21] [@js.enum]) -> unit [@@js.set "minimumSignificantDigits"]
    val get_maximumSignificantDigits: t -> ([`L_n_1[@js 1] | `L_n_2[@js 2] | `L_n_3[@js 3] | `L_n_4[@js 4] | `L_n_5[@js 5] | `L_n_6[@js 6] | `L_n_7[@js 7] | `L_n_8[@js 8] | `L_n_9[@js 9] | `L_n_10[@js 10] | `L_n_11[@js 11] | `L_n_12[@js 12] | `L_n_13[@js 13] | `L_n_14[@js 14] | `L_n_15[@js 15] | `L_n_16[@js 16] | `L_n_17[@js 17] | `L_n_18[@js 18] | `L_n_19[@js 19] | `L_n_20[@js 20] | `L_n_21[@js 21]] [@js.enum]) [@@js.get "maximumSignificantDigits"]
    val set_maximumSignificantDigits: t -> ([`L_n_1 | `L_n_2 | `L_n_3 | `L_n_4 | `L_n_5 | `L_n_6 | `L_n_7 | `L_n_8 | `L_n_9 | `L_n_10 | `L_n_11 | `L_n_12 | `L_n_13 | `L_n_14 | `L_n_15 | `L_n_16 | `L_n_17 | `L_n_18 | `L_n_19 | `L_n_20 | `L_n_21] [@js.enum]) -> unit [@@js.set "maximumSignificantDigits"]
    val get_notation: t -> string [@@js.get "notation"]
    val set_notation: t -> string -> unit [@@js.set "notation"]
    val get_compactDisplay: t -> string [@@js.get "compactDisplay"]
    val set_compactDisplay: t -> string -> unit [@@js.set "compactDisplay"]
  end
  module[@js.scope "BigInt"] BigInt : sig
    type t = _BigInt
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val toString: t -> ?radix:float -> unit -> string [@@js.call "toString"]
    val toLocaleString: t -> ?locales:string -> ?options:_BigIntToLocaleStringOptions -> unit -> string [@@js.call "toLocaleString"]
    val valueOf: t -> bigint [@@js.call "valueOf"]
    val get__Symbol_toStringTag_: t -> ([`L_s0_BigInt[@js "BigInt"]] [@js.enum]) [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "BigIntConstructor"] BigIntConstructor : sig
    type t = _BigIntConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val apply: t -> ?value:any -> unit -> bigint [@@js.apply]
    val get_prototype: t -> _BigInt [@@js.get "prototype"]
    val asIntN: t -> bits:float -> int:bigint -> bigint [@@js.call "asIntN"]
    val asUintN: t -> bits:float -> int:bigint -> bigint [@@js.call "asUintN"]
  end
  val bigInt: _BigIntConstructor [@@js.global "BigInt"]
  module[@js.scope "BigInt64Array"] BigInt64Array : sig
    type t = _BigInt64Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
    val get_buffer: t -> ArrayBufferLike.t_0 [@@js.get "buffer"]
    val get_byteLength: t -> float [@@js.get "byteLength"]
    val get_byteOffset: t -> float [@@js.get "byteOffset"]
    val copyWithin: t -> target:float -> start:float -> ?end_:float -> unit -> t [@@js.call "copyWithin"]
    val entries: t -> (float * bigint) IterableIterator.t_1 [@@js.call "entries"]
    val every: t -> predicate:(value:bigint -> index:float -> array:t -> bool) -> ?thisArg:any -> unit -> bool [@@js.call "every"]
    val fill: t -> value:bigint -> ?start:float -> ?end_:float -> unit -> t [@@js.call "fill"]
    val filter: t -> predicate:(value:bigint -> index:float -> array:t -> any) -> ?thisArg:any -> unit -> t [@@js.call "filter"]
    val find: t -> predicate:(value:bigint -> index:float -> array:t -> bool) -> ?thisArg:any -> unit -> bigint or_undefined [@@js.call "find"]
    val findIndex: t -> predicate:(value:bigint -> index:float -> array:t -> bool) -> ?thisArg:any -> unit -> float [@@js.call "findIndex"]
    val forEach: t -> callbackfn:(value:bigint -> index:float -> array:t -> unit) -> ?thisArg:any -> unit -> unit [@@js.call "forEach"]
    val includes: t -> searchElement:bigint -> ?fromIndex:float -> unit -> bool [@@js.call "includes"]
    val indexOf: t -> searchElement:bigint -> ?fromIndex:float -> unit -> float [@@js.call "indexOf"]
    val join: t -> ?separator:string -> unit -> string [@@js.call "join"]
    val keys: t -> float IterableIterator.t_1 [@@js.call "keys"]
    val lastIndexOf: t -> searchElement:bigint -> ?fromIndex:float -> unit -> float [@@js.call "lastIndexOf"]
    val get_length: t -> float [@@js.get "length"]
    val map: t -> callbackfn:(value:bigint -> index:float -> array:t -> bigint) -> ?thisArg:any -> unit -> t [@@js.call "map"]
    val reduce: t -> callbackfn:(previousValue:bigint -> currentValue:bigint -> currentIndex:float -> array:t -> bigint) -> bigint [@@js.call "reduce"]
    val reduce': t -> callbackfn:(previousValue:'U -> currentValue:bigint -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduce"]
    val reduceRight: t -> callbackfn:(previousValue:bigint -> currentValue:bigint -> currentIndex:float -> array:t -> bigint) -> bigint [@@js.call "reduceRight"]
    val reduceRight': t -> callbackfn:(previousValue:'U -> currentValue:bigint -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduceRight"]
    val reverse: t -> t [@@js.call "reverse"]
    val set_: t -> array:bigint ArrayLike.t_1 -> ?offset:float -> unit -> unit [@@js.call "set"]
    val slice: t -> ?start:float -> ?end_:float -> unit -> t [@@js.call "slice"]
    val some: t -> predicate:(value:bigint -> index:float -> array:t -> bool) -> ?thisArg:any -> unit -> bool [@@js.call "some"]
    val sort: t -> ?compareFn:(a:bigint -> b:bigint -> bigint or_number) -> unit -> t [@@js.call "sort"]
    val subarray: t -> ?begin_:float -> ?end_:float -> unit -> t [@@js.call "subarray"]
    val toLocaleString: t -> string [@@js.call "toLocaleString"]
    val toString: t -> string [@@js.call "toString"]
    val valueOf: t -> t [@@js.call "valueOf"]
    val values: t -> bigint IterableIterator.t_1 [@@js.call "values"]
    val _Symbol_iterator_: t -> bigint IterableIterator.t_1 [@@js.call "[Symbol.iterator]"]
    val get__Symbol_toStringTag_: t -> ([`L_s1_BigInt64Array[@js "BigInt64Array"]] [@js.enum]) [@@js.get "[Symbol.toStringTag]"]
    val get: t -> float -> bigint [@@js.index_get]
    val set: t -> float -> bigint -> unit [@@js.index_set]
  end
  module[@js.scope "BigInt64ArrayConstructor"] BigInt64ArrayConstructor : sig
    type t = _BigInt64ArrayConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_prototype: t -> _BigInt64Array [@@js.get "prototype"]
    val create: t -> ?length:float -> unit -> _BigInt64Array [@@js.apply_newable]
    val create': t -> array:bigint Iterable.t_1 -> _BigInt64Array [@@js.apply_newable]
    val create'': t -> buffer:ArrayBufferLike.t_0 -> ?byteOffset:float -> ?length:float -> unit -> _BigInt64Array [@@js.apply_newable]
    val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
    val of_: t -> items:(bigint list [@js.variadic]) -> _BigInt64Array [@@js.call "of"]
    val from: t -> arrayLike:bigint ArrayLike.t_1 -> _BigInt64Array [@@js.call "from"]
    val from': t -> arrayLike:'U ArrayLike.t_1 -> mapfn:(v:'U -> k:float -> bigint) -> ?thisArg:any -> unit -> _BigInt64Array [@@js.call "from"]
  end
  val bigInt64Array: _BigInt64ArrayConstructor [@@js.global "BigInt64Array"]
  module[@js.scope "BigUint64Array"] BigUint64Array : sig
    type t = _BigUint64Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
    val get_buffer: t -> ArrayBufferLike.t_0 [@@js.get "buffer"]
    val get_byteLength: t -> float [@@js.get "byteLength"]
    val get_byteOffset: t -> float [@@js.get "byteOffset"]
    val copyWithin: t -> target:float -> start:float -> ?end_:float -> unit -> t [@@js.call "copyWithin"]
    val entries: t -> (float * bigint) IterableIterator.t_1 [@@js.call "entries"]
    val every: t -> predicate:(value:bigint -> index:float -> array:t -> bool) -> ?thisArg:any -> unit -> bool [@@js.call "every"]
    val fill: t -> value:bigint -> ?start:float -> ?end_:float -> unit -> t [@@js.call "fill"]
    val filter: t -> predicate:(value:bigint -> index:float -> array:t -> any) -> ?thisArg:any -> unit -> t [@@js.call "filter"]
    val find: t -> predicate:(value:bigint -> index:float -> array:t -> bool) -> ?thisArg:any -> unit -> bigint or_undefined [@@js.call "find"]
    val findIndex: t -> predicate:(value:bigint -> index:float -> array:t -> bool) -> ?thisArg:any -> unit -> float [@@js.call "findIndex"]
    val forEach: t -> callbackfn:(value:bigint -> index:float -> array:t -> unit) -> ?thisArg:any -> unit -> unit [@@js.call "forEach"]
    val includes: t -> searchElement:bigint -> ?fromIndex:float -> unit -> bool [@@js.call "includes"]
    val indexOf: t -> searchElement:bigint -> ?fromIndex:float -> unit -> float [@@js.call "indexOf"]
    val join: t -> ?separator:string -> unit -> string [@@js.call "join"]
    val keys: t -> float IterableIterator.t_1 [@@js.call "keys"]
    val lastIndexOf: t -> searchElement:bigint -> ?fromIndex:float -> unit -> float [@@js.call "lastIndexOf"]
    val get_length: t -> float [@@js.get "length"]
    val map: t -> callbackfn:(value:bigint -> index:float -> array:t -> bigint) -> ?thisArg:any -> unit -> t [@@js.call "map"]
    val reduce: t -> callbackfn:(previousValue:bigint -> currentValue:bigint -> currentIndex:float -> array:t -> bigint) -> bigint [@@js.call "reduce"]
    val reduce': t -> callbackfn:(previousValue:'U -> currentValue:bigint -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduce"]
    val reduceRight: t -> callbackfn:(previousValue:bigint -> currentValue:bigint -> currentIndex:float -> array:t -> bigint) -> bigint [@@js.call "reduceRight"]
    val reduceRight': t -> callbackfn:(previousValue:'U -> currentValue:bigint -> currentIndex:float -> array:t -> 'U) -> initialValue:'U -> 'U [@@js.call "reduceRight"]
    val reverse: t -> t [@@js.call "reverse"]
    val set_: t -> array:bigint ArrayLike.t_1 -> ?offset:float -> unit -> unit [@@js.call "set"]
    val slice: t -> ?start:float -> ?end_:float -> unit -> t [@@js.call "slice"]
    val some: t -> predicate:(value:bigint -> index:float -> array:t -> bool) -> ?thisArg:any -> unit -> bool [@@js.call "some"]
    val sort: t -> ?compareFn:(a:bigint -> b:bigint -> bigint or_number) -> unit -> t [@@js.call "sort"]
    val subarray: t -> ?begin_:float -> ?end_:float -> unit -> t [@@js.call "subarray"]
    val toLocaleString: t -> string [@@js.call "toLocaleString"]
    val toString: t -> string [@@js.call "toString"]
    val valueOf: t -> t [@@js.call "valueOf"]
    val values: t -> bigint IterableIterator.t_1 [@@js.call "values"]
    val _Symbol_iterator_: t -> bigint IterableIterator.t_1 [@@js.call "[Symbol.iterator]"]
    val get__Symbol_toStringTag_: t -> ([`L_s2_BigUint64Array[@js "BigUint64Array"]] [@js.enum]) [@@js.get "[Symbol.toStringTag]"]
    val get: t -> float -> bigint [@@js.index_get]
    val set: t -> float -> bigint -> unit [@@js.index_set]
  end
  module[@js.scope "BigUint64ArrayConstructor"] BigUint64ArrayConstructor : sig
    type t = _BigUint64ArrayConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_prototype: t -> _BigUint64Array [@@js.get "prototype"]
    val create: t -> ?length:float -> unit -> _BigUint64Array [@@js.apply_newable]
    val create': t -> array:bigint Iterable.t_1 -> _BigUint64Array [@@js.apply_newable]
    val create'': t -> buffer:ArrayBufferLike.t_0 -> ?byteOffset:float -> ?length:float -> unit -> _BigUint64Array [@@js.apply_newable]
    val get_BYTES_PER_ELEMENT: t -> float [@@js.get "BYTES_PER_ELEMENT"]
    val of_: t -> items:(bigint list [@js.variadic]) -> _BigUint64Array [@@js.call "of"]
    val from: t -> arrayLike:bigint ArrayLike.t_1 -> _BigUint64Array [@@js.call "from"]
    val from': t -> arrayLike:'U ArrayLike.t_1 -> mapfn:(v:'U -> k:float -> bigint) -> ?thisArg:any -> unit -> _BigUint64Array [@@js.call "from"]
  end
  val bigUint64Array: _BigUint64ArrayConstructor [@@js.global "BigUint64Array"]
  module[@js.scope "DataView"] DataView : sig
    type t = _DataView
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val getBigInt64: t -> byteOffset:float -> ?littleEndian:bool -> unit -> bigint [@@js.call "getBigInt64"]
    val getBigUint64: t -> byteOffset:float -> ?littleEndian:bool -> unit -> bigint [@@js.call "getBigUint64"]
    val setBigInt64: t -> byteOffset:float -> value:bigint -> ?littleEndian:bool -> unit -> unit [@@js.call "setBigInt64"]
    val setBigUint64: t -> byteOffset:float -> value:bigint -> ?littleEndian:bool -> unit -> unit [@@js.call "setBigUint64"]
  end
  module[@js.scope "Intl"] Intl : sig
    module[@js.scope "NumberFormat"] NumberFormat : sig
      type t = _Intl_NumberFormat
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val format: t -> value:bigint or_number -> string [@@js.call "format"]
      val resolvedOptions: t -> ResolvedNumberFormatOptions.t_0 [@@js.call "resolvedOptions"]
    end
  end
end
