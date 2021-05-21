[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Perf_hooks : sig
  module Entry_type : sig
    type t =
      ([ `function_ [@js "function"]
       | `gc [@js "gc"]
       | `http [@js "http"]
       | `http2 [@js "http2"]
       | `mark [@js "mark"]
       | `measure [@js "measure"]
       | `node [@js "node"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Anonymous_interface0 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_entry_types : t -> Entry_type.t list [@@js.get "entryTypes"]

    val set_entry_types : t -> Entry_type.t list -> unit [@@js.set "entryTypes"]

    val get_buffered : t -> bool [@@js.get "buffered"]

    val set_buffered : t -> bool -> unit [@@js.set "buffered"]
  end

  module Performance_entry : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_duration : t -> int [@@js.get "duration"]

    val get_name : t -> string [@@js.get "name"]

    val get_start_time : t -> int [@@js.get "startTime"]

    val get_entry_type : t -> Entry_type.t [@@js.get "entryType"]

    val get_kind : t -> int [@@js.get "kind"]

    val get_flags : t -> int [@@js.get "flags"]
  end
  [@@js.scope "PerformanceEntry"]

  module Performance_node_timing : sig
    include module type of struct
      include Performance_entry
    end

    val get_bootstrap_complete : t -> int [@@js.get "bootstrapComplete"]

    val get_environment : t -> int [@@js.get "environment"]

    val get_idle_time : t -> int [@@js.get "idleTime"]

    val get_loop_exit : t -> int [@@js.get "loopExit"]

    val get_loop_start : t -> int [@@js.get "loopStart"]

    val get_v8Start : t -> int [@@js.get "v8Start"]
  end
  [@@js.scope "PerformanceNodeTiming"]

  module Event_loop_utilization : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_idle : t -> int [@@js.get "idle"]

    val set_idle : t -> int -> unit [@@js.set "idle"]

    val get_active : t -> int [@@js.get "active"]

    val set_active : t -> int -> unit [@@js.set "active"]

    val get_utilization : t -> int [@@js.get "utilization"]

    val set_utilization : t -> int -> unit [@@js.set "utilization"]
  end
  [@@js.scope "EventLoopUtilization"]

  module Performance : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val clear_marks : t -> ?name:string -> unit -> unit [@@js.call "clearMarks"]

    val mark : t -> ?name:string -> unit -> unit [@@js.call "mark"]

    val measure :
      t -> name:string -> start_mark:string -> end_mark:string -> unit
      [@@js.call "measure"]

    val get_node_timing : t -> Performance_node_timing.t [@@js.get "nodeTiming"]

    val now : t -> int [@@js.call "now"]

    val get_time_origin : t -> int [@@js.get "timeOrigin"]

    val timerify : t -> fn:'T -> 'T [@@js.call "timerify"]

    val event_loop_utilization :
         t
      -> ?util1:Event_loop_utilization.t
      -> ?util2:Event_loop_utilization.t
      -> unit
      -> Event_loop_utilization.t
      [@@js.call "eventLoopUtilization"]
  end
  [@@js.scope "Performance"]

  module Performance_observer_entry_list : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_entries : t -> Performance_entry.t list [@@js.call "getEntries"]

    val get_entries_by_name :
         t
      -> name:string
      -> ?type_:Entry_type.t
      -> unit
      -> Performance_entry.t list
      [@@js.call "getEntriesByName"]

    val get_entries_by_type :
      t -> type_:Entry_type.t -> Performance_entry.t list
      [@@js.call "getEntriesByType"]
  end
  [@@js.scope "PerformanceObserverEntryList"]

  module Performance_observer_callback : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    (* val apply : t -> list:Performance_observer_entry_list.t ->
       observer:Performance_observer.t -> unit [@@js.apply] *)
  end
  (* [@@js.scope "PerformanceObserverCallback"] *)

  module Performance_observer : sig
    include module type of struct
      include Node_async_hooks.Async_hooks.Async_resource
    end

    val create : callback:Performance_observer_callback.t -> t [@@js.create]

    val disconnect : t -> unit [@@js.call "disconnect"]

    val observe : t -> options:Anonymous_interface0.t -> unit
      [@@js.call "observe"]
  end
  [@@js.scope "PerformanceObserver"]

  module Constants : sig
    val node_performance_gc_major : int
      [@@js.global "NODE_PERFORMANCE_GC_MAJOR"]

    val node_performance_gc_minor : int
      [@@js.global "NODE_PERFORMANCE_GC_MINOR"]

    val node_performance_gc_incremental : int
      [@@js.global "NODE_PERFORMANCE_GC_INCREMENTAL"]

    val node_performance_gc_weakcb : int
      [@@js.global "NODE_PERFORMANCE_GC_WEAKCB"]

    val node_performance_gc_flags_no : int
      [@@js.global "NODE_PERFORMANCE_GC_FLAGS_NO"]

    val node_performance_gc_flags_construct_retained : int
      [@@js.global "NODE_PERFORMANCE_GC_FLAGS_CONSTRUCT_RETAINED"]

    val node_performance_gc_flags_forced : int
      [@@js.global "NODE_PERFORMANCE_GC_FLAGS_FORCED"]

    val node_performance_gc_flags_synchronous_phantom_processing : int
      [@@js.global "NODE_PERFORMANCE_GC_FLAGS_SYNCHRONOUS_PHANTOM_PROCESSING"]

    val node_performance_gc_flags_all_available_garbage : int
      [@@js.global "NODE_PERFORMANCE_GC_FLAGS_ALL_AVAILABLE_GARBAGE"]

    val node_performance_gc_flags_all_external_memory : int
      [@@js.global "NODE_PERFORMANCE_GC_FLAGS_ALL_EXTERNAL_MEMORY"]

    val node_performance_gc_flags_schedule_idle : int
      [@@js.global "NODE_PERFORMANCE_GC_FLAGS_SCHEDULE_IDLE"]
  end
  [@@js.scope "constants"]

  val performance : Performance.t [@@js.global "performance"]

  module Event_loop_monitor_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_resolution : t -> int [@@js.get "resolution"]

    val set_resolution : t -> int -> unit [@@js.set "resolution"]
  end
  [@@js.scope "EventLoopMonitorOptions"]

  module Event_loop_delay_monitor : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val enable : t -> bool [@@js.call "enable"]

    val disable : t -> bool [@@js.call "disable"]

    val reset : t -> unit [@@js.call "reset"]

    val percentile : t -> percentile:int -> int [@@js.call "percentile"]

    val get_percentiles : t -> (int, int) Map.t [@@js.get "percentiles"]

    val get_exceeds : t -> int [@@js.get "exceeds"]

    val get_min : t -> int [@@js.get "min"]

    val get_max : t -> int [@@js.get "max"]

    val get_mean : t -> int [@@js.get "mean"]

    val get_stddev : t -> int [@@js.get "stddev"]
  end
  [@@js.scope "EventLoopDelayMonitor"]

  val monitor_event_loop_delay :
    ?options:Event_loop_monitor_options.t -> unit -> Event_loop_delay_monitor.t
    [@@js.global "monitorEventLoopDelay"]
end
[@@js.scope Import.perf_hooks]
