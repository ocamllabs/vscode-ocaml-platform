[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2017

module Symbol_constructor : sig
  include module type of struct
    include Symbol_constructor
  end

  val get_async_iterator : t -> symbol [@@js.get "asyncIterator"]
end
[@@js.scope "SymbolConstructor"]

module Async_iterator : sig
  type ('T, 'TReturn, 'TNext) t

  val t_to_js :
       ('T -> Ojs.t)
    -> ('TReturn -> Ojs.t)
    -> ('TNext -> Ojs.t)
    -> ('T, 'TReturn, 'TNext) t
    -> Ojs.t

  val t_of_js :
       (Ojs.t -> 'T)
    -> (Ojs.t -> 'TReturn)
    -> (Ojs.t -> 'TNext)
    -> Ojs.t
    -> ('T, 'TReturn, 'TNext) t

  val next :
       ('T, 'TReturn, 'TNext) t
    -> args:
         (* FIXME: type 'union<() | ('TNext)>' cannot be used for variadic
            argument *) (any list[@js.variadic])
    -> ('T, 'TReturn) Iterator_result.t Promise.t
    [@@js.call "next"]

  val return :
       ('T, 'TReturn, 'TNext) t
    -> ?value:('TReturn, 'TReturn Promise.t) union2
    -> unit
    -> ('T, 'TReturn) Iterator_result.t Promise.t
    [@@js.call "return"]

  val throw :
       ('T, 'TReturn, 'TNext) t
    -> ?e:any
    -> unit
    -> ('T, 'TReturn) Iterator_result.t Promise.t
    [@@js.call "throw"]
end
[@@js.scope "AsyncIterator"]

module Async_iterable : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end

module Async_iterable_iterator : sig
  type 'T t = ('T, any, never or_undefined) Async_iterator.t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end
