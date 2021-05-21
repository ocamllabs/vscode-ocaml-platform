[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals
open Node_events
open Node_net

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_encoding : t -> Buffer_encoding.t [@@js.get "encoding"]

  val set_encoding : t -> Buffer_encoding.t -> unit [@@js.set "encoding"]
end

module Anonymous_interface1 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_encoding : t -> ([ `buffer [@js "buffer"] ][@js.enum]) or_null
    [@@js.get "encoding"]

  val set_encoding : t -> ([ `buffer ][@js.enum]) or_null -> unit
    [@@js.set "encoding"]
end

module Anonymous_interface2 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_stdout : t -> Buffer.t [@@js.get "stdout"]

  val set_stdout : t -> Buffer.t -> unit [@@js.set "stdout"]

  val get_stderr : t -> Buffer.t [@@js.get "stderr"]

  val set_stderr : t -> Buffer.t -> unit [@@js.set "stderr"]
end

module Anonymous_interface3 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_stdout : t -> string [@@js.get "stdout"]

  val set_stdout : t -> string -> unit [@@js.set "stdout"]

  val get_stderr : t -> string [@@js.get "stderr"]

  val set_stderr : t -> string -> unit [@@js.set "stderr"]
end

module Anonymous_interface4 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_stdout : t -> Buffer.t or_string [@@js.get "stdout"]

  val set_stdout : t -> Buffer.t or_string -> unit [@@js.set "stdout"]

  val get_stderr : t -> Buffer.t or_string [@@js.get "stderr"]

  val set_stderr : t -> Buffer.t or_string -> unit [@@js.set "stderr"]
end

module Child_process : sig
  module Serializable : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Send_handle : sig
    type t = (Net.Server.t, Net.Socket.t) union2

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Message_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_keep_open : t -> bool [@@js.get "keepOpen"]

    val set_keep_open : t -> bool -> unit [@@js.set "keepOpen"]
  end
  [@@js.scope "MessageOptions"]

  module Child_process : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_stdin : t -> Node_stream.Stream.Writable.t or_null
      [@@js.get "stdin"]

    val set_stdin : t -> Node_stream.Stream.Writable.t or_null -> unit
      [@@js.set "stdin"]

    val get_stdout : t -> Node_stream.Stream.Readable.t or_null
      [@@js.get "stdout"]

    val set_stdout : t -> Node_stream.Stream.Readable.t or_null -> unit
      [@@js.set "stdout"]

    val get_stderr : t -> Node_stream.Stream.Readable.t or_null
      [@@js.get "stderr"]

    val set_stderr : t -> Node_stream.Stream.Readable.t or_null -> unit
      [@@js.set "stderr"]

    val get_channel : t -> Node_stream.Stream.Pipe.t or_null
      [@@js.get "channel"]

    val get_stdio :
         t
      -> Node_stream.Stream.Writable.t or_null
         * Node_stream.Stream.Readable.t or_null
         * Node_stream.Stream.Readable.t or_null
         * (Node_stream.Stream.Readable.t, Node_stream.Stream.Writable.t) union2
           or_null_or_undefined
         * (Node_stream.Stream.Readable.t, Node_stream.Stream.Writable.t) union2
           or_null_or_undefined
      [@@js.get "stdio"]

    val get_killed : t -> bool [@@js.get "killed"]

    val get_pid : t -> int [@@js.get "pid"]

    val get_connected : t -> bool [@@js.get "connected"]

    val get_exit_code : t -> int or_null [@@js.get "exitCode"]

    val get_signal_code : t -> Node_process.Process.Signals.t or_null
      [@@js.get "signalCode"]

    val get_spawnargs : t -> string list [@@js.get "spawnargs"]

    val get_spawnfile : t -> string [@@js.get "spawnfile"]

    val kill :
      t -> ?signal:Node_process.Process.Signals.t or_number -> unit -> bool
      [@@js.call "kill"]

    val send :
         t
      -> message:Serializable.t
      -> ?callback:(error:Error.t or_null -> unit)
      -> unit
      -> bool
      [@@js.call "send"]

    val send' :
         t
      -> message:Serializable.t
      -> ?send_handle:Send_handle.t
      -> ?callback:(error:Error.t or_null -> unit)
      -> unit
      -> bool
      [@@js.call "send"]

    val send'' :
         t
      -> message:Serializable.t
      -> ?send_handle:Send_handle.t
      -> ?options:Message_options.t
      -> ?callback:(error:Error.t or_null -> unit)
      -> unit
      -> bool
      [@@js.call "send"]

    val disconnect : t -> unit [@@js.call "disconnect"]

    val unref : t -> unit [@@js.call "unref"]

    val ref : t -> unit [@@js.call "ref"]

    val emit :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val emit' :
         t
      -> event:([ `close ][@js.enum])
      -> code:int or_null
      -> signal:Node_process.Process.Signals.t or_null
      -> bool
      [@@js.call "emit"]

    val emit'' : t -> event:([ `disconnect ][@js.enum]) -> bool
      [@@js.call "emit"]

    val emit''' : t -> event:([ `error ][@js.enum]) -> err:Error.t -> bool
      [@@js.call "emit"]

    val emit'''' :
         t
      -> event:([ `exit ][@js.enum])
      -> code:int or_null
      -> signal:Node_process.Process.Signals.t or_null
      -> bool
      [@@js.call "emit"]

    val emit''''' :
         t
      -> event:([ `message ][@js.enum])
      -> message:Serializable.t
      -> send_handle:Send_handle.t
      -> bool
      [@@js.call "emit"]

    module Close_listener : sig
      type t =
           code:int or_null
        -> signal:Node_process.Process.Signals.t or_null
        -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Disconnect_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Error_listener : sig
      type t = err:Error.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Exit_listener : sig
      type t =
           code:int or_null
        -> signal:Node_process.Process.Signals.t or_null
        -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Message_listener : sig
      type t = message:Serializable.t -> send_handle:Send_handle.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Spawn_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    type listener =
      ([ `Close of Close_listener.t
       | `Disconnect of Disconnect_listener.t
       | `Error of Error_listener.t
       | `Exit of Exit_listener.t
       | `Message of Message_listener.t
       | `Spawn of Spawn_listener.t
       ]
      [@js.union])

    [@@@js.stop]

    val on : t -> listener -> unit

    val add_listener : t -> listener -> unit

    val once : t -> listener -> unit

    val prepend_listener : t -> listener -> unit

    [@@@js.start]

    [@@@js.implem
    val on : t -> string -> Ojs.t -> unit [@@js.call "on"]

    val add_listener : t -> string -> Ojs.t -> unit [@@js.call "addListener"]

    val once : t -> string -> Ojs.t -> unit [@@js.call "once"]

    val prepend_listener : t -> string -> Ojs.t -> unit
      [@@js.call "prependListener"]

    let with_listener_fn fn t = function
      | `Close f -> fn t "close" @@ [%js.of: Close_listener.t] f
      | `Disconnect f -> fn t "disconnect" @@ [%js.of: Disconnect_listener.t] f
      | `Error f -> fn t "error" @@ [%js.of: Error_listener.t] f
      | `Exit f -> fn t "exit" @@ [%js.of: Exit_listener.t] f
      | `Message f -> fn t "message" @@ [%js.of: Message_listener.t] f
      | `Spawn f -> fn t "spawn" @@ [%js.of: Spawn_listener.t] f

    let on = with_listener_fn on

    let add_listener = with_listener_fn add_listener

    let once = with_listener_fn once

    let prepend_listener = with_listener_fn prepend_listener]
  end
  [@@js.scope "ChildProcess"]

  module Child_process_without_null_streams : sig
    include module type of struct
      include Child_process
    end

    val get_stdin : t -> Node_stream.Stream.Writable.t [@@js.get "stdin"]

    val set_stdin : t -> Node_stream.Stream.Writable.t -> unit
      [@@js.set "stdin"]

    val get_stdout : t -> Node_stream.Stream.Readable.t [@@js.get "stdout"]

    val set_stdout : t -> Node_stream.Stream.Readable.t -> unit
      [@@js.set "stdout"]

    val get_stderr : t -> Node_stream.Stream.Readable.t [@@js.get "stderr"]

    val set_stderr : t -> Node_stream.Stream.Readable.t -> unit
      [@@js.set "stderr"]

    val get_stdio :
         t
      -> Node_stream.Stream.Writable.t
         * Node_stream.Stream.Readable.t
         * Node_stream.Stream.Readable.t
         * (Node_stream.Stream.Readable.t, Node_stream.Stream.Writable.t) union2
           or_null_or_undefined
         * (Node_stream.Stream.Readable.t, Node_stream.Stream.Writable.t) union2
           or_null_or_undefined
      [@@js.get "stdio"]
  end
  [@@js.scope "ChildProcessWithoutNullStreams"]

  module Child_process_by_stdio : sig
    type ('I, 'O, 'E) t

    val t_to_js :
      ('I -> Ojs.t) -> ('O -> Ojs.t) -> ('E -> Ojs.t) -> ('I, 'O, 'E) t -> Ojs.t

    val t_of_js :
      (Ojs.t -> 'I) -> (Ojs.t -> 'O) -> (Ojs.t -> 'E) -> Ojs.t -> ('I, 'O, 'E) t

    val get_stdin : ('I, 'O, 'E) t -> 'I [@@js.get "stdin"]

    val set_stdin : ('I, 'O, 'E) t -> 'I -> unit [@@js.set "stdin"]

    val get_stdout : ('I, 'O, 'E) t -> 'O [@@js.get "stdout"]

    val set_stdout : ('I, 'O, 'E) t -> 'O -> unit [@@js.set "stdout"]

    val get_stderr : ('I, 'O, 'E) t -> 'E [@@js.get "stderr"]

    val set_stderr : ('I, 'O, 'E) t -> 'E -> unit [@@js.set "stderr"]

    val get_stdio :
         ('I, 'O, 'E) t
      -> 'I
         * 'O
         * 'E
         * (Node_stream.Stream.Readable.t, Node_stream.Stream.Writable.t) union2
           or_null_or_undefined
         * (Node_stream.Stream.Readable.t, Node_stream.Stream.Writable.t) union2
           or_null_or_undefined
      [@@js.get "stdio"]

    val cast : ('I, 'O, 'E) t -> Child_process.t [@@js.cast]
  end
  [@@js.scope "ChildProcessByStdio"]

  module Stdio_options : sig
    type t =
      ( ( Node_stream.Stream.Stream.t
        , ([ `ignore [@js "ignore"]
           | `inherit_ [@js "inherit"]
           | `ipc [@js "ipc"]
           | `pipe [@js "pipe"]
           ]
          [@js.enum]) )
        or_enum
        or_number
        or_null_or_undefined
        list
      , ([ `ignore [@js "ignore"]
         | `inherit_ [@js "inherit"]
         | `pipe [@js "pipe"]
         ]
        [@js.enum]) )
      or_enum

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Serialization_type : sig
    type t =
      ([ `advanced [@js "advanced"]
       | `json [@js "json"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Messaging_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_serialization : t -> Serialization_type.t [@@js.get "serialization"]

    val set_serialization : t -> Serialization_type.t -> unit
      [@@js.set "serialization"]
  end
  [@@js.scope "MessagingOptions"]

  module Process_env_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_uid : t -> int [@@js.get "uid"]

    val set_uid : t -> int -> unit [@@js.set "uid"]

    val get_gid : t -> int [@@js.get "gid"]

    val set_gid : t -> int -> unit [@@js.set "gid"]

    val get_cwd : t -> string [@@js.get "cwd"]

    val set_cwd : t -> string -> unit [@@js.set "cwd"]

    val get_env : t -> Node_process.Process.Process_env.t [@@js.get "env"]

    val set_env : t -> Node_process.Process.Process_env.t -> unit
      [@@js.set "env"]

    val create :
         ?uid:int
      -> ?gid:int
      -> ?cwd:string
      -> ?env:Node_process.Process.Process_env.t
      -> unit
      -> t
      [@@js.builder]
  end
  [@@js.scope "ProcessEnvOptions"]

  module Common_options : sig
    include module type of struct
      include Process_env_options
    end

    val get_windows_hide : t -> bool [@@js.get "windowsHide"]

    val set_windows_hide : t -> bool -> unit [@@js.set "windowsHide"]

    val get_timeout : t -> int [@@js.get "timeout"]

    val set_timeout : t -> int -> unit [@@js.set "timeout"]
  end
  [@@js.scope "CommonOptions"]

  module Common_spawn_options : sig
    include module type of struct
      include Common_options
    end

    val get_argv0 : t -> string [@@js.get "argv0"]

    val set_argv0 : t -> string -> unit [@@js.set "argv0"]

    val get_stdio : t -> Stdio_options.t [@@js.get "stdio"]

    val set_stdio : t -> Stdio_options.t -> unit [@@js.set "stdio"]

    val get_shell : t -> bool or_string [@@js.get "shell"]

    val set_shell : t -> bool or_string -> unit [@@js.set "shell"]

    val get_windows_verbatim_arguments : t -> bool
      [@@js.get "windowsVerbatimArguments"]

    val set_windows_verbatim_arguments : t -> bool -> unit
      [@@js.set "windowsVerbatimArguments"]

    val cast' : t -> Messaging_options.t [@@js.cast]
  end
  [@@js.scope "CommonSpawnOptions"]

  module Spawn_options : sig
    include module type of struct
      include Common_spawn_options
    end

    val get_detached : t -> bool [@@js.get "detached"]

    val set_detached : t -> bool -> unit [@@js.set "detached"]
  end
  [@@js.scope "SpawnOptions"]

  module Spawn_options_without_stdio : sig
    include module type of struct
      include Spawn_options
    end

    val get_stdio :
         t
      -> ( ([ `pipe [@js "pipe"] ][@js.enum]) or_null_or_undefined list
         , ([ `pipe [@js "pipe"] ][@js.enum]) )
         or_enum
      [@@js.get "stdio"]

    val set_stdio :
         t
      -> ( ([ `pipe ][@js.enum]) or_null_or_undefined list
         , ([ `pipe ][@js.enum]) )
         or_enum
      -> unit
      [@@js.set "stdio"]
  end
  [@@js.scope "SpawnOptionsWithoutStdio"]

  module Stdio_null : sig
    type t =
      ( Node_stream.Stream.Stream.t
      , ([ `ignore [@js "ignore"] | `inherit_ [@js "inherit"] ][@js.enum]) )
      or_enum

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Stdio_pipe : sig
    type t = ([ `pipe [@js "pipe"] ][@js.enum]) or_null_or_undefined

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Spawn_options_with_stdio_tuple : sig
    type ('Stdin, 'Stdout, 'Stderr) t

    val t_to_js :
         ('Stdin -> Ojs.t)
      -> ('Stdout -> Ojs.t)
      -> ('Stderr -> Ojs.t)
      -> ('Stdin, 'Stdout, 'Stderr) t
      -> Ojs.t

    val t_of_js :
         (Ojs.t -> 'Stdin)
      -> (Ojs.t -> 'Stdout)
      -> (Ojs.t -> 'Stderr)
      -> Ojs.t
      -> ('Stdin, 'Stdout, 'Stderr) t

    val get_stdio : ('Stdin, 'Stdout, 'Stderr) t -> 'Stdin * 'Stdout * 'Stderr
      [@@js.get "stdio"]

    val set_stdio :
      ('Stdin, 'Stdout, 'Stderr) t -> 'Stdin * 'Stdout * 'Stderr -> unit
      [@@js.set "stdio"]

    val cast : ('Stdin, 'Stdout, 'Stderr) t -> Spawn_options.t [@@js.cast]
  end
  [@@js.scope "SpawnOptionsWithStdioTuple"]

  val spawn :
       string
    -> ?args:string list
    -> ?options:Spawn_options.t
    -> unit
    -> Child_process.t
    [@@js.global "spawn"]

  val spawn' :
       string
    -> options:
         ( Stdio_pipe.t
         , Stdio_pipe.t
         , Stdio_pipe.t )
         Spawn_options_with_stdio_tuple.t
    -> ( Node_stream.Stream.Writable.t
       , Node_stream.Stream.Readable.t
       , Node_stream.Stream.Readable.t )
       Child_process_by_stdio.t
    [@@js.global "spawn"]

  module Exec_options : sig
    include module type of struct
      include Common_options
    end

    val get_shell : t -> string [@@js.get "shell"]

    val set_shell : t -> string -> unit [@@js.set "shell"]

    val get_max_buffer : t -> int [@@js.get "maxBuffer"]

    val set_max_buffer : t -> int -> unit [@@js.set "maxBuffer"]

    val get_kill_signal : t -> Node_process.Process.Signals.t or_number
      [@@js.get "killSignal"]

    val set_kill_signal : t -> Node_process.Process.Signals.t or_number -> unit
      [@@js.set "killSignal"]
  end
  [@@js.scope "ExecOptions"]

  module Exec_options_with_string_encoding : sig
    include module type of struct
      include Exec_options
    end

    val get_encoding : t -> Buffer_encoding.t [@@js.get "encoding"]

    val set_encoding : t -> Buffer_encoding.t -> unit [@@js.set "encoding"]
  end
  [@@js.scope "ExecOptionsWithStringEncoding"]

  module Exec_options_with_buffer_encoding : sig
    include module type of struct
      include Exec_options
    end

    val get_encoding : t -> Buffer_encoding.t or_null [@@js.get "encoding"]

    val set_encoding : t -> Buffer_encoding.t or_null -> unit
      [@@js.set "encoding"]
  end
  [@@js.scope "ExecOptionsWithBufferEncoding"]

  module Exec_exception : sig
    include module type of struct
      include Error
    end

    val get_cmd : t -> string [@@js.get "cmd"]

    val set_cmd : t -> string -> unit [@@js.set "cmd"]

    val get_killed : t -> bool [@@js.get "killed"]

    val set_killed : t -> bool -> unit [@@js.set "killed"]

    val get_code : t -> int [@@js.get "code"]

    val set_code : t -> int -> unit [@@js.set "code"]

    val get_signal : t -> Node_process.Process.Signals.t [@@js.get "signal"]

    val set_signal : t -> Node_process.Process.Signals.t -> unit
      [@@js.set "signal"]
  end
  [@@js.scope "ExecException"]

  val exec :
       string
    -> ?options:Exec_options.t
    -> ?callback:
         (   error:Exec_exception.t or_null
          -> stdout:string
          -> stderr:string
          -> unit)
    -> unit
    -> Child_process.t
    [@@js.global "exec"]

  module Promise_with_child : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val get_child : 'T t -> Child_process.t [@@js.get "child"]

    val set_child : 'T t -> Child_process.t -> unit [@@js.set "child"]

    val cast : 'T t -> 'T Promise.t [@@js.cast]
  end
  [@@js.scope "PromiseWithChild"]

  module Exec : sig
    val __promisify__ :
         string
      -> ?options:Exec_options.t
      -> unit
      -> Anonymous_interface3.t Promise_with_child.t
      [@@js.global "__promisify__"]
  end
  [@@js.scope "exec"]

  module Exec_file_options : sig
    include module type of struct
      include Common_options
    end

    val get_max_buffer : t -> int [@@js.get "maxBuffer"]

    val set_max_buffer : t -> int -> unit [@@js.set "maxBuffer"]

    val get_kill_signal : t -> Node_process.Process.Signals.t or_number
      [@@js.get "killSignal"]

    val set_kill_signal : t -> Node_process.Process.Signals.t or_number -> unit
      [@@js.set "killSignal"]

    val get_windows_verbatim_arguments : t -> bool
      [@@js.get "windowsVerbatimArguments"]

    val set_windows_verbatim_arguments : t -> bool -> unit
      [@@js.set "windowsVerbatimArguments"]

    val get_shell : t -> bool or_string [@@js.get "shell"]

    val set_shell : t -> bool or_string -> unit [@@js.set "shell"]
  end
  [@@js.scope "ExecFileOptions"]

  module Exec_file_options_with_string_encoding : sig
    include module type of struct
      include Exec_file_options
    end

    val get_encoding : t -> Buffer_encoding.t [@@js.get "encoding"]

    val set_encoding : t -> Buffer_encoding.t -> unit [@@js.set "encoding"]
  end
  [@@js.scope "ExecFileOptionsWithStringEncoding"]

  module Exec_file_options_with_buffer_encoding : sig
    include module type of struct
      include Exec_file_options
    end

    val get_encoding : t -> ([ `buffer [@js "buffer"] ][@js.enum]) or_null
      [@@js.get "encoding"]

    val set_encoding : t -> ([ `buffer ][@js.enum]) or_null -> unit
      [@@js.set "encoding"]
  end
  [@@js.scope "ExecFileOptionsWithBufferEncoding"]

  module Exec_file_options_with_other_encoding : sig
    include module type of struct
      include Exec_file_options
    end

    val get_encoding : t -> Buffer_encoding.t [@@js.get "encoding"]

    val set_encoding : t -> Buffer_encoding.t -> unit [@@js.set "encoding"]
  end
  [@@js.scope "ExecFileOptionsWithOtherEncoding"]

  module Exec_file_exception : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  val exec_file :
       string
    -> ?options:Exec_file_options.t
    -> ?callback:
         (   error:Exec_file_exception.t or_null
          -> stdout:string
          -> stderr:string
          -> unit)
    -> unit
    -> Child_process.t
    [@@js.global "execFile"]

  module Exec_file : sig
    val __promisify__ :
         string
      -> ?args:string list
      -> ?options:Exec_file_options.t
      -> unit
      -> Anonymous_interface3.t Promise_with_child.t
      [@@js.global "__promisify__"]
  end
  [@@js.scope "execFile"]

  module Fork_options : sig
    include module type of struct
      include Process_env_options
    end

    val get_exec_path : t -> string [@@js.get "execPath"]

    val set_exec_path : t -> string -> unit [@@js.set "execPath"]

    val get_exec_argv : t -> string list [@@js.get "execArgv"]

    val set_exec_argv : t -> string list -> unit [@@js.set "execArgv"]

    val get_silent : t -> bool [@@js.get "silent"]

    val set_silent : t -> bool -> unit [@@js.set "silent"]

    val get_stdio : t -> Stdio_options.t [@@js.get "stdio"]

    val set_stdio : t -> Stdio_options.t -> unit [@@js.set "stdio"]

    val get_detached : t -> bool [@@js.get "detached"]

    val set_detached : t -> bool -> unit [@@js.set "detached"]

    val get_windows_verbatim_arguments : t -> bool
      [@@js.get "windowsVerbatimArguments"]

    val set_windows_verbatim_arguments : t -> bool -> unit
      [@@js.set "windowsVerbatimArguments"]

    val cast' : t -> Messaging_options.t [@@js.cast]
  end
  [@@js.scope "ForkOptions"]

  val fork :
    module_path:string -> ?options:Fork_options.t -> unit -> Child_process.t
    [@@js.global "fork"]

  val fork :
       module_path:string
    -> ?args:string list
    -> ?options:Fork_options.t
    -> unit
    -> Child_process.t
    [@@js.global "fork"]

  module Spawn_sync_options : sig
    include module type of struct
      include Common_spawn_options
    end

    val get_input : t -> Array_buffer_view.t or_string [@@js.get "input"]

    val set_input : t -> Array_buffer_view.t or_string -> unit
      [@@js.set "input"]

    val get_kill_signal : t -> Node_process.Process.Signals.t or_number
      [@@js.get "killSignal"]

    val set_kill_signal : t -> Node_process.Process.Signals.t or_number -> unit
      [@@js.set "killSignal"]

    val get_max_buffer : t -> int [@@js.get "maxBuffer"]

    val set_max_buffer : t -> int -> unit [@@js.set "maxBuffer"]

    val get_encoding :
         t
      -> (Buffer_encoding.t, ([ `buffer [@js "buffer"] ][@js.enum])) or_enum
         or_null
      [@@js.get "encoding"]

    val set_encoding :
      t -> (Buffer_encoding.t, ([ `buffer ][@js.enum])) or_enum or_null -> unit
      [@@js.set "encoding"]
  end
  [@@js.scope "SpawnSyncOptions"]

  module Spawn_sync_options_with_string_encoding : sig
    include module type of struct
      include Spawn_sync_options
    end

    val get_encoding : t -> Buffer_encoding.t [@@js.get "encoding"]

    val set_encoding : t -> Buffer_encoding.t -> unit [@@js.set "encoding"]
  end
  [@@js.scope "SpawnSyncOptionsWithStringEncoding"]

  module Spawn_sync_options_with_buffer_encoding : sig
    include module type of struct
      include Spawn_sync_options
    end

    val get_encoding : t -> ([ `buffer [@js "buffer"] ][@js.enum]) or_null
      [@@js.get "encoding"]

    val set_encoding : t -> ([ `buffer ][@js.enum]) or_null -> unit
      [@@js.set "encoding"]
  end
  [@@js.scope "SpawnSyncOptionsWithBufferEncoding"]

  module Spawn_sync_returns : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val get_pid : 'T t -> int [@@js.get "pid"]

    val set_pid : 'T t -> int -> unit [@@js.set "pid"]

    val get_output : 'T t -> string list [@@js.get "output"]

    val set_output : 'T t -> string list -> unit [@@js.set "output"]

    val get_stdout : 'T t -> 'T [@@js.get "stdout"]

    val set_stdout : 'T t -> 'T -> unit [@@js.set "stdout"]

    val get_stderr : 'T t -> 'T [@@js.get "stderr"]

    val set_stderr : 'T t -> 'T -> unit [@@js.set "stderr"]

    val get_status : 'T t -> int or_null [@@js.get "status"]

    val set_status : 'T t -> int or_null -> unit [@@js.set "status"]

    val get_signal : 'T t -> Node_process.Process.Signals.t or_null
      [@@js.get "signal"]

    val set_signal : 'T t -> Node_process.Process.Signals.t or_null -> unit
      [@@js.set "signal"]

    val get_error : 'T t -> Error.t [@@js.get "error"]

    val set_error : 'T t -> Error.t -> unit [@@js.set "error"]
  end
  [@@js.scope "SpawnSyncReturns"]

  val spawn_sync :
       string
    -> ?args:string list
    -> ?options:Spawn_sync_options.t
    -> unit
    -> Buffer.t Spawn_sync_returns.t
    [@@js.global "spawnSync"]

  module Exec_sync_options : sig
    include module type of struct
      include Common_options
    end

    val get_input : t -> Uint8_array.t or_string [@@js.get "input"]

    val set_input : t -> Uint8_array.t or_string -> unit [@@js.set "input"]

    val get_stdio : t -> Stdio_options.t [@@js.get "stdio"]

    val set_stdio : t -> Stdio_options.t -> unit [@@js.set "stdio"]

    val get_shell : t -> string [@@js.get "shell"]

    val set_shell : t -> string -> unit [@@js.set "shell"]

    val get_kill_signal : t -> Node_process.Process.Signals.t or_number
      [@@js.get "killSignal"]

    val set_kill_signal : t -> Node_process.Process.Signals.t or_number -> unit
      [@@js.set "killSignal"]

    val get_max_buffer : t -> int [@@js.get "maxBuffer"]

    val set_max_buffer : t -> int -> unit [@@js.set "maxBuffer"]

    val get_encoding :
         t
      -> (Buffer_encoding.t, ([ `buffer [@js "buffer"] ][@js.enum])) or_enum
         or_null
      [@@js.get "encoding"]

    val set_encoding :
      t -> (Buffer_encoding.t, ([ `buffer ][@js.enum])) or_enum or_null -> unit
      [@@js.set "encoding"]
  end
  [@@js.scope "ExecSyncOptions"]

  module Exec_sync_options_with_string_encoding : sig
    include module type of struct
      include Exec_sync_options
    end

    val get_encoding : t -> Buffer_encoding.t [@@js.get "encoding"]

    val set_encoding : t -> Buffer_encoding.t -> unit [@@js.set "encoding"]
  end
  [@@js.scope "ExecSyncOptionsWithStringEncoding"]

  module Exec_sync_options_with_buffer_encoding : sig
    include module type of struct
      include Exec_sync_options
    end

    val get_encoding : t -> ([ `buffer [@js "buffer"] ][@js.enum]) or_null
      [@@js.get "encoding"]

    val set_encoding : t -> ([ `buffer ][@js.enum]) or_null -> unit
      [@@js.set "encoding"]
  end
  [@@js.scope "ExecSyncOptionsWithBufferEncoding"]

  val exec_sync : string -> ?options:Exec_sync_options.t -> unit -> Buffer.t
    [@@js.global "execSync"]

  module Exec_file_sync_options : sig
    include module type of struct
      include Common_options
    end

    val get_input : t -> Array_buffer_view.t or_string [@@js.get "input"]

    val set_input : t -> Array_buffer_view.t or_string -> unit
      [@@js.set "input"]

    val get_stdio : t -> Stdio_options.t [@@js.get "stdio"]

    val set_stdio : t -> Stdio_options.t -> unit [@@js.set "stdio"]

    val get_kill_signal : t -> Node_process.Process.Signals.t or_number
      [@@js.get "killSignal"]

    val set_kill_signal : t -> Node_process.Process.Signals.t or_number -> unit
      [@@js.set "killSignal"]

    val get_max_buffer : t -> int [@@js.get "maxBuffer"]

    val set_max_buffer : t -> int -> unit [@@js.set "maxBuffer"]

    val get_encoding : t -> Buffer_encoding.t [@@js.get "encoding"]

    val set_encoding : t -> Buffer_encoding.t -> unit [@@js.set "encoding"]

    val get_shell : t -> bool or_string [@@js.get "shell"]

    val set_shell : t -> bool or_string -> unit [@@js.set "shell"]
  end
  [@@js.scope "ExecFileSyncOptions"]

  module Exec_file_sync_options_with_string_encoding : sig
    include module type of struct
      include Exec_file_sync_options
    end

    val get_encoding : t -> Buffer_encoding.t [@@js.get "encoding"]

    val set_encoding : t -> Buffer_encoding.t -> unit [@@js.set "encoding"]
  end
  [@@js.scope "ExecFileSyncOptionsWithStringEncoding"]

  module Exec_file_sync_options_with_buffer_encoding : sig
    include module type of struct
      include Exec_file_sync_options
    end

    val get_encoding : t -> Buffer_encoding.t [@@js.get "encoding"]

    val set_encoding : t -> Buffer_encoding.t -> unit [@@js.set "encoding"]
  end
  [@@js.scope "ExecFileSyncOptionsWithBufferEncoding"]

  val exec_file_sync :
       string
    -> ?args:string list
    -> ?options:Exec_file_sync_options.t
    -> unit
    -> Buffer.t
    [@@js.global "execFileSync"]
end
[@@js.scope Import.child_process]
