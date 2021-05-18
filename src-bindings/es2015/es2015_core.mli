[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es5

module Array : sig
  include module type of struct
    include Array
  end

  val find :
       'T t
    -> (this:unit -> value:'T -> index:int -> obj:'T list -> bool)
    -> ?this_arg:any
    -> unit
    -> 'S or_undefined
    [@@js.call "find"]

  val find' :
       'T t
    -> (value:'T -> index:int -> obj:'T list -> unknown)
    -> ?this_arg:any
    -> unit
    -> 'T or_undefined
    [@@js.call "find"]

  val find_index :
       'T t
    -> (value:'T -> index:int -> obj:'T list -> unknown)
    -> ?this_arg:any
    -> unit
    -> int
    [@@js.call "findIndex"]

  val fill : 'T t -> value:'T -> ?start:int -> ?end_:int -> unit -> 'T t
    [@@js.call "fill"]

  val copy_within : 'T t -> target:int -> start:int -> ?end_:int -> unit -> 'T t
    [@@js.call "copyWithin"]

  val to_ml : 'T t -> 'T list [@@js.cast]

  val of_ml : 'T list -> 'T t [@@js.cast]
end
[@@js.scope "Array"]

module Array_constructor : sig
  include module type of struct
    include Array_constructor
  end

  val from : t -> array:'T Array.t -> 'T list [@@js.call "from"]

  val from' :
       t
    -> array:'T Array.t
    -> mapfn:(v:'T -> k:int -> 'U)
    -> ?this_arg:any
    -> unit
    -> 'U list
    [@@js.call "from"]

  val of_ : t -> items:('T list[@js.variadic]) -> 'T list [@@js.call "of"]
end
[@@js.scope "ArrayConstructor"]

module Date_constructor : sig
  include module type of struct
    include Date_constructor
  end

  val create : t -> value:Date.t or_string or_number -> Date.t
    [@@js.apply_newable]
end
[@@js.scope "DateConstructor"]

module Function : sig
  include module type of struct
    include Function
  end

  val get_name : t -> string [@@js.get "name"]
end
[@@js.scope "Function"]

module Math : sig
  include module type of struct
    include Math
  end

  val clz32 : int -> int [@@js.global "Math.clz32"]

  val imul : x:int -> y:int -> int [@@js.global "Math.imul"]

  val sign : int -> int [@@js.global "Math.sign"]

  val log10 : int -> int [@@js.global "Math.log10"]

  val log2 : int -> int [@@js.global "Math.log2"]

  val log1p : int -> int [@@js.global "Math.log1p"]

  val expm1 : int -> int [@@js.global "Math.expm1"]

  val cosh : int -> int [@@js.global "Math.cosh"]

  val sinh : int -> int [@@js.global "Math.sinh"]

  val tanh : int -> int [@@js.global "Math.tanh"]

  val acosh : int -> int [@@js.global "Math.acosh"]

  val asinh : int -> int [@@js.global "Math.asinh"]

  val atanh : int -> int [@@js.global "Math.atanh"]

  val hypot : (int list[@js.variadic]) -> int [@@js.global "Math.hypot"]

  val trunc : int -> int [@@js.global "Math.trunc"]

  val fround : int -> int [@@js.global "Math.fround"]

  val cbrt : int -> int [@@js.global "Math.cbrt"]
end

module Number_constructor : sig
  include module type of struct
    include Number_constructor
  end

  val get_epsilon : t -> int [@@js.get "EPSILON"]

  val is_finite : t -> number:unknown -> bool [@@js.call "isFinite"]

  val is_integer : t -> number:unknown -> bool [@@js.call "isInteger"]

  val is_na_n : t -> number:unknown -> bool [@@js.call "isNaN"]

  val is_safe_integer : t -> number:unknown -> bool [@@js.call "isSafeInteger"]

  val get_max_safe_integer : t -> int [@@js.get "MAX_SAFE_INTEGER"]

  val get_min_safe_integer : t -> int [@@js.get "MIN_SAFE_INTEGER"]

  val parse_float : t -> string:string -> int [@@js.call "parseFloat"]

  val parse_int : t -> string:string -> ?radix:int -> unit -> int
    [@@js.call "parseInt"]
end
[@@js.scope "NumberConstructor"]

module Object_constructor : sig
  include module type of struct
    include Object_constructor
  end

  val assign : t -> target:'T -> source:'U -> ('T, 'U) intersection2
    [@@js.call "assign"]

  val assign' :
    t -> target:'T -> source1:'U -> source2:'V -> ('T, 'U, 'V) intersection3
    [@@js.call "assign"]

  val assign'' :
       t
    -> target:'T
    -> source1:'U
    -> source2:'V
    -> source3:'W
    -> ('T, 'U, 'V, 'W) intersection4
    [@@js.call "assign"]

  val assign''' :
    t -> target:untyped_object -> sources:(any list[@js.variadic]) -> any
    [@@js.call "assign"]

  val get_own_property_symbols : t -> any -> symbol list
    [@@js.call "getOwnPropertySymbols"]

  val keys : t -> any -> string list [@@js.call "keys"]

  val is : t -> value1:any -> value2:any -> bool [@@js.call "is"]

  val set_prototype_of : t -> any -> proto:untyped_object or_null -> any
    [@@js.call "setPrototypeOf"]
end
[@@js.scope "ObjectConstructor"]

module Readonly_array : sig
  include module type of struct
    include Readonly_array
  end

  val find :
       'T t
    -> (this:unit -> value:'T -> index:int -> obj:'T list -> bool)
    -> ?this_arg:any
    -> unit
    -> 'S or_undefined
    [@@js.call "find"]

  val find' :
       'T t
    -> (value:'T -> index:int -> obj:'T list -> unknown)
    -> ?this_arg:any
    -> unit
    -> 'T or_undefined
    [@@js.call "find"]

  val find_index :
       'T t
    -> (value:'T -> index:int -> obj:'T list -> unknown)
    -> ?this_arg:any
    -> unit
    -> int
    [@@js.call "findIndex"]

  val to_ml : 'T t -> 'T list [@@js.cast]

  val of_ml : 'T list -> 'T t [@@js.cast]
end
[@@js.scope "ReadonlyArray"]

module Reg_exp : sig
  include module type of struct
    include Reg_exp
  end

  val get_flags : t -> string [@@js.get "flags"]

  val get_sticky : t -> bool [@@js.get "sticky"]

  val get_unicode : t -> bool [@@js.get "unicode"]

  type replacer =
       matched:string
    -> captures:string list
    -> offset:int
    -> string:string
    -> string

  [@@@js.stop]

  val replace : string -> regexp:t -> replacer:replacer -> string

  [@@@js.start]

  [@@@js.implem
  val replace :
       string
    -> regexp:t
    -> replacer:(string -> (Ojs.t list[@js.variadic]) -> string)
    -> string
    [@@js.call]

  let replace s ~regexp ~(replacer : replacer) =
    let rec separate acc = function
      | offset :: string :: _ when Ojs.type_of offset = "number" ->
        (List.rev acc, [%js.to: int] offset, [%js.to: string] string)
      | capture :: args -> separate ([%js.to: string] capture :: acc) args
      | _ -> assert false
      (* replacer arguments will always be terminated with a numeric offset and
         final string *)
    in
    let js_replacer matched args =
      let captures, offset, string = separate [] args in
      replacer ~matched ~captures ~offset ~string
    in
    replace s ~regexp ~replacer:js_replacer]
end
[@@js.scope "RegExp"]

module Reg_exp_constructor : sig
  include module type of struct
    include Reg_exp_constructor
  end

  val create :
    t -> pattern:Reg_exp.t or_string -> ?flags:string -> unit -> Reg_exp.t
    [@@js.apply_newable]

  val apply :
    t -> pattern:Reg_exp.t or_string -> ?flags:string -> unit -> Reg_exp.t
    [@@js.apply]
end
[@@js.scope "RegExpConstructor"]

module String : sig
  include module type of struct
    include String
  end

  val code_point_at : t -> pos:int -> int or_undefined [@@js.call "codePointAt"]

  val includes : t -> search_string:string -> ?position:int -> unit -> bool
    [@@js.call "includes"]

  val ends_with : t -> search_string:string -> ?end_position:int -> unit -> bool
    [@@js.call "endsWith"]

  val normalize :
    t -> form:([ `NFC | `NFD | `NFKC | `NFKD ][@js.enum]) -> string
    [@@js.call "normalize"]

  val normalize' : t -> ?form:string -> unit -> string [@@js.call "normalize"]

  val repeat : t -> count:int -> string [@@js.call "repeat"]

  val starts_with : t -> search_string:string -> ?position:int -> unit -> bool
    [@@js.call "startsWith"]

  val anchor : t -> name:string -> string [@@js.call "anchor"]

  val big : t -> string [@@js.call "big"]

  val blink : t -> string [@@js.call "blink"]

  val bold : t -> string [@@js.call "bold"]

  val fixed : t -> string [@@js.call "fixed"]

  val fontcolor : t -> color:string -> string [@@js.call "fontcolor"]

  val fontsize : t -> size:int -> string [@@js.call "fontsize"]

  val fontsize' : t -> size:string -> string [@@js.call "fontsize"]

  val italics : t -> string [@@js.call "italics"]

  val link : t -> url:string -> string [@@js.call "link"]

  val small : t -> string [@@js.call "small"]

  val strike : t -> string [@@js.call "strike"]

  val sub : t -> string [@@js.call "sub"]

  val sup : t -> string [@@js.call "sup"]

  val to_ml : t -> string [@@js.cast]

  val of_ml : string -> t [@@js.cast]
end
[@@js.scope "String"]

module String_constructor : sig
  include module type of struct
    include String_constructor
  end

  val from_code_point : t -> code_points:(int list[@js.variadic]) -> string
    [@@js.call "fromCodePoint"]

  val raw :
       t
    -> template:Template_strings_array.t
    -> substitutions:(any list[@js.variadic])
    -> string
    [@@js.call "raw"]
end
[@@js.scope "StringConstructor"]
