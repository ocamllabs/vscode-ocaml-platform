[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2019

module Symbol_constructor : sig
  include module type of struct
    include Symbol_constructor
  end

  val get_match_all : t -> symbol [@@js.get "matchAll"]
end
[@@js.scope "SymbolConstructor"]

module Reg_exp : sig
  include module type of struct
    include Reg_exp
  end
end
