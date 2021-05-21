[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Domain : sig
  module Global : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val run :
         t
      -> fn:(args:(any list[@js.variadic]) -> 'T)
      -> args:(any list[@js.variadic])
      -> 'T
      [@@js.call "run"]

    val add :
      t -> emitter:(Node_events.Events.Event_emitter.t, Timer.t) union2 -> unit
      [@@js.call "add"]

    val remove :
      t -> emitter:(Node_events.Events.Event_emitter.t, Timer.t) union2 -> unit
      [@@js.call "remove"]

    val bind : t -> cb:'T -> 'T [@@js.call "bind"]

    val intercept : t -> cb:'T -> 'T [@@js.call "intercept"]
  end
  [@@js.scope "Domain"]

  include module type of struct
    include Global
  end

  module Domain : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_members :
      t -> (Node_events.Events.Event_emitter.t, Timer.t) union2 list
      [@@js.get "members"]

    val set_members :
      t -> (Node_events.Events.Event_emitter.t, Timer.t) union2 list -> unit
      [@@js.set "members"]

    val enter : t -> unit [@@js.call "enter"]

    val exit : t -> unit [@@js.call "exit"]
  end
  [@@js.scope "Domain"]

  val create_ : unit -> Domain.t [@@js.global "create"]
end
[@@js.scope Import.domain]
