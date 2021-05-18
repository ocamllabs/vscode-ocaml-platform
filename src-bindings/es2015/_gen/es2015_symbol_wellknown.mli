[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - RegExpMatchArray
 *)
[@@@js.stop]
module type Missing = sig
  module RegExpMatchArray : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module RegExpMatchArray : sig
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
      type anonymous_interface_0 = [`anonymous_interface_0] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_1 = [`anonymous_interface_1] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_2 = [`anonymous_interface_2] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_3 = [`anonymous_interface_3] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_4 = [`anonymous_interface_4] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_5 = [`anonymous_interface_5] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
    module Types : sig
      open AnonymousInterfaces
      type 'T _Array = [`Array of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and _ArrayBuffer = [`ArrayBuffer] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _ArrayBufferConstructor = [`ArrayBufferConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _ArrayConstructor = [`ArrayConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _DataView = [`DataView] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Date = [`Date] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Float32Array = [`Float32Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Float64Array = [`Float64Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Function = untyped_function
      and _GeneratorFunction = [`GeneratorFunction] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Int16Array = [`Int16Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Int32Array = [`Int32Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Int8Array = [`Int8Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _JSON = [`JSON] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and ('K, 'V) _Map = [`Map of ('K * 'V)] intf
      [@@js.custom { of_js=(fun _K _V -> Obj.magic); to_js=(fun _K _V -> Obj.magic) }]
      and _MapConstructor = [`MapConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Math = [`Math] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T _Promise = [`Promise of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and _PromiseConstructor = [`PromiseConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _RegExp = regexp
      and _RegExpConstructor = [`RegExpConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T _Set = [`Set of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and _SetConstructor = [`SetConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _String = [`String] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Symbol = symbol
      and _SymbolConstructor = [`SymbolConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Uint16Array = [`Uint16Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Uint32Array = [`Uint32Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Uint8Array = [`Uint8Array] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Uint8ClampedArray = [`Uint8ClampedArray] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and ('K, 'V) _WeakMap = [`WeakMap of ('K * 'V)] intf
      [@@js.custom { of_js=(fun _K _V -> Obj.magic); to_js=(fun _K _V -> Obj.magic) }]
      and 'T _WeakSet = [`WeakSet of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module AnonymousInterface0 : sig
    type t = anonymous_interface_0
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_copyWithin: t -> bool [@@js.get "copyWithin"]
    val set_copyWithin: t -> bool -> unit [@@js.set "copyWithin"]
    val get_entries: t -> bool [@@js.get "entries"]
    val set_entries: t -> bool -> unit [@@js.set "entries"]
    val get_fill: t -> bool [@@js.get "fill"]
    val set_fill: t -> bool -> unit [@@js.set "fill"]
    val get_find: t -> bool [@@js.get "find"]
    val set_find: t -> bool -> unit [@@js.set "find"]
    val get_findIndex: t -> bool [@@js.get "findIndex"]
    val set_findIndex: t -> bool -> unit [@@js.set "findIndex"]
    val get_keys: t -> bool [@@js.get "keys"]
    val set_keys: t -> bool -> unit [@@js.set "keys"]
    val get_values: t -> bool [@@js.get "values"]
    val set_values: t -> bool -> unit [@@js.set "values"]
  end
  module AnonymousInterface1 : sig
    type t = anonymous_interface_1
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_match_: t -> string:string -> RegExpMatchArray.t_0 or_null [@@js.call "[Symbol.match]"]
  end
  module AnonymousInterface2 : sig
    type t = anonymous_interface_2
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_replace_: t -> string:string -> replaceValue:string -> string [@@js.call "[Symbol.replace]"]
  end
  module AnonymousInterface3 : sig
    type t = anonymous_interface_3
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_replace_: t -> string:string -> replacer:(substring:string -> args:(any list [@js.variadic]) -> string) -> string [@@js.call "[Symbol.replace]"]
  end
  module AnonymousInterface4 : sig
    type t = anonymous_interface_4
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_search_: t -> string:string -> float [@@js.call "[Symbol.search]"]
  end
  module AnonymousInterface5 : sig
    type t = anonymous_interface_5
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_split_: t -> string:string -> ?limit:float -> unit -> string list [@@js.call "[Symbol.split]"]
  end
  module[@js.scope "SymbolConstructor"] SymbolConstructor : sig
    type t = _SymbolConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_hasInstance: t -> symbol [@@js.get "hasInstance"]
    val get_isConcatSpreadable: t -> symbol [@@js.get "isConcatSpreadable"]
    val get_match: t -> symbol [@@js.get "match"]
    val get_replace: t -> symbol [@@js.get "replace"]
    val get_search: t -> symbol [@@js.get "search"]
    val get_species: t -> symbol [@@js.get "species"]
    val get_split: t -> symbol [@@js.get "split"]
    val get_toPrimitive: t -> symbol [@@js.get "toPrimitive"]
    val get_toStringTag: t -> symbol [@@js.get "toStringTag"]
    val get_unscopables: t -> symbol [@@js.get "unscopables"]
  end
  module[@js.scope "Symbol"] Symbol : sig
    type t = _Symbol
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_toPrimitive_: t -> hint:string -> symbol [@@js.call "[Symbol.toPrimitive]"]
    val get__Symbol_toStringTag_: t -> string [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "Array"] Array : sig
    type 'T t = 'T _Array
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    val _Symbol_unscopables_: 'T t -> anonymous_interface_0 [@@js.call "[Symbol.unscopables]"]
    val to_ml: 'T t -> 'T list [@@js.cast]
    val of_ml: 'T list -> 'T t [@@js.cast]
  end
  module[@js.scope "Date"] Date : sig
    type t = _Date
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_toPrimitive_: t -> hint:([`L_s9_default] [@js.enum]) -> string [@@js.call "[Symbol.toPrimitive]"]
    val _Symbol_toPrimitive_': t -> hint:([`L_s11_string] [@js.enum]) -> string [@@js.call "[Symbol.toPrimitive]"]
    val _Symbol_toPrimitive_'': t -> hint:([`L_s10_number] [@js.enum]) -> float [@@js.call "[Symbol.toPrimitive]"]
    val _Symbol_toPrimitive_''': t -> hint:string -> string or_number [@@js.call "[Symbol.toPrimitive]"]
  end
  module[@js.scope "Map"] Map : sig
    type ('K, 'V) t = ('K, 'V) _Map
    val t_to_js: ('K -> Ojs.t) -> ('V -> Ojs.t) -> ('K, 'V) t -> Ojs.t
    val t_of_js: (Ojs.t -> 'K) -> (Ojs.t -> 'V) -> Ojs.t -> ('K, 'V) t
    type ('K, 'V) t_2 = ('K, 'V) t
    val t_2_to_js: ('K -> Ojs.t) -> ('V -> Ojs.t) -> ('K, 'V) t_2 -> Ojs.t
    val t_2_of_js: (Ojs.t -> 'K) -> (Ojs.t -> 'V) -> Ojs.t -> ('K, 'V) t_2
    val get__Symbol_toStringTag_: ('K, 'V) t -> string [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "WeakMap"] WeakMap : sig
    type ('K, 'V) t = ('K, 'V) _WeakMap
    val t_to_js: ('K -> Ojs.t) -> ('V -> Ojs.t) -> ('K, 'V) t -> Ojs.t
    val t_of_js: (Ojs.t -> 'K) -> (Ojs.t -> 'V) -> Ojs.t -> ('K, 'V) t
    type ('K, 'V) t_2 = ('K, 'V) t
    val t_2_to_js: ('K -> Ojs.t) -> ('V -> Ojs.t) -> ('K, 'V) t_2 -> Ojs.t
    val t_2_of_js: (Ojs.t -> 'K) -> (Ojs.t -> 'V) -> Ojs.t -> ('K, 'V) t_2
    val get__Symbol_toStringTag_: ('K, 'V) t -> string [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "Set"] Set : sig
    type 'T t = 'T _Set
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    val get__Symbol_toStringTag_: 'T t -> string [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "WeakSet"] WeakSet : sig
    type 'T t = 'T _WeakSet
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    val get__Symbol_toStringTag_: 'T t -> string [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "JSON"] JSON : sig
    type t = _JSON
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_toStringTag_: t -> string [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "Function"] Function : sig
    type t = _Function
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_hasInstance_: t -> value:any -> bool [@@js.call "[Symbol.hasInstance]"]
  end
  module[@js.scope "GeneratorFunction"] GeneratorFunction : sig
    type t = _GeneratorFunction
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_toStringTag_: t -> string [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "Math"] Math : sig
    type t = _Math
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_toStringTag_: t -> string [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "Promise"] Promise : sig
    type 'T t = 'T _Promise
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    val get__Symbol_toStringTag_: 'T t -> string [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "PromiseConstructor"] PromiseConstructor : sig
    type t = _PromiseConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_species_: t -> t [@@js.get "[Symbol.species]"]
  end
  module[@js.scope "RegExp"] RegExp : sig
    type t = _RegExp
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val _Symbol_match_: t -> string:string -> RegExpMatchArray.t_0 or_null [@@js.call "[Symbol.match]"]
    val _Symbol_replace_: t -> string:string -> replaceValue:string -> string [@@js.call "[Symbol.replace]"]
    val _Symbol_replace_': t -> string:string -> replacer:(substring:string -> args:(any list [@js.variadic]) -> string) -> string [@@js.call "[Symbol.replace]"]
    val _Symbol_search_: t -> string:string -> float [@@js.call "[Symbol.search]"]
    val _Symbol_split_: t -> string:string -> ?limit:float -> unit -> string list [@@js.call "[Symbol.split]"]
  end
  module[@js.scope "RegExpConstructor"] RegExpConstructor : sig
    type t = _RegExpConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_species_: t -> t [@@js.get "[Symbol.species]"]
  end
  module[@js.scope "String"] String : sig
    type t = _String
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val match_: t -> matcher:anonymous_interface_1 -> RegExpMatchArray.t_0 or_null [@@js.call "match"]
    val replace: t -> searchValue:anonymous_interface_2 -> replaceValue:string -> string [@@js.call "replace"]
    val replace': t -> searchValue:anonymous_interface_3 -> replacer:(substring:string -> args:(any list [@js.variadic]) -> string) -> string [@@js.call "replace"]
    val search: t -> searcher:anonymous_interface_4 -> float [@@js.call "search"]
    val split: t -> splitter:anonymous_interface_5 -> ?limit:float -> unit -> string list [@@js.call "split"]
    val to_ml: t -> string [@@js.cast]
    val of_ml: string -> t [@@js.cast]
  end
  module[@js.scope "ArrayBuffer"] ArrayBuffer : sig
    type t = _ArrayBuffer
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_toStringTag_: t -> string [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "DataView"] DataView : sig
    type t = _DataView
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_toStringTag_: t -> string [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "Int8Array"] Int8Array : sig
    type t = _Int8Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_toStringTag_: t -> ([`L_s4_Int8Array[@js "Int8Array"]] [@js.enum]) [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "Uint8Array"] Uint8Array : sig
    type t = _Uint8Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_toStringTag_: t -> ([`L_s7_Uint8Array[@js "Uint8Array"]] [@js.enum]) [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "Uint8ClampedArray"] Uint8ClampedArray : sig
    type t = _Uint8ClampedArray
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_toStringTag_: t -> ([`L_s8_Uint8ClampedArray[@js "Uint8ClampedArray"]] [@js.enum]) [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "Int16Array"] Int16Array : sig
    type t = _Int16Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_toStringTag_: t -> ([`L_s2_Int16Array[@js "Int16Array"]] [@js.enum]) [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "Uint16Array"] Uint16Array : sig
    type t = _Uint16Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_toStringTag_: t -> ([`L_s5_Uint16Array[@js "Uint16Array"]] [@js.enum]) [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "Int32Array"] Int32Array : sig
    type t = _Int32Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_toStringTag_: t -> ([`L_s3_Int32Array[@js "Int32Array"]] [@js.enum]) [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "Uint32Array"] Uint32Array : sig
    type t = _Uint32Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_toStringTag_: t -> ([`L_s6_Uint32Array[@js "Uint32Array"]] [@js.enum]) [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "Float32Array"] Float32Array : sig
    type t = _Float32Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_toStringTag_: t -> ([`L_s0_Float32Array[@js "Float32Array"]] [@js.enum]) [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "Float64Array"] Float64Array : sig
    type t = _Float64Array
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_toStringTag_: t -> ([`L_s1_Float64Array[@js "Float64Array"]] [@js.enum]) [@@js.get "[Symbol.toStringTag]"]
  end
  module[@js.scope "ArrayConstructor"] ArrayConstructor : sig
    type t = _ArrayConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_species_: t -> t [@@js.get "[Symbol.species]"]
  end
  module[@js.scope "MapConstructor"] MapConstructor : sig
    type t = _MapConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_species_: t -> t [@@js.get "[Symbol.species]"]
  end
  module[@js.scope "SetConstructor"] SetConstructor : sig
    type t = _SetConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_species_: t -> t [@@js.get "[Symbol.species]"]
  end
  module[@js.scope "ArrayBufferConstructor"] ArrayBufferConstructor : sig
    type t = _ArrayBufferConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get__Symbol_species_: t -> t [@@js.get "[Symbol.species]"]
  end
end
