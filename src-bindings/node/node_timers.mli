[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Timers : sig
  val set_timeout :
    ((any list[@js.variadic]) -> unit) -> ?ms:int -> unit -> Timeout.t
    [@@js.global "setTimeout"]

  module Set_timeout : sig
    val __promisify__ : ms:int -> unit Promise.t [@@js.global "__promisify__"]

    val __promisify__ : ms:int -> value:'T -> 'T Promise.t
      [@@js.global "__promisify__"]
  end
  [@@js.scope "setTimeout"]

  val clear_timeout : Timeout.t -> unit [@@js.global "clearTimeout"]

  val set_interval :
    ((any list[@js.variadic]) -> unit) -> ?ms:int -> unit -> Timeout.t
    [@@js.global "setInterval"]

  val clear_interval : Timeout.t -> unit [@@js.global "clearInterval"]

  val set_immediate : ((any list[@js.variadic]) -> unit) -> unit -> Immediate.t
    [@@js.global "setImmediate"]

  module Set_immediate : sig
    val __promisify__ : unit -> unit Promise.t [@@js.global "__promisify__"]

    val __promisify__ : value:'T -> 'T Promise.t [@@js.global "__promisify__"]
  end
  [@@js.scope "setImmediate"]

  val clear_immediate : Immediate.t -> unit [@@js.global "clearImmediate"]
end
[@@js.scope Import.timers]
