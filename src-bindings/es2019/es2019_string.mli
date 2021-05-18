[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2018

module String : sig
  include module type of struct
    include String
  end

  val trim_end : t -> string [@@js.call "trimEnd"]

  val trim_start : t -> string [@@js.call "trimStart"]

  val trim_left : t -> string [@@js.call "trimLeft"]

  val trim_right : t -> string [@@js.call "trimRight"]

  val to_ml : t -> string [@@js.cast]

  val of_ml : string -> t [@@js.cast]
end
[@@js.scope "String"]
