[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t
end

module Net : sig
  open Node_stream
  open Node_dns

  module Lookup_function : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val apply :
         t
      -> hostname:string
      -> options:Dns.Lookup_one_options.t
      -> callback:
           (   err:Errno_exception.t or_null
            -> address:string
            -> family:int
            -> unit)
      -> unit
      [@@js.apply]
  end
  [@@js.scope "LookupFunction"]

  module Address_info : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_address : t -> string [@@js.get "address"]

    val set_address : t -> string -> unit [@@js.set "address"]

    val get_family : t -> string [@@js.get "family"]

    val set_family : t -> string -> unit [@@js.set "family"]

    val get_port : t -> int [@@js.get "port"]

    val set_port : t -> int -> unit [@@js.set "port"]
  end
  [@@js.scope "AddressInfo"]

  module Socket_constructor_opts : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_fd : t -> int [@@js.get "fd"]

    val set_fd : t -> int -> unit [@@js.set "fd"]

    val get_allow_half_open : t -> bool [@@js.get "allowHalfOpen"]

    val set_allow_half_open : t -> bool -> unit [@@js.set "allowHalfOpen"]

    val get_readable : t -> bool [@@js.get "readable"]

    val set_readable : t -> bool -> unit [@@js.set "readable"]

    val get_writable : t -> bool [@@js.get "writable"]

    val set_writable : t -> bool -> unit [@@js.set "writable"]
  end
  [@@js.scope "SocketConstructorOpts"]

  module On_read_opts : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_buffer : t -> (Uint8_array.t, unit -> Uint8_array.t) union2
      [@@js.get "buffer"]

    val set_buffer : t -> (Uint8_array.t, unit -> Uint8_array.t) union2 -> unit
      [@@js.set "buffer"]

    val callback : t -> bytes_written:int -> buf:Uint8_array.t -> bool
      [@@js.call "callback"]
  end
  [@@js.scope "OnReadOpts"]

  module Connect_opts : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_onread : t -> On_read_opts.t [@@js.get "onread"]

    val set_onread : t -> On_read_opts.t -> unit [@@js.set "onread"]
  end
  [@@js.scope "ConnectOpts"]

  module Tcp_socket_connect_opts : sig
    include module type of struct
      include Connect_opts
    end

    val get_port : t -> int [@@js.get "port"]

    val set_port : t -> int -> unit [@@js.set "port"]

    val get_host : t -> string [@@js.get "host"]

    val set_host : t -> string -> unit [@@js.set "host"]

    val get_local_address : t -> string [@@js.get "localAddress"]

    val set_local_address : t -> string -> unit [@@js.set "localAddress"]

    val get_local_port : t -> int [@@js.get "localPort"]

    val set_local_port : t -> int -> unit [@@js.set "localPort"]

    val get_hints : t -> int [@@js.get "hints"]

    val set_hints : t -> int -> unit [@@js.set "hints"]

    val get_family : t -> int [@@js.get "family"]

    val set_family : t -> int -> unit [@@js.set "family"]

    val get_lookup : t -> Lookup_function.t [@@js.get "lookup"]

    val set_lookup : t -> Lookup_function.t -> unit [@@js.set "lookup"]
  end
  [@@js.scope "TcpSocketConnectOpts"]

  module Ipc_socket_connect_opts : sig
    include module type of struct
      include Connect_opts
    end

    val get_path : t -> string [@@js.get "path"]

    val set_path : t -> string -> unit [@@js.set "path"]
  end
  [@@js.scope "IpcSocketConnectOpts"]

  module Socket_connect_opts : sig
    type t = (Ipc_socket_connect_opts.t, Tcp_socket_connect_opts.t) union2

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Socket : sig
    include module type of struct
      include Stream.Duplex
    end

    val create : ?options:Socket_constructor_opts.t -> unit -> t [@@js.create]

    val write :
         t
      -> buffer:Uint8_array.t or_string
      -> ?cb:(?err:Error.t -> unit -> unit)
      -> unit
      -> bool
      [@@js.call "write"]

    val write' :
         t
      -> str:Uint8_array.t or_string
      -> ?encoding:Buffer_encoding.t
      -> ?cb:(?err:Error.t -> unit -> unit)
      -> unit
      -> bool
      [@@js.call "write"]

    val connect :
         t
      -> options:Socket_connect_opts.t
      -> ?connection_listener:(unit -> unit)
      -> unit
      -> t
      [@@js.call "connect"]

    val connect' :
         t
      -> port:int
      -> host:string
      -> ?connection_listener:(unit -> unit)
      -> unit
      -> t
      [@@js.call "connect"]

    val connect'' :
      t -> port:int -> ?connection_listener:(unit -> unit) -> unit -> t
      [@@js.call "connect"]

    val connect''' :
      t -> path:string -> ?connection_listener:(unit -> unit) -> unit -> t
      [@@js.call "connect"]

    val set_encoding : t -> ?encoding:Buffer_encoding.t -> unit -> t
      [@@js.call "setEncoding"]

    val pause : t -> t [@@js.call "pause"]

    val resume : t -> t [@@js.call "resume"]

    val set_timeout : t -> timeout:int -> ?callback:(unit -> unit) -> unit -> t
      [@@js.call "setTimeout"]

    val set_no_delay : t -> ?no_delay:bool -> unit -> t [@@js.call "setNoDelay"]

    val set_keep_alive : t -> ?enable:bool -> ?initial_delay:int -> unit -> t
      [@@js.call "setKeepAlive"]

    val address : t -> (Address_info.t, Anonymous_interface0.t) union2
      [@@js.call "address"]

    val unref : t -> t [@@js.call "unref"]

    val ref : t -> t [@@js.call "ref"]

    val get_buffer_size : t -> int [@@js.get "bufferSize"]

    val get_bytes_read : t -> int [@@js.get "bytesRead"]

    val get_bytes_written : t -> int [@@js.get "bytesWritten"]

    val get_connecting : t -> bool [@@js.get "connecting"]

    val get_destroyed : t -> bool [@@js.get "destroyed"]

    val get_local_address : t -> string [@@js.get "localAddress"]

    val get_local_port : t -> int [@@js.get "localPort"]

    val get_remote_address : t -> string [@@js.get "remoteAddress"]

    val get_remote_family : t -> string [@@js.get "remoteFamily"]

    val get_remote_port : t -> int [@@js.get "remotePort"]

    val end_ : t -> ?cb:(unit -> unit) -> unit -> unit [@@js.call "end"]

    val end_' :
      t -> buffer:Uint8_array.t or_string -> ?cb:(unit -> unit) -> unit -> unit
      [@@js.call "end"]

    val end_'' :
         t
      -> str:Uint8_array.t or_string
      -> ?encoding:Buffer_encoding.t
      -> ?cb:(unit -> unit)
      -> unit
      -> unit
      [@@js.call "end"]

    val add_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "addListener"]

    val add_listener' :
         t
      -> event:([ `close ][@js.enum])
      -> listener:(had_error:bool -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'' :
      t -> event:([ `connect ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener''' :
      t -> event:([ `data ][@js.enum]) -> listener:(data:Buffer.t -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''' :
      t -> event:([ `drain ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener''''' :
      t -> event:([ `end_ ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''''' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "addListener"]

    val add_listener''''''' :
         t
      -> event:([ `lookup ][@js.enum])
      -> listener:
           (   err:Error.t
            -> address:string
            -> family:string or_number
            -> host:string
            -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'''''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val emit :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val emit' : t -> event:([ `close ][@js.enum]) -> had_error:bool -> bool
      [@@js.call "emit"]

    val emit'' : t -> event:([ `connect ][@js.enum]) -> bool [@@js.call "emit"]

    val emit''' : t -> event:([ `data ][@js.enum]) -> data:Buffer.t -> bool
      [@@js.call "emit"]

    val emit'''' : t -> event:([ `drain ][@js.enum]) -> bool [@@js.call "emit"]

    val emit''''' : t -> event:([ `end_ ][@js.enum]) -> bool [@@js.call "emit"]

    val emit'''''' : t -> event:([ `error ][@js.enum]) -> err:Error.t -> bool
      [@@js.call "emit"]

    val emit''''''' :
         t
      -> event:([ `lookup ][@js.enum])
      -> err:Error.t
      -> address:string
      -> family:string or_number
      -> host:string
      -> bool
      [@@js.call "emit"]

    val emit'''''''' : t -> event:([ `timeout ][@js.enum]) -> bool
      [@@js.call "emit"]

    module Close_listener : sig
      type t = had_error:bool -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Connect_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Data_listener : sig
      type t = data:Buffer.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Drain_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module End_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Error_listener : sig
      type t = err:Error.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Lookup_listener : sig
      type t =
           err:Error.t
        -> address:string
        -> family:string or_number
        -> host:string
        -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Timeout_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    type listener =
      ([ `Close of Close_listener.t
       | `Connect of Connect_listener.t
       | `Data of Data_listener.t
       | `Drain of Drain_listener.t
       | `End_ of End_listener.t
       | `Error of Error_listener.t
       | `Lookup of Lookup_listener.t
       | `Timeout of Timeout_listener.t
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
      | `Close f -> fn t "close" @@ [%js.of: Close_listener.t] f
      | `Connect f -> fn t "connect" @@ [%js.of: Connect_listener.t] f
      | `Data f -> fn t "data" @@ [%js.of: Data_listener.t] f
      | `Drain f -> fn t "drain" @@ [%js.of: Drain_listener.t] f
      | `End_ f -> fn t "end_" @@ [%js.of: End_listener.t] f
      | `Error f -> fn t "error" @@ [%js.of: Error_listener.t] f
      | `Lookup f -> fn t "lookup" @@ [%js.of: Lookup_listener.t] f
      | `Timeout f -> fn t "timeout" @@ [%js.of: Timeout_listener.t] f

    let on = with_listener_fn on

    let add_listener = with_listener_fn add_listener

    let once = with_listener_fn once

    let prepend_listener = with_listener_fn prepend_listener

    let prepend_once_listener = with_listener_fn prepend_once_listener]

    val on :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "on"]
  end
  [@@js.scope "Socket"]

  module Listen_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_port : t -> int [@@js.get "port"]

    val set_port : t -> int -> unit [@@js.set "port"]

    val get_host : t -> string [@@js.get "host"]

    val set_host : t -> string -> unit [@@js.set "host"]

    val get_backlog : t -> int [@@js.get "backlog"]

    val set_backlog : t -> int -> unit [@@js.set "backlog"]

    val get_path : t -> string [@@js.get "path"]

    val set_path : t -> string -> unit [@@js.set "path"]

    val get_exclusive : t -> bool [@@js.get "exclusive"]

    val set_exclusive : t -> bool -> unit [@@js.set "exclusive"]

    val get_readable_all : t -> bool [@@js.get "readableAll"]

    val set_readable_all : t -> bool -> unit [@@js.set "readableAll"]

    val get_writable_all : t -> bool [@@js.get "writableAll"]

    val set_writable_all : t -> bool -> unit [@@js.set "writableAll"]

    val get_ipv6Only : t -> bool [@@js.get "ipv6Only"]

    val set_ipv6Only : t -> bool -> unit [@@js.set "ipv6Only"]
  end
  [@@js.scope "ListenOptions"]

  module Server_opts : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_allow_half_open : t -> bool [@@js.get "allowHalfOpen"]

    val set_allow_half_open : t -> bool -> unit [@@js.set "allowHalfOpen"]

    val get_pause_on_connect : t -> bool [@@js.get "pauseOnConnect"]

    val set_pause_on_connect : t -> bool -> unit [@@js.set "pauseOnConnect"]
  end
  [@@js.scope "ServerOpts"]

  module Server : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create : ?connection_listener:(socket:Socket.t -> unit) -> unit -> t
      [@@js.create]

    val create' :
         ?options:Server_opts.t
      -> ?connection_listener:(socket:Socket.t -> unit)
      -> unit
      -> t
      [@@js.create]

    val listen :
         t
      -> ?port:int
      -> ?hostname:string
      -> ?backlog:int
      -> ?listening_listener:(unit -> unit)
      -> unit
      -> t
      [@@js.call "listen"]

    val listen' :
         t
      -> ?port:int
      -> ?hostname:string
      -> ?listening_listener:(unit -> unit)
      -> unit
      -> t
      [@@js.call "listen"]

    val listen'' :
         t
      -> ?port:int
      -> ?backlog:int
      -> ?listening_listener:(unit -> unit)
      -> unit
      -> t
      [@@js.call "listen"]

    val listen''' :
      t -> ?port:int -> ?listening_listener:(unit -> unit) -> unit -> t
      [@@js.call "listen"]

    val listen'''' :
         t
      -> path:string
      -> ?backlog:int
      -> ?listening_listener:(unit -> unit)
      -> unit
      -> t
      [@@js.call "listen"]

    val listen''''' :
      t -> path:string -> ?listening_listener:(unit -> unit) -> unit -> t
      [@@js.call "listen"]

    val listen'''''' :
         t
      -> options:Listen_options.t
      -> ?listening_listener:(unit -> unit)
      -> unit
      -> t
      [@@js.call "listen"]

    val listen''''''' :
         t
      -> handle:any
      -> ?backlog:int
      -> ?listening_listener:(unit -> unit)
      -> unit
      -> t
      [@@js.call "listen"]

    val listen'''''''' :
      t -> handle:any -> ?listening_listener:(unit -> unit) -> unit -> t
      [@@js.call "listen"]

    val close : t -> ?callback:(?err:Error.t -> unit -> unit) -> unit -> t
      [@@js.call "close"]

    val address : t -> Address_info.t or_string or_null [@@js.call "address"]

    val get_connections :
      t -> cb:(error:Error.t or_null -> count:int -> unit) -> unit
      [@@js.call "getConnections"]

    val ref : t -> t [@@js.call "ref"]

    val unref : t -> t [@@js.call "unref"]

    val get_max_connections : t -> int [@@js.get "maxConnections"]

    val set_max_connections : t -> int -> unit [@@js.set "maxConnections"]

    val get_connections : t -> int [@@js.get "connections"]

    val set_connections : t -> int -> unit [@@js.set "connections"]

    val get_listening : t -> bool [@@js.get "listening"]

    val set_listening : t -> bool -> unit [@@js.set "listening"]

    val add_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "addListener"]

    val add_listener' :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'' :
         t
      -> event:([ `connection ][@js.enum])
      -> listener:(socket:Socket.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''' :
      t -> event:([ `listening ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val emit :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val emit' : t -> event:([ `close ][@js.enum]) -> bool [@@js.call "emit"]

    val emit'' :
      t -> event:([ `connection ][@js.enum]) -> socket:Socket.t -> bool
      [@@js.call "emit"]

    val emit''' : t -> event:([ `error ][@js.enum]) -> err:Error.t -> bool
      [@@js.call "emit"]

    val emit'''' : t -> event:([ `listening ][@js.enum]) -> bool
      [@@js.call "emit"]

    val on :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "on"]

    val on' : t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on'' :
         t
      -> event:([ `connection ][@js.enum])
      -> listener:(socket:Socket.t -> unit)
      -> t
      [@@js.call "on"]

    val on''' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "on"]

    val on'''' :
      t -> event:([ `listening ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val once :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "once"]

    val once' :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once'' :
         t
      -> event:([ `connection ][@js.enum])
      -> listener:(socket:Socket.t -> unit)
      -> t
      [@@js.call "once"]

    val once''' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "once"]

    val once'''' :
      t -> event:([ `listening ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val prepend_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener' :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'' :
         t
      -> event:([ `connection ][@js.enum])
      -> listener:(socket:Socket.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener''' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'''' :
      t -> event:([ `listening ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_once_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener' :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'' :
         t
      -> event:([ `connection ][@js.enum])
      -> listener:(socket:Socket.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''' :
      t -> event:([ `listening ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]
  end
  [@@js.scope "Server"]

  module Tcp_net_connect_opts : sig
    include module type of struct
      include Tcp_socket_connect_opts
    end

    val get_timeout : t -> int [@@js.get "timeout"]

    val set_timeout : t -> int -> unit [@@js.set "timeout"]

    val cast' : t -> Socket_constructor_opts.t [@@js.cast]
  end
  [@@js.scope "TcpNetConnectOpts"]

  module Ipc_net_connect_opts : sig
    include module type of struct
      include Ipc_socket_connect_opts
    end

    val get_timeout : t -> int [@@js.get "timeout"]

    val set_timeout : t -> int -> unit [@@js.set "timeout"]

    val cast' : t -> Socket_constructor_opts.t [@@js.cast]
  end
  [@@js.scope "IpcNetConnectOpts"]

  module Net_connect_opts : sig
    type t = (Ipc_net_connect_opts.t, Tcp_net_connect_opts.t) union2

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  val create_server :
    ?connection_listener:(socket:Socket.t -> unit) -> unit -> Server.t
    [@@js.global "createServer"]

  val create_server :
       ?options:Server_opts.t
    -> ?connection_listener:(socket:Socket.t -> unit)
    -> unit
    -> Server.t
    [@@js.global "createServer"]

  val connect :
       options:Net_connect_opts.t
    -> ?connection_listener:(unit -> unit)
    -> unit
    -> Socket.t
    [@@js.global "connect"]

  val connect :
       port:int
    -> ?host:string
    -> ?connection_listener:(unit -> unit)
    -> unit
    -> Socket.t
    [@@js.global "connect"]

  val connect :
    path:string -> ?connection_listener:(unit -> unit) -> unit -> Socket.t
    [@@js.global "connect"]

  val create_connection :
       options:Net_connect_opts.t
    -> ?connection_listener:(unit -> unit)
    -> unit
    -> Socket.t
    [@@js.global "createConnection"]

  val create_connection :
       port:int
    -> ?host:string
    -> ?connection_listener:(unit -> unit)
    -> unit
    -> Socket.t
    [@@js.global "createConnection"]

  val create_connection :
    path:string -> ?connection_listener:(unit -> unit) -> unit -> Socket.t
    [@@js.global "createConnection"]

  val is_ip : input:string -> int [@@js.global "isIP"]

  val is_i_pv4 : input:string -> bool [@@js.global "isIPv4"]

  val is_i_pv6 : input:string -> bool [@@js.global "isIPv6"]
end
[@@js.scope Import.net]
