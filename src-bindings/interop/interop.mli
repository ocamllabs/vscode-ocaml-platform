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
  type 'a t = (module Ojs.T with type t = 'a)

  module type Generic = sig
    type 'a t

    val t_to_js : ('a -> Ojs.t) -> 'a t -> Ojs.t

    val t_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a t
  end

  module Unit : Ojs.T with type t = unit

  module Result (Ok : Ojs.T) (Error : Ojs.T) :
    Ojs.T with type t = (Ok.t, Error.t) result

  module Or_undefined (T : Ojs.T) : Ojs.T with type t = T.t or_undefined

  module Dict (T : Ojs.T) : Ojs.T with type t = T.t Dict.t
end

module Interface : sig
  module Make () : Ojs.T with type t = private Ojs.t

  module Extend (Super : Ojs.T) () : Ojs.T with type t = private Super.t

  module Generic (Super : Ojs.T) () :
    Js.Generic with type 'a t = private Super.t
end

module Class = Interface
