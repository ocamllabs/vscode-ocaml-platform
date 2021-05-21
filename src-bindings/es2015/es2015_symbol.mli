[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es5

module Symbol : sig
  include module type of struct
    include Symbol
  end

  val for_ : key:string -> symbol [@@js.global "for"]

  val key_for : sym:symbol -> string or_undefined [@@js.global "keyFor"]
end
[@@js.scope "Symbol"]

module Symbol_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_prototype : t -> Symbol.t [@@js.get "prototype"]

  val apply : t -> ?description:string or_number -> unit -> symbol [@@js.apply]

  val for_ : t -> key:string -> symbol [@@js.call "for"]

  val key_for : t -> sym:symbol -> string or_undefined [@@js.call "keyFor"]
end
[@@js.scope "SymbolConstructor"]

val symbol : Symbol_constructor.t [@@js.global "Symbol"]
