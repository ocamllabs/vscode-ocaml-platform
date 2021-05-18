[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es5
open Es2015_iterable

module Generator : sig
  include module type of struct
    include Iterator
  end

  type ('T, 'TReturn) t_2 = ('T, 'TReturn, unknown) t

  val t_2_to_js :
    ('T -> Ojs.t) -> ('TReturn -> Ojs.t) -> ('T, 'TReturn) t_2 -> Ojs.t

  val t_2_of_js :
    (Ojs.t -> 'T) -> (Ojs.t -> 'TReturn) -> Ojs.t -> ('T, 'TReturn) t_2

  type 'T t_1 = ('T, any, unknown) t

  val t_1_to_js : ('T -> Ojs.t) -> 'T t_1 -> Ojs.t

  val t_1_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t_1

  type t_0 = (unknown, any, unknown) t

  val t_0_to_js : t_0 -> Ojs.t

  val t_0_of_js : Ojs.t -> t_0

  val next :
       ('T, 'TReturn, 'TNext) t
    -> args:
         (* FIXME: type 'union<() | ('TNext)>' cannot be used for variadic
            argument *) (any list[@js.variadic])
    -> ('T, 'TReturn) Iterator_result.t
    [@@js.call "next"]

  val return :
       ('T, 'TReturn, 'TNext) t
    -> value:'TReturn
    -> ('T, 'TReturn) Iterator_result.t
    [@@js.call "return"]

  val throw :
    ('T, 'TReturn, 'TNext) t -> e:any -> ('T, 'TReturn) Iterator_result.t
    [@@js.call "throw"]
end
[@@js.scope "Generator"]

module Generator_function : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create :
    t -> args:(any list[@js.variadic]) -> (unknown, any, unknown) Generator.t
    [@@js.apply_newable]

  val apply :
    t -> args:(any list[@js.variadic]) -> (unknown, any, unknown) Generator.t
    [@@js.apply]

  val get_length : t -> int [@@js.get "length"]

  val get_name : t -> string [@@js.get "name"]

  val get_prototype : t -> (unknown, any, unknown) Generator.t
    [@@js.get "prototype"]

  (* Constructor *)

  val create : (string list[@js.variadic]) -> t [@@js.new "GeneratorFunction"]

  val get_length : unit -> int [@@js.global "GeneratorFunction.length"]

  val get_name : unit -> string [@@js.global "GeneratorFunction.name"]
end

module Generator_function_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val create : t -> (string list[@js.variadic]) -> Generator_function.t
    [@@js.apply_newable]

  val apply : t -> (string list[@js.variadic]) -> Generator_function.t
    [@@js.apply]

  val get_length : t -> int [@@js.get "length"]

  val get_name : t -> string [@@js.get "name"]

  val get_prototype : t -> Generator_function.t [@@js.get "prototype"]
end
[@@js.scope "GeneratorFunctionConstructor"]
