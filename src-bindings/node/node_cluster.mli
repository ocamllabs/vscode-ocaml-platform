[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Cluster : sig
  open Node_net

  module Cluster_settings : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_exec_argv : t -> string list [@@js.get "execArgv"]

    val set_exec_argv : t -> string list -> unit [@@js.set "execArgv"]

    val get_exec : t -> string [@@js.get "exec"]

    val set_exec : t -> string -> unit [@@js.set "exec"]

    val get_args : t -> string list [@@js.get "args"]

    val set_args : t -> string list -> unit [@@js.set "args"]

    val get_silent : t -> bool [@@js.get "silent"]

    val set_silent : t -> bool -> unit [@@js.set "silent"]

    val get_stdio : t -> any list [@@js.get "stdio"]

    val set_stdio : t -> any list -> unit [@@js.set "stdio"]

    val get_uid : t -> int [@@js.get "uid"]

    val set_uid : t -> int -> unit [@@js.set "uid"]

    val get_gid : t -> int [@@js.get "gid"]

    val set_gid : t -> int -> unit [@@js.set "gid"]

    val get_inspect_port : t -> (unit -> int) or_number [@@js.get "inspectPort"]

    val set_inspect_port : t -> (unit -> int) or_number -> unit
      [@@js.set "inspectPort"]
  end
  [@@js.scope "ClusterSettings"]

  module Address : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_address : t -> string [@@js.get "address"]

    val set_address : t -> string -> unit [@@js.set "address"]

    val get_port : t -> int [@@js.get "port"]

    val set_port : t -> int -> unit [@@js.set "port"]

    val get_address_type :
      t -> ([ `udp4 [@js "udp4"] | `udp6 [@js "udp6"] ][@js.enum]) or_number
      [@@js.get "addressType"]

    val set_address_type : t -> ([ `udp4 | `udp6 ][@js.enum]) or_number -> unit
      [@@js.set "addressType"]
  end
  [@@js.scope "Address"]

  module Worker : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_id : t -> int [@@js.get "id"]

    val set_id : t -> int -> unit [@@js.set "id"]

    val get_process : t -> Node_child_process.Child_process.Child_process.t
      [@@js.get "process"]

    val set_process :
      t -> Node_child_process.Child_process.Child_process.t -> unit
      [@@js.set "process"]

    val send :
         t
      -> message:Node_child_process.Child_process.Serializable.t
      -> ?send_handle:Node_child_process.Child_process.Send_handle.t
      -> ?callback:(error:Error.t or_null -> unit)
      -> unit
      -> bool
      [@@js.call "send"]

    val kill : t -> ?signal:string -> unit -> unit [@@js.call "kill"]

    val destroy : t -> ?signal:string -> unit -> unit [@@js.call "destroy"]

    val disconnect : t -> unit [@@js.call "disconnect"]

    val is_connected : t -> bool [@@js.call "isConnected"]

    val is_dead : t -> bool [@@js.call "isDead"]

    val get_exited_after_disconnect : t -> bool
      [@@js.get "exitedAfterDisconnect"]

    val set_exited_after_disconnect : t -> bool -> unit
      [@@js.set "exitedAfterDisconnect"]

    module Disconnect_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Error_listener : sig
      type t = error:Error.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Exit_listener : sig
      type t = code:int -> signal:string -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Listening_listener : sig
      type t = address:Address.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Message_listener : sig
      type t = message:any -> handle:(Net.Server.t, Net.Socket.t) union2 -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Online_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    type listener =
      ([ `Disconnect of Disconnect_listener.t
       | `Error of Error_listener.t
       | `Exit of Exit_listener.t
       | `Listening of Listening_listener.t
       | `Message of Message_listener.t
       | `Online of Online_listener.t
       ]
      [@js.union])

    [@@@js.stop]

    val on : t -> listener -> unit

    val add_listener : t -> listener -> unit

    val once : t -> listener -> unit

    val prepend_listener : t -> listener -> unit

    val prepend_once_listener : t -> listener -> unit

    [@@@js.start]

    [@@@js.implem
    val on : t -> string -> Ojs.t -> unit [@@js.call "on"]

    val add_listener : t -> string -> Ojs.t -> unit [@@js.call "addListener"]

    val once : t -> string -> Ojs.t -> unit [@@js.call "once"]

    val prepend_listener : t -> string -> Ojs.t -> unit
      [@@js.call "prependListener"]

    val prepend_once_listener : t -> string -> Ojs.t -> unit
      [@@js.call "prependOnceListener"]

    let with_listener_fn fn t = function
      | `Disconnect f -> fn t "disconnect" @@ [%js.of: Disconnect_listener.t] f
      | `Error f -> fn t "error" @@ [%js.of: Error_listener.t] f
      | `Exit f -> fn t "exit" @@ [%js.of: Exit_listener.t] f
      | `Listening f -> fn t "listening" @@ [%js.of: Listening_listener.t] f
      | `Message f -> fn t "message" @@ [%js.of: Message_listener.t] f
      | `Online f -> fn t "online" @@ [%js.of: Online_listener.t] f

    let on = with_listener_fn on

    let add_listener = with_listener_fn add_listener

    let once = with_listener_fn once

    let prepend_listener = with_listener_fn prepend_listener

    let prepend_once_listener = with_listener_fn prepend_once_listener]

    val emit :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val emit_disconnect : t -> event:([ `disconnect ][@js.enum]) -> bool
      [@@js.call "emit"]

    val emit_error : t -> event:([ `error ][@js.enum]) -> error:Error.t -> bool
      [@@js.call "emit"]

    val emit_exit :
      t -> event:([ `exit ][@js.enum]) -> code:int -> signal:string -> bool
      [@@js.call "emit"]

    val emit_listening :
      t -> event:([ `listening ][@js.enum]) -> address:Address.t -> bool
      [@@js.call "emit"]

    val emit_message :
         t
      -> event:([ `message ][@js.enum])
      -> message:any
      -> handle:(Net.Server.t, Net.Socket.t) union2
      -> bool
      [@@js.call "emit"]

    val emit_online : t -> event:([ `online ][@js.enum]) -> bool
      [@@js.call "emit"]
  end
  [@@js.scope "Worker"]

  module Cluster : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_worker : t -> Worker.t [@@js.get "Worker"]

    val set_worker : t -> Worker.t -> unit [@@js.set "Worker"]

    val disconnect : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "disconnect"]

    val fork : t -> ?env:any -> unit -> Worker.t [@@js.call "fork"]

    val get_is_master : t -> bool [@@js.get "isMaster"]

    val set_is_master : t -> bool -> unit [@@js.set "isMaster"]

    val get_is_worker : t -> bool [@@js.get "isWorker"]

    val set_is_worker : t -> bool -> unit [@@js.set "isWorker"]

    val get_scheduling_policy : t -> int [@@js.get "schedulingPolicy"]

    val set_scheduling_policy : t -> int -> unit [@@js.set "schedulingPolicy"]

    val get_settings : t -> Cluster_settings.t [@@js.get "settings"]

    val set_settings : t -> Cluster_settings.t -> unit [@@js.set "settings"]

    val setup_master : t -> ?settings:Cluster_settings.t -> unit -> unit
      [@@js.call "setupMaster"]

    val get_worker : t -> Worker.t [@@js.get "worker"]

    val set_worker : t -> Worker.t -> unit [@@js.set "worker"]

    val get_workers : t -> Worker.t Dict.t [@@js.get "workers"]

    val set_workers : t -> Worker.t Dict.t -> unit [@@js.set "workers"]

    val get_sched_none : t -> int [@@js.get "SCHED_NONE"]

    val get_sched_rr : t -> int [@@js.get "SCHED_RR"]

    module Disconnect_listener : sig
      type t = worker:Worker.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Exit_listener : sig
      type t = worker:Worker.t -> code:int -> signal:string -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Fork_listener : sig
      type t = worker:Worker.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Listening_listener : sig
      type t = worker:Worker.t -> address:Address.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Message_listener : sig
      type t =
           worker:Worker.t
        -> message:any
        -> handle:(Net.Server.t, Net.Socket.t) union2
        -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Online_listener : sig
      type t = worker:Worker.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Setup_listener : sig
      type t = settings:Cluster_settings.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    type listener =
      ([ `Disconnect of Disconnect_listener.t
       | `Exit of Exit_listener.t
       | `Fork of Fork_listener.t
       | `Listening of Listening_listener.t
       | `Message of Message_listener.t
       | `Online of Online_listener.t
       | `Setup of Setup_listener.t
       ]
      [@js.union])

    [@@@js.stop]

    val on : t -> listener -> unit

    val add_listener : t -> listener -> unit

    val once : t -> listener -> unit

    val prepend_listener : t -> listener -> unit

    val prepend_once_listener : t -> listener -> unit

    [@@@js.start]

    [@@@js.implem
    val on : t -> string -> Ojs.t -> unit [@@js.call "on"]

    val add_listener : t -> string -> Ojs.t -> unit [@@js.call "addListener"]

    val once : t -> string -> Ojs.t -> unit [@@js.call "once"]

    val prepend_listener : t -> string -> Ojs.t -> unit
      [@@js.call "prependListener"]

    val prepend_once_listener : t -> string -> Ojs.t -> unit
      [@@js.call "prependOnceListener"]

    let with_listener_fn fn t = function
      | `Disconnect f -> fn t "disconnect" @@ [%js.of: Disconnect_listener.t] f
      | `Exit f -> fn t "exit" @@ [%js.of: Exit_listener.t] f
      | `Fork f -> fn t "fork" @@ [%js.of: Fork_listener.t] f
      | `Listening f -> fn t "listening" @@ [%js.of: Listening_listener.t] f
      | `Message f -> fn t "message" @@ [%js.of: Message_listener.t] f
      | `Online f -> fn t "online" @@ [%js.of: Online_listener.t] f
      | `Setup f -> fn t "setup" @@ [%js.of: Setup_listener.t] f

    let on = with_listener_fn on

    let add_listener = with_listener_fn add_listener

    let once = with_listener_fn once

    let prepend_listener = with_listener_fn prepend_listener

    let prepend_once_listener = with_listener_fn prepend_once_listener]

    val emit :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val emit' :
      t -> event:([ `disconnect ][@js.enum]) -> worker:Worker.t -> bool
      [@@js.call "emit"]

    val emit'' :
         t
      -> event:([ `exit ][@js.enum])
      -> worker:Worker.t
      -> code:int
      -> signal:string
      -> bool
      [@@js.call "emit"]

    val emit''' : t -> event:([ `fork ][@js.enum]) -> worker:Worker.t -> bool
      [@@js.call "emit"]

    val emit'''' :
         t
      -> event:([ `listening ][@js.enum])
      -> worker:Worker.t
      -> address:Address.t
      -> bool
      [@@js.call "emit"]

    val emit''''' :
         t
      -> event:([ `message ][@js.enum])
      -> worker:Worker.t
      -> message:any
      -> handle:(Net.Server.t, Net.Socket.t) union2
      -> bool
      [@@js.call "emit"]

    val emit'''''' :
      t -> event:([ `online ][@js.enum]) -> worker:Worker.t -> bool
      [@@js.call "emit"]

    val emit''''''' :
      t -> event:([ `setup ][@js.enum]) -> settings:Cluster_settings.t -> bool
      [@@js.call "emit"]
  end
  [@@js.scope "Cluster"]

  val s_ched_none : int [@@js.global "SCHED_NONE"]

  val s_ched_rr : int [@@js.global "SCHED_RR"]

  val disconnect : ?callback:(unit -> unit) -> unit -> unit
    [@@js.global "disconnect"]

  val fork : ?env:any -> unit -> Worker.t [@@js.global "fork"]

  val is_master : bool [@@js.global "isMaster"]

  val is_worker : bool [@@js.global "isWorker"]

  val scheduling_policy : int [@@js.global "schedulingPolicy"]

  val settings : Cluster_settings.t [@@js.global "settings"]

  val setup_master : ?settings:Cluster_settings.t -> unit -> unit
    [@@js.global "setupMaster"]

  val worker : Worker.t [@@js.global "worker"]

  val workers : Worker.t Dict.t [@@js.global "workers"]

  val add_listener :
       event:string
    -> listener:(args:(any list[@js.variadic]) -> unit)
    -> Cluster.t
    [@@js.global "addListener"]

  val add_listener :
       event:([ `disconnect ][@js.enum])
    -> listener:(worker:Worker.t -> unit)
    -> Cluster.t
    [@@js.global "addListener"]

  val add_listener :
       event:([ `exit ][@js.enum])
    -> listener:(worker:Worker.t -> code:int -> signal:string -> unit)
    -> Cluster.t
    [@@js.global "addListener"]

  val add_listener :
       event:([ `fork ][@js.enum])
    -> listener:(worker:Worker.t -> unit)
    -> Cluster.t
    [@@js.global "addListener"]

  val add_listener :
       event:([ `listening ][@js.enum])
    -> listener:(worker:Worker.t -> address:Address.t -> unit)
    -> Cluster.t
    [@@js.global "addListener"]

  val add_listener :
       event:([ `message ][@js.enum])
    -> listener:
         (   worker:Worker.t
          -> message:any
          -> handle:(Net.Server.t, Net.Socket.t) union2
          -> unit)
    -> Cluster.t
    [@@js.global "addListener"]

  val add_listener :
       event:([ `online ][@js.enum])
    -> listener:(worker:Worker.t -> unit)
    -> Cluster.t
    [@@js.global "addListener"]

  val add_listener :
       event:([ `setup ][@js.enum])
    -> listener:(settings:Cluster_settings.t -> unit)
    -> Cluster.t
    [@@js.global "addListener"]

  val emit : event:symbol or_string -> args:(any list[@js.variadic]) -> bool
    [@@js.global "emit"]

  val emit : event:([ `disconnect ][@js.enum]) -> worker:Worker.t -> bool
    [@@js.global "emit"]

  val emit :
       event:([ `exit ][@js.enum])
    -> worker:Worker.t
    -> code:int
    -> signal:string
    -> bool
    [@@js.global "emit"]

  val emit : event:([ `fork ][@js.enum]) -> worker:Worker.t -> bool
    [@@js.global "emit"]

  val emit :
       event:([ `listening ][@js.enum])
    -> worker:Worker.t
    -> address:Address.t
    -> bool
    [@@js.global "emit"]

  val emit :
       event:([ `message ][@js.enum])
    -> worker:Worker.t
    -> message:any
    -> handle:(Net.Server.t, Net.Socket.t) union2
    -> bool
    [@@js.global "emit"]

  val emit : event:([ `online ][@js.enum]) -> worker:Worker.t -> bool
    [@@js.global "emit"]

  val emit : event:([ `setup ][@js.enum]) -> settings:Cluster_settings.t -> bool
    [@@js.global "emit"]

  val on :
       event:string
    -> listener:(args:(any list[@js.variadic]) -> unit)
    -> Cluster.t
    [@@js.global "on"]

  val on :
       event:([ `disconnect ][@js.enum])
    -> listener:(worker:Worker.t -> unit)
    -> Cluster.t
    [@@js.global "on"]

  val on :
       event:([ `exit ][@js.enum])
    -> listener:(worker:Worker.t -> code:int -> signal:string -> unit)
    -> Cluster.t
    [@@js.global "on"]

  val on :
       event:([ `fork ][@js.enum])
    -> listener:(worker:Worker.t -> unit)
    -> Cluster.t
    [@@js.global "on"]

  val on :
       event:([ `listening ][@js.enum])
    -> listener:(worker:Worker.t -> address:Address.t -> unit)
    -> Cluster.t
    [@@js.global "on"]

  val on :
       event:([ `message ][@js.enum])
    -> listener:
         (   worker:Worker.t
          -> message:any
          -> handle:(Net.Server.t, Net.Socket.t) union2
          -> unit)
    -> Cluster.t
    [@@js.global "on"]

  val on :
       event:([ `online ][@js.enum])
    -> listener:(worker:Worker.t -> unit)
    -> Cluster.t
    [@@js.global "on"]

  val on :
       event:([ `setup ][@js.enum])
    -> listener:(settings:Cluster_settings.t -> unit)
    -> Cluster.t
    [@@js.global "on"]

  val once :
       event:string
    -> listener:(args:(any list[@js.variadic]) -> unit)
    -> Cluster.t
    [@@js.global "once"]

  val once :
       event:([ `disconnect ][@js.enum])
    -> listener:(worker:Worker.t -> unit)
    -> Cluster.t
    [@@js.global "once"]

  val once :
       event:([ `exit ][@js.enum])
    -> listener:(worker:Worker.t -> code:int -> signal:string -> unit)
    -> Cluster.t
    [@@js.global "once"]

  val once :
       event:([ `fork ][@js.enum])
    -> listener:(worker:Worker.t -> unit)
    -> Cluster.t
    [@@js.global "once"]

  val once :
       event:([ `listening ][@js.enum])
    -> listener:(worker:Worker.t -> address:Address.t -> unit)
    -> Cluster.t
    [@@js.global "once"]

  val once :
       event:([ `message ][@js.enum])
    -> listener:
         (   worker:Worker.t
          -> message:any
          -> handle:(Net.Server.t, Net.Socket.t) union2
          -> unit)
    -> Cluster.t
    [@@js.global "once"]

  val once :
       event:([ `online ][@js.enum])
    -> listener:(worker:Worker.t -> unit)
    -> Cluster.t
    [@@js.global "once"]

  val once :
       event:([ `setup ][@js.enum])
    -> listener:(settings:Cluster_settings.t -> unit)
    -> Cluster.t
    [@@js.global "once"]

  val remove_listener :
       event:string
    -> listener:(args:(any list[@js.variadic]) -> unit)
    -> Cluster.t
    [@@js.global "removeListener"]

  val remove_all_listeners : ?event:string -> unit -> Cluster.t
    [@@js.global "removeAllListeners"]

  val set_max_listeners : n:int -> Cluster.t [@@js.global "setMaxListeners"]

  val get_max_listeners : unit -> int [@@js.global "getMaxListeners"]

  val listeners : event:string -> untyped_function list
    [@@js.global "listeners"]

  val listener_count : type_:string -> int [@@js.global "listenerCount"]

  val prepend_listener :
       event:string
    -> listener:(args:(any list[@js.variadic]) -> unit)
    -> Cluster.t
    [@@js.global "prependListener"]

  val prepend_listener :
       event:([ `disconnect ][@js.enum])
    -> listener:(worker:Worker.t -> unit)
    -> Cluster.t
    [@@js.global "prependListener"]

  val prepend_listener :
       event:([ `exit ][@js.enum])
    -> listener:(worker:Worker.t -> code:int -> signal:string -> unit)
    -> Cluster.t
    [@@js.global "prependListener"]

  val prepend_listener :
       event:([ `fork ][@js.enum])
    -> listener:(worker:Worker.t -> unit)
    -> Cluster.t
    [@@js.global "prependListener"]

  val prepend_listener :
       event:([ `listening ][@js.enum])
    -> listener:(worker:Worker.t -> address:Address.t -> unit)
    -> Cluster.t
    [@@js.global "prependListener"]

  val prepend_listener :
       event:([ `message ][@js.enum])
    -> listener:
         (   worker:Worker.t
          -> message:any
          -> handle:(Net.Server.t, Net.Socket.t) union2
          -> unit)
    -> Cluster.t
    [@@js.global "prependListener"]

  val prepend_listener :
       event:([ `online ][@js.enum])
    -> listener:(worker:Worker.t -> unit)
    -> Cluster.t
    [@@js.global "prependListener"]

  val prepend_listener :
       event:([ `setup ][@js.enum])
    -> listener:(settings:Cluster_settings.t -> unit)
    -> Cluster.t
    [@@js.global "prependListener"]

  val prepend_once_listener :
       event:string
    -> listener:(args:(any list[@js.variadic]) -> unit)
    -> Cluster.t
    [@@js.global "prependOnceListener"]

  val prepend_once_listener :
       event:([ `disconnect ][@js.enum])
    -> listener:(worker:Worker.t -> unit)
    -> Cluster.t
    [@@js.global "prependOnceListener"]

  val prepend_once_listener :
       event:([ `exit ][@js.enum])
    -> listener:(worker:Worker.t -> code:int -> signal:string -> unit)
    -> Cluster.t
    [@@js.global "prependOnceListener"]

  val prepend_once_listener :
       event:([ `fork ][@js.enum])
    -> listener:(worker:Worker.t -> unit)
    -> Cluster.t
    [@@js.global "prependOnceListener"]

  val prepend_once_listener :
       event:([ `listening ][@js.enum])
    -> listener:(worker:Worker.t -> address:Address.t -> unit)
    -> Cluster.t
    [@@js.global "prependOnceListener"]

  val prepend_once_listener :
       event:([ `message ][@js.enum])
    -> listener:
         (   worker:Worker.t
          -> message:any
          -> handle:(Net.Server.t, Net.Socket.t) union2
          -> unit)
    -> Cluster.t
    [@@js.global "prependOnceListener"]

  val prepend_once_listener :
       event:([ `online ][@js.enum])
    -> listener:(worker:Worker.t -> unit)
    -> Cluster.t
    [@@js.global "prependOnceListener"]

  val prepend_once_listener :
       event:([ `setup ][@js.enum])
    -> listener:(settings:Cluster_settings.t -> unit)
    -> Cluster.t
    [@@js.global "prependOnceListener"]

  val event_names : unit -> string list [@@js.global "eventNames"]
end
[@@js.scope Import.cluster]
