[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2016

module String : sig
  include module type of struct
    include String
  end

  val pad_start : t -> max_length:int -> ?fill_string:string -> unit -> string
    [@@js.call "padStart"]

  val pad_end : t -> max_length:int -> ?fill_string:string -> unit -> string
    [@@js.call "padEnd"]

  val to_ml : t -> string [@@js.cast]

  val of_ml : string -> t [@@js.cast]
end
[@@js.scope "String"]
