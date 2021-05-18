[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020

module Trace_events : sig
  module Tracing : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_categories : t -> string [@@js.get "categories"]

    val disable : t -> unit [@@js.call "disable"]

    val enable : t -> unit [@@js.call "enable"]

    val get_enabled : t -> bool [@@js.get "enabled"]
  end
  [@@js.scope "Tracing"]

  module Create_tracing_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_categories : t -> string list [@@js.get "categories"]

    val set_categories : t -> string list -> unit [@@js.set "categories"]
  end
  [@@js.scope "CreateTracingOptions"]

  val create_tracing : options:CreateTracingOptions.t -> Tracing.t
    [@@js.global "createTracing"]

  val get_enabled_categories : unit -> string or_undefined
    [@@js.global "getEnabledCategories"]
end
[@@js.scope Import.trace_events]
