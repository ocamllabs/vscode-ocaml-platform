[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_once : t -> bool [@@js.get "once"]

  val set_once : t -> bool -> unit [@@js.set "once"]
end

module Events : sig
  module Event_emitter_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_capture_rejections : t -> bool [@@js.get "captureRejections"]

    val set_capture_rejections : t -> bool -> unit
      [@@js.set "captureRejections"]
  end
  [@@js.scope "EventEmitterOptions"]

  module Node_event_target : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val once :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "once"]
  end
  [@@js.scope "NodeEventTarget"]

  module Dom_event_target : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val add_event_listener :
         t
      -> event:string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> ?opts:Anonymous_interface0.t
      -> unit
      -> any
      [@@js.call "addEventListener"]
  end
  [@@js.scope "DOMEventTarget"]

  module Event_emitter : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create : ?options:Event_emitter_options.t -> unit -> t [@@js.create]

    val once :
         emitter:Node_event_target.t
      -> event:symbol or_string
      -> any list Promise.t
      [@@js.global "once"]

    val once' : emitter:Dom_event_target.t -> event:string -> any list Promise.t
      [@@js.global "once"]

    val on : emitter:t -> event:string -> any Async_iterable_iterator.t
      [@@js.global "on"]

    val listener_count : emitter:t -> event:symbol or_string -> int
      [@@js.global "listenerCount"]

    val get_error_monitor :
      unit -> (* FIXME: unknown type 'unique symbol' *) any
      [@@js.get "errorMonitor"]

    val get_capture_rejection_symbol :
      unit -> (* FIXME: unknown type 'unique symbol' *) any
      [@@js.get "captureRejectionSymbol"]

    val get_capture_rejections : unit -> bool [@@js.get "captureRejections"]

    val set_capture_rejections : bool -> unit [@@js.set "captureRejections"]

    val get_default_max_listeners : unit -> int [@@js.get "defaultMaxListeners"]

    val set_default_max_listeners : int -> unit [@@js.set "defaultMaxListeners"]
  end
  [@@js.scope "EventEmitter"]
end
[@@js.scope Import.events]

module Event_emitter : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val add_listener :
       t
    -> event:symbol or_string
    -> listener:(args:(any list[@js.variadic]) -> unit)
    -> t
    [@@js.call "addListener"]

  val on :
       t
    -> event:symbol or_string
    -> listener:(args:(any list[@js.variadic]) -> unit)
    -> t
    [@@js.call "on"]

  val once :
       t
    -> event:symbol or_string
    -> listener:(args:(any list[@js.variadic]) -> unit)
    -> t
    [@@js.call "once"]

  val remove_listener :
       t
    -> event:symbol or_string
    -> listener:(args:(any list[@js.variadic]) -> unit)
    -> t
    [@@js.call "removeListener"]

  val off :
       t
    -> event:symbol or_string
    -> listener:(args:(any list[@js.variadic]) -> unit)
    -> t
    [@@js.call "off"]

  val remove_all_listeners : t -> ?event:symbol or_string -> unit -> t
    [@@js.call "removeAllListeners"]

  val set_max_listeners : t -> n:int -> t [@@js.call "setMaxListeners"]

  val get_max_listeners : t -> int [@@js.call "getMaxListeners"]

  val listeners : t -> event:symbol or_string -> untyped_function list
    [@@js.call "listeners"]

  val raw_listeners : t -> event:symbol or_string -> untyped_function list
    [@@js.call "rawListeners"]

  val emit :
    t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
    [@@js.call "emit"]

  val listener_count : t -> event:symbol or_string -> int
    [@@js.call "listenerCount"]

  val prepend_listener :
       t
    -> event:symbol or_string
    -> listener:(args:(any list[@js.variadic]) -> unit)
    -> t
    [@@js.call "prependListener"]

  val prepend_once_listener :
       t
    -> event:symbol or_string
    -> listener:(args:(any list[@js.variadic]) -> unit)
    -> t
    [@@js.call "prependOnceListener"]

  val event_names : t -> symbol or_string list [@@js.call "eventNames"]
end
[@@js.scope "EventEmitter"]
