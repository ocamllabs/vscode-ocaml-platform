val iter_set : Ojs.t -> string -> ('a -> Ojs.t) -> 'a option -> unit

type 'a or_undefined = 'a option

val or_undefined_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a option

val or_undefined_to_js : ('a -> Ojs.t) -> 'a option -> Ojs.t

type 'a maybe_list = 'a list

val maybe_list_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a list

val maybe_list_to_js : ('a -> Ojs.t) -> 'a list -> Ojs.t

module Regexp : sig
  type t = Js_of_ocaml.Regexp.regexp

  val t_to_js : Js_of_ocaml.Regexp.regexp -> Ojs.t

  val t_of_js : Ojs.t -> Js_of_ocaml.Regexp.regexp

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

  val t_to_js : ('a -> Ojs.t) -> 'a t -> Ojs.t

  val t_of_js : (Ojs.t -> 'a) -> Ojs.t -> 'a t

  val of_alist : (string * 'a) list -> 'a t
end

module Js : sig
  module type T = sig
    type t

    val t_of_js : Ojs.t -> t

    val t_to_js : t -> Ojs.t
  end
end

module Interface : sig
  module Make () : Js.T with type t = private Ojs.t
end

module Class : sig
  module Make () : Js.T with type t = private Ojs.t

  module Extend (Super : Js.T) () : Js.T with type t = private Super.t
end
