[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - AsyncResource
  - Map<T1, T2>
 *)
[@@@js.stop]
module type Missing = sig
  module AsyncResource : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Map : sig
    type ('T1, 'T2) t_2
    val t_2_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T1, 'T2) t_2 -> Ojs.t
    val t_2_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> Ojs.t -> ('T1, 'T2) t_2
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module AsyncResource : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Map : sig
      type ('T1, 'T2) t_2
      val t_2_to_js: ('T1 -> Ojs.t) -> ('T2 -> Ojs.t) -> ('T1, 'T2) t_2 -> Ojs.t
      val t_2_of_js: (Ojs.t -> 'T1) -> (Ojs.t -> 'T2) -> Ojs.t -> ('T1, 'T2) t_2
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
      type perf_hooks_EntryType = ([`L_s0_function[@js "function"] | `L_s1_gc[@js "gc"] | `L_s2_http[@js "http"] | `L_s3_http2[@js "http2"] | `L_s4_mark[@js "mark"] | `L_s5_measure[@js "measure"] | `L_s6_node[@js "node"]] [@js.enum])
      and perf_hooks_EventLoopDelayMonitor = [`Perf_hooks_EventLoopDelayMonitor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and perf_hooks_EventLoopMonitorOptions = [`Perf_hooks_EventLoopMonitorOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and perf_hooks_EventLoopUtilization = [`Perf_hooks_EventLoopUtilization] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and perf_hooks_Performance = [`Perf_hooks_Performance] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and perf_hooks_PerformanceEntry = [`Perf_hooks_PerformanceEntry] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and perf_hooks_PerformanceNodeTiming = [`Perf_hooks_PerformanceNodeTiming | `Perf_hooks_PerformanceEntry] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and perf_hooks_PerformanceObserver = [`Perf_hooks_PerformanceObserver] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and perf_hooks_PerformanceObserverCallback = [`Perf_hooks_PerformanceObserverCallback] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and perf_hooks_PerformanceObserverEntryList = [`Perf_hooks_PerformanceObserverEntryList] intf
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
    val get_entryTypes: t -> perf_hooks_EntryType list [@@js.get "entryTypes"]
    val set_entryTypes: t -> perf_hooks_EntryType list -> unit [@@js.set "entryTypes"]
    val get_buffered: t -> bool [@@js.get "buffered"]
    val set_buffered: t -> bool -> unit [@@js.set "buffered"]
  end
  module[@js.scope "node:perf_hooks"] Node_perf_hooks : sig
    (* export * from 'perf_hooks'; *)
  end
  module[@js.scope "perf_hooks"] Perf_hooks : sig
    (* import { AsyncResource } from 'node:async_hooks'; *)
    module EntryType : sig
      type t = perf_hooks_EntryType
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "PerformanceEntry"] PerformanceEntry : sig
      type t = perf_hooks_PerformanceEntry
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_duration: t -> float [@@js.get "duration"]
      val get_name: t -> string [@@js.get "name"]
      val get_startTime: t -> float [@@js.get "startTime"]
      val get_entryType: t -> perf_hooks_EntryType [@@js.get "entryType"]
      val get_kind: t -> float [@@js.get "kind"]
      val get_flags: t -> float [@@js.get "flags"]
    end
    module[@js.scope "PerformanceNodeTiming"] PerformanceNodeTiming : sig
      type t = perf_hooks_PerformanceNodeTiming
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_bootstrapComplete: t -> float [@@js.get "bootstrapComplete"]
      val get_environment: t -> float [@@js.get "environment"]
      val get_idleTime: t -> float [@@js.get "idleTime"]
      val get_loopExit: t -> float [@@js.get "loopExit"]
      val get_loopStart: t -> float [@@js.get "loopStart"]
      val get_v8Start: t -> float [@@js.get "v8Start"]
      val cast: t -> perf_hooks_PerformanceEntry [@@js.cast]
    end
    module[@js.scope "EventLoopUtilization"] EventLoopUtilization : sig
      type t = perf_hooks_EventLoopUtilization
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_idle: t -> float [@@js.get "idle"]
      val set_idle: t -> float -> unit [@@js.set "idle"]
      val get_active: t -> float [@@js.get "active"]
      val set_active: t -> float -> unit [@@js.set "active"]
      val get_utilization: t -> float [@@js.get "utilization"]
      val set_utilization: t -> float -> unit [@@js.set "utilization"]
    end
    module[@js.scope "Performance"] Performance : sig
      type t = perf_hooks_Performance
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val clearMarks: t -> ?name:string -> unit -> unit [@@js.call "clearMarks"]
      val mark: t -> ?name:string -> unit -> unit [@@js.call "mark"]
      val measure: t -> name:string -> startMark:string -> endMark:string -> unit [@@js.call "measure"]
      val get_nodeTiming: t -> perf_hooks_PerformanceNodeTiming [@@js.get "nodeTiming"]
      val now: t -> float [@@js.call "now"]
      val get_timeOrigin: t -> float [@@js.get "timeOrigin"]
      val timerify: t -> fn:'T -> 'T [@@js.call "timerify"]
      val eventLoopUtilization: t -> ?util1:perf_hooks_EventLoopUtilization -> ?util2:perf_hooks_EventLoopUtilization -> unit -> perf_hooks_EventLoopUtilization [@@js.call "eventLoopUtilization"]
    end
    module[@js.scope "PerformanceObserverEntryList"] PerformanceObserverEntryList : sig
      type t = perf_hooks_PerformanceObserverEntryList
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val getEntries: t -> perf_hooks_PerformanceEntry list [@@js.call "getEntries"]
      val getEntriesByName: t -> name:string -> ?type_:perf_hooks_EntryType -> unit -> perf_hooks_PerformanceEntry list [@@js.call "getEntriesByName"]
      val getEntriesByType: t -> type_:perf_hooks_EntryType -> perf_hooks_PerformanceEntry list [@@js.call "getEntriesByType"]
    end
    module[@js.scope "PerformanceObserverCallback"] PerformanceObserverCallback : sig
      type t = perf_hooks_PerformanceObserverCallback
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val apply: t -> list:perf_hooks_PerformanceObserverEntryList -> observer:perf_hooks_PerformanceObserver -> unit [@@js.apply]
    end
    module[@js.scope "PerformanceObserver"] PerformanceObserver : sig
      type t = perf_hooks_PerformanceObserver
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: callback:perf_hooks_PerformanceObserverCallback -> t [@@js.create]
      val disconnect: t -> unit [@@js.call "disconnect"]
      val observe: t -> options:anonymous_interface_0 -> unit [@@js.call "observe"]
      val cast: t -> AsyncResource.t_0 [@@js.cast]
    end
    module[@js.scope "constants"] Constants : sig
      val nODE_PERFORMANCE_GC_MAJOR: float [@@js.global "NODE_PERFORMANCE_GC_MAJOR"]
      val nODE_PERFORMANCE_GC_MINOR: float [@@js.global "NODE_PERFORMANCE_GC_MINOR"]
      val nODE_PERFORMANCE_GC_INCREMENTAL: float [@@js.global "NODE_PERFORMANCE_GC_INCREMENTAL"]
      val nODE_PERFORMANCE_GC_WEAKCB: float [@@js.global "NODE_PERFORMANCE_GC_WEAKCB"]
      val nODE_PERFORMANCE_GC_FLAGS_NO: float [@@js.global "NODE_PERFORMANCE_GC_FLAGS_NO"]
      val nODE_PERFORMANCE_GC_FLAGS_CONSTRUCT_RETAINED: float [@@js.global "NODE_PERFORMANCE_GC_FLAGS_CONSTRUCT_RETAINED"]
      val nODE_PERFORMANCE_GC_FLAGS_FORCED: float [@@js.global "NODE_PERFORMANCE_GC_FLAGS_FORCED"]
      val nODE_PERFORMANCE_GC_FLAGS_SYNCHRONOUS_PHANTOM_PROCESSING: float [@@js.global "NODE_PERFORMANCE_GC_FLAGS_SYNCHRONOUS_PHANTOM_PROCESSING"]
      val nODE_PERFORMANCE_GC_FLAGS_ALL_AVAILABLE_GARBAGE: float [@@js.global "NODE_PERFORMANCE_GC_FLAGS_ALL_AVAILABLE_GARBAGE"]
      val nODE_PERFORMANCE_GC_FLAGS_ALL_EXTERNAL_MEMORY: float [@@js.global "NODE_PERFORMANCE_GC_FLAGS_ALL_EXTERNAL_MEMORY"]
      val nODE_PERFORMANCE_GC_FLAGS_SCHEDULE_IDLE: float [@@js.global "NODE_PERFORMANCE_GC_FLAGS_SCHEDULE_IDLE"]
    end
    val performance: perf_hooks_Performance [@@js.global "performance"]
    module[@js.scope "EventLoopMonitorOptions"] EventLoopMonitorOptions : sig
      type t = perf_hooks_EventLoopMonitorOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_resolution: t -> float [@@js.get "resolution"]
      val set_resolution: t -> float -> unit [@@js.set "resolution"]
    end
    module[@js.scope "EventLoopDelayMonitor"] EventLoopDelayMonitor : sig
      type t = perf_hooks_EventLoopDelayMonitor
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val enable: t -> bool [@@js.call "enable"]
      val disable: t -> bool [@@js.call "disable"]
      val reset: t -> unit [@@js.call "reset"]
      val percentile: t -> percentile:float -> float [@@js.call "percentile"]
      val get_percentiles: t -> (float, float) Map.t_2 [@@js.get "percentiles"]
      val get_exceeds: t -> float [@@js.get "exceeds"]
      val get_min: t -> float [@@js.get "min"]
      val get_max: t -> float [@@js.get "max"]
      val get_mean: t -> float [@@js.get "mean"]
      val get_stddev: t -> float [@@js.get "stddev"]
    end
    val monitorEventLoopDelay: ?options:perf_hooks_EventLoopMonitorOptions -> unit -> perf_hooks_EventLoopDelayMonitor [@@js.global "monitorEventLoopDelay"]
  end
end
