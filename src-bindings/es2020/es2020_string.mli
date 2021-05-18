[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2019

module String : sig
  include module type of struct
    include String
  end

  val match_all :
    t -> regexp:regexp -> Reg_exp_match_array.t Iterable_iterator.t
    [@@js.call "matchAll"]

  val to_ml : t -> string [@@js.cast]

  val of_ml : string -> t [@@js.cast]
end
[@@js.scope "String"]
