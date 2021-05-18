[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - ArrayLike<T1>
  - PromiseLike<T1>
 *)
[@@@js.stop]
module type Missing = sig
  module ArrayLike : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module PromiseLike : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module ArrayLike : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module PromiseLike : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
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
      type 'T _Array = [`Array of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and _ArrayConstructor = [`ArrayConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Float32Array = [`Float32Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Float32ArrayConstructor = [`Float32ArrayConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Float64Array = [`Float64Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Float64ArrayConstructor = [`Float64ArrayConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _IArguments = [`IArguments] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Int16Array = [`Int16Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Int16ArrayConstructor = [`Int16ArrayConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Int32Array = [`Int32Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Int32ArrayConstructor = [`Int32ArrayConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Int8Array = [`Int8Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Int8ArrayConstructor = [`Int8ArrayConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T _Iterable = [`Iterable of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and 'T _IterableIterator = [`IterableIterator of 'T | `Iterator of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and ('T, 'TReturn, 'TNext) _Iterator = [`Iterator of ('T * 'TReturn * 'TNext)] intf
      [@@js.custom { of_js=(fun _T _TReturn _TNext -> Obj.magic); to_js=(fun _T _TReturn _TNext -> Obj.magic) }]
      and ('T, 'TReturn) _IteratorResult = ([`U_b_false of 'T _IteratorYieldResult [@js false] | `U_b_true of 'TReturn _IteratorReturnResult [@js true]] [@js.union on_field "done"])
      and 'TReturn _IteratorReturnResult = [`IteratorReturnResult of 'TReturn] intf
      [@@js.custom { of_js=(fun _TReturn -> Obj.magic); to_js=(fun _TReturn -> Obj.magic) }]
      and 'TYield _IteratorYieldResult = [`IteratorYieldResult of 'TYield] intf
      [@@js.custom { of_js=(fun _TYield -> Obj.magic); to_js=(fun _TYield -> Obj.magic) }]
      and ('K, 'V) _Map = [`Map of ('K * 'V)] intf
      [@@js.custom { of_js=(fun _K _V -> Obj.magic); to_js=(fun _K _V -> Obj.magic) }]
      and _MapConstructor = [`MapConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T _Promise = [`Promise of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and _PromiseConstructor = [`PromiseConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T _ReadonlyArray = [`ReadonlyArray of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and ('K, 'V) _ReadonlyMap = [`ReadonlyMap of ('K * 'V)] intf
      [@@js.custom { of_js=(fun _K _V -> Obj.magic); to_js=(fun _K _V -> Obj.magic) }]
      and 'T _ReadonlySet = [`ReadonlySet of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and 'T _Set = [`Set of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and _SetConstructor = [`SetConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _String = [`String] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _SymbolConstructor = [`SymbolConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Uint16Array = [`Uint16Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Uint16ArrayConstructor = [`Uint16ArrayConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Uint32Array = [`Uint32Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Uint32ArrayConstructor = [`Uint32ArrayConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Uint8Array = [`Uint8Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Uint8ArrayConstructor = [`Uint8ArrayConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Uint8ClampedArray = [`Uint8ClampedArray] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Uint8ClampedArrayConstructor = [`Uint8ClampedArrayConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and ('K, 'V) _WeakMap = [`WeakMap of ('K * 'V)] intf
      [@@js.custom { of_js=(fun _K _V -> Obj.magic); to_js=(fun _K _V -> Obj.magic) }]
      and _WeakMapConstructor = [`WeakMapConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T _WeakSet = [`WeakSet of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and _WeakSetConstructor = [`WeakSetConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "SymbolConstructor"] SymbolConstructor : sig
    type t = _SymbolConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_iterator: t -> symbol [@@js.get "iterator"]
  end
  module[@js.scope "IteratorYieldResult"] IteratorYieldResult : sig
    type 'TYield t = 'TYield _IteratorYieldResult
    val t_to_js: ('TYield -> Ojs.t) -> 'TYield t -> Ojs.t
    val t_of_js: (Ojs.t -> 'TYield) -> Ojs.t -> 'TYield t
    type 'TYield t_1 = 'TYield t
    val t_1_to_js: ('TYield -> Ojs.t) -> 'TYield t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'TYield) -> Ojs.t -> 'TYield t_1
    val get_done: 'TYield t -> ([`L_b_false[@js false]] [@js.enum]) [@@js.get "done"]
    val set_done: 'TYield t -> ([`L_b_false] [@js.enum]) -> unit [@@js.set "done"]
    val get_value: 'TYield t -> 'TYield [@@js.get "value"]
    val set_value: 'TYield t -> 'TYield -> unit [@@js.set "value"]
  end
  module[@js.scope "IteratorReturnResult"] IteratorReturnResult : sig
    type 'TReturn t = 'TReturn _IteratorReturnResult
    val t_to_js: ('TReturn -> Ojs.t) -> 'TReturn t -> Ojs.t
    val t_of_js: (Ojs.t -> 'TReturn) -> Ojs.t -> 'TReturn t
    type 'TReturn t_1 = 'TReturn t
    val t_1_to_js: ('TReturn -> Ojs.t) -> 'TReturn t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'TReturn) -> Ojs.t -> 'TReturn t_1
    val get_done: 'TReturn t -> ([`L_b_true[@js true]] [@js.enum]) [@@js.get "done"]
    val set_done: 'TReturn t -> ([`L_b_true] [@js.enum]) -> unit [@@js.set "done"]
    val get_value: 'TReturn t -> 'TReturn [@@js.get "value"]
    val set_value: 'TReturn t -> 'TReturn -> unit [@@js.set "value"]
  end
  module IteratorResult : sig
    type ('T, 'TReturn) t = ('T, 'TReturn) _IteratorResult
    val t_to_js: ('T -> Ojs.t) -> ('TReturn -> Ojs.t) -> ('T, 'TReturn) t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'TReturn) -> Ojs.t -> ('T, 'TReturn) t
    type ('T, 'TReturn) t_2 = ('T, 'TReturn) t
    val t_2_to_js: ('T -> Ojs.t) -> ('TReturn -> Ojs.t) -> ('T, 'TReturn) t_2 -> Ojs.t
    val t_2_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'TReturn) -> Ojs.t -> ('T, 'TReturn) t_2
  end
  module[@js.scope "Iterator"] Iterator : sig
    type ('T, 'TReturn, 'TNext) t = ('T, 'TReturn, 'TNext) _Iterator
    val t_to_js: ('T -> Ojs.t) -> ('TReturn -> Ojs.t) -> ('TNext -> Ojs.t) -> ('T, 'TReturn, 'TNext) t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'TReturn) -> (Ojs.t -> 'TNext) -> Ojs.t -> ('T, 'TReturn, 'TNext) t
    type ('T, 'TReturn, 'TNext) t_3 = ('T, 'TReturn, 'TNext) t
    val t_3_to_js: ('T -> Ojs.t) -> ('TReturn -> Ojs.t) -> ('TNext -> Ojs.t) -> ('T, 'TReturn, 'TNext) t_3 -> Ojs.t
    val t_3_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'TReturn) -> (Ojs.t -> 'TNext) -> Ojs.t -> ('T, 'TReturn, 'TNext) t_3
    val next: ('T, 'TReturn, 'TNext) t -> args:((* FIXME: type 'union<() | ('TNext)>' cannot be used for variadic argument *)any list [@js.variadic]) -> ('T, 'TReturn) _IteratorResult [@@js.call "next"]
    val return: ('T, 'TReturn, 'TNext) t -> ?value:'TReturn -> unit -> ('T, 'TReturn) _IteratorResult [@@js.call "return"]
    val throw: ('T, 'TReturn, 'TNext) t -> ?e:any -> unit -> ('T, 'TReturn) _IteratorResult [@@js.call "throw"]
  end
  module[@js.scope "Iterable"] Iterable : sig
    type 'T t = 'T _Iterable
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    val _Symbol_iterator_: 'T t -> ('T, any, never or_undefined) _Iterator [@@js.call "[Symbol.iterator]"]
  end
  module[@js.scope "IterableIterator"] IterableIterator : sig
    type 'T t = 'T _IterableIterator
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    val _Symbol_iterator_: 'T t -> 'T t [@@js.call "[Symbol.iterator]"]
    val cast: 'T t -> ('T, any, never or_undefined) _Iterator [@@js.cast]
  end
  module[@js.scope "Array"] Array : sig
    type 'T t = 'T _Array
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    val _Symbol_iterator_: 'T t -> 'T _IterableIterator [@@js.call "[Symbol.iterator]"]
    val entries: 'T t -> (float * 'T) _IterableIterator [@@js.call "entries"]
    val keys: 'T t -> float _IterableIterator [@@js.call "keys"]
    val values: 'T t -> 'T _IterableIterator [@@js.call "values"]
    val to_ml: 'T t -> 'T list [@@js.cast]
    val of_ml: 'T list -> 'T t [@@js.cast]
  end
  module[@js.scope "ArrayConstructor"] ArrayConstructor : sig
    type t = _ArrayConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val from: t -> iterable:('T ArrayLike.t_1, 'T _Iterable) union2 -> 'T list [@@js.call "from"]
    val from': t -> iterable:('T ArrayLike.t_1, 'T _Iterable) union2 -> mapfn:(v:'T -> k:float -> 'U) -> ?thisArg:any -> unit -> 'U list [@@js.call "from"]
  end
  module[@js.scope "ReadonlyArray"] ReadonlyArray : sig
    type 'T t = 'T _ReadonlyArray
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    val _Symbol_iterator_: 'T t -> 'T _IterableIterator [@@js.call "[Symbol.iterator]"]
    val entries: 'T t -> (float * 'T) _IterableIterator [@@js.call "entries"]
    val keys: 'T t -> float _IterableIterator [@@js.call "keys"]
    val values: 'T t -> 'T _IterableIterator [@@js.call "values"]
    val to_ml: 'T t -> 'T list [@@js.cast]
    val of_ml: 'T list -> 'T t [@@js.cast]
  end
  module[@js.scope "IArguments"] IArguments : sig
    type t = _IArguments
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_iterator_: t -> any _IterableIterator [@@js.call "[Symbol.iterator]"]
  end
  module[@js.scope "Map"] Map : sig
    type ('K, 'V) t = ('K, 'V) _Map
    val t_to_js: ('K -> Ojs.t) -> ('V -> Ojs.t) -> ('K, 'V) t -> Ojs.t
    val t_of_js: (Ojs.t -> 'K) -> (Ojs.t -> 'V) -> Ojs.t -> ('K, 'V) t
    type ('K, 'V) t_2 = ('K, 'V) t
    val t_2_to_js: ('K -> Ojs.t) -> ('V -> Ojs.t) -> ('K, 'V) t_2 -> Ojs.t
    val t_2_of_js: (Ojs.t -> 'K) -> (Ojs.t -> 'V) -> Ojs.t -> ('K, 'V) t_2
    val _Symbol_iterator_: ('K, 'V) t -> ('K * 'V) _IterableIterator [@@js.call "[Symbol.iterator]"]
    val entries: ('K, 'V) t -> ('K * 'V) _IterableIterator [@@js.call "entries"]
    val keys: ('K, 'V) t -> 'K _IterableIterator [@@js.call "keys"]
    val values: ('K, 'V) t -> 'V _IterableIterator [@@js.call "values"]
  end
  module[@js.scope "ReadonlyMap"] ReadonlyMap : sig
    type ('K, 'V) t = ('K, 'V) _ReadonlyMap
    val t_to_js: ('K -> Ojs.t) -> ('V -> Ojs.t) -> ('K, 'V) t -> Ojs.t
    val t_of_js: (Ojs.t -> 'K) -> (Ojs.t -> 'V) -> Ojs.t -> ('K, 'V) t
    type ('K, 'V) t_2 = ('K, 'V) t
    val t_2_to_js: ('K -> Ojs.t) -> ('V -> Ojs.t) -> ('K, 'V) t_2 -> Ojs.t
    val t_2_of_js: (Ojs.t -> 'K) -> (Ojs.t -> 'V) -> Ojs.t -> ('K, 'V) t_2
    val _Symbol_iterator_: ('K, 'V) t -> ('K * 'V) _IterableIterator [@@js.call "[Symbol.iterator]"]
    val entries: ('K, 'V) t -> ('K * 'V) _IterableIterator [@@js.call "entries"]
    val keys: ('K, 'V) t -> 'K _IterableIterator [@@js.call "keys"]
    val values: ('K, 'V) t -> 'V _IterableIterator [@@js.call "values"]
  end
  module[@js.scope "MapConstructor"] MapConstructor : sig
    type t = _MapConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> iterable:('K * 'V) _Iterable -> ('K, 'V) _Map [@@js.apply_newable]
  end
  module WeakMap : sig
    type ('K, 'V) t = ('K, 'V) _WeakMap
    val t_to_js: ('K -> Ojs.t) -> ('V -> Ojs.t) -> ('K, 'V) t -> Ojs.t
    val t_of_js: (Ojs.t -> 'K) -> (Ojs.t -> 'V) -> Ojs.t -> ('K, 'V) t
    type ('K, 'V) t_2 = ('K, 'V) t
    val t_2_to_js: ('K -> Ojs.t) -> ('V -> Ojs.t) -> ('K, 'V) t_2 -> Ojs.t
    val t_2_of_js: (Ojs.t -> 'K) -> (Ojs.t -> 'V) -> Ojs.t -> ('K, 'V) t_2
  end
  module[@js.scope "WeakMapConstructor"] WeakMapConstructor : sig
    type t = _WeakMapConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> iterable:('K * 'V) _Iterable -> ('K, 'V) _WeakMap [@@js.apply_newable]
  end
  module[@js.scope "Set"] Set : sig
    type 'T t = 'T _Set
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    val _Symbol_iterator_: 'T t -> 'T _IterableIterator [@@js.call "[Symbol.iterator]"]
    val entries: 'T t -> ('T * 'T) _IterableIterator [@@js.call "entries"]
    val keys: 'T t -> 'T _IterableIterator [@@js.call "keys"]
    val values: 'T t -> 'T _IterableIterator [@@js.call "values"]
  end
  module[@js.scope "ReadonlySet"] ReadonlySet : sig
    type 'T t = 'T _ReadonlySet
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    val _Symbol_iterator_: 'T t -> 'T _IterableIterator [@@js.call "[Symbol.iterator]"]
    val entries: 'T t -> ('T * 'T) _IterableIterator [@@js.call "entries"]
    val keys: 'T t -> 'T _IterableIterator [@@js.call "keys"]
    val values: 'T t -> 'T _IterableIterator [@@js.call "values"]
  end
  module[@js.scope "SetConstructor"] SetConstructor : sig
    type t = _SetConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> ?iterable:'T _Iterable or_null -> unit -> 'T _Set [@@js.apply_newable]
  end
  module WeakSet : sig
    type 'T t = 'T _WeakSet
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
  end
  module[@js.scope "WeakSetConstructor"] WeakSetConstructor : sig
    type t = _WeakSetConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> iterable:'T _Iterable -> 'T _WeakSet [@@js.apply_newable]
  end
  module Promise : sig
    type 'T t = 'T _Promise
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
  end
  module[@js.scope "PromiseConstructor"] PromiseConstructor : sig
    type t = _PromiseConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val all: t -> values:('T, 'T PromiseLike.t_1) union2 _Iterable -> 'T list _Promise [@@js.call "all"]
    val race: t -> values:'T _Iterable -> (* FIXME: unknown type 'T extends PromiseLike<infer U> ? U : T' *)any _Promise [@@js.call "race"]
    val race': t -> values:('T, 'T PromiseLike.t_1) union2 _Iterable -> 'T _Promise [@@js.call "race"]
  end
  module[@js.scope "String"] String : sig
    type t = _String
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_iterator_: t -> string _IterableIterator [@@js.call "[Symbol.iterator]"]
    val to_ml: t -> string [@@js.cast]
    val of_ml: string -> t [@@js.cast]
  end
  module[@js.scope "Int8Array"] Int8Array : sig
    type t = _Int8Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_iterator_: t -> float _IterableIterator [@@js.call "[Symbol.iterator]"]
    val entries: t -> (float * float) _IterableIterator [@@js.call "entries"]
    val keys: t -> float _IterableIterator [@@js.call "keys"]
    val values: t -> float _IterableIterator [@@js.call "values"]
  end
  module[@js.scope "Int8ArrayConstructor"] Int8ArrayConstructor : sig
    type t = _Int8ArrayConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> elements:float _Iterable -> _Int8Array [@@js.apply_newable]
    val from: t -> arrayLike:float _Iterable -> ?mapfn:(v:float -> k:float -> float) -> ?thisArg:any -> unit -> _Int8Array [@@js.call "from"]
  end
  module[@js.scope "Uint8Array"] Uint8Array : sig
    type t = _Uint8Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_iterator_: t -> float _IterableIterator [@@js.call "[Symbol.iterator]"]
    val entries: t -> (float * float) _IterableIterator [@@js.call "entries"]
    val keys: t -> float _IterableIterator [@@js.call "keys"]
    val values: t -> float _IterableIterator [@@js.call "values"]
  end
  module[@js.scope "Uint8ArrayConstructor"] Uint8ArrayConstructor : sig
    type t = _Uint8ArrayConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> elements:float _Iterable -> _Uint8Array [@@js.apply_newable]
    val from: t -> arrayLike:float _Iterable -> ?mapfn:(v:float -> k:float -> float) -> ?thisArg:any -> unit -> _Uint8Array [@@js.call "from"]
  end
  module[@js.scope "Uint8ClampedArray"] Uint8ClampedArray : sig
    type t = _Uint8ClampedArray
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_iterator_: t -> float _IterableIterator [@@js.call "[Symbol.iterator]"]
    val entries: t -> (float * float) _IterableIterator [@@js.call "entries"]
    val keys: t -> float _IterableIterator [@@js.call "keys"]
    val values: t -> float _IterableIterator [@@js.call "values"]
  end
  module[@js.scope "Uint8ClampedArrayConstructor"] Uint8ClampedArrayConstructor : sig
    type t = _Uint8ClampedArrayConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> elements:float _Iterable -> _Uint8ClampedArray [@@js.apply_newable]
    val from: t -> arrayLike:float _Iterable -> ?mapfn:(v:float -> k:float -> float) -> ?thisArg:any -> unit -> _Uint8ClampedArray [@@js.call "from"]
  end
  module[@js.scope "Int16Array"] Int16Array : sig
    type t = _Int16Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_iterator_: t -> float _IterableIterator [@@js.call "[Symbol.iterator]"]
    val entries: t -> (float * float) _IterableIterator [@@js.call "entries"]
    val keys: t -> float _IterableIterator [@@js.call "keys"]
    val values: t -> float _IterableIterator [@@js.call "values"]
  end
  module[@js.scope "Int16ArrayConstructor"] Int16ArrayConstructor : sig
    type t = _Int16ArrayConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> elements:float _Iterable -> _Int16Array [@@js.apply_newable]
    val from: t -> arrayLike:float _Iterable -> ?mapfn:(v:float -> k:float -> float) -> ?thisArg:any -> unit -> _Int16Array [@@js.call "from"]
  end
  module[@js.scope "Uint16Array"] Uint16Array : sig
    type t = _Uint16Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_iterator_: t -> float _IterableIterator [@@js.call "[Symbol.iterator]"]
    val entries: t -> (float * float) _IterableIterator [@@js.call "entries"]
    val keys: t -> float _IterableIterator [@@js.call "keys"]
    val values: t -> float _IterableIterator [@@js.call "values"]
  end
  module[@js.scope "Uint16ArrayConstructor"] Uint16ArrayConstructor : sig
    type t = _Uint16ArrayConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> elements:float _Iterable -> _Uint16Array [@@js.apply_newable]
    val from: t -> arrayLike:float _Iterable -> ?mapfn:(v:float -> k:float -> float) -> ?thisArg:any -> unit -> _Uint16Array [@@js.call "from"]
  end
  module[@js.scope "Int32Array"] Int32Array : sig
    type t = _Int32Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_iterator_: t -> float _IterableIterator [@@js.call "[Symbol.iterator]"]
    val entries: t -> (float * float) _IterableIterator [@@js.call "entries"]
    val keys: t -> float _IterableIterator [@@js.call "keys"]
    val values: t -> float _IterableIterator [@@js.call "values"]
  end
  module[@js.scope "Int32ArrayConstructor"] Int32ArrayConstructor : sig
    type t = _Int32ArrayConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> elements:float _Iterable -> _Int32Array [@@js.apply_newable]
    val from: t -> arrayLike:float _Iterable -> ?mapfn:(v:float -> k:float -> float) -> ?thisArg:any -> unit -> _Int32Array [@@js.call "from"]
  end
  module[@js.scope "Uint32Array"] Uint32Array : sig
    type t = _Uint32Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_iterator_: t -> float _IterableIterator [@@js.call "[Symbol.iterator]"]
    val entries: t -> (float * float) _IterableIterator [@@js.call "entries"]
    val keys: t -> float _IterableIterator [@@js.call "keys"]
    val values: t -> float _IterableIterator [@@js.call "values"]
  end
  module[@js.scope "Uint32ArrayConstructor"] Uint32ArrayConstructor : sig
    type t = _Uint32ArrayConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> elements:float _Iterable -> _Uint32Array [@@js.apply_newable]
    val from: t -> arrayLike:float _Iterable -> ?mapfn:(v:float -> k:float -> float) -> ?thisArg:any -> unit -> _Uint32Array [@@js.call "from"]
  end
  module[@js.scope "Float32Array"] Float32Array : sig
    type t = _Float32Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_iterator_: t -> float _IterableIterator [@@js.call "[Symbol.iterator]"]
    val entries: t -> (float * float) _IterableIterator [@@js.call "entries"]
    val keys: t -> float _IterableIterator [@@js.call "keys"]
    val values: t -> float _IterableIterator [@@js.call "values"]
  end
  module[@js.scope "Float32ArrayConstructor"] Float32ArrayConstructor : sig
    type t = _Float32ArrayConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> elements:float _Iterable -> _Float32Array [@@js.apply_newable]
    val from: t -> arrayLike:float _Iterable -> ?mapfn:(v:float -> k:float -> float) -> ?thisArg:any -> unit -> _Float32Array [@@js.call "from"]
  end
  module[@js.scope "Float64Array"] Float64Array : sig
    type t = _Float64Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_iterator_: t -> float _IterableIterator [@@js.call "[Symbol.iterator]"]
    val entries: t -> (float * float) _IterableIterator [@@js.call "entries"]
    val keys: t -> float _IterableIterator [@@js.call "keys"]
    val values: t -> float _IterableIterator [@@js.call "values"]
  end
  module[@js.scope "Float64ArrayConstructor"] Float64ArrayConstructor : sig
    type t = _Float64ArrayConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> elements:float _Iterable -> _Float64Array [@@js.apply_newable]
    val from: t -> arrayLike:float _Iterable -> ?mapfn:(v:float -> k:float -> float) -> ?thisArg:any -> unit -> _Float64Array [@@js.call "from"]
  end
end
