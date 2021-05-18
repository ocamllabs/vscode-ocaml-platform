[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - AsyncIterableIterator<T1>
  - NodeJS.EventEmitter
  - Promise<T1>
 *)
[@@@js.stop]
module type Missing = sig
  module AsyncIterableIterator : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module NodeJS : sig
    module EventEmitter : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
  end
  module Promise : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module AsyncIterableIterator : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module NodeJS : sig
      module EventEmitter : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
    end
    module Promise : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
  end
]
module Make (M: Missing) : sig
  open M
  module Internal : sig
    module AnonymousInterfaces : sig
      type anonymous_interface_0 = [`anonymous_interface_0] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
    module Types : sig
      open AnonymousInterfaces
      type events_DOMEventTarget = [`Events_DOMEventTarget] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and events_EventEmitter = [`Events_EventEmitter] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and events_EventEmitter = [`Events_EventEmitter] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and events_EventEmitterOptions = [`Events_EventEmitterOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and events_NodeEventTarget = [`Events_NodeEventTarget] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and events_global_NodeJS_EventEmitter = [`Events_global_NodeJS_EventEmitter] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module AnonymousInterface0 : sig
    type t = anonymous_interface_0
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_once: t -> bool [@@js.get "once"]
    val set_once: t -> bool -> unit [@@js.set "once"]
  end
  module[@js.scope "node:events"] Node_events : sig
    (* import EventEmitter = require('events'); *)
    
  end
  module[@js.scope "events"] Events : sig
    module[@js.scope "EventEmitterOptions"] EventEmitterOptions : sig
      type t = events_EventEmitterOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_captureRejections: t -> bool [@@js.get "captureRejections"]
      val set_captureRejections: t -> bool -> unit [@@js.set "captureRejections"]
    end
    module[@js.scope "NodeEventTarget"] NodeEventTarget : sig
      type t = events_NodeEventTarget
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val once: t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "once"]
    end
    module[@js.scope "DOMEventTarget"] DOMEventTarget : sig
      type t = events_DOMEventTarget
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val addEventListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> ?opts:anonymous_interface_0 -> unit -> any [@@js.call "addEventListener"]
    end
    module[@js.scope "EventEmitter"] EventEmitter : sig
      type t = events_EventEmitter
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val cast: t -> NodeJS.EventEmitter.t_0 [@@js.cast]
    end
    module[@js.scope "EventEmitter"] EventEmitter : sig
      type t = events_EventEmitter
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: ?options:events_EventEmitterOptions -> unit -> t [@@js.create]
      val once: emitter:events_NodeEventTarget -> event:symbol or_string -> any list Promise.t_1 [@@js.global "once"]
      val once': emitter:events_DOMEventTarget -> event:string -> any list Promise.t_1 [@@js.global "once"]
      val on: emitter:NodeJS.EventEmitter.t_0 -> event:string -> any AsyncIterableIterator.t_1 [@@js.global "on"]
      val listenerCount: emitter:NodeJS.EventEmitter.t_0 -> event:symbol or_string -> float [@@js.global "listenerCount"]
      val get_errorMonitor: unit -> (* FIXME: unknown type 'unique symbol' *)any [@@js.get "errorMonitor"]
      val get_captureRejectionSymbol: unit -> (* FIXME: unknown type 'unique symbol' *)any [@@js.get "captureRejectionSymbol"]
      val get_captureRejections: unit -> bool [@@js.get "captureRejections"]
      val set_captureRejections: bool -> unit [@@js.set "captureRejections"]
      val get_defaultMaxListeners: unit -> float [@@js.get "defaultMaxListeners"]
      val set_defaultMaxListeners: float -> unit [@@js.set "defaultMaxListeners"]
    end
    (* import internal = require('events'); *)
    module[@js.scope "EventEmitter"] EventEmitter : sig
      
    end
    module[@js.scope "global"] Global : sig
      module[@js.scope "NodeJS"] NodeJS : sig
        module[@js.scope "EventEmitter"] EventEmitter : sig
          type t = events_global_NodeJS_EventEmitter
          val t_to_js: t -> Ojs.t
          val t_of_js: Ojs.t -> t
          type t_0 = t
          val t_0_to_js: t_0 -> Ojs.t
          val t_0_of_js: Ojs.t -> t_0
          val addListener: t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "addListener"]
          val on: t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "on"]
          val once: t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "once"]
          val removeListener: t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "removeListener"]
          val off: t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "off"]
          val removeAllListeners: t -> ?event:symbol or_string -> unit -> t [@@js.call "removeAllListeners"]
          val setMaxListeners: t -> n:float -> t [@@js.call "setMaxListeners"]
          val getMaxListeners: t -> float [@@js.call "getMaxListeners"]
          val listeners: t -> event:symbol or_string -> untyped_function list [@@js.call "listeners"]
          val rawListeners: t -> event:symbol or_string -> untyped_function list [@@js.call "rawListeners"]
          val emit: t -> event:symbol or_string -> args:(any list [@js.variadic]) -> bool [@@js.call "emit"]
          val listenerCount: t -> event:symbol or_string -> float [@@js.call "listenerCount"]
          val prependListener: t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependListener"]
          val prependOnceListener: t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependOnceListener"]
          val eventNames: t -> symbol or_string list [@@js.call "eventNames"]
        end
      end
    end
    
  end
end
