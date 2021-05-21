[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2017

module Promise : sig
  include module type of struct
    include Promise
  end

  val finally :
    'T t -> ?onfinally:(unit -> unit) or_null_or_undefined -> unit -> 'T t
    [@@js.call "finally"]
end
[@@js.scope "Promise"]
