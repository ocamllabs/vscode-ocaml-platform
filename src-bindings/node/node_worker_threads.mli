[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_message : t -> any [@@js.get "message"]

  val set_message : t -> any -> unit [@@js.set "message"]
end

module Worker_threads : sig
  module Message_port : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val close : t -> unit [@@js.call "close"]

    val post_message :
         t
      -> value:any (* -> ?transfer_list:Transfer_list_item.t list *)
      -> unit
      -> unit
      [@@js.call "postMessage"]

    val ref : t -> unit [@@js.call "ref"]

    val unref : t -> unit [@@js.call "unref"]

    val start : t -> unit [@@js.call "start"]

    val add_listener :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener' :
      t -> event:([ `message ][@js.enum]) -> listener:(value:any -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'' :
         t
      -> event:([ `messageerror ][@js.enum])
      -> listener:(error:Error.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "addListener"]

    val emit : t -> event:([ `close ][@js.enum]) -> bool [@@js.call "emit"]

    val emit' : t -> event:([ `message ][@js.enum]) -> value:any -> bool
      [@@js.call "emit"]

    val emit'' :
      t -> event:([ `messageerror ][@js.enum]) -> error:Error.t -> bool
      [@@js.call "emit"]

    val emit''' :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val on : t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on' :
      t -> event:([ `message ][@js.enum]) -> listener:(value:any -> unit) -> t
      [@@js.call "on"]

    val on'' :
         t
      -> event:([ `messageerror ][@js.enum])
      -> listener:(error:Error.t -> unit)
      -> t
      [@@js.call "on"]

    val on''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "on"]

    val once : t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once' :
      t -> event:([ `message ][@js.enum]) -> listener:(value:any -> unit) -> t
      [@@js.call "once"]

    val once'' :
         t
      -> event:([ `messageerror ][@js.enum])
      -> listener:(error:Error.t -> unit)
      -> t
      [@@js.call "once"]

    val once''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "once"]

    val prepend_listener :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener' :
      t -> event:([ `message ][@js.enum]) -> listener:(value:any -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'' :
         t
      -> event:([ `messageerror ][@js.enum])
      -> listener:(error:Error.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_once_listener :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener' :
      t -> event:([ `message ][@js.enum]) -> listener:(value:any -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'' :
         t
      -> event:([ `messageerror ][@js.enum])
      -> listener:(error:Error.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val remove_listener :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "removeListener"]

    val remove_listener' :
      t -> event:([ `message ][@js.enum]) -> listener:(value:any -> unit) -> t
      [@@js.call "removeListener"]

    val remove_listener'' :
         t
      -> event:([ `messageerror ][@js.enum])
      -> listener:(error:Error.t -> unit)
      -> t
      [@@js.call "removeListener"]

    val remove_listener''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "removeListener"]

    val off : t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "off"]

    val off' :
      t -> event:([ `message ][@js.enum]) -> listener:(value:any -> unit) -> t
      [@@js.call "off"]

    val off'' :
         t
      -> event:([ `messageerror ][@js.enum])
      -> listener:(error:Error.t -> unit)
      -> t
      [@@js.call "off"]

    val off''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "off"]
  end
  [@@js.scope "MessagePort"]

  module Message_channel : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_port1 : t -> Message_port.t [@@js.get "port1"]

    val get_port2 : t -> Message_port.t [@@js.get "port2"]
  end
  [@@js.scope "MessageChannel"]

  module Transfer_list_item : sig
    type t =
      ( Array_buffer.t
      , Node_fs_promises.Fs_promises.File_handle.t
      , Message_port.t )
      union3

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Resource_limits : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_max_young_generation_size_mb : t -> int
      [@@js.get "maxYoungGenerationSizeMb"]

    val set_max_young_generation_size_mb : t -> int -> unit
      [@@js.set "maxYoungGenerationSizeMb"]

    val get_max_old_generation_size_mb : t -> int
      [@@js.get "maxOldGenerationSizeMb"]

    val set_max_old_generation_size_mb : t -> int -> unit
      [@@js.set "maxOldGenerationSizeMb"]

    val get_code_range_size_mb : t -> int [@@js.get "codeRangeSizeMb"]

    val set_code_range_size_mb : t -> int -> unit [@@js.set "codeRangeSizeMb"]

    val get_stack_size_mb : t -> int [@@js.get "stackSizeMb"]

    val set_stack_size_mb : t -> int -> unit [@@js.set "stackSizeMb"]
  end
  [@@js.scope "ResourceLimits"]

  module Worker_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_argv : t -> any list [@@js.get "argv"]

    val set_argv : t -> any list -> unit [@@js.set "argv"]

    val get_env :
      t -> (string Dict.t, (* FIXME: unknown type 'unique symbol' *) any) union2
      [@@js.get "env"]

    val set_env :
         t
      -> (string Dict.t, (* FIXME: unknown type 'unique symbol' *) any) union2
      -> unit
      [@@js.set "env"]

    val get_eval : t -> bool [@@js.get "eval"]

    val set_eval : t -> bool -> unit [@@js.set "eval"]

    val get_worker_data : t -> any [@@js.get "workerData"]

    val set_worker_data : t -> any -> unit [@@js.set "workerData"]

    val get_stdin : t -> bool [@@js.get "stdin"]

    val set_stdin : t -> bool -> unit [@@js.set "stdin"]

    val get_stdout : t -> bool [@@js.get "stdout"]

    val set_stdout : t -> bool -> unit [@@js.set "stdout"]

    val get_stderr : t -> bool [@@js.get "stderr"]

    val set_stderr : t -> bool -> unit [@@js.set "stderr"]

    val get_exec_argv : t -> string list [@@js.get "execArgv"]

    val set_exec_argv : t -> string list -> unit [@@js.set "execArgv"]

    val get_resource_limits : t -> Resource_limits.t [@@js.get "resourceLimits"]

    val set_resource_limits : t -> Resource_limits.t -> unit
      [@@js.set "resourceLimits"]

    val get_transfer_list : t -> Transfer_list_item.t list
      [@@js.get "transferList"]

    val set_transfer_list : t -> Transfer_list_item.t list -> unit
      [@@js.set "transferList"]

    val get_track_unmanaged_fds : t -> bool [@@js.get "trackUnmanagedFds"]

    val set_track_unmanaged_fds : t -> bool -> unit
      [@@js.set "trackUnmanagedFds"]
  end
  [@@js.scope "WorkerOptions"]

  module Worker : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_stdin : t -> Node_stream.Stream.Writable.t or_null
      [@@js.get "stdin"]

    val get_stdout : t -> Node_stream.Stream.Writable.t [@@js.get "stdout"]

    val get_stderr : t -> Node_stream.Stream.Writable.t [@@js.get "stderr"]

    val get_thread_id : t -> int [@@js.get "threadId"]

    val get_resource_limits : t -> Resource_limits.t [@@js.get "resourceLimits"]

    val create :
         filename:Node_url.Url.Url.t or_string
      -> ?options:Worker_options.t
      -> unit
      -> t
      [@@js.create]

    val post_message :
      t -> value:any -> ?transfer_list:Transfer_list_item.t list -> unit -> unit
      [@@js.call "postMessage"]

    val ref : t -> unit [@@js.call "ref"]

    val unref : t -> unit [@@js.call "unref"]

    val terminate : t -> int Promise.t [@@js.call "terminate"]

    val get_heap_snapshot : t -> Node_stream.Stream.Writable.t Promise.t
      [@@js.call "getHeapSnapshot"]

    val add_listener :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "addListener"]

    val add_listener' :
      t -> event:([ `exit ][@js.enum]) -> listener:(exitCode:int -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'' :
      t -> event:([ `message ][@js.enum]) -> listener:(value:any -> unit) -> t
      [@@js.call "addListener"]

    val add_listener''' :
         t
      -> event:([ `messageerror ][@js.enum])
      -> listener:(error:Error.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'''' :
      t -> event:([ `online ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "addListener"]

    val emit : t -> event:([ `error ][@js.enum]) -> err:Error.t -> bool
      [@@js.call "emit"]

    val emit' : t -> event:([ `exit ][@js.enum]) -> exit_code:int -> bool
      [@@js.call "emit"]

    val emit'' : t -> event:([ `message ][@js.enum]) -> value:any -> bool
      [@@js.call "emit"]

    val emit''' :
      t -> event:([ `messageerror ][@js.enum]) -> error:Error.t -> bool
      [@@js.call "emit"]

    val emit'''' : t -> event:([ `online ][@js.enum]) -> bool [@@js.call "emit"]

    val emit''''' :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val on :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "on"]

    val on' :
      t -> event:([ `exit ][@js.enum]) -> listener:(exitCode:int -> unit) -> t
      [@@js.call "on"]

    val on'' :
      t -> event:([ `message ][@js.enum]) -> listener:(value:any -> unit) -> t
      [@@js.call "on"]

    val on''' :
         t
      -> event:([ `messageerror ][@js.enum])
      -> listener:(error:Error.t -> unit)
      -> t
      [@@js.call "on"]

    val on'''' :
      t -> event:([ `online ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "on"]

    val once :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "once"]

    val once' :
      t -> event:([ `exit ][@js.enum]) -> listener:(exitCode:int -> unit) -> t
      [@@js.call "once"]

    val once'' :
      t -> event:([ `message ][@js.enum]) -> listener:(value:any -> unit) -> t
      [@@js.call "once"]

    val once''' :
         t
      -> event:([ `messageerror ][@js.enum])
      -> listener:(error:Error.t -> unit)
      -> t
      [@@js.call "once"]

    val once'''' :
      t -> event:([ `online ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "once"]

    val prepend_listener :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener' :
      t -> event:([ `exit ][@js.enum]) -> listener:(exitCode:int -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'' :
      t -> event:([ `message ][@js.enum]) -> listener:(value:any -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener''' :
         t
      -> event:([ `messageerror ][@js.enum])
      -> listener:(error:Error.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener'''' :
      t -> event:([ `online ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_once_listener :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener' :
      t -> event:([ `exit ][@js.enum]) -> listener:(exitCode:int -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'' :
      t -> event:([ `message ][@js.enum]) -> listener:(value:any -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''' :
         t
      -> event:([ `messageerror ][@js.enum])
      -> listener:(error:Error.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''' :
      t -> event:([ `online ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val remove_listener :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "removeListener"]

    val remove_listener' :
      t -> event:([ `exit ][@js.enum]) -> listener:(exitCode:int -> unit) -> t
      [@@js.call "removeListener"]

    val remove_listener'' :
      t -> event:([ `message ][@js.enum]) -> listener:(value:any -> unit) -> t
      [@@js.call "removeListener"]

    val remove_listener''' :
         t
      -> event:([ `messageerror ][@js.enum])
      -> listener:(error:Error.t -> unit)
      -> t
      [@@js.call "removeListener"]

    val remove_listener'''' :
      t -> event:([ `online ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "removeListener"]

    val remove_listener''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "removeListener"]

    val off :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "off"]

    val off' :
      t -> event:([ `exit ][@js.enum]) -> listener:(exitCode:int -> unit) -> t
      [@@js.call "off"]

    val off'' :
      t -> event:([ `message ][@js.enum]) -> listener:(value:any -> unit) -> t
      [@@js.call "off"]

    val off''' :
         t
      -> event:([ `messageerror ][@js.enum])
      -> listener:(error:Error.t -> unit)
      -> t
      [@@js.call "off"]

    val off'''' :
      t -> event:([ `online ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "off"]

    val off''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "off"]
  end
  [@@js.scope "Worker"]

  val mark_as_untransferable : object_:untyped_object -> unit
    [@@js.global "markAsUntransferable"]

  val move_message_port_to_context :
    port:Message_port.t -> context:Node_vm.Vm.Context.t -> Message_port.t
    [@@js.global "moveMessagePortToContext"]

  val receive_message_on_port :
    port:Message_port.t -> Anonymous_interface0.t or_undefined
    [@@js.global "receiveMessageOnPort"]

  val is_main_thread : bool [@@js.global "isMainThread"]

  val parent_port : Message_port.t or_null [@@js.global "parentPort"]

  val resource_limits : Resource_limits.t [@@js.global "resourceLimits"]

  val share_env : (* FIXME: unknown type 'unique symbol' *) any
    [@@js.global "SHARE_ENV"]

  val thread_id : int [@@js.global "threadId"]

  val worker_data : any [@@js.global "workerData"]
end
[@@js.scope Import.worker_threads]
