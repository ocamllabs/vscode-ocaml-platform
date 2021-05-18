[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - Iterator<T1, T2, T3>
  - IteratorResult<T1, T2>
 *)
[@@@js.stop]
module type Missing = sig
  module Iterator : sig
    type ('T1, 'T2, 'T3) t_3
    val t_3_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T3 -> Ojs.t) -> ('T1, 'T2, 'T3) t_3 -> Ojs.t
    val t_3_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> (Ojs.t -> 'T3) -> Ojs.t -> ('T1, 'T2, 'T3) t_3
  end
  module IteratorResult : sig
    type ('T1, 'T2) t_2
    val t_2_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T1, 'T2) t_2 -> Ojs.t
    val t_2_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> Ojs.t -> ('T1, 'T2) t_2
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module Iterator : sig
      type ('T1, 'T2, 'T3) t_3
      val t_3_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T3 -> Ojs.t) -> ('T1, 'T2, 'T3) t_3 -> Ojs.t
      val t_3_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> (Ojs.t -> 'T3) -> Ojs.t -> ('T1, 'T2, 'T3) t_3
    end
    module IteratorResult : sig
      type ('T1, 'T2) t_2
      val t_2_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T1, 'T2) t_2 -> Ojs.t
      val t_2_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> Ojs.t -> ('T1, 'T2) t_2
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
      type ('T, 'TReturn, 'TNext) _Generator = [`Generator of ('T * 'TReturn * 'TNext)] intf
      [@@js.custom { of_js=(fun _T _TReturn _TNext -> Obj.magic); to_js=(fun _T _TReturn _TNext -> Obj.magic) }]
      and _GeneratorFunction = [`GeneratorFunction] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _GeneratorFunctionConstructor = [`GeneratorFunctionConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "Generator"] Generator : sig
    type ('T, 'TReturn, 'TNext) t = ('T, 'TReturn, 'TNext) _Generator
    val t_to_js: ('T -> Ojs.t) -> ('TReturn -> Ojs.t) -> ('TNext -> Ojs.t) -> ('T, 'TReturn, 'TNext) t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'TReturn) -> (Ojs.t -> 'TNext) -> Ojs.t -> ('T, 'TReturn, 'TNext) t
    type ('T, 'TReturn, 'TNext) t_3 = ('T, 'TReturn, 'TNext) t
    val t_3_to_js: ('T -> Ojs.t) -> ('TReturn -> Ojs.t) -> ('TNext -> Ojs.t) -> ('T, 'TReturn, 'TNext) t_3 -> Ojs.t
    val t_3_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'TReturn) -> (Ojs.t -> 'TNext) -> Ojs.t -> ('T, 'TReturn, 'TNext) t_3
    type ('T, 'TReturn) t_2 = ('T, 'TReturn, unknown) t
    val t_2_to_js: ('T -> Ojs.t) -> ('TReturn -> Ojs.t) -> ('T, 'TReturn) t_2 -> Ojs.t
    val t_2_of_js: (Ojs.t -> 'T) -> (Ojs.t -> 'TReturn) -> Ojs.t -> ('T, 'TReturn) t_2
    type 'T t_1 = ('T, any, unknown) t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
    type t_0 = (unknown, any, unknown) t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val next: ('T, 'TReturn, 'TNext) t -> args:((* FIXME: type 'union<() | ('TNext)>' cannot be used for variadic argument *)any list [@js.variadic]) -> ('T, 'TReturn) IteratorResult.t_2 [@@js.call "next"]
    val return: ('T, 'TReturn, 'TNext) t -> value:'TReturn -> ('T, 'TReturn) IteratorResult.t_2 [@@js.call "return"]
    val throw: ('T, 'TReturn, 'TNext) t -> e:any -> ('T, 'TReturn) IteratorResult.t_2 [@@js.call "throw"]
    val _Symbol_iterator_: ('T, 'TReturn, 'TNext) t -> ('T, 'TReturn, 'TNext) t [@@js.call "[Symbol.iterator]"]
    val cast: ('T, 'TReturn, 'TNext) t -> ('T, 'TReturn, 'TNext) Iterator.t_3 [@@js.cast]
  end
  module[@js.scope "GeneratorFunction"] GeneratorFunction : sig
    type t = _GeneratorFunction
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> args:(any list [@js.variadic]) -> (unknown, any, unknown) _Generator [@@js.apply_newable]
    val apply: t -> args:(any list [@js.variadic]) -> (unknown, any, unknown) _Generator [@@js.apply]
    val get_length: t -> float [@@js.get "length"]
    val get_name: t -> string [@@js.get "name"]
    val get_prototype: t -> (unknown, any, unknown) _Generator [@@js.get "prototype"]
  end
  module[@js.scope "GeneratorFunctionConstructor"] GeneratorFunctionConstructor : sig
    type t = _GeneratorFunctionConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> args:(string list [@js.variadic]) -> _GeneratorFunction [@@js.apply_newable]
    val apply: t -> args:(string list [@js.variadic]) -> _GeneratorFunction [@@js.apply]
    val get_length: t -> float [@@js.get "length"]
    val get_name: t -> string [@@js.get "name"]
    val get_prototype: t -> _GeneratorFunction [@@js.get "prototype"]
  end
end
