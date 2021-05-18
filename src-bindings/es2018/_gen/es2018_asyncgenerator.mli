[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - AsyncIterator<T1, T2, T3>
  - IteratorResult<T1, T2>
  - Promise<T1>
  - PromiseLike<T1>
 *)
[@@@js.stop]
module type Missing = sig
  module AsyncIterator : sig
    type ('T1, 'T2, 'T3) t_3
    val t_3_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T3 -> Ojs.t) -> ('T1, 'T2, 'T3) t_3 -> Ojs.t
    val t_3_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> (Ojs.t -> 'T3) -> Ojs.t -> ('T1, 'T2, 'T3) t_3
  end
  module IteratorResult : sig
    type ('T1, 'T2) t_2
    val t_2_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T1, 'T2) t_2 -> Ojs.t
    val t_2_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> Ojs.t -> ('T1, 'T2) t_2
  end
  module Promise : sig
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
    module AsyncIterator : sig
      type ('T1, 'T2, 'T3) t_3
      val t_3_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T3 -> Ojs.t) -> ('T1, 'T2, 'T3) t_3 -> Ojs.t
      val t_3_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> (Ojs.t -> 'T3) -> Ojs.t -> ('T1, 'T2, 'T3) t_3
    end
    module IteratorResult : sig
      type ('T1, 'T2) t_2
      val t_2_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T1, 'T2) t_2 -> Ojs.t
      val t_2_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> Ojs.t -> ('T1, 'T2) t_2
    end
    module Promise : sig
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
      type ('T, 'TReturn, 'TNext) _AsyncGenerator = [`AsyncGenerator of ('T * 'TReturn * 'TNext)] intf
      [@@js.custom { of_js=(fun _T _TReturn _TNext -> Obj.magic); to_js=(fun _T _TReturn _TNext -> Obj.magic) }]
      and _AsyncGeneratorFunction = [`AsyncGeneratorFunction] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _AsyncGeneratorFunctionConstructor = [`AsyncGeneratorFunctionConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "AsyncGenerator"] AsyncGenerator : sig
    type ('T, 'TReturn, 'TNext) t = ('T, 'TReturn, 'TNext) _AsyncGenerator
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
    val next: ('T, 'TReturn, 'TNext) t -> args:((* FIXME: type 'union<() | ('TNext)>' cannot be used for variadic argument *)any list [@js.variadic]) -> ('T, 'TReturn) IteratorResult.t_2 Promise.t_1 [@@js.call "next"]
    val return: ('T, 'TReturn, 'TNext) t -> value:('TReturn, 'TReturn PromiseLike.t_1) union2 -> ('T, 'TReturn) IteratorResult.t_2 Promise.t_1 [@@js.call "return"]
    val throw: ('T, 'TReturn, 'TNext) t -> e:any -> ('T, 'TReturn) IteratorResult.t_2 Promise.t_1 [@@js.call "throw"]
    val _Symbol_asyncIterator_: ('T, 'TReturn, 'TNext) t -> ('T, 'TReturn, 'TNext) t [@@js.call "[Symbol.asyncIterator]"]
    val cast: ('T, 'TReturn, 'TNext) t -> ('T, 'TReturn, 'TNext) AsyncIterator.t_3 [@@js.cast]
  end
  module[@js.scope "AsyncGeneratorFunction"] AsyncGeneratorFunction : sig
    type t = _AsyncGeneratorFunction
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> args:(any list [@js.variadic]) -> (unknown, any, unknown) _AsyncGenerator [@@js.apply_newable]
    val apply: t -> args:(any list [@js.variadic]) -> (unknown, any, unknown) _AsyncGenerator [@@js.apply]
    val get_length: t -> float [@@js.get "length"]
    val get_name: t -> string [@@js.get "name"]
    val get_prototype: t -> (unknown, any, unknown) _AsyncGenerator [@@js.get "prototype"]
  end
  module[@js.scope "AsyncGeneratorFunctionConstructor"] AsyncGeneratorFunctionConstructor : sig
    type t = _AsyncGeneratorFunctionConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: t -> args:(string list [@js.variadic]) -> _AsyncGeneratorFunction [@@js.apply_newable]
    val apply: t -> args:(string list [@js.variadic]) -> _AsyncGeneratorFunction [@@js.apply]
    val get_length: t -> float [@@js.get "length"]
    val get_name: t -> string [@@js.get "name"]
    val get_prototype: t -> _AsyncGeneratorFunction [@@js.get "prototype"]
  end
end
