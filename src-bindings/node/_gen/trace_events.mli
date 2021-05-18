[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib

module Internal : sig
  module AnonymousInterfaces : sig
    
  end
  module Types : sig
    open AnonymousInterfaces
    type trace_events_CreateTracingOptions = [`Trace_events_CreateTracingOptions] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and trace_events_Tracing = [`Trace_events_Tracing] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
  end
end

open Internal
open AnonymousInterfaces
open Types
module[@js.scope "node:trace_events"] Node_trace_events : sig
  (* export * from 'trace_events'; *)
end
module[@js.scope "trace_events"] Trace_events : sig
  module[@js.scope "Tracing"] Tracing : sig
    type t = trace_events_Tracing
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_categories: t -> string [@@js.get "categories"]
    val disable: t -> unit [@@js.call "disable"]
    val enable: t -> unit [@@js.call "enable"]
    val get_enabled: t -> bool [@@js.get "enabled"]
  end
  module[@js.scope "CreateTracingOptions"] CreateTracingOptions : sig
    type t = trace_events_CreateTracingOptions
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_categories: t -> string list [@@js.get "categories"]
    val set_categories: t -> string list -> unit [@@js.set "categories"]
  end
  val createTracing: options:trace_events_CreateTracingOptions -> trace_events_Tracing [@@js.global "createTracing"]
  val getEnabledCategories: unit -> string or_undefined [@@js.global "getEnabledCategories"]
end
