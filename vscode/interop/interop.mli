val iter_set : Ojs.t -> string -> ('a -> Ojs.t) -> 'a option -> unit

type 'a or_undefined = 'a option

val or_undefined_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a option

val or_undefined_to_js : ('a -> Ojs.t) -> 'a option -> Ojs.t

type 'a maybe_list = 'a list

val maybe_list_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a list

val maybe_list_to_js : ('a -> Ojs.t) -> 'a list -> Ojs.t

module Regexp : sig
  type t = Js_of_ocaml.Regexp.regexp

  val t_of_js : Ojs.t -> Js_of_ocaml.Regexp.regexp

  val t_to_js : Js_of_ocaml.Regexp.regexp -> Ojs.t

  type replacer =
       matched:string
    -> captures:string list
    -> offset:int
    -> string:string
    -> string

  val replace : string -> regexp:t -> replacer:replacer -> string
end

module Dict : sig
  include Map.S with type key = string

  val t_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a t

  val t_to_js : ('a -> Ojs.t) -> 'a t -> Ojs.t

  val of_alist : (string * 'a) list -> 'a t
end

module Js : sig
  module type T = sig
    type t

    val t_of_js : Ojs.t -> t

    val t_to_js : t -> Ojs.t
  end

  type 'a t = (module T with type t = 'a)

  module Any : T with type t = Ojs.t

  module Unit : T with type t = unit

  module Bool : T with type t = bool

  module Int : T with type t = int

  module String : T with type t = string

  module Option (T : T) : T with type t = T.t option

  module Result (Ok : T) (Error : T) : T with type t = (Ok.t, Error.t) result

  module Or_undefined (T : T) : T with type t = T.t or_undefined

  module List (T : T) : T with type t = T.t list

  module Dict (T : T) : T with type t = T.t Dict.t
end

module Interface : sig
  module Make () : Js.T with type t = private Ojs.t

  module Extend (Super : Js.T) () : Js.T with type t = private Super.t

  module Generic (Super : Js.T) () : sig
    type 'a t = private Super.t

    type 'a generic = 'a t

    val generic_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a t

    val generic_to_js : ('a -> Ojs.t) -> 'a t -> Ojs.t
  end
end

module Class = Interface
