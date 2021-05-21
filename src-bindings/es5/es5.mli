[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

(* Ts2ocaml_baselib *)

type never = private Ojs.t

val never_to_js : never -> Ojs.t

val never_of_js : Ojs.t -> never

module Never : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val absurd : t -> 'a
    [@@js.custom
      exception Ts_Never

      let absurd _ = raise Ts_Never]
end

type any = Ojs.t

val any_to_js : any -> Ojs.t

val any_of_js : Ojs.t -> any

module Any : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val unsafe_cast : t -> 'a [@@js.custom let unsafe_cast x = Obj.magic x]
end

type unknown = private Ojs.t

val unknown_to_js : unknown -> Ojs.t

val unknown_of_js : Ojs.t -> unknown

module Unknown : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val unsafe_cast : t -> 'a [@@js.custom let unsafe_cast x = Obj.magic x]
end

[@@@js.stop]

type ('t, +'a) enum

val enum_to_js : ('t -> Ojs.t) -> ('a -> Ojs.t) -> ('t, 'a) enum -> Ojs.t

val enum_of_js : (Ojs.t -> 't) -> (Ojs.t -> 'a) -> Ojs.t -> ('t, 'a) enum

[@@@js.start]

[@@@js.implem
type ('t, +'a) enum = 'a

let enum_to_js (_ : 't -> Ojs.t) (f : 'a -> Ojs.t) (e : ('t, 'a) enum) : Ojs.t =
  f e

let enum_of_js (_ : Ojs.t -> 't) (f : Ojs.t -> 'a) (e : Ojs.t) : ('t, 'a) enum =
  f e]

module Enum : sig
  [@@@js.stop]

  type ('t, +'a) t = ('t, 'a) enum

  val t_to_js : ('t -> Ojs.t) -> ('a -> Ojs.t) -> ('t, 'a) t -> Ojs.t

  val t_of_js : (Ojs.t -> 't) -> (Ojs.t -> 'a) -> Ojs.t -> ('t, 'a) t

  [@@@js.start]

  [@@@js.implem
  type ('t, +'a) t = ('t, 'a) enum

  let t_to_js = enum_to_js

  let t_of_js = enum_of_js]

  val get_value : ('t, 'a) t -> 'a [@@js.custom let get_value x = x]
end

type untyped_object

val untyped_object_of_js : Ojs.t -> untyped_object

val untyped_object_to_js : untyped_object -> Ojs.t

type untyped_function

val untyped_function_of_js : Ojs.t -> untyped_function

val untyped_function_to_js : untyped_function -> Ojs.t

type symbol

val symbol_of_js : Ojs.t -> symbol

val symbol_to_js : symbol -> Ojs.t

type regexp

val regexp_of_js : Ojs.t -> regexp

val regexp_to_js : regexp -> Ojs.t

type bigint

val bigint_of_js : Ojs.t -> bigint

val bigint_to_js : bigint -> Ojs.t

type 'a or_null = 'a option

val or_null_to_js : ('a -> Ojs.t) -> 'a or_null -> Ojs.t

val or_null_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a or_null

type 'a or_undefined = 'a option

val or_undefined_to_js : ('a -> Ojs.t) -> 'a or_undefined -> Ojs.t

val or_undefined_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a or_undefined

type 'a or_null_or_undefined = 'a option

val or_null_or_undefined_to_js :
  ('a -> Ojs.t) -> 'a or_null_or_undefined -> Ojs.t

val or_null_or_undefined_of_js :
  (Ojs.t -> 'a) -> Ojs.t -> 'a or_null_or_undefined

type ('a, 'b) and_ = private Ojs.t

val and__to_js : ('a -> Ojs.t) -> ('b -> Ojs.t) -> ('a, 'b) and_ -> Ojs.t

val and__of_js : (Ojs.t -> 'a) -> (Ojs.t -> 'b) -> Ojs.t -> ('a, 'b) and_

module And : sig
  type ('a, 'b) t = ('a, 'b) and_

  val t_to_js : ('a -> Ojs.t) -> ('b -> Ojs.t) -> ('a, 'b) t -> Ojs.t

  val t_of_js : (Ojs.t -> 'a) -> (Ojs.t -> 'b) -> Ojs.t -> ('a, 'b) t

  val car : ('a, 'b) t -> 'a
    [@@js.custom let car (x : ('a, 'b) t) : 'a = Obj.magic x]

  val cdr : ('a, 'b) t -> 'b
    [@@js.custom let cdr (x : ('a, 'b) t) : 'b = Obj.magic x]
end

type ('a, 'b) intersection2 = ('b, 'a) and_

val intersection2_to_js :
  ('a -> Ojs.t) -> ('b -> Ojs.t) -> ('a, 'b) intersection2 -> Ojs.t

val intersection2_of_js :
  (Ojs.t -> 'a) -> (Ojs.t -> 'b) -> Ojs.t -> ('a, 'b) intersection2

type ('a, 'b, 'c) intersection3 = (('b, 'c) intersection2, 'a) and_

val intersection3_to_js :
     ('a -> Ojs.t)
  -> ('b -> Ojs.t)
  -> ('c -> Ojs.t)
  -> ('a, 'b, 'c) intersection3
  -> Ojs.t

val intersection3_of_js :
     (Ojs.t -> 'a)
  -> (Ojs.t -> 'b)
  -> (Ojs.t -> 'c)
  -> Ojs.t
  -> ('a, 'b, 'c) intersection3

type ('a, 'b, 'c, 'd) intersection4 = (('b, 'c, 'd) intersection3, 'a) and_

val intersection4_to_js :
     ('a -> Ojs.t)
  -> ('b -> Ojs.t)
  -> ('c -> Ojs.t)
  -> ('d -> Ojs.t)
  -> ('a, 'b, 'c, 'd) intersection4
  -> Ojs.t

val intersection4_of_js :
     (Ojs.t -> 'a)
  -> (Ojs.t -> 'b)
  -> (Ojs.t -> 'c)
  -> (Ojs.t -> 'd)
  -> Ojs.t
  -> ('a, 'b, 'c, 'd) intersection4

type ('a, 'b, 'c, 'd, 'e) intersection5 =
  (('b, 'c, 'd, 'e) intersection4, 'a) and_

val intersection5_to_js :
     ('a -> Ojs.t)
  -> ('b -> Ojs.t)
  -> ('c -> Ojs.t)
  -> ('d -> Ojs.t)
  -> ('e -> Ojs.t)
  -> ('a, 'b, 'c, 'd, 'e) intersection5
  -> Ojs.t

val intersection5_of_js :
     (Ojs.t -> 'a)
  -> (Ojs.t -> 'b)
  -> (Ojs.t -> 'c)
  -> (Ojs.t -> 'd)
  -> (Ojs.t -> 'e)
  -> Ojs.t
  -> ('a, 'b, 'c, 'd, 'e) intersection5

type ('a, 'b, 'c, 'd, 'e, 'f) intersection6 =
  (('b, 'c, 'd, 'e, 'f) intersection5, 'a) and_

val intersection6_to_js :
     ('a -> Ojs.t)
  -> ('b -> Ojs.t)
  -> ('c -> Ojs.t)
  -> ('d -> Ojs.t)
  -> ('e -> Ojs.t)
  -> ('f -> Ojs.t)
  -> ('a, 'b, 'c, 'd, 'e, 'f) intersection6
  -> Ojs.t

val intersection6_of_js :
     (Ojs.t -> 'a)
  -> (Ojs.t -> 'b)
  -> (Ojs.t -> 'c)
  -> (Ojs.t -> 'd)
  -> (Ojs.t -> 'e)
  -> (Ojs.t -> 'f)
  -> Ojs.t
  -> ('a, 'b, 'c, 'd, 'e, 'f) intersection6

type ('a, 'b, 'c, 'd, 'e, 'f, 'g) intersection7 =
  (('b, 'c, 'd, 'e, 'f, 'g) intersection6, 'a) and_

val intersection7_to_js :
     ('a -> Ojs.t)
  -> ('b -> Ojs.t)
  -> ('c -> Ojs.t)
  -> ('d -> Ojs.t)
  -> ('e -> Ojs.t)
  -> ('f -> Ojs.t)
  -> ('g -> Ojs.t)
  -> ('a, 'b, 'c, 'd, 'e, 'f, 'g) intersection7
  -> Ojs.t

val intersection7_of_js :
     (Ojs.t -> 'a)
  -> (Ojs.t -> 'b)
  -> (Ojs.t -> 'c)
  -> (Ojs.t -> 'd)
  -> (Ojs.t -> 'e)
  -> (Ojs.t -> 'f)
  -> (Ojs.t -> 'g)
  -> Ojs.t
  -> ('a, 'b, 'c, 'd, 'e, 'f, 'g) intersection7

type ('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h) intersection8 =
  (('b, 'c, 'd, 'e, 'f, 'g, 'h) intersection7, 'a) and_

val intersection8_to_js :
     ('a -> Ojs.t)
  -> ('b -> Ojs.t)
  -> ('c -> Ojs.t)
  -> ('d -> Ojs.t)
  -> ('e -> Ojs.t)
  -> ('f -> Ojs.t)
  -> ('g -> Ojs.t)
  -> ('h -> Ojs.t)
  -> ('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h) intersection8
  -> Ojs.t

val intersection8_of_js :
     (Ojs.t -> 'a)
  -> (Ojs.t -> 'b)
  -> (Ojs.t -> 'c)
  -> (Ojs.t -> 'd)
  -> (Ojs.t -> 'e)
  -> (Ojs.t -> 'f)
  -> (Ojs.t -> 'g)
  -> (Ojs.t -> 'h)
  -> Ojs.t
  -> ('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h) intersection8

module Intersection : sig
  val get_0 : ('a, 'b) intersection2 -> 'a
    [@@js.custom let get_0 x = Obj.magic x]

  val get_1 : ('a, 'b, 'c) intersection3 -> 'b
    [@@js.custom let get_1 x = Obj.magic x]

  val get_2 : ('a, 'b, 'c, 'd) intersection4 -> 'c
    [@@js.custom let get_2 x = Obj.magic x]

  val get_3 : ('a, 'b, 'c, 'd, 'e) intersection5 -> 'd
    [@@js.custom let get_3 x = Obj.magic x]

  val get_4 : ('a, 'b, 'c, 'd, 'e, 'f) intersection6 -> 'e
    [@@js.custom let get_4 x = Obj.magic x]

  val get_5 : ('a, 'b, 'c, 'd, 'e, 'f, 'g) intersection7 -> 'f
    [@@js.custom let get_5 x = Obj.magic x]

  val get_6 : ('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h) intersection8 -> 'g
    [@@js.custom let get_6 x = Obj.magic x]
end

[@@@js.stop]

type ('a, 'b) or_

val or__to_js : ('a -> Ojs.t) -> ('b -> Ojs.t) -> ('a, 'b) or_ -> Ojs.t

val or__of_js : (Ojs.t -> 'a) -> (Ojs.t -> 'b) -> Ojs.t -> ('a, 'b) or_

[@@@js.start]

[@@@js.implem
type ('a, 'b) or_from_js =
  { a_of_js : Ojs.t -> 'a
  ; b_of_js : Ojs.t -> 'b
  ; value : Ojs.t
  }

type ('a, 'b) or_ =
  | A of 'a
  | B of 'b
  | FromJS of ('a, 'b) or_from_js

let or__to_js a_to_js b_to_js = function
  | A a -> a_to_js a
  | B b -> b_to_js b
  | FromJS x -> x.value

let or__of_js a_of_js b_of_js value = FromJS { a_of_js; b_of_js; value }]

module Or : sig
  type ('a, 'b) t = ('a, 'b) or_

  val t_to_js : ('a -> Ojs.t) -> ('b -> Ojs.t) -> ('a, 'b) t -> Ojs.t

  val t_of_js : (Ojs.t -> 'a) -> (Ojs.t -> 'b) -> Ojs.t -> ('a, 'b) t

  val inl : 'a -> ('a, 'b) t [@@js.custom let inl (x : 'a) : ('a, 'b) t = A x]

  val inr : 'b -> ('a, 'b) t [@@js.custom let inr (x : 'b) : ('a, 'b) t = B x]

  val test :
       is_left:(Ojs.t -> bool)
    -> is_right:(Ojs.t -> bool)
    -> ('a, 'b) t
    -> [ `Left of 'a | `Right of 'b | `Other of Ojs.t ]
    [@@js.custom
      let test ~is_left ~is_right = function
        | A a -> `Left a
        | B b -> `Right b
        | FromJS x ->
          if is_left x.value then
            `Left (x.a_of_js x.value)
          else if is_right x.value then
            `Right (x.b_of_js x.value)
          else
            `Other x.value]
end

type ('a, 'b) union2 = ('b, 'a) or_

val union2_to_js : ('a -> Ojs.t) -> ('b -> Ojs.t) -> ('a, 'b) union2 -> Ojs.t

val union2_of_js : (Ojs.t -> 'a) -> (Ojs.t -> 'b) -> Ojs.t -> ('a, 'b) union2

type ('a, 'b, 'c) union3 = (('b, 'c) union2, 'a) or_

val union3_to_js :
     ('a -> Ojs.t)
  -> ('b -> Ojs.t)
  -> ('c -> Ojs.t)
  -> ('a, 'b, 'c) union3
  -> Ojs.t

val union3_of_js :
     (Ojs.t -> 'a)
  -> (Ojs.t -> 'b)
  -> (Ojs.t -> 'c)
  -> Ojs.t
  -> ('a, 'b, 'c) union3

type ('a, 'b, 'c, 'd) union4 = (('b, 'c, 'd) union3, 'a) or_

val union4_to_js :
     ('a -> Ojs.t)
  -> ('b -> Ojs.t)
  -> ('c -> Ojs.t)
  -> ('d -> Ojs.t)
  -> ('a, 'b, 'c, 'd) union4
  -> Ojs.t

val union4_of_js :
     (Ojs.t -> 'a)
  -> (Ojs.t -> 'b)
  -> (Ojs.t -> 'c)
  -> (Ojs.t -> 'd)
  -> Ojs.t
  -> ('a, 'b, 'c, 'd) union4

type ('a, 'b, 'c, 'd, 'e) union5 = (('b, 'c, 'd, 'e) union4, 'a) or_

val union5_to_js :
     ('a -> Ojs.t)
  -> ('b -> Ojs.t)
  -> ('c -> Ojs.t)
  -> ('d -> Ojs.t)
  -> ('e -> Ojs.t)
  -> ('a, 'b, 'c, 'd, 'e) union5
  -> Ojs.t

val union5_of_js :
     (Ojs.t -> 'a)
  -> (Ojs.t -> 'b)
  -> (Ojs.t -> 'c)
  -> (Ojs.t -> 'd)
  -> (Ojs.t -> 'e)
  -> Ojs.t
  -> ('a, 'b, 'c, 'd, 'e) union5

type ('a, 'b, 'c, 'd, 'e, 'f) union6 = (('b, 'c, 'd, 'e, 'f) union5, 'a) or_

val union6_to_js :
     ('a -> Ojs.t)
  -> ('b -> Ojs.t)
  -> ('c -> Ojs.t)
  -> ('d -> Ojs.t)
  -> ('e -> Ojs.t)
  -> ('f -> Ojs.t)
  -> ('a, 'b, 'c, 'd, 'e, 'f) union6
  -> Ojs.t

val union6_of_js :
     (Ojs.t -> 'a)
  -> (Ojs.t -> 'b)
  -> (Ojs.t -> 'c)
  -> (Ojs.t -> 'd)
  -> (Ojs.t -> 'e)
  -> (Ojs.t -> 'f)
  -> Ojs.t
  -> ('a, 'b, 'c, 'd, 'e, 'f) union6

type ('a, 'b, 'c, 'd, 'e, 'f, 'g) union7 =
  (('b, 'c, 'd, 'e, 'f, 'g) union6, 'a) or_

val union7_to_js :
     ('a -> Ojs.t)
  -> ('b -> Ojs.t)
  -> ('c -> Ojs.t)
  -> ('d -> Ojs.t)
  -> ('e -> Ojs.t)
  -> ('f -> Ojs.t)
  -> ('g -> Ojs.t)
  -> ('a, 'b, 'c, 'd, 'e, 'f, 'g) union7
  -> Ojs.t

val union7_of_js :
     (Ojs.t -> 'a)
  -> (Ojs.t -> 'b)
  -> (Ojs.t -> 'c)
  -> (Ojs.t -> 'd)
  -> (Ojs.t -> 'e)
  -> (Ojs.t -> 'f)
  -> (Ojs.t -> 'g)
  -> Ojs.t
  -> ('a, 'b, 'c, 'd, 'e, 'f, 'g) union7

type ('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h) union8 =
  (('b, 'c, 'd, 'e, 'f, 'g, 'h) union7, 'a) or_

val union8_to_js :
     ('a -> Ojs.t)
  -> ('b -> Ojs.t)
  -> ('c -> Ojs.t)
  -> ('d -> Ojs.t)
  -> ('e -> Ojs.t)
  -> ('f -> Ojs.t)
  -> ('g -> Ojs.t)
  -> ('h -> Ojs.t)
  -> ('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h) union8
  -> Ojs.t

val union8_of_js :
     (Ojs.t -> 'a)
  -> (Ojs.t -> 'b)
  -> (Ojs.t -> 'c)
  -> (Ojs.t -> 'd)
  -> (Ojs.t -> 'e)
  -> (Ojs.t -> 'f)
  -> (Ojs.t -> 'g)
  -> (Ojs.t -> 'h)
  -> Ojs.t
  -> ('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h) union8

module Union : sig
  val inject_0 : 'a -> ('a, 'b) union2
    [@@js.custom let inject_0 x = Obj.magic x]

  val inject_1 : 'b -> ('a, 'b, 'c) union3
    [@@js.custom let inject_1 x = Obj.magic x]

  val inject_2 : 'c -> ('a, 'b, 'c, 'd) union4
    [@@js.custom let inject_2 x = Obj.magic x]

  val inject_3 : 'd -> ('a, 'b, 'c, 'd, 'e) union5
    [@@js.custom let inject_3 x = Obj.magic x]

  val inject_4 : 'e -> ('a, 'b, 'c, 'd, 'e, 'f) union6
    [@@js.custom let inject_4 x = Obj.magic x]

  val inject_5 : 'f -> ('a, 'b, 'c, 'd, 'e, 'f, 'g) union7
    [@@js.custom let inject_5 x = Obj.magic x]

  val inject_6 : 'g -> ('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h) union8
    [@@js.custom let inject_6 x = Obj.magic x]
end

type 'a or_string =
  [ `String of string
  | `Other of 'a
  ]
[@@js.custom
  { of_js =
      (fun a_of_js x ->
        match Ojs.type_of x with
        | "string" -> `String (Ojs.string_of_js x)
        | _ -> `Other (a_of_js x))
  ; to_js =
      (fun a_to_js -> function
        | `String x -> Ojs.string_to_js x
        | `Other x -> a_to_js x)
  }]

val or_string_to_js : ('a -> Ojs.t) -> 'a or_string -> Ojs.t

val or_string_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a or_string

type 'a or_number =
  [ `Number of float
  | `Other of 'a
  ]
[@@js.custom
  { of_js =
      (fun a_of_js x ->
        match Ojs.type_of x with
        | "number" -> `Number (Ojs.float_of_js x)
        | _ -> `Other (a_of_js x))
  ; to_js =
      (fun a_to_js -> function
        | `Number x -> Ojs.float_to_js x
        | `Other x -> a_to_js x)
  }]

val or_number_to_js : ('a -> Ojs.t) -> 'a or_number -> Ojs.t

val or_number_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a or_number

type 'a or_boolean =
  [ `Boolean of bool
  | `Other of 'a
  ]
[@@js.custom
  { of_js =
      (fun a_of_js x ->
        match Ojs.type_of x with
        | "boolean" -> `Boolean (Ojs.bool_of_js x)
        | _ -> `Other (a_of_js x))
  ; to_js =
      (fun a_to_js -> function
        | `Boolean x -> Ojs.bool_to_js x
        | `Other x -> a_to_js x)
  }]

val or_boolean_to_js : ('a -> Ojs.t) -> 'a or_boolean -> Ojs.t

val or_boolean_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a or_boolean

type 'a or_symbol =
  [ `Symbol of symbol
  | `Other of 'a
  ]
[@@js.custom
  { of_js =
      (fun a_of_js x ->
        match Ojs.type_of x with
        | "symbol" -> `Symbol (symbol_of_js x)
        | _ -> `Other (a_of_js x))
  ; to_js =
      (fun a_to_js -> function
        | `Symbol x -> symbol_to_js x
        | `Other x -> a_to_js x)
  }]

val or_symbol_to_js : ('a -> Ojs.t) -> 'a or_symbol -> Ojs.t

val or_symbol_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a or_symbol

type 'a or_bigint =
  [ `BigInt of bigint
  | `Other of 'a
  ]
[@@js.custom
  { of_js =
      (fun a_of_js x ->
        match Ojs.type_of x with
        | "bigint" -> `BigInt (bigint_of_js x)
        | _ -> `Other (a_of_js x))
  ; to_js =
      (fun a_to_js -> function
        | `BigInt x -> bigint_to_js x
        | `Other x -> a_to_js x)
  }]

val or_bigint_to_js : ('a -> Ojs.t) -> 'a or_bigint -> Ojs.t

val or_bigint_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a or_bigint

val is_array : Ojs.t -> bool [@@js.global "Array.isArray"]

type ('a, 't) or_array =
  [ `Array of 't list
  | `Other of 'a
  ]
[@@js.custom
  { of_js =
      (fun a_of_js t_of_js x ->
        if is_array x then
          `Array (Ojs.list_of_js t_of_js x)
        else
          `Other (a_of_js x))
  ; to_js =
      (fun a_to_js t_to_js -> function
        | `Array x -> Ojs.list_to_js t_to_js x
        | `Other x -> a_to_js x)
  }]

val or_array_to_js :
  ('a -> Ojs.t) -> ('t -> Ojs.t) -> ('a, 't) or_array -> Ojs.t

val or_array_of_js :
  (Ojs.t -> 'a) -> (Ojs.t -> 't) -> Ojs.t -> ('a, 't) or_array

type ('a, 'cases) or_enum =
  [ `Enum of 'cases
  | `Other of 'a
  ]
[@@js.custom
  { of_js =
      (fun a_of_js cases_of_js x ->
        try `Enum (cases_of_js x) with
        | _ -> `Other (a_of_js x))
  ; to_js =
      (fun a_to_js cases_to_js -> function
        | `Enum cases -> cases_to_js cases
        | `Other x -> a_to_js x)
  }]

val or_enum_to_js :
  ('a -> Ojs.t) -> ('cases -> Ojs.t) -> ('a, 'cases) or_enum -> Ojs.t

val or_enum_of_js :
  (Ojs.t -> 'a) -> (Ojs.t -> 'cases) -> Ojs.t -> ('a, 'cases) or_enum

[@@@js.stop]

external pure_js_expr : string -> Ojs.t = "caml_pure_js_expr"

[@@@js.start]

[@@@js.implem external pure_js_expr : string -> Ojs.t = "caml_pure_js_expr"]

(* lib_es5.D.ts *)

val nan : int [@@js.global "NaN"]

val infinity : int [@@js.global "Infinity"]

val eval : string -> any [@@js.global "eval"]

val parse_int : string -> ?radix:int -> unit -> int [@@js.global "parseInt"]

val parse_float : string:string -> int [@@js.global "parseFloat"]

val is_nan : int -> bool [@@js.global "isNaN"]

val is_finite : int -> bool [@@js.global "isFinite"]

val decode_uri : string -> string [@@js.global "decodeURI"]

val decode_uri_component : string -> string [@@js.global "decodeURIComponent"]

val encode_uri : string -> string [@@js.global "encodeURI"]

val encode_uri_component : bool or_string or_number -> string
  [@@js.global "encodeURIComponent"]

val escape : string -> string [@@js.global "escape"]

val unescape : string -> string [@@js.global "unescape"]

module Symbol : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val to_string : t -> string [@@js.call "toString"]

  val value_of : t -> symbol [@@js.call "valueOf"]
end
[@@js.scope "Symbol"]

module Property_key : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t
end

module Property_descriptor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_configurable : t -> bool [@@js.get "configurable"]

  val set_configurable : t -> bool -> unit [@@js.set "configurable"]

  val get_enumerable : t -> bool [@@js.get "enumerable"]

  val set_enumerable : t -> bool -> unit [@@js.set "enumerable"]

  val get_value : t -> any [@@js.get "value"]

  val set_value : t -> any -> unit [@@js.set "value"]

  val get_writable : t -> bool [@@js.get "writable"]

  val set_writable : t -> bool -> unit [@@js.set "writable"]

  val get_ : t -> any [@@js.call "get"]

  val set_ : t -> any -> unit [@@js.call "set"]
end
[@@js.scope "PropertyDescriptor"]

module Property_descriptor_map : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get : t -> string -> Property_descriptor.t [@@js.index_get]

  val set : t -> string -> Property_descriptor.t -> unit [@@js.index_set]
end
[@@js.scope "PropertyDescriptorMap"]

module Partial : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end

module Required : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end

module Readonly : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end

module Pick : sig
  type ('T, 'K) t

  val t_to_js : ('T -> Ojs.t) -> ('K -> Ojs.t) -> ('T, 'K) t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> (Ojs.t -> 'K) -> Ojs.t -> ('T, 'K) t
end

module Record : sig
  type ('K, 'T) t

  val t_to_js : ('K -> Ojs.t) -> ('T -> Ojs.t) -> ('K, 'T) t -> Ojs.t

  val t_of_js : (Ojs.t -> 'K) -> (Ojs.t -> 'T) -> Ojs.t -> ('K, 'T) t
end

module Exclude : sig
  type ('T, 'U) t

  val t_to_js : ('T -> Ojs.t) -> ('U -> Ojs.t) -> ('T, 'U) t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> (Ojs.t -> 'U) -> Ojs.t -> ('T, 'U) t
end

module Extract : sig
  type ('T, 'U) t

  val t_to_js : ('T -> Ojs.t) -> ('U -> Ojs.t) -> ('T, 'U) t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> (Ojs.t -> 'U) -> Ojs.t -> ('T, 'U) t
end

module Omit : sig
  type ('T, 'K) t

  val t_to_js : ('T -> Ojs.t) -> ('K -> Ojs.t) -> ('T, 'K) t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> (Ojs.t -> 'K) -> Ojs.t -> ('T, 'K) t
end

module Non_nullable : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end

module Parameters : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end

module Constructor_parameters : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end

module Return_type : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end

module Instance_type : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end

module This_type : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end

module Function : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val apply_ : t -> this:t -> this_arg:any -> ?arg_array:any -> unit -> any
    [@@js.call "apply"]

  val call :
    t -> this:t -> this_arg:any -> arg_array:(any list[@js.variadic]) -> any
    [@@js.call "call"]

  val bind :
    t -> this:t -> this_arg:any -> arg_array:(any list[@js.variadic]) -> any
    [@@js.call "bind"]

  val to_string : t -> string [@@js.call "toString"]

  val get_prototype : t -> any [@@js.get "prototype"]

  val set_prototype : t -> any -> unit [@@js.set "prototype"]

  val get_length : t -> int [@@js.get "length"]

  val get_arguments : t -> any [@@js.get "arguments"]

  val set_arguments : t -> any -> unit [@@js.set "arguments"]

  val get_caller : t -> t [@@js.get "caller"]

  val set_caller : t -> t -> unit [@@js.set "caller"]

  (* Constructor *)

  val create : (string list[@js.variadic]) -> t [@@js.new "Function"]
end

module Function_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create : t -> (string list[@js.variadic]) -> Function.t
    [@@js.apply_newable]

  val apply : t -> (string list[@js.variadic]) -> Function.t [@@js.apply]

  val get_prototype : t -> Function.t [@@js.get "prototype"]
end
[@@js.scope "FunctionConstructor"]

val function_ : Function_constructor.t [@@js.global "Function"]

module Object : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_constructor : t -> Function.t [@@js.get "constructor"]

  val set_constructor : t -> Function.t -> unit [@@js.set "constructor"]

  val to_string : t -> string [@@js.call "toString"]

  val to_locale_string : t -> string [@@js.call "toLocaleString"]

  val value_of : t -> t [@@js.call "valueOf"]

  val has_own_property : t -> Property_key.t -> bool
    [@@js.call "hasOwnProperty"]

  val is_prototype_of : t -> t -> bool [@@js.call "isPrototypeOf"]

  val property_is_enumerable : t -> Property_key.t -> bool
    [@@js.call "propertyIsEnumerable"]

  (* Constructor *)

  val create : ?value:any -> unit -> t [@@js.new "Object"]

  val get_prototype_of : any -> any [@@js.global "Object.getPrototypeOf"]

  val get_own_property_descriptor :
    any -> p:Property_key.t -> Property_descriptor.t or_undefined
    [@@js.global "Object.getOwnPropertyDescriptor"]

  val get_own_property_names : any -> string list
    [@@js.global "Object.getOwnPropertyNames"]

  val create_ : untyped_object or_null -> any [@@js.new "Object"]

  val create' :
       untyped_object or_null
    -> properties:(Property_descriptor_map.t, any This_type.t) intersection2
    -> any
    [@@js.new "Object"]

  val define_property :
       t
    -> any
    -> p:Property_key.t
    -> attributes:(Property_descriptor.t, any This_type.t) intersection2
    -> any
    [@@js.global "Object.defineProperty"]

  val define_properties :
       t
    -> any
    -> properties:(Property_descriptor_map.t, any This_type.t) intersection2
    -> any
    [@@js.global "Object.defineProperties"]

  val seal : 'T -> 'T [@@js.global "Object.seal"]

  val freeze : 'T list -> 'T list [@@js.global "Object.freeze"]

  val freeze' : 'T -> 'T [@@js.global "Object.freeze"]

  val freeze'' : 'T -> 'T Readonly.t [@@js.global "Object.freeze"]

  val prevent_extensions : 'T -> 'T [@@js.global "Object.preventExtensions"]

  val is_sealed : any -> bool [@@js.global "Object.isSealed"]

  val is_frozen : any -> bool [@@js.global "Object.isFrozen"]

  val is_extensible : any -> bool [@@js.global "Object.isExtensible"]

  val keys : untyped_object -> string list [@@js.global "Object.keys"]
end

module Object_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create : t -> ?value:any -> unit -> Object.t [@@js.apply_newable]

  val apply : t -> any [@@js.apply]

  val apply' : t -> any -> any [@@js.apply]

  val get_prototype : t -> Object.t [@@js.get "prototype"]

  val get_prototype_of : t -> any -> any [@@js.call "getPrototypeOf"]

  val get_own_property_descriptor :
    t -> any -> p:Property_key.t -> Property_descriptor.t or_undefined
    [@@js.call "getOwnPropertyDescriptor"]

  val get_own_property_names : t -> any -> string list
    [@@js.call "getOwnPropertyNames"]

  val create_ : t -> untyped_object or_null -> any [@@js.call "create"]

  val create' :
       t
    -> untyped_object or_null
    -> properties:(Property_descriptor_map.t, any This_type.t) intersection2
    -> any
    [@@js.call "create"]

  val define_property :
       t
    -> any
    -> p:Property_key.t
    -> attributes:(Property_descriptor.t, any This_type.t) intersection2
    -> any
    [@@js.call "defineProperty"]

  val define_properties :
       t
    -> any
    -> properties:(Property_descriptor_map.t, any This_type.t) intersection2
    -> any
    [@@js.call "defineProperties"]

  val seal : t -> 'T -> 'T [@@js.call "seal"]

  val freeze : t -> 'T list -> 'T list [@@js.call "freeze"]

  val freeze' : t -> 'T -> 'T [@@js.call "freeze"]

  val freeze'' : t -> 'T -> 'T Readonly.t [@@js.call "freeze"]

  val prevent_extensions : t -> 'T -> 'T [@@js.call "preventExtensions"]

  val is_sealed : t -> any -> bool [@@js.call "isSealed"]

  val is_frozen : t -> any -> bool [@@js.call "isFrozen"]

  val is_extensible : t -> any -> bool [@@js.call "isExtensible"]

  val keys : t -> untyped_object -> string list [@@js.call "keys"]
end
[@@js.scope "ObjectConstructor"]

val object_ : Object_constructor.t [@@js.global "Object"]

module This_parameter_type : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end

module Omit_this_parameter : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end

module Callable_function : sig
  include module type of struct
    include Function
  end

  val apply_ : t -> this:(this:'T -> 'R) -> this_arg:'T -> 'R
    [@@js.call "apply"]

  val apply_all :
       t
    -> this:
         (   this:'T
          -> args:
               (* FIXME: type ''A' cannot be used for variadic argument *)
               (any list[@js.variadic])
          -> 'R)
    -> this_arg:'T
    -> args:'A
    -> 'R
    [@@js.call "apply"]

  val call :
       t
    -> this:
         (   this:'T
          -> args:
               (* FIXME: type ''A' cannot be used for variadic argument *)
               (any list[@js.variadic])
          -> 'R)
    -> this_arg:'T
    -> args:
         (* FIXME: type ''A' cannot be used for variadic argument *)
         (any list[@js.variadic])
    -> 'R
    [@@js.call "call"]

  val bind :
       t
    -> this:'T
    -> this_arg:'T This_parameter_type.t
    -> 'T Omit_this_parameter.t
    [@@js.call "bind"]

  val bind_all :
       t
    -> this:
         (   this:'T
          -> args:
               (* FIXME: type ''A' cannot be used for variadic argument *)
               (any list[@js.variadic])
          -> 'R)
    -> this_arg:'T
    -> (   args:
             (* FIXME: type ''A' cannot be used for variadic argument *)
             (any list[@js.variadic])
        -> 'R
       [@js.dummy])
    [@@js.call "bind"]
end
[@@js.scope "CallableFunction"]

module Newable_function : sig
  include module type of struct
    include Function
  end

  (* val apply_ : t -> this:'T Anonymous_interface12.t -> this_arg:'T -> unit
     [@@js.call "apply"] *)

  (* val apply' : t -> this:('A, 'T) Anonymous_interface10.t -> this_arg:'T ->
     'A -> unit [@@js.call "apply"] *)

  (* val call : t -> this:('A, 'T) Anonymous_interface10.t -> this_arg:'T -> (*
     fixme: type ''A' cannot be used for variadic argument *) (any
     list[@js.variadic]) -> unit [@@js.call "call"] *)

  val bind : t -> this:'T -> this_arg:any -> 'T [@@js.call "bind"]

  (* val bind' : t -> this:('A, 'A0, 'R) Anonymous_interface8.t -> this_arg:any
     -> arg0:'A0 -> ('A, 'R) Anonymous_interface9.t [@@js.call "bind"] *)

  (* val bind'' : t -> this:('A, 'A0, 'A1, 'R) Anonymous_interface7.t ->
     this_arg:any -> arg0:'A0 -> arg1:'A1 -> ('A, 'R) Anonymous_interface9.t
     [@@js.call "bind"] *)

  (* val bind''' : t -> this:('A, 'A0, 'A1, 'A2, 'R) Anonymous_interface6.t ->
     this_arg:any -> arg0:'A0 -> arg1:'A1 -> arg2:'A2 -> ('A, 'R)
     Anonymous_interface9.t [@@js.call "bind"] *)

  (* val bind'''' : t -> this:('A, 'A0, 'A1, 'A2, 'A3, 'R)
     Anonymous_interface5.t -> this_arg:any -> arg0:'A0 -> arg1:'A1 -> arg2:'A2
     -> arg3:'A3 -> ('A, 'R) Anonymous_interface9.t [@@js.call "bind"] *)

  (* val bind''''' : t -> this:('AX, 'R) Anonymous_interface11.t -> this_arg:any
     -> ('AX list[@js.variadic]) -> ('AX, 'R) Anonymous_interface11.t [@@js.call
     "bind"] *)
end

module Iarguments : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get : t -> int -> any [@@js.index_get]

  val set : t -> int -> any -> unit [@@js.index_set]

  val get_length : t -> int [@@js.get "length"]

  val set_length : t -> int -> unit [@@js.set "length"]

  val get_callee : t -> Function.t [@@js.get "callee"]

  val set_callee : t -> Function.t -> unit [@@js.set "callee"]
end
[@@js.scope "IArguments"]

module Intl : sig
  module Collator_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_usage : t -> string [@@js.get "usage"]

    val set_usage : t -> string -> unit [@@js.set "usage"]

    val get_locale_matcher : t -> string [@@js.get "localeMatcher"]

    val set_locale_matcher : t -> string -> unit [@@js.set "localeMatcher"]

    val get_numeric : t -> bool [@@js.get "numeric"]

    val set_numeric : t -> bool -> unit [@@js.set "numeric"]

    val get_case_first : t -> string [@@js.get "caseFirst"]

    val set_case_first : t -> string -> unit [@@js.set "caseFirst"]

    val get_sensitivity : t -> string [@@js.get "sensitivity"]

    val set_sensitivity : t -> string -> unit [@@js.set "sensitivity"]

    val get_ignore_punctuation : t -> bool [@@js.get "ignorePunctuation"]

    val set_ignore_punctuation : t -> bool -> unit
      [@@js.set "ignorePunctuation"]
  end
  [@@js.scope "CollatorOptions"]

  module Resolved_collator_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_locale : t -> string [@@js.get "locale"]

    val set_locale : t -> string -> unit [@@js.set "locale"]

    val get_usage : t -> string [@@js.get "usage"]

    val set_usage : t -> string -> unit [@@js.set "usage"]

    val get_sensitivity : t -> string [@@js.get "sensitivity"]

    val set_sensitivity : t -> string -> unit [@@js.set "sensitivity"]

    val get_ignore_punctuation : t -> bool [@@js.get "ignorePunctuation"]

    val set_ignore_punctuation : t -> bool -> unit
      [@@js.set "ignorePunctuation"]

    val get_collation : t -> string [@@js.get "collation"]

    val set_collation : t -> string -> unit [@@js.set "collation"]

    val get_case_first : t -> string [@@js.get "caseFirst"]

    val set_case_first : t -> string -> unit [@@js.set "caseFirst"]

    val get_numeric : t -> bool [@@js.get "numeric"]

    val set_numeric : t -> bool -> unit [@@js.set "numeric"]
  end
  [@@js.scope "ResolvedCollatorOptions"]

  module Collator : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val compare : t -> x:string -> y:string -> int [@@js.call "compare"]

    val resolved_options : t -> Resolved_collator_options.t
      [@@js.call "resolvedOptions"]
  end
  [@@js.scope "Collator"]

  module Collator_constructor : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create :
         t
      -> ?locales:string list
      -> ?options:Collator_options.t
      -> unit
      -> Collator.t
      [@@js.apply_newable]

    val apply :
         t
      -> ?locales:string list
      -> ?options:Collator_options.t
      -> unit
      -> Collator.t
      [@@js.apply]

    val supported_locales_of :
         t
      -> locales:string list
      -> ?options:Collator_options.t
      -> unit
      -> string list
      [@@js.call "supportedLocalesOf"]
  end

  val collator : Collator_constructor.t [@@js.global "Collator"]

  module Number_format_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_locale_matcher : t -> string [@@js.get "localeMatcher"]

    val set_locale_matcher : t -> string -> unit [@@js.set "localeMatcher"]

    val get_style : t -> string [@@js.get "style"]

    val set_style : t -> string -> unit [@@js.set "style"]

    val get_currency : t -> string [@@js.get "currency"]

    val set_currency : t -> string -> unit [@@js.set "currency"]

    val get_currency_display : t -> string [@@js.get "currencyDisplay"]

    val set_currency_display : t -> string -> unit [@@js.set "currencyDisplay"]

    val get_currency_sign : t -> string [@@js.get "currencySign"]

    val set_currency_sign : t -> string -> unit [@@js.set "currencySign"]

    val get_use_grouping : t -> bool [@@js.get "useGrouping"]

    val set_use_grouping : t -> bool -> unit [@@js.set "useGrouping"]

    val get_minimum_integer_digits : t -> int [@@js.get "minimumIntegerDigits"]

    val set_minimum_integer_digits : t -> int -> unit
      [@@js.set "minimumIntegerDigits"]

    val get_minimum_fraction_digits : t -> int
      [@@js.get "minimumFractionDigits"]

    val set_minimum_fraction_digits : t -> int -> unit
      [@@js.set "minimumFractionDigits"]

    val get_maximum_fraction_digits : t -> int
      [@@js.get "maximumFractionDigits"]

    val set_maximum_fraction_digits : t -> int -> unit
      [@@js.set "maximumFractionDigits"]

    val get_minimum_significant_digits : t -> int
      [@@js.get "minimumSignificantDigits"]

    val set_minimum_significant_digits : t -> int -> unit
      [@@js.set "minimumSignificantDigits"]

    val get_maximum_significant_digits : t -> int
      [@@js.get "maximumSignificantDigits"]

    val set_maximum_significant_digits : t -> int -> unit
      [@@js.set "maximumSignificantDigits"]
  end
  [@@js.scope "NumberFormatOptions"]

  module Resolved_number_format_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_locale : t -> string [@@js.get "locale"]

    val set_locale : t -> string -> unit [@@js.set "locale"]

    val get_numbering_system : t -> string [@@js.get "numberingSystem"]

    val set_numbering_system : t -> string -> unit [@@js.set "numberingSystem"]

    val get_style : t -> string [@@js.get "style"]

    val set_style : t -> string -> unit [@@js.set "style"]

    val get_currency : t -> string [@@js.get "currency"]

    val set_currency : t -> string -> unit [@@js.set "currency"]

    val get_currency_display : t -> string [@@js.get "currencyDisplay"]

    val set_currency_display : t -> string -> unit [@@js.set "currencyDisplay"]

    val get_minimum_integer_digits : t -> int [@@js.get "minimumIntegerDigits"]

    val set_minimum_integer_digits : t -> int -> unit
      [@@js.set "minimumIntegerDigits"]

    val get_minimum_fraction_digits : t -> int
      [@@js.get "minimumFractionDigits"]

    val set_minimum_fraction_digits : t -> int -> unit
      [@@js.set "minimumFractionDigits"]

    val get_maximum_fraction_digits : t -> int
      [@@js.get "maximumFractionDigits"]

    val set_maximum_fraction_digits : t -> int -> unit
      [@@js.set "maximumFractionDigits"]

    val get_minimum_significant_digits : t -> int
      [@@js.get "minimumSignificantDigits"]

    val set_minimum_significant_digits : t -> int -> unit
      [@@js.set "minimumSignificantDigits"]

    val get_maximum_significant_digits : t -> int
      [@@js.get "maximumSignificantDigits"]

    val set_maximum_significant_digits : t -> int -> unit
      [@@js.set "maximumSignificantDigits"]

    val get_use_grouping : t -> bool [@@js.get "useGrouping"]

    val set_use_grouping : t -> bool -> unit [@@js.set "useGrouping"]
  end
  [@@js.scope "ResolvedNumberFormatOptions"]

  module Number_format : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val format : t -> value:int -> string [@@js.call "format"]

    val resolved_options : t -> Resolved_number_format_options.t
      [@@js.call "resolvedOptions"]
  end
  [@@js.scope "NumberFormat"]

  module Number_format_constructor : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create :
         t
      -> ?locales:string list
      -> ?options:Number_format_options.t
      -> unit
      -> Number_format.t
      [@@js.apply_newable]

    val apply :
         t
      -> ?locales:string list
      -> ?options:Number_format_options.t
      -> unit
      -> Number_format.t
      [@@js.apply]

    val supported_locales_of :
         t
      -> locales:string list
      -> ?options:Number_format_options.t
      -> unit
      -> string list
      [@@js.call "supportedLocalesOf"]
  end

  val number_format : Number_format_constructor.t [@@js.global "NumberFormat"]

  module Date_time_format_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_locale_matcher :
      t -> ([ `best_fit [@js "best fit"] | `lookup [@js "lookup"] ][@js.enum])
      [@@js.get "localeMatcher"]

    val set_locale_matcher : t -> ([ `best_fit | `lookup ][@js.enum]) -> unit
      [@@js.set "localeMatcher"]

    val get_weekday :
         t
      -> ([ `long [@js "long"] | `narrow [@js "narrow"] | `short [@js "short"] ]
         [@js.enum])
      [@@js.get "weekday"]

    val set_weekday : t -> ([ `long | `narrow | `short ][@js.enum]) -> unit
      [@@js.set "weekday"]

    val get_era :
         t
      -> ([ `long [@js "long"] | `narrow [@js "narrow"] | `short [@js "short"] ]
         [@js.enum])
      [@@js.get "era"]

    val set_era : t -> ([ `long | `narrow | `short ][@js.enum]) -> unit
      [@@js.set "era"]

    val get_year :
      t -> ([ `two_digit [@js "2-digit"] | `numeric [@js "numeric"] ][@js.enum])
      [@@js.get "year"]

    val set_year : t -> ([ `two_digit | `numeric ][@js.enum]) -> unit
      [@@js.set "year"]

    val get_month :
         t
      -> ([ `two_digit [@js "2-digit"]
          | `long [@js "long"]
          | `narrow [@js "narrow"]
          | `numeric [@js "numeric"]
          | `short [@js "short"]
          ]
         [@js.enum])
      [@@js.get "month"]

    val set_month :
         t
      -> ([ `two_digit | `long | `narrow | `numeric | `short ][@js.enum])
      -> unit
      [@@js.set "month"]

    val get_day :
      t -> ([ `two_digit [@js "2-digit"] | `numeric [@js "numeric"] ][@js.enum])
      [@@js.get "day"]

    val set_day : t -> ([ `two_digit | `numeric ][@js.enum]) -> unit
      [@@js.set "day"]

    val get_hour :
      t -> ([ `two_digit [@js "2-digit"] | `numeric [@js "numeric"] ][@js.enum])
      [@@js.get "hour"]

    val set_hour : t -> ([ `two_digit | `numeric ][@js.enum]) -> unit
      [@@js.set "hour"]

    val get_minute :
      t -> ([ `two_digit [@js "2-digit"] | `numeric [@js "numeric"] ][@js.enum])
      [@@js.get "minute"]

    val set_minute : t -> ([ `two_digit | `numeric ][@js.enum]) -> unit
      [@@js.set "minute"]

    val get_second :
      t -> ([ `two_digit [@js "2-digit"] | `numeric [@js "numeric"] ][@js.enum])
      [@@js.get "second"]

    val set_second : t -> ([ `two_digit | `numeric ][@js.enum]) -> unit
      [@@js.set "second"]

    val get_time_zone_name :
      t -> ([ `long [@js "long"] | `short [@js "short"] ][@js.enum])
      [@@js.get "timeZoneName"]

    val set_time_zone_name : t -> ([ `long | `short ][@js.enum]) -> unit
      [@@js.set "timeZoneName"]

    val get_format_matcher :
      t -> ([ `basic [@js "basic"] | `best_fit [@js "best fit"] ][@js.enum])
      [@@js.get "formatMatcher"]

    val set_format_matcher : t -> ([ `basic | `best_fit ][@js.enum]) -> unit
      [@@js.set "formatMatcher"]

    val get_hour12 : t -> bool [@@js.get "hour12"]

    val set_hour12 : t -> bool -> unit [@@js.set "hour12"]

    val get_time_zone : t -> string [@@js.get "timeZone"]

    val set_time_zone : t -> string -> unit [@@js.set "timeZone"]
  end
  [@@js.scope "DateTimeFormatOptions"]

  module Resolved_date_time_format_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_locale : t -> string [@@js.get "locale"]

    val set_locale : t -> string -> unit [@@js.set "locale"]

    val get_calendar : t -> string [@@js.get "calendar"]

    val set_calendar : t -> string -> unit [@@js.set "calendar"]

    val get_numbering_system : t -> string [@@js.get "numberingSystem"]

    val set_numbering_system : t -> string -> unit [@@js.set "numberingSystem"]

    val get_time_zone : t -> string [@@js.get "timeZone"]

    val set_time_zone : t -> string -> unit [@@js.set "timeZone"]

    val get_hour12 : t -> bool [@@js.get "hour12"]

    val set_hour12 : t -> bool -> unit [@@js.set "hour12"]

    val get_weekday : t -> string [@@js.get "weekday"]

    val set_weekday : t -> string -> unit [@@js.set "weekday"]

    val get_era : t -> string [@@js.get "era"]

    val set_era : t -> string -> unit [@@js.set "era"]

    val get_year : t -> string [@@js.get "year"]

    val set_year : t -> string -> unit [@@js.set "year"]

    val get_month : t -> string [@@js.get "month"]

    val set_month : t -> string -> unit [@@js.set "month"]

    val get_day : t -> string [@@js.get "day"]

    val set_day : t -> string -> unit [@@js.set "day"]

    val get_hour : t -> string [@@js.get "hour"]

    val set_hour : t -> string -> unit [@@js.set "hour"]

    val get_minute : t -> string [@@js.get "minute"]

    val set_minute : t -> string -> unit [@@js.set "minute"]

    val get_second : t -> string [@@js.get "second"]

    val set_second : t -> string -> unit [@@js.set "second"]

    val get_time_zone_name : t -> string [@@js.get "timeZoneName"]

    val set_time_zone_name : t -> string -> unit [@@js.set "timeZoneName"]
  end
  [@@js.scope "ResolvedDateTimeFormatOptions"]

  module Date_time_format : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    (* val format : t -> ?date:Date.t or_number -> unit -> string [@@js.call
       "format"] *)

    val format : t -> string [@@js.call "format"]

    val resolved_options : t -> Resolved_date_time_format_options.t
      [@@js.call "resolvedOptions"]
  end
  [@@js.scope "DateTimeFormat"]

  module Date_time_format_constructor : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create :
         t
      -> ?locales:string list
      -> ?options:Date_time_format_options.t
      -> unit
      -> Date_time_format.t
      [@@js.apply_newable]

    val apply :
         t
      -> ?locales:string list
      -> ?options:Date_time_format_options.t
      -> unit
      -> Date_time_format.t
      [@@js.apply]

    val supported_locales_of :
         t
      -> locales:string list
      -> ?options:Date_time_format_options.t
      -> unit
      -> string list
      [@@js.call "supportedLocalesOf"]
  end

  val date_time_format : Date_time_format_constructor.t
    [@@js.global "DateTimeFormat"]
end
[@@js.scope "Intl"]

module Concat_array : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

  val get_length : 'T t -> int [@@js.get "length"]

  val get : 'T t -> int -> 'T [@@js.index_get]

  val join : 'T t -> ?separator:string -> unit -> string [@@js.call "join"]

  val slice : 'T t -> ?start:int -> ?end_:int -> unit -> 'T list
    [@@js.call "slice"]
end
[@@js.scope "ConcatArray"]

module Readonly_array : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

  val get_length : 'T t -> int [@@js.get "length"]

  val to_string : 'T t -> string [@@js.call "toString"]

  val to_locale_string : 'T t -> string [@@js.call "toLocaleString"]

  val concat : 'T t -> ('T Concat_array.t list[@js.variadic]) -> 'T list
    [@@js.call "concat"]

  val concat' :
    'T t -> (('T, 'T Concat_array.t) union2 list[@js.variadic]) -> 'T list
    [@@js.call "concat"]

  val join : 'T t -> ?separator:string -> unit -> string [@@js.call "join"]

  val slice : 'T t -> ?start:int -> ?end_:int -> unit -> 'T list
    [@@js.call "slice"]

  val index_of : 'T t -> search_element:'T -> ?from_index:int -> unit -> int
    [@@js.call "indexOf"]

  val last_index_of :
    'T t -> search_element:'T -> ?from_index:int -> unit -> int
    [@@js.call "lastIndexOf"]

  val every :
       'T t
    -> (value:'T -> index:int -> array:'T list -> bool)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "every"]

  val every' :
       'T t
    -> (value:'T -> index:int -> array:'T list -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "every"]

  val some :
       'T t
    -> (value:'T -> index:int -> array:'T list -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "some"]

  val for_each :
       'T t
    -> callbackfn:(value:'T -> index:int -> array:'T list -> unit)
    -> ?this_arg:any
    -> unit
    -> unit
    [@@js.call "forEach"]

  val map :
       'T t
    -> callbackfn:(value:'T -> index:int -> array:'T list -> 'U)
    -> ?this_arg:any
    -> unit
    -> 'U list
    [@@js.call "map"]

  val filter :
       'T t
    -> (value:'T -> index:int -> array:'T list -> bool)
    -> ?this_arg:any
    -> unit
    -> 'S list
    [@@js.call "filter"]

  val filter' :
       'T t
    -> (value:'T -> index:int -> array:'T list -> unknown)
    -> ?this_arg:any
    -> unit
    -> 'T list
    [@@js.call "filter"]

  val reduce :
       'T t
    -> callbackfn:
         (   previousValue:'T
          -> current_value:'T
          -> current_index:int
          -> array:'T list
          -> 'T)
    -> 'T
    [@@js.call "reduce"]

  val reduce' :
       'T t
    -> callbackfn:
         (   previousValue:'T
          -> current_value:'T
          -> current_index:int
          -> array:'T list
          -> 'T)
    -> initial_value:'T
    -> 'T
    [@@js.call "reduce"]

  val reduce'' :
       'T t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:'T
          -> current_index:int
          -> array:'T list
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduce"]

  val reduce_right :
       'T t
    -> callbackfn:
         (   previousValue:'T
          -> current_value:'T
          -> current_index:int
          -> array:'T list
          -> 'T)
    -> 'T
    [@@js.call "reduceRight"]

  val reduce_right' :
       'T t
    -> callbackfn:
         (   previousValue:'T
          -> current_value:'T
          -> current_index:int
          -> array:'T list
          -> 'T)
    -> initial_value:'T
    -> 'T
    [@@js.call "reduceRight"]

  val reduce_right'' :
       'T t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:'T
          -> current_index:int
          -> array:'T list
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduceRight"]

  val get : 'T t -> int -> 'T [@@js.index_get]

  val to_ml : 'T t -> 'T list [@@js.cast]

  val of_ml : 'T list -> 'T t [@@js.cast]
end
[@@js.scope "ReadonlyArray"]

module Template_strings_array : sig
  include module type of struct
    include Readonly_array
  end

  type t = string Readonly_array.t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_raw : t -> string list [@@js.get "raw"]
end
[@@js.scope "TemplateStringsArray"]

module Array : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

  val get_length : 'T t -> int [@@js.get "length"]

  val set_length : 'T t -> int -> unit [@@js.set "length"]

  val to_string : 'T t -> string [@@js.call "toString"]

  val to_locale_string : 'T t -> string [@@js.call "toLocaleString"]

  val pop : 'T t -> 'T or_undefined [@@js.call "pop"]

  val push : 'T t -> ('T list[@js.variadic]) -> int [@@js.call "push"]

  val concat : 'T t -> ('T Concat_array.t list[@js.variadic]) -> 'T list
    [@@js.call "concat"]

  val concat' :
    'T t -> (('T, 'T Concat_array.t) union2 list[@js.variadic]) -> 'T list
    [@@js.call "concat"]

  val join : 'T t -> ?separator:string -> unit -> string [@@js.call "join"]

  val reverse : 'T t -> 'T list [@@js.call "reverse"]

  val shift : 'T t -> 'T or_undefined [@@js.call "shift"]

  val slice : 'T t -> ?start:int -> ?end_:int -> unit -> 'T list
    [@@js.call "slice"]

  val sort : 'T t -> ?compare_fn:(a:'T -> b:'T -> int) -> unit -> 'T t
    [@@js.call "sort"]

  val splice : 'T t -> start:int -> ?delete_count:int -> unit -> 'T list
    [@@js.call "splice"]

  val splice' :
    'T t -> start:int -> delete_count:int -> ('T list[@js.variadic]) -> 'T list
    [@@js.call "splice"]

  val unshift : 'T t -> ('T list[@js.variadic]) -> int [@@js.call "unshift"]

  val index_of : 'T t -> search_element:'T -> ?from_index:int -> unit -> int
    [@@js.call "indexOf"]

  val last_index_of :
    'T t -> search_element:'T -> ?from_index:int -> unit -> int
    [@@js.call "lastIndexOf"]

  val every :
       'T t
    -> (value:'T -> index:int -> array:'T list -> bool)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "every"]

  val every' :
       'T t
    -> (value:'T -> index:int -> array:'T list -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "every"]

  val some :
       'T t
    -> (value:'T -> index:int -> array:'T list -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "some"]

  val for_each :
       'T t
    -> callbackfn:(value:'T -> index:int -> array:'T list -> unit)
    -> ?this_arg:any
    -> unit
    -> unit
    [@@js.call "forEach"]

  val map :
       'T t
    -> callbackfn:(value:'T -> index:int -> array:'T list -> 'U)
    -> ?this_arg:any
    -> unit
    -> 'U list
    [@@js.call "map"]

  val filter :
       'T t
    -> (value:'T -> index:int -> array:'T list -> bool)
    -> ?this_arg:any
    -> unit
    -> 'S list
    [@@js.call "filter"]

  val filter' :
       'T t
    -> (value:'T -> index:int -> array:'T list -> unknown)
    -> ?this_arg:any
    -> unit
    -> 'T list
    [@@js.call "filter"]

  val reduce :
       'T t
    -> callbackfn:
         (   previousValue:'T
          -> current_value:'T
          -> current_index:int
          -> array:'T list
          -> 'T)
    -> 'T
    [@@js.call "reduce"]

  val reduce' :
       'T t
    -> callbackfn:
         (   previousValue:'T
          -> current_value:'T
          -> current_index:int
          -> array:'T list
          -> 'T)
    -> initial_value:'T
    -> 'T
    [@@js.call "reduce"]

  val reduce'' :
       'T t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:'T
          -> current_index:int
          -> array:'T list
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduce"]

  val reduce_right :
       'T t
    -> callbackfn:
         (   previousValue:'T
          -> current_value:'T
          -> current_index:int
          -> array:'T list
          -> 'T)
    -> 'T
    [@@js.call "reduceRight"]

  val reduce_right' :
       'T t
    -> callbackfn:
         (   previousValue:'T
          -> current_value:'T
          -> current_index:int
          -> array:'T list
          -> 'T)
    -> initial_value:'T
    -> 'T
    [@@js.call "reduceRight"]

  val reduce_right'' :
       'T t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:'T
          -> current_index:int
          -> array:'T list
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduceRight"]

  val get : 'T t -> int -> 'T [@@js.index_get]

  val set : 'T t -> int -> 'T -> unit [@@js.index_set]

  val to_ml : 'T t -> 'T list [@@js.cast]

  val of_ml : 'T list -> 'T t [@@js.cast]

  (* Constructor *)

  val create : ?array_length:int -> unit -> any list [@@js.new "Array"]

  val create' : array_length:int -> 'T list [@@js.new "Array"]

  val create'' : ('T list[@js.variadic]) -> 'T list [@@js.new "Array"]

  val is_array : any -> bool [@@js.global "Array.isArray"]
end

module Array_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create : t -> ?array_length:int -> unit -> any list [@@js.apply_newable]

  val create' : t -> array_length:int -> 'T list [@@js.apply_newable]

  val create'' : t -> ('T list[@js.variadic]) -> 'T list [@@js.apply_newable]

  val apply : t -> ?array_length:int -> unit -> any list [@@js.apply]

  val apply' : t -> array_length:int -> 'T list [@@js.apply]

  val apply'' : t -> ('T list[@js.variadic]) -> 'T list [@@js.apply]

  val is_array : t -> any -> bool [@@js.call "isArray"]

  val get_prototype : t -> any list [@@js.get "prototype"]
end
[@@js.scope "ArrayConstructor"]

val array : Array_constructor.t [@@js.global "Array"]

module Reg_exp_match_array : sig
  include module type of struct
    include Array
  end

  type t = string Array.t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_index : t -> int [@@js.get "index"]

  val set_index : t -> int -> unit [@@js.set "index"]

  val get_input : t -> string [@@js.get "input"]

  val set_input : t -> string -> unit [@@js.set "input"]
end
[@@js.scope "RegExpMatchArray"]

module Reg_exp_exec_array : sig
  include module type of struct
    include Array
  end

  type t = string Array.t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_index : t -> int [@@js.get "index"]

  val set_index : t -> int -> unit [@@js.set "index"]

  val get_input : t -> string [@@js.get "input"]

  val set_input : t -> string -> unit [@@js.set "input"]
end
[@@js.scope "RegExpExecArray"]

module Reg_exp : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val exec : t -> string:string -> Reg_exp_exec_array.t or_null
    [@@js.call "exec"]

  val test : t -> string:string -> bool [@@js.call "test"]

  val get_source : t -> string [@@js.get "source"]

  val get_global : t -> bool [@@js.get "global"]

  val get_ignore_case : t -> bool [@@js.get "ignoreCase"]

  val get_multiline : t -> bool [@@js.get "multiline"]

  val get_last_index : t -> int [@@js.get "lastIndex"]

  val set_last_index : t -> int -> unit [@@js.set "lastIndex"]

  val compile : t -> t [@@js.call "compile"]

  (* Constructor *)

  val create : string -> t [@@js.new "RegExp"]

  val create' : string -> ?flags:string -> unit -> t [@@js.new "RegExp"]

  val get_1 : unit -> string [@@js.global "RegExp.$1"]

  val set_1 : string -> unit [@@js.global "RegExp.$1"]

  val get_2 : unit -> string [@@js.global "RegExp.$2"]

  val set_2 : string -> unit [@@js.global "RegExp.$2"]

  val get_3 : unit -> string [@@js.global "RegExp.$3"]

  val set_3 : string -> unit [@@js.global "RegExp.$3"]

  val get_4 : unit -> string [@@js.global "RegExp.$4"]

  val set_4 : string -> unit [@@js.global "RegExp.$4"]

  val get_5 : unit -> string [@@js.global "RegExp.$5"]

  val set_5 : string -> unit [@@js.global "RegExp.$5"]

  val get_6 : unit -> string [@@js.global "RegExp.$6"]

  val set_6 : string -> unit [@@js.global "RegExp.$6"]

  val get_7 : unit -> string [@@js.global "RegExp.$7"]

  val set_7 : string -> unit [@@js.global "RegExp.$7"]

  val get_8 : unit -> string [@@js.global "RegExp.$8"]

  val set_8 : string -> unit [@@js.global "RegExp.$8"]

  val get_9 : unit -> string [@@js.global "RegExp.$9"]

  val set_9 : string -> unit [@@js.global "RegExp.$9"]

  val get_last_match : unit -> string [@@js.global "RegExp.lastMatch"]

  val set_last_match : string -> unit [@@js.global "RegExp.lastMatch"]
end

module Reg_exp_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create : t -> pattern:Reg_exp.t or_string -> Reg_exp.t
    [@@js.apply_newable]

  val create' : t -> pattern:string -> ?flags:string -> unit -> Reg_exp.t
    [@@js.apply_newable]

  val apply : t -> pattern:Reg_exp.t or_string -> Reg_exp.t [@@js.apply]

  val apply' : t -> pattern:string -> ?flags:string -> unit -> Reg_exp.t
    [@@js.apply]

  val get_prototype : t -> Reg_exp.t [@@js.get "prototype"]

  val get_1 : t -> string [@@js.get "$1"]

  val set_1 : t -> string -> unit [@@js.set "$1"]

  val get_2 : t -> string [@@js.get "$2"]

  val set_2 : t -> string -> unit [@@js.set "$2"]

  val get_3 : t -> string [@@js.get "$3"]

  val set_3 : t -> string -> unit [@@js.set "$3"]

  val get_4 : t -> string [@@js.get "$4"]

  val set_4 : t -> string -> unit [@@js.set "$4"]

  val get_5 : t -> string [@@js.get "$5"]

  val set_5 : t -> string -> unit [@@js.set "$5"]

  val get_6 : t -> string [@@js.get "$6"]

  val set_6 : t -> string -> unit [@@js.set "$6"]

  val get_7 : t -> string [@@js.get "$7"]

  val set_7 : t -> string -> unit [@@js.set "$7"]

  val get_8 : t -> string [@@js.get "$8"]

  val set_8 : t -> string -> unit [@@js.set "$8"]

  val get_9 : t -> string [@@js.get "$9"]

  val set_9 : t -> string -> unit [@@js.set "$9"]

  val get_last_match : t -> string [@@js.get "lastMatch"]

  val set_last_match : t -> string -> unit [@@js.set "lastMatch"]
end
[@@js.scope "RegExpConstructor"]

val reg_exp : Reg_exp_constructor.t [@@js.global "RegExp"]

module String : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val locale_compare :
       t
    -> that:string
    -> ?locales:string list
    -> ?options:Intl.Collator_options.t
    -> unit
    -> int
    [@@js.call "localeCompare"]

  val to_string : t -> string [@@js.call "toString"]

  val char_at : t -> pos:int -> string [@@js.call "charAt"]

  val char_code_at : t -> index:int -> int [@@js.call "charCodeAt"]

  val concat : t -> strings:(string list[@js.variadic]) -> string
    [@@js.call "concat"]

  val index_of : t -> search_string:string -> ?position:int -> unit -> int
    [@@js.call "indexOf"]

  val last_index_of : t -> search_string:string -> ?position:int -> unit -> int
    [@@js.call "lastIndexOf"]

  val locale_compare' : t -> that:string -> int [@@js.call "localeCompare"]

  val match_ : t -> regexp:Reg_exp.t or_string -> Reg_exp_match_array.t or_null
    [@@js.call "match"]

  val replace :
    t -> search_value:Reg_exp.t or_string -> replace_value:string -> string
    [@@js.call "replace"]

  val replace' :
       t
    -> search_value:Reg_exp.t or_string
    -> replacer:(substring:string -> args:(any list[@js.variadic]) -> string)
    -> string
    [@@js.call "replace"]

  val search : t -> regexp:Reg_exp.t or_string -> int [@@js.call "search"]

  val slice : t -> ?start:int -> ?end_:int -> unit -> string [@@js.call "slice"]

  val split :
    t -> separator:Reg_exp.t or_string -> ?limit:int -> unit -> string list
    [@@js.call "split"]

  val substring : t -> start:int -> ?end_:int -> unit -> string
    [@@js.call "substring"]

  val to_lower_case : t -> string [@@js.call "toLowerCase"]

  val to_locale_lower_case : t -> ?locales:string list -> unit -> string
    [@@js.call "toLocaleLowerCase"]

  val to_upper_case : t -> string [@@js.call "toUpperCase"]

  val to_locale_upper_case : t -> ?locales:string list -> unit -> string
    [@@js.call "toLocaleUpperCase"]

  val trim : t -> string [@@js.call "trim"]

  val get_length : t -> int [@@js.get "length"]

  val substr : t -> from:int -> ?length:int -> unit -> string
    [@@js.call "substr"]

  val value_of : t -> string [@@js.call "valueOf"]

  val get : t -> int -> string [@@js.index_get]

  val to_ml : t -> string [@@js.cast]

  val of_ml : string -> t [@@js.cast]

  (* Constructor *)

  val create : ?value:any -> unit -> t [@@js.new "String"]

  val from_char_code : codes:(int list[@js.variadic]) -> string
    [@@js.global "String.fromCharCode"]
end

module String_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create : t -> ?value:any -> unit -> String.t [@@js.apply_newable]

  val apply : t -> ?value:any -> unit -> string [@@js.apply]

  val get_prototype : t -> String.t [@@js.get "prototype"]

  val from_char_code : t -> codes:(int list[@js.variadic]) -> string
    [@@js.call "fromCharCode"]
end
[@@js.scope "StringConstructor"]

val string : String_constructor.t [@@js.global "String"]

module Boolean : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val value_of : t -> bool [@@js.call "valueOf"]

  val to_ml : t -> bool [@@js.cast]

  val of_ml : bool -> t [@@js.cast]

  (* Constructor *)

  val create : ?value:any -> unit -> t [@@js.new "Boolean"]
end

module Boolean_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create : t -> ?value:any -> unit -> Boolean.t [@@js.apply_newable]

  val apply : t -> ?value:'T -> unit -> bool [@@js.apply]

  val get_prototype : t -> Boolean.t [@@js.get "prototype"]
end
[@@js.scope "BooleanConstructor"]

val boolean : Boolean_constructor.t [@@js.global "Boolean"]

module Number : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val to_locale_string :
       t
    -> ?locales:string list
    -> ?options:Intl.Number_format_options.t
    -> unit
    -> string
    [@@js.call "toLocaleString"]

  val to_string : t -> ?radix:int -> unit -> string [@@js.call "toString"]

  val to_fixed : t -> ?fraction_digits:int -> unit -> string
    [@@js.call "toFixed"]

  val to_exponential : t -> ?fraction_digits:int -> unit -> string
    [@@js.call "toExponential"]

  val to_precision : t -> ?precision:int -> unit -> string
    [@@js.call "toPrecision"]

  val value_of : t -> int [@@js.call "valueOf"]

  val to_ml : t -> int [@@js.cast]

  val of_ml : int -> t [@@js.cast]

  (* Constructor *)

  val create : ?value:any -> unit -> t [@@js.new "Number"]

  val get_max_value : int [@@js.global "Number.MAX_VALUE"]

  val get_min_value : int [@@js.global "Number.MIN_VALUE"]

  val get_nan : int [@@js.global "Number.NaN"]

  val get_negative_infinity : int [@@js.global "Number.NEGATIVE_INFINITY"]

  val get_positive_infinity : int [@@js.global "Number.POSITIVE_INFINITY"]
end

module Number_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create : t -> ?value:any -> unit -> Number.t [@@js.apply_newable]

  val apply : t -> ?value:any -> unit -> int [@@js.apply]

  val get_prototype : t -> Number.t [@@js.get "prototype"]

  val get_max_value : t -> int [@@js.get "MAX_VALUE"]

  val get_min_value : t -> int [@@js.get "MIN_VALUE"]

  val get_nan : t -> int [@@js.get "NaN"]

  val get_negative_infinity : t -> int [@@js.get "NEGATIVE_INFINITY"]

  val get_positive_infinity : t -> int [@@js.get "POSITIVE_INFINITY"]
end
[@@js.scope "NumberConstructor"]

val number : Number_constructor.t [@@js.global "Number"]

module Import_meta : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t
end

module Math : sig
  val get_e : int [@@js.global "Math.E"]

  val get_ln10 : int [@@js.global "Math.LN10"]

  val get_ln2 : int [@@js.global "Math.LN2"]

  val get_log2_e : int [@@js.global "Math.LOG2E"]

  val get_log10_e : int [@@js.global "Math.LOG10E"]

  val get_pi : int [@@js.global "Math.PI"]

  val get_sqrt1_2 : int [@@js.global "Math.SQRT1_2"]

  val get_sqrt2 : int [@@js.global "Math.SQRT2"]

  val abs : int -> int [@@js.global "Math.abs"]

  val acos : int -> int [@@js.global "Math.acos"]

  val asin : int -> int [@@js.global "Math.asin"]

  val atan : int -> int [@@js.global "Math.atan"]

  val atan2 : y:int -> x:int -> int [@@js.global "Math.atan2"]

  val ceil : int -> int [@@js.global "Math.ceil"]

  val cos : int -> int [@@js.global "Math.cos"]

  val exp : int -> int [@@js.global "Math.exp"]

  val floor : int -> int [@@js.global "Math.floor"]

  val log : int -> int [@@js.global "Math.log"]

  val max : (int list[@js.variadic]) -> int [@@js.global "Math.max"]

  val min : (int list[@js.variadic]) -> int [@@js.global "Math.min"]

  val pow : x:int -> y:int -> int [@@js.global "Math.pow"]

  val random : int [@@js.global "Math.random"]

  val round : int -> int [@@js.global "Math.round"]

  val sin : int -> int [@@js.global "Math.sin"]

  val sqrt : int -> int [@@js.global "Math.sqrt"]

  val tan : int -> int [@@js.global "Math.tan"]
end

module Date : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val to_locale_string :
       t
    -> ?locales:string list
    -> ?options:Intl.Date_time_format_options.t
    -> unit
    -> string
    [@@js.call "toLocaleString"]

  val to_locale_date_string :
       t
    -> ?locales:string list
    -> ?options:Intl.Date_time_format_options.t
    -> unit
    -> string
    [@@js.call "toLocaleDateString"]

  val to_locale_time_string :
       t
    -> ?locales:string list
    -> ?options:Intl.Date_time_format_options.t
    -> unit
    -> string
    [@@js.call "toLocaleTimeString"]

  val to_string : t -> string [@@js.call "toString"]

  val to_date_string : t -> string [@@js.call "toDateString"]

  val to_time_string : t -> string [@@js.call "toTimeString"]

  val to_locale_string' : t -> string [@@js.call "toLocaleString"]

  val to_locale_date_string' : t -> string [@@js.call "toLocaleDateString"]

  val to_locale_time_string' : t -> string [@@js.call "toLocaleTimeString"]

  val value_of : t -> int [@@js.call "valueOf"]

  val get_time : t -> int [@@js.call "getTime"]

  val get_full_year : t -> int [@@js.call "getFullYear"]

  val get_utc_full_year : t -> int [@@js.call "getUTCFullYear"]

  val get_month : t -> int [@@js.call "getMonth"]

  val get_utc_month : t -> int [@@js.call "getUTCMonth"]

  val get_date : t -> int [@@js.call "getDate"]

  val get_utc_date : t -> int [@@js.call "getUTCDate"]

  val get_day : t -> int [@@js.call "getDay"]

  val get_utc_day : t -> int [@@js.call "getUTCDay"]

  val get_hours : t -> int [@@js.call "getHours"]

  val get_utc_hours : t -> int [@@js.call "getUTCHours"]

  val get_minutes : t -> int [@@js.call "getMinutes"]

  val get_utc_minutes : t -> int [@@js.call "getUTCMinutes"]

  val get_seconds : t -> int [@@js.call "getSeconds"]

  val get_utc_seconds : t -> int [@@js.call "getUTCSeconds"]

  val get_milliseconds : t -> int [@@js.call "getMilliseconds"]

  val get_utc_milliseconds : t -> int [@@js.call "getUTCMilliseconds"]

  val get_timezone_offset : t -> int [@@js.call "getTimezoneOffset"]

  val set_time : t -> time:int -> int [@@js.call "setTime"]

  val set_milliseconds : t -> ms:int -> int [@@js.call "setMilliseconds"]

  val set_utc_milliseconds : t -> ms:int -> int [@@js.call "setUTCMilliseconds"]

  val set_seconds : t -> sec:int -> ?ms:int -> unit -> int
    [@@js.call "setSeconds"]

  val set_utc_seconds : t -> sec:int -> ?ms:int -> unit -> int
    [@@js.call "setUTCSeconds"]

  val set_minutes : t -> min:int -> ?sec:int -> ?ms:int -> unit -> int
    [@@js.call "setMinutes"]

  val set_utc_minutes : t -> min:int -> ?sec:int -> ?ms:int -> unit -> int
    [@@js.call "setUTCMinutes"]

  val set_hours :
    t -> hours:int -> ?min:int -> ?sec:int -> ?ms:int -> unit -> int
    [@@js.call "setHours"]

  val set_utc_hours :
    t -> hours:int -> ?min:int -> ?sec:int -> ?ms:int -> unit -> int
    [@@js.call "setUTCHours"]

  val set_date : t -> date:int -> int [@@js.call "setDate"]

  val set_utc_date : t -> date:int -> int [@@js.call "setUTCDate"]

  val set_month : t -> month:int -> ?date:int -> unit -> int
    [@@js.call "setMonth"]

  val set_utc_month : t -> month:int -> ?date:int -> unit -> int
    [@@js.call "setUTCMonth"]

  val set_full_year : t -> year:int -> ?month:int -> ?date:int -> unit -> int
    [@@js.call "setFullYear"]

  val set_utc_full_year :
    t -> year:int -> ?month:int -> ?date:int -> unit -> int
    [@@js.call "setUTCFullYear"]

  val to_utc_string : t -> string [@@js.call "toUTCString"]

  val to_iso_string : t -> string [@@js.call "toISOString"]

  val to_json : t -> ?key:any -> unit -> string [@@js.call "toJSON"]

  (* Constructor *)

  val create : unit -> t [@@js.new "Date"]

  val create' : string or_number -> t [@@js.new "Date"]

  val create'' :
       t
    -> year:int
    -> month:int
    -> ?date:int
    -> ?hours:int
    -> ?minutes:int
    -> ?seconds:int
    -> ?ms:int
    -> unit
    -> t
    [@@js.new "Date"]

  val parse : string -> int [@@js.global "Date.parse"]

  val utc :
       year:int
    -> month:int
    -> ?date:int
    -> ?hours:int
    -> ?minutes:int
    -> ?seconds:int
    -> ?ms:int
    -> unit
    -> int
    [@@js.global "Date.UTC"]

  val now : unit -> int [@@js.global "Date.now"]
end

module Date_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create : t -> Date.t [@@js.apply_newable]

  val create' : t -> string or_number -> Date.t [@@js.apply_newable]

  val create'' :
       t
    -> year:int
    -> month:int
    -> ?date:int
    -> ?hours:int
    -> ?minutes:int
    -> ?seconds:int
    -> ?ms:int
    -> unit
    -> Date.t
    [@@js.apply_newable]

  val apply : t -> string [@@js.apply]

  val get_prototype : t -> Date.t [@@js.get "prototype"]

  val parse : t -> string -> int [@@js.call "parse"]

  val utc :
       t
    -> year:int
    -> month:int
    -> ?date:int
    -> ?hours:int
    -> ?minutes:int
    -> ?seconds:int
    -> ?ms:int
    -> unit
    -> int
    [@@js.call "UTC"]

  val now : t -> int [@@js.call "now"]
end
[@@js.scope "DateConstructor"]

val date : Date_constructor.t [@@js.global "Date"]

module Error : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_name : t -> string [@@js.get "name"]

  val set_name : t -> string -> unit [@@js.set "name"]

  val get_message : t -> string [@@js.get "message"]

  val set_message : t -> string -> unit [@@js.set "message"]

  val get_stack : t -> string [@@js.get "stack"]

  val set_stack : t -> string -> unit [@@js.set "stack"]

  (* Constructor *)

  val create : ?message:string -> unit -> t [@@js.new "Error"]
end

module Error_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create : t -> ?message:string -> unit -> Error.t [@@js.apply_newable]

  val apply : t -> ?message:string -> unit -> Error.t [@@js.apply]

  val get_prototype : t -> Error.t [@@js.get "prototype"]
end
[@@js.scope "ErrorConstructor"]

val error : Error_constructor.t [@@js.global "Error"]

module Eval_error : sig
  include module type of struct
    include Error
  end

  (* Constructor *)

  val create : ?message:string -> unit -> t [@@js.new "EvalError"]
end

module Eval_error_constructor : sig
  include module type of struct
    include Error_constructor
  end

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create : t -> ?message:string -> unit -> Eval_error.t [@@js.apply_newable]

  val apply : t -> ?message:string -> unit -> Eval_error.t [@@js.apply]

  val get_prototype : t -> Eval_error.t [@@js.get "prototype"]
end
[@@js.scope "EvalErrorConstructor"]

val eval_error : Eval_error_constructor.t [@@js.global "EvalError"]

module Range_error : sig
  include module type of struct
    include Error
  end

  (* Constructor *)

  val create : ?message:string -> unit -> t [@@js.new "RangeError"]
end

module Range_error_constructor : sig
  include module type of struct
    include Error_constructor
  end

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create : t -> ?message:string -> unit -> Range_error.t
    [@@js.apply_newable]

  val apply : t -> ?message:string -> unit -> Range_error.t [@@js.apply]

  val get_prototype : t -> Range_error.t [@@js.get "prototype"]
end
[@@js.scope "RangeErrorConstructor"]

val range_error : Range_error_constructor.t [@@js.global "RangeError"]

module Reference_error : sig
  include module type of struct
    include Error
  end

  (* Constructor *)

  val create : ?message:string -> unit -> t [@@js.new "ReferenceError"]
end

module Reference_error_constructor : sig
  include module type of struct
    include Error_constructor
  end

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create : t -> ?message:string -> unit -> Reference_error.t
    [@@js.apply_newable]

  val apply : t -> ?message:string -> unit -> Reference_error.t [@@js.apply]

  val get_prototype : t -> Reference_error.t [@@js.get "prototype"]
end
[@@js.scope "ReferenceErrorConstructor"]

val reference_error : Reference_error_constructor.t
  [@@js.global "ReferenceError"]

module Syntax_error : sig
  include module type of struct
    include Error
  end

  (* Constructor *)

  val create : ?message:string -> unit -> t [@@js.new "SyntaxError"]
end

module Syntax_error_constructor : sig
  include module type of struct
    include Error_constructor
  end

  val create : t -> ?message:string -> unit -> Syntax_error.t
    [@@js.apply_newable]

  val apply : t -> ?message:string -> unit -> Syntax_error.t [@@js.apply]

  val get_prototype : t -> Syntax_error.t [@@js.get "prototype"]
end
[@@js.scope "SyntaxErrorConstructor"]

val syntax_error : Syntax_error_constructor.t [@@js.global "SyntaxError"]

module Type_error : sig
  include module type of struct
    include Error
  end

  (* Constructor *)

  val create : ?message:string -> unit -> t [@@js.new "TypeError"]
end

module Type_error_constructor : sig
  include module type of struct
    include Error_constructor
  end

  val create : t -> ?message:string -> unit -> Type_error.t [@@js.apply_newable]

  val apply : t -> ?message:string -> unit -> Type_error.t [@@js.apply]

  val get_prototype : t -> Type_error.t [@@js.get "prototype"]
end
[@@js.scope "TypeErrorConstructor"]

val type_error : Type_error_constructor.t [@@js.global "TypeError"]

module Uri_error : sig
  include module type of struct
    include Error
  end

  (* Constructor *)

  val create : ?message:string -> unit -> t [@@js.new "URIError"]
end

module Uri_error_constructor : sig
  include module type of struct
    include Error_constructor
  end

  val create : t -> ?message:string -> unit -> Uri_error.t [@@js.apply_newable]

  val apply : t -> ?message:string -> unit -> Uri_error.t [@@js.apply]

  val get_prototype : t -> Uri_error.t [@@js.get "prototype"]
end
[@@js.scope "URIErrorConstructor"]

val uri_error : Uri_error_constructor.t [@@js.global "URIError"]

module Json : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val parse :
       string
    -> ?reviver:(this:any -> key:string -> value:any -> any)
    -> unit
    -> any
    [@@js.global "parse"]

  val stringify :
       any
    -> ?replacer:(this:any -> key:string -> value:any -> any)
    -> ?space:string or_number
    -> unit
    -> string
    [@@js.global "stringify"]

  val stringify' :
       any
    -> ?replacer:string or_number list or_null
    -> ?space:string or_number
    -> unit
    -> string
    [@@js.global "stringify"]
end
[@@js.scope "JSON"]

module Typed_property_descriptor : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

  val get_enumerable : 'T t -> bool [@@js.get "enumerable"]

  val set_enumerable : 'T t -> bool -> unit [@@js.set "enumerable"]

  val get_configurable : 'T t -> bool [@@js.get "configurable"]

  val set_configurable : 'T t -> bool -> unit [@@js.set "configurable"]

  val get_writable : 'T t -> bool [@@js.get "writable"]

  val set_writable : 'T t -> bool -> unit [@@js.set "writable"]

  val get_value : 'T t -> 'T [@@js.get "value"]

  val set_value : 'T t -> 'T -> unit [@@js.set "value"]

  val get : 'T t -> 'T [@@js.call "get"]

  val set : 'T t -> 'T -> unit [@@js.call "set"]
end
[@@js.scope "TypedPropertyDescriptor"]

module Class_decorator : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val apply : t -> target:'TFunction -> ('TFunction, unit) union2 [@@js.apply]
end
[@@js.scope "ClassDecorator"]

module Property_decorator : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val apply : t -> target:Object.t -> property_key:symbol or_string -> unit
    [@@js.apply]
end
[@@js.scope "PropertyDecorator"]

module Method_decorator : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val apply :
       t
    -> target:Object.t
    -> property_key:symbol or_string
    -> descriptor:'T Typed_property_descriptor.t
    -> (unit, 'T Typed_property_descriptor.t) union2
    [@@js.apply]
end
[@@js.scope "MethodDecorator"]

module Parameter_decorator : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val apply :
       t
    -> target:Object.t
    -> property_key:symbol or_string
    -> parameter_index:int
    -> unit
    [@@js.apply]
end
[@@js.scope "ParameterDecorator"]

module Promise : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

  val then_ :
       'T t
    -> ?onfulfilled:('T -> 'TResult t)
    -> ?onrejected:(any -> 'TResult t)
    -> unit
    -> 'TResult t
    [@@js.call "then"]

  val catch : 'T t -> ?onrejected:(any -> 'T t) -> unit -> 'T t
    [@@js.call "catch"]

  (* Constructor *)

  val create : (resolve:('T -> unit) -> reject:('E -> unit) -> unit) -> 'T t
    [@@js.new "Promise"]
end

module Array_buffer : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_byte_length : t -> int [@@js.get "byteLength"]

  val slice : t -> begin_:int -> ?end_:int -> unit -> t [@@js.call "slice"]

  (* Constructor *)

  val create : byte_length:int -> t [@@js.new "ArrayBuffer"]

  val is_view : any -> bool [@@js.global "ArrayBuffer.isView"]
end

module Array_buffer_types : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_array_buffer : t -> Array_buffer.t [@@js.get "ArrayBuffer"]

  val set_array_buffer : t -> Array_buffer.t -> unit [@@js.set "ArrayBuffer"]
end
[@@js.scope "ArrayBufferTypes"]

module Array_buffer_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> Array_buffer.t [@@js.get "prototype"]

  val create : t -> byte_length:int -> Array_buffer.t [@@js.apply_newable]

  val is_view : t -> any -> bool [@@js.call "isView"]
end
[@@js.scope "ArrayBufferConstructor"]

val array_buffer : Array_buffer_constructor.t [@@js.global "ArrayBuffer"]

module Array_buffer_view : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_buffer : t -> Array_buffer.t [@@js.get "buffer"]

  val set_buffer : t -> Array_buffer.t -> unit [@@js.set "buffer"]

  val get_byte_length : t -> int [@@js.get "byteLength"]

  val set_byte_length : t -> int -> unit [@@js.set "byteLength"]

  val get_byte_offset : t -> int [@@js.get "byteOffset"]

  val set_byte_offset : t -> int -> unit [@@js.set "byteOffset"]
end
[@@js.scope "ArrayBufferView"]

module Data_view : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_buffer : t -> Array_buffer.t [@@js.get "buffer"]

  val get_byte_length : t -> int [@@js.get "byteLength"]

  val get_byte_offset : t -> int [@@js.get "byteOffset"]

  val get_float32 : t -> byte_offset:int -> ?little_endian:bool -> unit -> int
    [@@js.call "getFloat32"]

  val get_float64 : t -> byte_offset:int -> ?little_endian:bool -> unit -> int
    [@@js.call "getFloat64"]

  val get_int8 : t -> byte_offset:int -> int [@@js.call "getInt8"]

  val get_int16 : t -> byte_offset:int -> ?little_endian:bool -> unit -> int
    [@@js.call "getInt16"]

  val get_int32 : t -> byte_offset:int -> ?little_endian:bool -> unit -> int
    [@@js.call "getInt32"]

  val get_uint8 : t -> byte_offset:int -> int [@@js.call "getUint8"]

  val get_uint16 : t -> byte_offset:int -> ?little_endian:bool -> unit -> int
    [@@js.call "getUint16"]

  val get_uint32 : t -> byte_offset:int -> ?little_endian:bool -> unit -> int
    [@@js.call "getUint32"]

  val set_float32 :
    t -> byte_offset:int -> value:int -> ?little_endian:bool -> unit -> unit
    [@@js.call "setFloat32"]

  val set_float64 :
    t -> byte_offset:int -> value:int -> ?little_endian:bool -> unit -> unit
    [@@js.call "setFloat64"]

  val set_int8 : t -> byte_offset:int -> value:int -> unit [@@js.call "setInt8"]

  val set_int16 :
    t -> byte_offset:int -> value:int -> ?little_endian:bool -> unit -> unit
    [@@js.call "setInt16"]

  val set_int32 :
    t -> byte_offset:int -> value:int -> ?little_endian:bool -> unit -> unit
    [@@js.call "setInt32"]

  val set_uint8 : t -> byte_offset:int -> value:int -> unit
    [@@js.call "setUint8"]

  val set_uint16 :
    t -> byte_offset:int -> value:int -> ?little_endian:bool -> unit -> unit
    [@@js.call "setUint16"]

  val set_uint32 :
    t -> byte_offset:int -> value:int -> ?little_endian:bool -> unit -> unit
    [@@js.call "setUint32"]

  (* Constructor *)

  val create :
    buffer:Array_buffer.t -> ?byte_offset:int -> ?byte_length:int -> unit -> t
    [@@js.new "DataView"]
end

module Data_view_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> Data_view.t [@@js.get "prototype"]

  val create :
       t
    -> buffer:Array_buffer.t
    -> ?byte_offset:int
    -> ?byte_length:int
    -> unit
    -> Data_view.t
    [@@js.apply_newable]
end
[@@js.scope "DataViewConstructor"]

val data_view : Data_view_constructor.t [@@js.global "DataView"]

module Int8_array : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val get_buffer : t -> Array_buffer.t [@@js.get "buffer"]

  val get_byte_length : t -> int [@@js.get "byteLength"]

  val get_byte_offset : t -> int [@@js.get "byteOffset"]

  val copy_within : t -> target:int -> start:int -> ?end_:int -> unit -> t
    [@@js.call "copyWithin"]

  val every :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "every"]

  val fill : t -> int -> ?start:int -> ?end_:int -> unit -> t [@@js.call "fill"]

  val filter :
       t
    -> (value:int -> index:int -> array:t -> any)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "filter"]

  val find :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int or_undefined
    [@@js.call "find"]

  val find_index :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int
    [@@js.call "findIndex"]

  val for_each :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> unit)
    -> ?this_arg:any
    -> unit
    -> unit
    [@@js.call "forEach"]

  val index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "indexOf"]

  val join : t -> ?separator:string -> unit -> string [@@js.call "join"]

  val last_index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "lastIndexOf"]

  val get_length : t -> int [@@js.get "length"]

  val map :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "map"]

  val reduce :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduce"]

  val reduce' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduce"]

  val reduce'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduce"]

  val reduce_right :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduceRight"]

  val reduce_right' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduceRight"]

  val reduce_right'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduceRight"]

  val reverse : t -> t [@@js.call "reverse"]

  val set_ : t -> array:int Array.t -> ?offset:int -> unit -> unit
    [@@js.call "set"]

  val slice : t -> ?start:int -> ?end_:int -> unit -> t [@@js.call "slice"]

  val some :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "some"]

  val sort : t -> ?compare_fn:(a:int -> b:int -> int) -> unit -> t
    [@@js.call "sort"]

  val subarray : t -> ?begin_:int -> ?end_:int -> unit -> t
    [@@js.call "subarray"]

  val to_locale_string : t -> string [@@js.call "toLocaleString"]

  val to_string : t -> string [@@js.call "toString"]

  val value_of : t -> t [@@js.call "valueOf"]

  val get : t -> int -> int [@@js.index_get]

  val set : t -> int -> int -> unit [@@js.index_set]

  (* Constructor *)

  val create : length:int -> t [@@js.new "Int8Array"]

  val create' : array:(Array_buffer.t, int Array.t) union2 -> t
    [@@js.new "Int8Array"]

  val create'' :
    buffer:Array_buffer.t -> ?byte_offset:int -> ?length:int -> unit -> t
    [@@js.new "Int8Array"]

  val get_bytes_per_element : int [@@js.global "Int8Array.BYTES_PER_ELEMENT"]

  val of_ : (int list[@js.variadic]) -> t [@@js.global "Int8Array.of"]

  val from : array:int Array.t -> t [@@js.global "Int8Array.from"]

  val from' :
       array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Int8Array.from"]
end

module Int8_array_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> Int8_array.t [@@js.get "prototype"]

  val create : t -> length:int -> Int8_array.t [@@js.apply_newable]

  val create' : t -> array:(Array_buffer.t, int Array.t) union2 -> Int8_array.t
    [@@js.apply_newable]

  val create'' :
       t
    -> buffer:Array_buffer.t
    -> ?byte_offset:int
    -> ?length:int
    -> unit
    -> Int8_array.t
    [@@js.apply_newable]

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val of_ : t -> (int list[@js.variadic]) -> Int8_array.t [@@js.call "of"]

  val from : t -> array:int Array.t -> Int8_array.t [@@js.call "from"]

  val from' :
       t
    -> array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Int8_array.t
    [@@js.call "from"]
end
[@@js.scope "Int8ArrayConstructor"]

val int8_array : Int8_array_constructor.t [@@js.global "Int8Array"]

module Uint8_array : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val get_buffer : t -> Array_buffer.t [@@js.get "buffer"]

  val get_byte_length : t -> int [@@js.get "byteLength"]

  val get_byte_offset : t -> int [@@js.get "byteOffset"]

  val copy_within : t -> target:int -> start:int -> ?end_:int -> unit -> t
    [@@js.call "copyWithin"]

  val every :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "every"]

  val fill : t -> value:int -> ?start:int -> ?end_:int -> unit -> t
    [@@js.call "fill"]

  val filter :
       t
    -> (value:int -> index:int -> array:t -> any)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "filter"]

  val find :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int or_undefined
    [@@js.call "find"]

  val find_index :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int
    [@@js.call "findIndex"]

  val for_each :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> unit)
    -> ?this_arg:any
    -> unit
    -> unit
    [@@js.call "forEach"]

  val index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "indexOf"]

  val join : t -> ?separator:string -> unit -> string [@@js.call "join"]

  val last_index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "lastIndexOf"]

  val get_length : t -> int [@@js.get "length"]

  val map :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "map"]

  val reduce :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduce"]

  val reduce' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduce"]

  val reduce'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduce"]

  val reduce_right :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduceRight"]

  val reduce_right' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduceRight"]

  val reduce_right'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduceRight"]

  val reverse : t -> t [@@js.call "reverse"]

  val set_ : t -> array:int Array.t -> ?offset:int -> unit -> unit
    [@@js.call "set"]

  val slice : t -> ?start:int -> ?end_:int -> unit -> t [@@js.call "slice"]

  val some :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "some"]

  val sort : t -> ?compare_fn:(a:int -> b:int -> int) -> unit -> t
    [@@js.call "sort"]

  val subarray : t -> ?begin_:int -> ?end_:int -> unit -> t
    [@@js.call "subarray"]

  val to_locale_string : t -> string [@@js.call "toLocaleString"]

  val to_string : t -> string [@@js.call "toString"]

  val value_of : t -> t [@@js.call "valueOf"]

  val get : t -> int -> int [@@js.index_get]

  val set : t -> int -> int -> unit [@@js.index_set]

  (* Constructor *)

  val create : length:int -> t [@@js.new "Uint8Array"]

  val create' : array:(Array_buffer.t, int Array.t) union2 -> t
    [@@js.new "Uint8Array"]

  val create'' :
    buffer:Array_buffer.t -> ?byte_offset:int -> ?length:int -> unit -> t
    [@@js.new "Uint8Array"]

  val get_bytes_per_element : int [@@js.global "Uint8Array.BYTES_PER_ELEMENT"]

  val of_ : (int list[@js.variadic]) -> t [@@js.global "Uint8Array.of"]

  val from : array:int Array.t -> t [@@js.global "Uint8Array.from"]

  val from' :
       array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Uint8Array.from"]
end

module Uint8_array_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> Uint8_array.t [@@js.get "prototype"]

  val create : t -> length:int -> Uint8_array.t [@@js.apply_newable]

  val create' : t -> array:(Array_buffer.t, int Array.t) union2 -> Uint8_array.t
    [@@js.apply_newable]

  val create'' :
       t
    -> buffer:Array_buffer.t
    -> ?byte_offset:int
    -> ?length:int
    -> unit
    -> Uint8_array.t
    [@@js.apply_newable]

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val of_ : t -> (int list[@js.variadic]) -> Uint8_array.t [@@js.call "of"]

  val from : t -> array:int Array.t -> Uint8_array.t [@@js.call "from"]

  val from' :
       t
    -> array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Uint8_array.t
    [@@js.call "from"]
end
[@@js.scope "Uint8ArrayConstructor"]

val uint8_array : Uint8_array_constructor.t [@@js.global "Uint8Array"]

module Uint8_clamped_array : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val get_buffer : t -> Array_buffer.t [@@js.get "buffer"]

  val get_byte_length : t -> int [@@js.get "byteLength"]

  val get_byte_offset : t -> int [@@js.get "byteOffset"]

  val copy_within : t -> target:int -> start:int -> ?end_:int -> unit -> t
    [@@js.call "copyWithin"]

  val every :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "every"]

  val fill : t -> value:int -> ?start:int -> ?end_:int -> unit -> t
    [@@js.call "fill"]

  val filter :
       t
    -> (value:int -> index:int -> array:t -> any)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "filter"]

  val find :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int or_undefined
    [@@js.call "find"]

  val find_index :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int
    [@@js.call "findIndex"]

  val for_each :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> unit)
    -> ?this_arg:any
    -> unit
    -> unit
    [@@js.call "forEach"]

  val index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "indexOf"]

  val join : t -> ?separator:string -> unit -> string [@@js.call "join"]

  val last_index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "lastIndexOf"]

  val get_length : t -> int [@@js.get "length"]

  val map :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "map"]

  val reduce :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduce"]

  val reduce' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduce"]

  val reduce'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduce"]

  val reduce_right :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduceRight"]

  val reduce_right' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduceRight"]

  val reduce_right'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduceRight"]

  val reverse : t -> t [@@js.call "reverse"]

  val set_ : t -> array:int Array.t -> ?offset:int -> unit -> unit
    [@@js.call "set"]

  val slice : t -> ?start:int -> ?end_:int -> unit -> t [@@js.call "slice"]

  val some :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "some"]

  val sort : t -> ?compare_fn:(a:int -> b:int -> int) -> unit -> t
    [@@js.call "sort"]

  val subarray : t -> ?begin_:int -> ?end_:int -> unit -> t
    [@@js.call "subarray"]

  val to_locale_string : t -> string [@@js.call "toLocaleString"]

  val to_string : t -> string [@@js.call "toString"]

  val value_of : t -> t [@@js.call "valueOf"]

  val get : t -> int -> int [@@js.index_get]

  val set : t -> int -> int -> unit [@@js.index_set]

  (* Constructor *)

  val create : length:int -> t [@@js.new "Uint8ClampedArray"]

  val create' : array:(Array_buffer.t, int Array.t) union2 -> t
    [@@js.new "Uint8ClampedArray"]

  val create'' :
    buffer:Array_buffer.t -> ?byte_offset:int -> ?length:int -> unit -> t
    [@@js.new "Uint8ClampedArray"]

  val get_bytes_per_element : int
    [@@js.global "Uint8ClampedArray.BYTES_PER_ELEMENT"]

  val of_ : (int list[@js.variadic]) -> t [@@js.global "Uint8ClampedArray.of"]

  val from : array:int Array.t -> t [@@js.global "Uint8ClampedArray.from"]

  val from' :
       array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Uint8ClampedArray.from"]
end

module Uint8_clamped_array_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> Uint8_clamped_array.t [@@js.get "prototype"]

  val create : t -> length:int -> Uint8_clamped_array.t [@@js.apply_newable]

  val create' :
    t -> array:(Array_buffer.t, int Array.t) union2 -> Uint8_clamped_array.t
    [@@js.apply_newable]

  val create'' :
       t
    -> buffer:Array_buffer.t
    -> ?byte_offset:int
    -> ?length:int
    -> unit
    -> Uint8_clamped_array.t
    [@@js.apply_newable]

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val of_ : t -> (int list[@js.variadic]) -> Uint8_clamped_array.t
    [@@js.call "of"]

  val from : t -> array:int Array.t -> Uint8_clamped_array.t [@@js.call "from"]

  val from' :
       t
    -> array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Uint8_clamped_array.t
    [@@js.call "from"]
end
[@@js.scope "Uint8ClampedArrayConstructor"]

val uint8_clamped_array : Uint8_clamped_array_constructor.t
  [@@js.global "Uint8ClampedArray"]

module Int16_array : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val get_buffer : t -> Array_buffer.t [@@js.get "buffer"]

  val get_byte_length : t -> int [@@js.get "byteLength"]

  val get_byte_offset : t -> int [@@js.get "byteOffset"]

  val copy_within : t -> target:int -> start:int -> ?end_:int -> unit -> t
    [@@js.call "copyWithin"]

  val every :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "every"]

  val fill : t -> value:int -> ?start:int -> ?end_:int -> unit -> t
    [@@js.call "fill"]

  val filter :
       t
    -> (value:int -> index:int -> array:t -> any)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "filter"]

  val find :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int or_undefined
    [@@js.call "find"]

  val find_index :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int
    [@@js.call "findIndex"]

  val for_each :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> unit)
    -> ?this_arg:any
    -> unit
    -> unit
    [@@js.call "forEach"]

  val index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "indexOf"]

  val join : t -> ?separator:string -> unit -> string [@@js.call "join"]

  val last_index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "lastIndexOf"]

  val get_length : t -> int [@@js.get "length"]

  val map :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "map"]

  val reduce :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduce"]

  val reduce' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduce"]

  val reduce'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduce"]

  val reduce_right :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduceRight"]

  val reduce_right' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduceRight"]

  val reduce_right'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduceRight"]

  val reverse : t -> t [@@js.call "reverse"]

  val set_ : t -> array:int Array.t -> ?offset:int -> unit -> unit
    [@@js.call "set"]

  val slice : t -> ?start:int -> ?end_:int -> unit -> t [@@js.call "slice"]

  val some :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "some"]

  val sort : t -> ?compare_fn:(a:int -> b:int -> int) -> unit -> t
    [@@js.call "sort"]

  val subarray : t -> ?begin_:int -> ?end_:int -> unit -> t
    [@@js.call "subarray"]

  val to_locale_string : t -> string [@@js.call "toLocaleString"]

  val to_string : t -> string [@@js.call "toString"]

  val value_of : t -> t [@@js.call "valueOf"]

  val get : t -> int -> int [@@js.index_get]

  val set : t -> int -> int -> unit [@@js.index_set]

  (* Constructor *)

  val create : length:int -> t [@@js.new "Int16Array"]

  val create' : array:(Array_buffer.t, int Array.t) union2 -> t
    [@@js.new "Int16Array"]

  val create'' :
    buffer:Array_buffer.t -> ?byte_offset:int -> ?length:int -> unit -> t
    [@@js.new "Int16Array"]

  val get_bytes_per_element : int [@@js.global "Int16Array.BYTES_PER_ELEMENT"]

  val of_ : (int list[@js.variadic]) -> t [@@js.global "Int16Array.of"]

  val from : array:int Array.t -> t [@@js.global "Int16Array.from"]

  val from' :
       array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Int16Array.from"]
end

module Int16_array_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> Int16_array.t [@@js.get "prototype"]

  val create : t -> length:int -> Int16_array.t [@@js.apply_newable]

  val create' : t -> array:(Array_buffer.t, int Array.t) union2 -> Int16_array.t
    [@@js.apply_newable]

  val create'' :
       t
    -> buffer:Array_buffer.t
    -> ?byte_offset:int
    -> ?length:int
    -> unit
    -> Int16_array.t
    [@@js.apply_newable]

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val of_ : t -> (int list[@js.variadic]) -> Int16_array.t [@@js.call "of"]

  val from : t -> array:int Array.t -> Int16_array.t [@@js.call "from"]

  val from' :
       t
    -> array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Int16_array.t
    [@@js.call "from"]
end
[@@js.scope "Int16ArrayConstructor"]

val int16_array : Int16_array_constructor.t [@@js.global "Int16Array"]

module Uint16_array : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val get_buffer : t -> Array_buffer.t [@@js.get "buffer"]

  val get_byte_length : t -> int [@@js.get "byteLength"]

  val get_byte_offset : t -> int [@@js.get "byteOffset"]

  val copy_within : t -> target:int -> start:int -> ?end_:int -> unit -> t
    [@@js.call "copyWithin"]

  val every :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "every"]

  val fill : t -> value:int -> ?start:int -> ?end_:int -> unit -> t
    [@@js.call "fill"]

  val filter :
       t
    -> (value:int -> index:int -> array:t -> any)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "filter"]

  val find :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int or_undefined
    [@@js.call "find"]

  val find_index :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int
    [@@js.call "findIndex"]

  val for_each :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> unit)
    -> ?this_arg:any
    -> unit
    -> unit
    [@@js.call "forEach"]

  val index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "indexOf"]

  val join : t -> ?separator:string -> unit -> string [@@js.call "join"]

  val last_index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "lastIndexOf"]

  val get_length : t -> int [@@js.get "length"]

  val map :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "map"]

  val reduce :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduce"]

  val reduce' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduce"]

  val reduce'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduce"]

  val reduce_right :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduceRight"]

  val reduce_right' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduceRight"]

  val reduce_right'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduceRight"]

  val reverse : t -> t [@@js.call "reverse"]

  val set_ : t -> array:int Array.t -> ?offset:int -> unit -> unit
    [@@js.call "set"]

  val slice : t -> ?start:int -> ?end_:int -> unit -> t [@@js.call "slice"]

  val some :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "some"]

  val sort : t -> ?compare_fn:(a:int -> b:int -> int) -> unit -> t
    [@@js.call "sort"]

  val subarray : t -> ?begin_:int -> ?end_:int -> unit -> t
    [@@js.call "subarray"]

  val to_locale_string : t -> string [@@js.call "toLocaleString"]

  val to_string : t -> string [@@js.call "toString"]

  val value_of : t -> t [@@js.call "valueOf"]

  val get : t -> int -> int [@@js.index_get]

  val set : t -> int -> int -> unit [@@js.index_set]

  (* Constructor *)

  val create : length:int -> t [@@js.new "Uint16Array"]

  val create' : array:(Array_buffer.t, int Array.t) union2 -> t
    [@@js.new "Uint16Array"]

  val create'' :
    buffer:Array_buffer.t -> ?byte_offset:int -> ?length:int -> unit -> t
    [@@js.new "Uint16Array"]

  val get_bytes_per_element : int [@@js.global "Uint16Array.BYTES_PER_ELEMENT"]

  val of_ : (int list[@js.variadic]) -> t [@@js.global "Uint16Array.of"]

  val from : array:int Array.t -> t [@@js.global "Uint16Array.from"]

  val from' :
       array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Uint16Array.from"]
end

module Uint16_array_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> Uint16_array.t [@@js.get "prototype"]

  val create : t -> length:int -> Uint16_array.t [@@js.apply_newable]

  val create' :
    t -> array:(Array_buffer.t, int Array.t) union2 -> Uint16_array.t
    [@@js.apply_newable]

  val create'' :
       t
    -> buffer:Array_buffer.t
    -> ?byte_offset:int
    -> ?length:int
    -> unit
    -> Uint16_array.t
    [@@js.apply_newable]

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val of_ : t -> (int list[@js.variadic]) -> Uint16_array.t [@@js.call "of"]

  val from : t -> array:int Array.t -> Uint16_array.t [@@js.call "from"]

  val from' :
       t
    -> array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Uint16_array.t
    [@@js.call "from"]
end
[@@js.scope "Uint16ArrayConstructor"]

val uint16_array : Uint16_array_constructor.t [@@js.global "Uint16Array"]

module Int32_array : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val get_buffer : t -> Array_buffer.t [@@js.get "buffer"]

  val get_byte_length : t -> int [@@js.get "byteLength"]

  val get_byte_offset : t -> int [@@js.get "byteOffset"]

  val copy_within : t -> target:int -> start:int -> ?end_:int -> unit -> t
    [@@js.call "copyWithin"]

  val every :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "every"]

  val fill : t -> value:int -> ?start:int -> ?end_:int -> unit -> t
    [@@js.call "fill"]

  val filter :
       t
    -> (value:int -> index:int -> array:t -> any)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "filter"]

  val find :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int or_undefined
    [@@js.call "find"]

  val find_index :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int
    [@@js.call "findIndex"]

  val for_each :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> unit)
    -> ?this_arg:any
    -> unit
    -> unit
    [@@js.call "forEach"]

  val index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "indexOf"]

  val join : t -> ?separator:string -> unit -> string [@@js.call "join"]

  val last_index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "lastIndexOf"]

  val get_length : t -> int [@@js.get "length"]

  val map :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "map"]

  val reduce :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduce"]

  val reduce' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduce"]

  val reduce'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduce"]

  val reduce_right :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduceRight"]

  val reduce_right' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduceRight"]

  val reduce_right'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduceRight"]

  val reverse : t -> t [@@js.call "reverse"]

  val set_ : t -> array:int Array.t -> ?offset:int -> unit -> unit
    [@@js.call "set"]

  val slice : t -> ?start:int -> ?end_:int -> unit -> t [@@js.call "slice"]

  val some :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "some"]

  val sort : t -> ?compare_fn:(a:int -> b:int -> int) -> unit -> t
    [@@js.call "sort"]

  val subarray : t -> ?begin_:int -> ?end_:int -> unit -> t
    [@@js.call "subarray"]

  val to_locale_string : t -> string [@@js.call "toLocaleString"]

  val to_string : t -> string [@@js.call "toString"]

  val value_of : t -> t [@@js.call "valueOf"]

  val get : t -> int -> int [@@js.index_get]

  val set : t -> int -> int -> unit [@@js.index_set]

  (* Constructor *)

  val create : length:int -> t [@@js.new "Int32Array"]

  val create' : array:(Array_buffer.t, int Array.t) union2 -> t
    [@@js.new "Int32Array"]

  val create'' :
    buffer:Array_buffer.t -> ?byte_offset:int -> ?length:int -> unit -> t
    [@@js.new "Int32Array"]

  val get_bytes_per_element : int [@@js.global "Int32Array.BYTES_PER_ELEMENT"]

  val of_ : (int list[@js.variadic]) -> t [@@js.global "Int32Array.of"]

  val from : array:int Array.t -> t [@@js.global "Int32Array.from"]

  val from' :
       array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Int32Array.from"]
end

module Int32_array_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> Int32_array.t [@@js.get "prototype"]

  val create : t -> length:int -> Int32_array.t [@@js.apply_newable]

  val create' : t -> array:(Array_buffer.t, int Array.t) union2 -> Int32_array.t
    [@@js.apply_newable]

  val create'' :
       t
    -> buffer:Array_buffer.t
    -> ?byte_offset:int
    -> ?length:int
    -> unit
    -> Int32_array.t
    [@@js.apply_newable]

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val of_ : t -> (int list[@js.variadic]) -> Int32_array.t [@@js.call "of"]

  val from : t -> array:int Array.t -> Int32_array.t [@@js.call "from"]

  val from' :
       t
    -> array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Int32_array.t
    [@@js.call "from"]
end
[@@js.scope "Int32ArrayConstructor"]

val int32_array : Int32_array_constructor.t [@@js.global "Int32Array"]

module Uint32_array : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val get_buffer : t -> Array_buffer.t [@@js.get "buffer"]

  val get_byte_length : t -> int [@@js.get "byteLength"]

  val get_byte_offset : t -> int [@@js.get "byteOffset"]

  val copy_within : t -> target:int -> start:int -> ?end_:int -> unit -> t
    [@@js.call "copyWithin"]

  val every :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "every"]

  val fill : t -> value:int -> ?start:int -> ?end_:int -> unit -> t
    [@@js.call "fill"]

  val filter :
       t
    -> (value:int -> index:int -> array:t -> any)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "filter"]

  val find :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int or_undefined
    [@@js.call "find"]

  val find_index :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int
    [@@js.call "findIndex"]

  val for_each :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> unit)
    -> ?this_arg:any
    -> unit
    -> unit
    [@@js.call "forEach"]

  val index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "indexOf"]

  val join : t -> ?separator:string -> unit -> string [@@js.call "join"]

  val last_index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "lastIndexOf"]

  val get_length : t -> int [@@js.get "length"]

  val map :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "map"]

  val reduce :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduce"]

  val reduce' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduce"]

  val reduce'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduce"]

  val reduce_right :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduceRight"]

  val reduce_right' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduceRight"]

  val reduce_right'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduceRight"]

  val reverse : t -> t [@@js.call "reverse"]

  val set_ : t -> array:int Array.t -> ?offset:int -> unit -> unit
    [@@js.call "set"]

  val slice : t -> ?start:int -> ?end_:int -> unit -> t [@@js.call "slice"]

  val some :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "some"]

  val sort : t -> ?compare_fn:(a:int -> b:int -> int) -> unit -> t
    [@@js.call "sort"]

  val subarray : t -> ?begin_:int -> ?end_:int -> unit -> t
    [@@js.call "subarray"]

  val to_locale_string : t -> string [@@js.call "toLocaleString"]

  val to_string : t -> string [@@js.call "toString"]

  val value_of : t -> t [@@js.call "valueOf"]

  val get : t -> int -> int [@@js.index_get]

  val set : t -> int -> int -> unit [@@js.index_set]

  (* Constructor *)

  val create : length:int -> t [@@js.new "Uint32Array"]

  val create' : array:(Array_buffer.t, int Array.t) union2 -> t
    [@@js.new "Uint32Array"]

  val create'' :
    buffer:Array_buffer.t -> ?byte_offset:int -> ?length:int -> unit -> t
    [@@js.new "Uint32Array"]

  val get_bytes_per_element : int [@@js.global "Uint32Array.BYTES_PER_ELEMENT"]

  val of_ : (int list[@js.variadic]) -> t [@@js.global "Uint32Array.of"]

  val from : array:int Array.t -> t [@@js.global "Uint32Array.from"]

  val from' :
       array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Uint32Array.from"]
end

module Uint32_array_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> Uint32_array.t [@@js.get "prototype"]

  val create : t -> length:int -> Uint32_array.t [@@js.apply_newable]

  val create' :
    t -> array:(Array_buffer.t, int Array.t) union2 -> Uint32_array.t
    [@@js.apply_newable]

  val create'' :
       t
    -> buffer:Array_buffer.t
    -> ?byte_offset:int
    -> ?length:int
    -> unit
    -> Uint32_array.t
    [@@js.apply_newable]

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val of_ : t -> (int list[@js.variadic]) -> Uint32_array.t [@@js.call "of"]

  val from : t -> array:int Array.t -> Uint32_array.t [@@js.call "from"]

  val from' :
       t
    -> array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Uint32_array.t
    [@@js.call "from"]
end
[@@js.scope "Uint32ArrayConstructor"]

val uint32_array : Uint32_array_constructor.t [@@js.global "Uint32Array"]

module Float32_array : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val get_buffer : t -> Array_buffer.t [@@js.get "buffer"]

  val get_byte_length : t -> int [@@js.get "byteLength"]

  val get_byte_offset : t -> int [@@js.get "byteOffset"]

  val copy_within : t -> target:int -> start:int -> ?end_:int -> unit -> t
    [@@js.call "copyWithin"]

  val every :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "every"]

  val fill : t -> value:int -> ?start:int -> ?end_:int -> unit -> t
    [@@js.call "fill"]

  val filter :
       t
    -> (value:int -> index:int -> array:t -> any)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "filter"]

  val find :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int or_undefined
    [@@js.call "find"]

  val find_index :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int
    [@@js.call "findIndex"]

  val for_each :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> unit)
    -> ?this_arg:any
    -> unit
    -> unit
    [@@js.call "forEach"]

  val index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "indexOf"]

  val join : t -> ?separator:string -> unit -> string [@@js.call "join"]

  val last_index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "lastIndexOf"]

  val get_length : t -> int [@@js.get "length"]

  val map :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "map"]

  val reduce :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduce"]

  val reduce' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduce"]

  val reduce'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduce"]

  val reduce_right :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduceRight"]

  val reduce_right' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduceRight"]

  val reduce_right'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduceRight"]

  val reverse : t -> t [@@js.call "reverse"]

  val set_ : t -> array:int Array.t -> ?offset:int -> unit -> unit
    [@@js.call "set"]

  val slice : t -> ?start:int -> ?end_:int -> unit -> t [@@js.call "slice"]

  val some :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "some"]

  val sort : t -> ?compare_fn:(a:int -> b:int -> int) -> unit -> t
    [@@js.call "sort"]

  val subarray : t -> ?begin_:int -> ?end_:int -> unit -> t
    [@@js.call "subarray"]

  val to_locale_string : t -> string [@@js.call "toLocaleString"]

  val to_string : t -> string [@@js.call "toString"]

  val value_of : t -> t [@@js.call "valueOf"]

  val get : t -> int -> int [@@js.index_get]

  val set : t -> int -> int -> unit [@@js.index_set]

  (* Constructor *)

  val create : length:int -> t [@@js.new "Float32Array"]

  val create' : array:(Array_buffer.t, int Array.t) union2 -> t
    [@@js.new "Float32Array"]

  val create'' :
    buffer:Array_buffer.t -> ?byte_offset:int -> ?length:int -> unit -> t
    [@@js.new "Float32Array"]

  val get_bytes_per_element : int [@@js.global "Float32Array.BYTES_PER_ELEMENT"]

  val of_ : (int list[@js.variadic]) -> t [@@js.global "Float32Array.of"]

  val from : array:int Array.t -> t [@@js.global "Float32Array.from"]

  val from' :
       array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Float32Array.from"]
end

module Float32_array_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> Float32_array.t [@@js.get "prototype"]

  val create : t -> length:int -> Float32_array.t [@@js.apply_newable]

  val create' :
    t -> array:(Array_buffer.t, int Array.t) union2 -> Float32_array.t
    [@@js.apply_newable]

  val create'' :
       t
    -> buffer:Array_buffer.t
    -> ?byte_offset:int
    -> ?length:int
    -> unit
    -> Float32_array.t
    [@@js.apply_newable]

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val of_ : t -> (int list[@js.variadic]) -> Float32_array.t [@@js.call "of"]

  val from : t -> array:int Array.t -> Float32_array.t [@@js.call "from"]

  val from' :
       t
    -> array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Float32_array.t
    [@@js.call "from"]
end
[@@js.scope "Float32ArrayConstructor"]

val float32_array : Float32_array_constructor.t [@@js.global "Float32Array"]

module Float64_array : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val get_buffer : t -> Array_buffer.t [@@js.get "buffer"]

  val get_byte_length : t -> int [@@js.get "byteLength"]

  val get_byte_offset : t -> int [@@js.get "byteOffset"]

  val copy_within : t -> target:int -> start:int -> ?end_:int -> unit -> t
    [@@js.call "copyWithin"]

  val every :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "every"]

  val fill : t -> value:int -> ?start:int -> ?end_:int -> unit -> t
    [@@js.call "fill"]

  val filter :
       t
    -> (value:int -> index:int -> array:t -> any)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "filter"]

  val find :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int or_undefined
    [@@js.call "find"]

  val find_index :
       t
    -> (value:int -> index:int -> obj:t -> bool)
    -> ?this_arg:any
    -> unit
    -> int
    [@@js.call "findIndex"]

  val for_each :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> unit)
    -> ?this_arg:any
    -> unit
    -> unit
    [@@js.call "forEach"]

  val index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "indexOf"]

  val join : t -> ?separator:string -> unit -> string [@@js.call "join"]

  val last_index_of : t -> search_element:int -> ?from_index:int -> unit -> int
    [@@js.call "lastIndexOf"]

  val get_length : t -> int [@@js.get "length"]

  val map :
       t
    -> callbackfn:(value:int -> index:int -> array:t -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.call "map"]

  val reduce :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduce"]

  val reduce' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduce"]

  val reduce'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduce"]

  val reduce_right :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> int
    [@@js.call "reduceRight"]

  val reduce_right' :
       t
    -> callbackfn:
         (   previousValue:int
          -> current_value:int
          -> current_index:int
          -> array:t
          -> int)
    -> initial_value:int
    -> int
    [@@js.call "reduceRight"]

  val reduce_right'' :
       t
    -> callbackfn:
         (   previousValue:'U
          -> current_value:int
          -> current_index:int
          -> array:t
          -> 'U)
    -> initial_value:'U
    -> 'U
    [@@js.call "reduceRight"]

  val reverse : t -> t [@@js.call "reverse"]

  val set_ : t -> array:int Array.t -> ?offset:int -> unit -> unit
    [@@js.call "set"]

  val slice : t -> ?start:int -> ?end_:int -> unit -> t [@@js.call "slice"]

  val some :
       t
    -> (value:int -> index:int -> array:t -> unknown)
    -> ?this_arg:any
    -> unit
    -> bool
    [@@js.call "some"]

  val sort : t -> ?compare_fn:(a:int -> b:int -> int) -> unit -> t
    [@@js.call "sort"]

  val subarray : t -> ?begin_:int -> ?end_:int -> unit -> t
    [@@js.call "subarray"]

  val to_string : t -> string [@@js.call "toString"]

  val value_of : t -> t [@@js.call "valueOf"]

  val get : t -> int -> int [@@js.index_get]

  val set : t -> int -> int -> unit [@@js.index_set]

  (* Constructor *)

  val create : length:int -> t [@@js.new "Float64Array"]

  val create' : array:(Array_buffer.t, int Array.t) union2 -> t
    [@@js.new "Float64Array"]

  val create'' :
    buffer:Array_buffer.t -> ?byte_offset:int -> ?length:int -> unit -> t
    [@@js.new "Float64Array"]

  val get_bytes_per_element : int [@@js.global "Float64Array.BYTES_PER_ELEMENT"]

  val of_ : (int list[@js.variadic]) -> t [@@js.global "Float64Array.of"]

  val from : array:int Array.t -> t [@@js.global "Float64Array.from"]

  val from' :
       array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> t
    [@@js.global "Float64Array.from"]
end

module Float64_array_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> Float64_array.t [@@js.get "prototype"]

  val create : t -> length:int -> Float64_array.t [@@js.apply_newable]

  val create' :
    t -> array:(Array_buffer.t, int Array.t) union2 -> Float64_array.t
    [@@js.apply_newable]

  val create'' :
       t
    -> buffer:Array_buffer.t
    -> ?byte_offset:int
    -> ?length:int
    -> unit
    -> Float64_array.t
    [@@js.apply_newable]

  val get_bytes_per_element : t -> int [@@js.get "BYTES_PER_ELEMENT"]

  val of_ : t -> (int list[@js.variadic]) -> Float64_array.t [@@js.call "of"]

  val from : t -> array:int Array.t -> Float64_array.t [@@js.call "from"]

  val from' :
       t
    -> array:'T Array.t
    -> mapfn:(v:'T -> k:int -> int)
    -> ?this_arg:any
    -> unit
    -> Float64_array.t
    [@@js.call "from"]
end
[@@js.scope "Float64ArrayConstructor"]

val float64_array : Float64_array_constructor.t [@@js.global "Float64Array"]
