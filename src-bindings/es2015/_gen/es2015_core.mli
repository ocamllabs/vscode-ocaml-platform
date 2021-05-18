[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - ArrayLike<T1>
  - Date
  - TemplateStringsArray
 *)
[@@@js.stop]
module type Missing = sig
  module ArrayLike : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module Date : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module TemplateStringsArray : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
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
    module Date : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module TemplateStringsArray : sig
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
    end
    module Types : sig
      open AnonymousInterfaces
      type 'T _Array = [`Array of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and _ArrayConstructor = [`ArrayConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _DateConstructor = [`DateConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _Function = untyped_function
      and _Math = [`Math] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NumberConstructor = [`NumberConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _ObjectConstructor = [`ObjectConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T _ReadonlyArray = [`ReadonlyArray of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and _RegExp = regexp
      and _RegExpConstructor = [`RegExpConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _String = [`String] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _StringConstructor = [`StringConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
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
  end
  module[@js.scope "Array"] Array : sig
    type 'T t = 'T _Array
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    val find: 'T t -> predicate:(this:unit -> value:'T -> index:float -> obj:'T list -> bool) -> ?thisArg:any -> unit -> 'S or_undefined [@@js.call "find"]
    val find': 'T t -> predicate:(value:'T -> index:float -> obj:'T list -> unknown) -> ?thisArg:any -> unit -> 'T or_undefined [@@js.call "find"]
    val findIndex: 'T t -> predicate:(value:'T -> index:float -> obj:'T list -> unknown) -> ?thisArg:any -> unit -> float [@@js.call "findIndex"]
    val fill: 'T t -> value:'T -> ?start:float -> ?end_:float -> unit -> 'T t [@@js.call "fill"]
    val copyWithin: 'T t -> target:float -> start:float -> ?end_:float -> unit -> 'T t [@@js.call "copyWithin"]
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
    val from: t -> arrayLike:'T ArrayLike.t_1 -> 'T list [@@js.call "from"]
    val from': t -> arrayLike:'T ArrayLike.t_1 -> mapfn:(v:'T -> k:float -> 'U) -> ?thisArg:any -> unit -> 'U list [@@js.call "from"]
    val of_: t -> items:('T list [@js.variadic]) -> 'T list [@@js.call "of"]
  end
  module[@js.scope "DateConstructor"] DateConstructor : sig
    type t = _DateConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> value:Date.t_0 or_string or_number -> Date.t_0 [@@js.apply_newable]
  end
  module[@js.scope "Function"] Function : sig
    type t = _Function
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_name: t -> string [@@js.get "name"]
  end
  module[@js.scope "Math"] Math : sig
    type t = _Math
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val clz32: t -> x:float -> float [@@js.call "clz32"]
    val imul: t -> x:float -> y:float -> float [@@js.call "imul"]
    val sign: t -> x:float -> float [@@js.call "sign"]
    val log10: t -> x:float -> float [@@js.call "log10"]
    val log2: t -> x:float -> float [@@js.call "log2"]
    val log1p: t -> x:float -> float [@@js.call "log1p"]
    val expm1: t -> x:float -> float [@@js.call "expm1"]
    val cosh: t -> x:float -> float [@@js.call "cosh"]
    val sinh: t -> x:float -> float [@@js.call "sinh"]
    val tanh: t -> x:float -> float [@@js.call "tanh"]
    val acosh: t -> x:float -> float [@@js.call "acosh"]
    val asinh: t -> x:float -> float [@@js.call "asinh"]
    val atanh: t -> x:float -> float [@@js.call "atanh"]
    val hypot: t -> values:(float list [@js.variadic]) -> float [@@js.call "hypot"]
    val trunc: t -> x:float -> float [@@js.call "trunc"]
    val fround: t -> x:float -> float [@@js.call "fround"]
    val cbrt: t -> x:float -> float [@@js.call "cbrt"]
  end
  module[@js.scope "NumberConstructor"] NumberConstructor : sig
    type t = _NumberConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_EPSILON: t -> float [@@js.get "EPSILON"]
    val isFinite: t -> number:unknown -> bool [@@js.call "isFinite"]
    val isInteger: t -> number:unknown -> bool [@@js.call "isInteger"]
    val isNaN: t -> number:unknown -> bool [@@js.call "isNaN"]
    val isSafeInteger: t -> number:unknown -> bool [@@js.call "isSafeInteger"]
    val get_MAX_SAFE_INTEGER: t -> float [@@js.get "MAX_SAFE_INTEGER"]
    val get_MIN_SAFE_INTEGER: t -> float [@@js.get "MIN_SAFE_INTEGER"]
    val parseFloat: t -> string:string -> float [@@js.call "parseFloat"]
    val parseInt: t -> string:string -> ?radix:float -> unit -> float [@@js.call "parseInt"]
  end
  module[@js.scope "ObjectConstructor"] ObjectConstructor : sig
    type t = _ObjectConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val assign: t -> target:'T -> source:'U -> ('T, 'U) intersection2 [@@js.call "assign"]
    val assign': t -> target:'T -> source1:'U -> source2:'V -> ('T, 'U, 'V) intersection3 [@@js.call "assign"]
    val assign'': t -> target:'T -> source1:'U -> source2:'V -> source3:'W -> ('T, 'U, 'V, 'W) intersection4 [@@js.call "assign"]
    val assign''': t -> target:untyped_object -> sources:(any list [@js.variadic]) -> any [@@js.call "assign"]
    val getOwnPropertySymbols: t -> o:any -> symbol list [@@js.call "getOwnPropertySymbols"]
    val keys: t -> o:anonymous_interface_0 -> string list [@@js.call "keys"]
    val is: t -> value1:any -> value2:any -> bool [@@js.call "is"]
    val setPrototypeOf: t -> o:any -> proto:untyped_object or_null -> any [@@js.call "setPrototypeOf"]
  end
  module[@js.scope "ReadonlyArray"] ReadonlyArray : sig
    type 'T t = 'T _ReadonlyArray
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    val find: 'T t -> predicate:(this:unit -> value:'T -> index:float -> obj:'T list -> bool) -> ?thisArg:any -> unit -> 'S or_undefined [@@js.call "find"]
    val find': 'T t -> predicate:(value:'T -> index:float -> obj:'T list -> unknown) -> ?thisArg:any -> unit -> 'T or_undefined [@@js.call "find"]
    val findIndex: 'T t -> predicate:(value:'T -> index:float -> obj:'T list -> unknown) -> ?thisArg:any -> unit -> float [@@js.call "findIndex"]
    val to_ml: 'T t -> 'T list [@@js.cast]
    val of_ml: 'T list -> 'T t [@@js.cast]
  end
  module[@js.scope "RegExp"] RegExp : sig
    type t = _RegExp
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_flags: t -> string [@@js.get "flags"]
    val get_sticky: t -> bool [@@js.get "sticky"]
    val get_unicode: t -> bool [@@js.get "unicode"]
  end
  module[@js.scope "RegExpConstructor"] RegExpConstructor : sig
    type t = _RegExpConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> pattern:_RegExp or_string -> ?flags:string -> unit -> _RegExp [@@js.apply_newable]
    val apply: t -> pattern:_RegExp or_string -> ?flags:string -> unit -> _RegExp [@@js.apply]
  end
  module[@js.scope "String"] String : sig
    type t = _String
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val codePointAt: t -> pos:float -> float or_undefined [@@js.call "codePointAt"]
    val includes: t -> searchString:string -> ?position:float -> unit -> bool [@@js.call "includes"]
    val endsWith: t -> searchString:string -> ?endPosition:float -> unit -> bool [@@js.call "endsWith"]
    val normalize: t -> form:([`L_s0_NFC | `L_s1_NFD | `L_s2_NFKC | `L_s3_NFKD] [@js.enum]) -> string [@@js.call "normalize"]
    val normalize': t -> ?form:string -> unit -> string [@@js.call "normalize"]
    val repeat: t -> count:float -> string [@@js.call "repeat"]
    val startsWith: t -> searchString:string -> ?position:float -> unit -> bool [@@js.call "startsWith"]
    val anchor: t -> name:string -> string [@@js.call "anchor"]
    val big: t -> string [@@js.call "big"]
    val blink: t -> string [@@js.call "blink"]
    val bold: t -> string [@@js.call "bold"]
    val fixed: t -> string [@@js.call "fixed"]
    val fontcolor: t -> color:string -> string [@@js.call "fontcolor"]
    val fontsize: t -> size:float -> string [@@js.call "fontsize"]
    val fontsize': t -> size:string -> string [@@js.call "fontsize"]
    val italics: t -> string [@@js.call "italics"]
    val link: t -> url:string -> string [@@js.call "link"]
    val small: t -> string [@@js.call "small"]
    val strike: t -> string [@@js.call "strike"]
    val sub: t -> string [@@js.call "sub"]
    val sup: t -> string [@@js.call "sup"]
    val to_ml: t -> string [@@js.cast]
    val of_ml: string -> t [@@js.cast]
  end
  module[@js.scope "StringConstructor"] StringConstructor : sig
    type t = _StringConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val fromCodePoint: t -> codePoints:(float list [@js.variadic]) -> string [@@js.call "fromCodePoint"]
    val raw: t -> template:TemplateStringsArray.t_0 -> substitutions:(any list [@js.variadic]) -> string [@@js.call "raw"]
  end
end
