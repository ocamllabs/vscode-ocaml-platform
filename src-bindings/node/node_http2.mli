[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t
end

module Anonymous_interface1 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_origin : t -> string [@@js.get "origin"]

  val set_origin : t -> string -> unit [@@js.set "origin"]
end

module Http2 : sig
  open Node_fs
  open Node_fs_promises
  open Node_net
  open Node_stream
  open Node_tls
  open Node_url

  module Incoming_http_status_header : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get__status : t -> int [@@js.get ":status"]

    val set__status : t -> int -> unit [@@js.set ":status"]
  end
  [@@js.scope "IncomingHttpStatusHeader"]

  module Incoming_http_headers : sig
    include module type of struct
      include Node_http.Http.Incoming_http_headers
    end

    val get__path : t -> string [@@js.get ":path"]

    val set__path : t -> string -> unit [@@js.set ":path"]

    val get__method : t -> string [@@js.get ":method"]

    val set__method : t -> string -> unit [@@js.set ":method"]

    val get__authority : t -> string [@@js.get ":authority"]

    val set__authority : t -> string -> unit [@@js.set ":authority"]

    val get__scheme : t -> string [@@js.get ":scheme"]

    val set__scheme : t -> string -> unit [@@js.set ":scheme"]
  end
  [@@js.scope "IncomingHttpHeaders"]

  module Stream_priority_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_exclusive : t -> bool [@@js.get "exclusive"]

    val set_exclusive : t -> bool -> unit [@@js.set "exclusive"]

    val get_parent : t -> int [@@js.get "parent"]

    val set_parent : t -> int -> unit [@@js.set "parent"]

    val get_weight : t -> int [@@js.get "weight"]

    val set_weight : t -> int -> unit [@@js.set "weight"]

    val get_silent : t -> bool [@@js.get "silent"]

    val set_silent : t -> bool -> unit [@@js.set "silent"]
  end
  [@@js.scope "StreamPriorityOptions"]

  module Stream_state : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_local_window_size : t -> int [@@js.get "localWindowSize"]

    val set_local_window_size : t -> int -> unit [@@js.set "localWindowSize"]

    val get_state : t -> int [@@js.get "state"]

    val set_state : t -> int -> unit [@@js.set "state"]

    val get_local_close : t -> int [@@js.get "localClose"]

    val set_local_close : t -> int -> unit [@@js.set "localClose"]

    val get_remote_close : t -> int [@@js.get "remoteClose"]

    val set_remote_close : t -> int -> unit [@@js.set "remoteClose"]

    val get_sum_dependency_weight : t -> int [@@js.get "sumDependencyWeight"]

    val set_sum_dependency_weight : t -> int -> unit
      [@@js.set "sumDependencyWeight"]

    val get_weight : t -> int [@@js.get "weight"]

    val set_weight : t -> int -> unit [@@js.set "weight"]
  end
  [@@js.scope "StreamState"]

  module Server_stream_response_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_end_stream : t -> bool [@@js.get "endStream"]

    val set_end_stream : t -> bool -> unit [@@js.set "endStream"]

    val get_wait_for_trailers : t -> bool [@@js.get "waitForTrailers"]

    val set_wait_for_trailers : t -> bool -> unit [@@js.set "waitForTrailers"]
  end
  [@@js.scope "ServerStreamResponseOptions"]

  module Stat_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_offset : t -> int [@@js.get "offset"]

    val set_offset : t -> int -> unit [@@js.set "offset"]

    val get_length : t -> int [@@js.get "length"]

    val set_length : t -> int -> unit [@@js.set "length"]
  end
  [@@js.scope "StatOptions"]

  module Server_stream_file_response_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val stat_check :
         t
      -> stats:Fs.Stats.t
      -> headers:Node_http.Http.Outgoing_http_headers.t
      -> stat_options:Stat_options.t
      -> unit or_boolean
      [@@js.call "statCheck"]

    val get_wait_for_trailers : t -> bool [@@js.get "waitForTrailers"]

    val set_wait_for_trailers : t -> bool -> unit [@@js.set "waitForTrailers"]

    val get_offset : t -> int [@@js.get "offset"]

    val set_offset : t -> int -> unit [@@js.set "offset"]

    val get_length : t -> int [@@js.get "length"]

    val set_length : t -> int -> unit [@@js.set "length"]
  end
  [@@js.scope "ServerStreamFileResponseOptions"]

  module Server_stream_file_response_options_with_error : sig
    include module type of struct
      include Server_stream_file_response_options
    end

    val on_error : t -> err:Errno_exception.t -> unit [@@js.call "onError"]
  end
  [@@js.scope "ServerStreamFileResponseOptionsWithError"]

  module Http2_stream : sig
    include module type of struct
      include Stream.Duplex
    end

    val get_aborted : t -> bool [@@js.get "aborted"]

    val get_buffer_size : t -> int [@@js.get "bufferSize"]

    val get_closed : t -> bool [@@js.get "closed"]

    val get_destroyed : t -> bool [@@js.get "destroyed"]

    val get_end_after_headers : t -> bool [@@js.get "endAfterHeaders"]

    val get_id : t -> int [@@js.get "id"]

    val get_pending : t -> bool [@@js.get "pending"]

    val get_rst_code : t -> int [@@js.get "rstCode"]

    val get_sent_headers : t -> Node_http.Http.Outgoing_http_headers.t
      [@@js.get "sentHeaders"]

    val get_sent_info_headers : t -> Node_http.Http.Outgoing_http_headers.t list
      [@@js.get "sentInfoHeaders"]

    val get_sent_trailers : t -> Node_http.Http.Outgoing_http_headers.t
      [@@js.get "sentTrailers"]

    (* val get_session : t -> Http2_session.t [@@js.get "session"] *)

    val get_state : t -> Stream_state.t [@@js.get "state"]

    val close : t -> ?code:int -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "close"]

    val priority : t -> options:Stream_priority_options.t -> unit
      [@@js.call "priority"]

    val set_timeout : t -> msecs:int -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "setTimeout"]

    val send_trailers :
      t -> headers:Node_http.Http.Outgoing_http_headers.t -> unit
      [@@js.call "sendTrailers"]

    val add_listener :
      t -> event:([ `aborted ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener' :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'' :
         t
      -> event:([ `data ][@js.enum])
      -> listener:(chunk:Buffer.t or_string -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''' :
      t -> event:([ `drain ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''' :
      t -> event:([ `end_ ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener''''' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''''' :
      t -> event:([ `finish ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener''''''' :
         t
      -> event:([ `frameError ][@js.enum])
      -> listener:(frameType:int -> error_code:int -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'''''''' :
         t
      -> event:([ `pipe ][@js.enum])
      -> listener:(src:Stream.Readable.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''''''''' :
         t
      -> event:([ `unpipe ][@js.enum])
      -> listener:(src:Stream.Readable.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'''''''''' :
         t
      -> event:([ `streamClosed ][@js.enum])
      -> listener:(code:int -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''''''''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''''''''''' :
         t
      -> event:([ `trailers ][@js.enum])
      -> listener:(trailers:Incoming_http_headers.t -> flags:int -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''''''''''''' :
      t -> event:([ `wantTrailers ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''''''''''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "addListener"]

    val emit : t -> event:([ `aborted ][@js.enum]) -> bool [@@js.call "emit"]

    val emit' : t -> event:([ `close ][@js.enum]) -> bool [@@js.call "emit"]

    val emit'' :
      t -> event:([ `data ][@js.enum]) -> chunk:Buffer.t or_string -> bool
      [@@js.call "emit"]

    val emit''' : t -> event:([ `drain ][@js.enum]) -> bool [@@js.call "emit"]

    val emit'''' : t -> event:([ `end_ ][@js.enum]) -> bool [@@js.call "emit"]

    val emit''''' : t -> event:([ `error ][@js.enum]) -> err:Error.t -> bool
      [@@js.call "emit"]

    val emit'''''' : t -> event:([ `finish ][@js.enum]) -> bool
      [@@js.call "emit"]

    val emit''''''' :
         t
      -> event:([ `frameError ][@js.enum])
      -> frame_type:int
      -> error_code:int
      -> bool
      [@@js.call "emit"]

    val emit'''''''' :
      t -> event:([ `pipe ][@js.enum]) -> src:Stream.Readable.t -> bool
      [@@js.call "emit"]

    val emit''''''''' :
      t -> event:([ `unpipe ][@js.enum]) -> src:Stream.Readable.t -> bool
      [@@js.call "emit"]

    val emit'''''''''' :
      t -> event:([ `streamClosed ][@js.enum]) -> code:int -> bool
      [@@js.call "emit"]

    val emit''''''''''' : t -> event:([ `timeout ][@js.enum]) -> bool
      [@@js.call "emit"]

    val emit'''''''''''' :
         t
      -> event:([ `trailers ][@js.enum])
      -> trailers:Incoming_http_headers.t
      -> flags:int
      -> bool
      [@@js.call "emit"]

    val emit''''''''''''' : t -> event:([ `wantTrailers ][@js.enum]) -> bool
      [@@js.call "emit"]

    val emit'''''''''''''' :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    module Aborted_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Close_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Data_listener : sig
      type t = chunk:Buffer.t or_string -> unit

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

    module Finish_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Frameerror_listener : sig
      type t = frameType:int -> error_code:int -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Pipe_listener : sig
      type t = src:Stream.Readable.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Unpipe_listener : sig
      type t = src:Stream.Readable.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Streamclosed_listener : sig
      type t = code:int -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Timeout_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Trailers_listener : sig
      type t = trailers:Incoming_http_headers.t -> flags:int -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Wanttrailers_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    type listener =
      ([ `Aborted of Aborted_listener.t
       | `Close of Close_listener.t
       | `Data of Data_listener.t
       | `Drain of Drain_listener.t
       | `End_ of End_listener.t
       | `Error of Error_listener.t
       | `Finish of Finish_listener.t
       | `Frameerror of Frameerror_listener.t
       | `Pipe of Pipe_listener.t
       | `Unpipe of Unpipe_listener.t
       | `Streamclosed of Streamclosed_listener.t
       | `Timeout of Timeout_listener.t
       | `Trailers of Trailers_listener.t
       | `Wanttrailers of Wanttrailers_listener.t
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
      | `Aborted f -> fn t "aborted" @@ [%js.of: Aborted_listener.t] f
      | `Close f -> fn t "close" @@ [%js.of: Close_listener.t] f
      | `Data f -> fn t "data" @@ [%js.of: Data_listener.t] f
      | `Drain f -> fn t "drain" @@ [%js.of: Drain_listener.t] f
      | `End_ f -> fn t "end_" @@ [%js.of: End_listener.t] f
      | `Error f -> fn t "error" @@ [%js.of: Error_listener.t] f
      | `Finish f -> fn t "finish" @@ [%js.of: Finish_listener.t] f
      | `Frameerror f -> fn t "frameError" @@ [%js.of: Frameerror_listener.t] f
      | `Pipe f -> fn t "pipe" @@ [%js.of: Pipe_listener.t] f
      | `Unpipe f -> fn t "unpipe" @@ [%js.of: Unpipe_listener.t] f
      | `Streamclosed f ->
        fn t "streamClosed" @@ [%js.of: Streamclosed_listener.t] f
      | `Timeout f -> fn t "timeout" @@ [%js.of: Timeout_listener.t] f
      | `Trailers f -> fn t "trailers" @@ [%js.of: Trailers_listener.t] f
      | `Wanttrailers f ->
        fn t "wantTrailers" @@ [%js.of: Wanttrailers_listener.t] f

    let on = with_listener_fn on

    let add_listener = with_listener_fn add_listener

    let once = with_listener_fn once

    let prepend_listener = with_listener_fn prepend_listener

    let prepend_once_listener = with_listener_fn prepend_once_listener]
  end
  [@@js.scope "Http2Stream"]

  module Client_http2_stream : sig
    include module type of struct
      include Http2_stream
    end

    val add_listener :
         t
      -> event:([ `continue ][@js.enum])
      -> listener:(unit -> Anonymous_interface0.t)
      -> t
      [@@js.call "addListener"]

    val add_listener' :
         t
      -> event:([ `headers ][@js.enum])
      -> listener:
           (   headers:
                 ( Incoming_http_headers.t
                 , Incoming_http_status_header.t )
                 intersection2
            -> flags:int
            -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'' :
         t
      -> event:([ `push ][@js.enum])
      -> listener:(headers:Incoming_http_headers.t -> flags:int -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''' :
         t
      -> event:([ `response ][@js.enum])
      -> listener:
           (   headers:
                 ( Incoming_http_headers.t
                 , Incoming_http_status_header.t )
                 intersection2
            -> flags:int
            -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "addListener"]

    val emit : t -> event:([ `continue ][@js.enum]) -> bool [@@js.call "emit"]

    val emit' :
         t
      -> event:([ `headers ][@js.enum])
      -> headers:
           ( Incoming_http_headers.t
           , Incoming_http_status_header.t )
           intersection2
      -> flags:int
      -> bool
      [@@js.call "emit"]

    val emit'' :
         t
      -> event:([ `push ][@js.enum])
      -> headers:Incoming_http_headers.t
      -> flags:int
      -> bool
      [@@js.call "emit"]

    val emit''' :
         t
      -> event:([ `response ][@js.enum])
      -> headers:
           ( Incoming_http_headers.t
           , Incoming_http_status_header.t )
           intersection2
      -> flags:int
      -> bool
      [@@js.call "emit"]

    val emit'''' :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    module Continue_listener : sig
      type t = unit -> Anonymous_interface0.t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Headers_listener : sig
      type t =
           headers:
             ( Incoming_http_headers.t
             , Incoming_http_status_header.t )
             intersection2
        -> flags:int
        -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Push_listener : sig
      type t = headers:Incoming_http_headers.t -> flags:int -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Response_listener : sig
      type t =
           headers:
             ( Incoming_http_headers.t
             , Incoming_http_status_header.t )
             intersection2
        -> flags:int
        -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    type listener =
      ([ `Continue of Continue_listener.t
       | `Headers of Headers_listener.t
       | `Push of Push_listener.t
       | `Response of Response_listener.t
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
      | `Continue f -> fn t "continue" @@ [%js.of: Continue_listener.t] f
      | `Headers f -> fn t "headers" @@ [%js.of: Headers_listener.t] f
      | `Push f -> fn t "push" @@ [%js.of: Push_listener.t] f
      | `Response f -> fn t "response" @@ [%js.of: Response_listener.t] f

    let on = with_listener_fn on

    let add_listener = with_listener_fn add_listener

    let once = with_listener_fn once

    let prepend_listener = with_listener_fn prepend_listener

    let prepend_once_listener = with_listener_fn prepend_once_listener]
  end
  [@@js.scope "ClientHttp2Stream"]

  module Server_http2_stream : sig
    include module type of struct
      include Http2_stream
    end

    val get_headers_sent : t -> bool [@@js.get "headersSent"]

    val get_push_allowed : t -> bool [@@js.get "pushAllowed"]

    val additional_headers :
      t -> headers:Node_http.Http.Outgoing_http_headers.t -> unit
      [@@js.call "additionalHeaders"]

    val push_stream :
         t
      -> headers:Node_http.Http.Outgoing_http_headers.t
      -> ?callback:
           (   err:Error.t or_null
            -> push_stream:t
            -> headers:Node_http.Http.Outgoing_http_headers.t
            -> unit)
      -> unit
      -> unit
      [@@js.call "pushStream"]

    val push_stream' :
         t
      -> headers:Node_http.Http.Outgoing_http_headers.t
      -> ?options:Stream_priority_options.t
      -> ?callback:
           (   err:Error.t or_null
            -> push_stream:t
            -> headers:Node_http.Http.Outgoing_http_headers.t
            -> unit)
      -> unit
      -> unit
      [@@js.call "pushStream"]

    val respond :
         t
      -> ?headers:Node_http.Http.Outgoing_http_headers.t
      -> ?options:Server_stream_response_options.t
      -> unit
      -> unit
      [@@js.call "respond"]

    val respond_with_fd :
         t
      -> fd:Fs_promises.File_handle.t or_number
      -> ?headers:Node_http.Http.Outgoing_http_headers.t
      -> ?options:Server_stream_file_response_options.t
      -> unit
      -> unit
      [@@js.call "respondWithFD"]

    val respond_with_file :
         t
      -> path:string
      -> ?headers:Node_http.Http.Outgoing_http_headers.t
      -> ?options:Server_stream_file_response_options_with_error.t
      -> unit
      -> unit
      [@@js.call "respondWithFile"]
  end
  [@@js.scope "ServerHttp2Stream"]

  module Settings : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_header_table_size : t -> int [@@js.get "headerTableSize"]

    val set_header_table_size : t -> int -> unit [@@js.set "headerTableSize"]

    val get_enable_push : t -> bool [@@js.get "enablePush"]

    val set_enable_push : t -> bool -> unit [@@js.set "enablePush"]

    val get_initial_window_size : t -> int [@@js.get "initialWindowSize"]

    val set_initial_window_size : t -> int -> unit
      [@@js.set "initialWindowSize"]

    val get_max_frame_size : t -> int [@@js.get "maxFrameSize"]

    val set_max_frame_size : t -> int -> unit [@@js.set "maxFrameSize"]

    val get_max_concurrent_streams : t -> int [@@js.get "maxConcurrentStreams"]

    val set_max_concurrent_streams : t -> int -> unit
      [@@js.set "maxConcurrentStreams"]

    val get_max_header_list_size : t -> int [@@js.get "maxHeaderListSize"]

    val set_max_header_list_size : t -> int -> unit
      [@@js.set "maxHeaderListSize"]

    val get_enable_connect_protocol : t -> bool
      [@@js.get "enableConnectProtocol"]

    val set_enable_connect_protocol : t -> bool -> unit
      [@@js.set "enableConnectProtocol"]
  end
  [@@js.scope "Settings"]

  module Client_session_request_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_end_stream : t -> bool [@@js.get "endStream"]

    val set_end_stream : t -> bool -> unit [@@js.set "endStream"]

    val get_exclusive : t -> bool [@@js.get "exclusive"]

    val set_exclusive : t -> bool -> unit [@@js.set "exclusive"]

    val get_parent : t -> int [@@js.get "parent"]

    val set_parent : t -> int -> unit [@@js.set "parent"]

    val get_weight : t -> int [@@js.get "weight"]

    val set_weight : t -> int -> unit [@@js.set "weight"]

    val get_wait_for_trailers : t -> bool [@@js.get "waitForTrailers"]

    val set_wait_for_trailers : t -> bool -> unit [@@js.set "waitForTrailers"]
  end
  [@@js.scope "ClientSessionRequestOptions"]

  module Session_state : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_effective_local_window_size : t -> int
      [@@js.get "effectiveLocalWindowSize"]

    val set_effective_local_window_size : t -> int -> unit
      [@@js.set "effectiveLocalWindowSize"]

    val get_effective_recv_data_length : t -> int
      [@@js.get "effectiveRecvDataLength"]

    val set_effective_recv_data_length : t -> int -> unit
      [@@js.set "effectiveRecvDataLength"]

    val get_next_stream_id : t -> int [@@js.get "nextStreamID"]

    val set_next_stream_id : t -> int -> unit [@@js.set "nextStreamID"]

    val get_local_window_size : t -> int [@@js.get "localWindowSize"]

    val set_local_window_size : t -> int -> unit [@@js.set "localWindowSize"]

    val get_last_proc_stream_id : t -> int [@@js.get "lastProcStreamID"]

    val set_last_proc_stream_id : t -> int -> unit [@@js.set "lastProcStreamID"]

    val get_remote_window_size : t -> int [@@js.get "remoteWindowSize"]

    val set_remote_window_size : t -> int -> unit [@@js.set "remoteWindowSize"]

    val get_outbound_queue_size : t -> int [@@js.get "outboundQueueSize"]

    val set_outbound_queue_size : t -> int -> unit
      [@@js.set "outboundQueueSize"]

    val get_deflate_dynamic_table_size : t -> int
      [@@js.get "deflateDynamicTableSize"]

    val set_deflate_dynamic_table_size : t -> int -> unit
      [@@js.set "deflateDynamicTableSize"]

    val get_inflate_dynamic_table_size : t -> int
      [@@js.get "inflateDynamicTableSize"]

    val set_inflate_dynamic_table_size : t -> int -> unit
      [@@js.set "inflateDynamicTableSize"]
  end
  [@@js.scope "SessionState"]

  module Http2_session : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_alpn_protocol : t -> string [@@js.get "alpnProtocol"]

    val get_closed : t -> bool [@@js.get "closed"]

    val get_connecting : t -> bool [@@js.get "connecting"]

    val get_destroyed : t -> bool [@@js.get "destroyed"]

    val get_encrypted : t -> bool [@@js.get "encrypted"]

    val get_local_settings : t -> Settings.t [@@js.get "localSettings"]

    val get_origin_set : t -> string list [@@js.get "originSet"]

    val get_pending_settings_ack : t -> bool [@@js.get "pendingSettingsAck"]

    val get_remote_settings : t -> Settings.t [@@js.get "remoteSettings"]

    val get_socket : t -> (Net.Socket.t, Tls.Tls_socket.t) union2
      [@@js.get "socket"]

    val get_state : t -> Session_state.t [@@js.get "state"]

    val get_type : t -> int [@@js.get "type"]

    val close : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "close"]

    val destroy : t -> ?error:Error.t -> ?code:int -> unit -> unit
      [@@js.call "destroy"]

    val goaway :
         t
      -> ?code:int
      -> ?last_stream_id:int
      -> ?opaque_data:Array_buffer_view.t
      -> unit
      -> unit
      [@@js.call "goaway"]

    val ping :
         t
      -> callback:
           (err:Error.t or_null -> duration:int -> payload:Buffer.t -> unit)
      -> bool
      [@@js.call "ping"]

    val ping' :
         t
      -> payload:Array_buffer_view.t
      -> callback:
           (err:Error.t or_null -> duration:int -> payload:Buffer.t -> unit)
      -> bool
      [@@js.call "ping"]

    val ref : t -> unit [@@js.call "ref"]

    val set_local_window_size : t -> window_size:int -> unit
      [@@js.call "setLocalWindowSize"]

    val set_timeout : t -> msecs:int -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "setTimeout"]

    val settings : t -> settings:Settings.t -> unit [@@js.call "settings"]

    val unref : t -> unit [@@js.call "unref"]

    val add_listener :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'' :
         t
      -> event:([ `frameError ][@js.enum])
      -> listener:(frameType:int -> error_code:int -> stream_id:int -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''' :
         t
      -> event:([ `goaway ][@js.enum])
      -> listener:
           (errorCode:int -> last_stream_id:int -> opaque_data:Buffer.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'''' :
         t
      -> event:([ `localSettings ][@js.enum])
      -> listener:(settings:Settings.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''''' :
      t -> event:([ `ping ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''''' :
         t
      -> event:([ `remoteSettings ][@js.enum])
      -> listener:(settings:Settings.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "addListener"]

    val emit : t -> event:([ `close ][@js.enum]) -> bool [@@js.call "emit"]

    val emit' : t -> event:([ `error ][@js.enum]) -> err:Error.t -> bool
      [@@js.call "emit"]

    val emit'' :
         t
      -> event:([ `frameError ][@js.enum])
      -> frame_type:int
      -> error_code:int
      -> stream_id:int
      -> bool
      [@@js.call "emit"]

    val emit''' :
         t
      -> event:([ `goaway ][@js.enum])
      -> error_code:int
      -> last_stream_id:int
      -> opaque_data:Buffer.t
      -> bool
      [@@js.call "emit"]

    val emit'''' :
      t -> event:([ `localSettings ][@js.enum]) -> settings:Settings.t -> bool
      [@@js.call "emit"]

    val emit''''' : t -> event:([ `ping ][@js.enum]) -> bool [@@js.call "emit"]

    val emit'''''' :
      t -> event:([ `remoteSettings ][@js.enum]) -> settings:Settings.t -> bool
      [@@js.call "emit"]

    val emit''''''' : t -> event:([ `timeout ][@js.enum]) -> bool
      [@@js.call "emit"]

    val emit'''''''' :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val on : t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "on"]

    val on'' :
         t
      -> event:([ `frameError ][@js.enum])
      -> listener:(frameType:int -> error_code:int -> stream_id:int -> unit)
      -> t
      [@@js.call "on"]

    val on''' :
         t
      -> event:([ `goaway ][@js.enum])
      -> listener:
           (errorCode:int -> last_stream_id:int -> opaque_data:Buffer.t -> unit)
      -> t
      [@@js.call "on"]

    val on'''' :
         t
      -> event:([ `localSettings ][@js.enum])
      -> listener:(settings:Settings.t -> unit)
      -> t
      [@@js.call "on"]

    val on''''' :
      t -> event:([ `ping ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on'''''' :
         t
      -> event:([ `remoteSettings ][@js.enum])
      -> listener:(settings:Settings.t -> unit)
      -> t
      [@@js.call "on"]

    val on''''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on'''''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "on"]

    val once : t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "once"]

    val once'' :
         t
      -> event:([ `frameError ][@js.enum])
      -> listener:(frameType:int -> error_code:int -> stream_id:int -> unit)
      -> t
      [@@js.call "once"]

    val once''' :
         t
      -> event:([ `goaway ][@js.enum])
      -> listener:
           (errorCode:int -> last_stream_id:int -> opaque_data:Buffer.t -> unit)
      -> t
      [@@js.call "once"]

    val once'''' :
         t
      -> event:([ `localSettings ][@js.enum])
      -> listener:(settings:Settings.t -> unit)
      -> t
      [@@js.call "once"]

    val once''''' :
      t -> event:([ `ping ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once'''''' :
         t
      -> event:([ `remoteSettings ][@js.enum])
      -> listener:(settings:Settings.t -> unit)
      -> t
      [@@js.call "once"]

    val once''''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once'''''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "once"]

    val prepend_listener :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'' :
         t
      -> event:([ `frameError ][@js.enum])
      -> listener:(frameType:int -> error_code:int -> stream_id:int -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener''' :
         t
      -> event:([ `goaway ][@js.enum])
      -> listener:
           (errorCode:int -> last_stream_id:int -> opaque_data:Buffer.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener'''' :
         t
      -> event:([ `localSettings ][@js.enum])
      -> listener:(settings:Settings.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener''''' :
      t -> event:([ `ping ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'''''' :
         t
      -> event:([ `remoteSettings ][@js.enum])
      -> listener:(settings:Settings.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener''''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'''''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_once_listener :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'' :
         t
      -> event:([ `frameError ][@js.enum])
      -> listener:(frameType:int -> error_code:int -> stream_id:int -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''' :
         t
      -> event:([ `goaway ][@js.enum])
      -> listener:
           (errorCode:int -> last_stream_id:int -> opaque_data:Buffer.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''' :
         t
      -> event:([ `localSettings ][@js.enum])
      -> listener:(settings:Settings.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''''' :
      t -> event:([ `ping ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''''' :
         t
      -> event:([ `remoteSettings ][@js.enum])
      -> listener:(settings:Settings.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependOnceListener"]
  end
  [@@js.scope "Http2Session"]

  module Client_http2_session : sig
    include module type of struct
      include Http2_session
    end

    val request :
         t
      -> ?headers:Node_http.Http.Outgoing_http_headers.t
      -> ?options:Client_session_request_options.t
      -> unit
      -> Client_http2_stream.t
      [@@js.call "request"]

    val add_listener :
         t
      -> event:([ `altsvc ][@js.enum])
      -> listener:(alt:string -> origin:string -> stream:int -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener' :
         t
      -> event:([ `origin ][@js.enum])
      -> listener:(origins:string list -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'' :
         t
      -> event:([ `connect ][@js.enum])
      -> listener:
           (session:t -> socket:(Net.Socket.t, Tls.Tls_socket.t) union2 -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Client_http2_stream.t
            -> headers:
                 ( Incoming_http_headers.t
                 , Incoming_http_status_header.t )
                 intersection2
            -> flags:int
            -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "addListener"]

    val emit :
         t
      -> event:([ `altsvc ][@js.enum])
      -> alt:string
      -> origin:string
      -> stream:int
      -> bool
      [@@js.call "emit"]

    val emit' :
      t -> event:([ `origin ][@js.enum]) -> origins:string list -> bool
      [@@js.call "emit"]

    val emit'' :
         t
      -> event:([ `connect ][@js.enum])
      -> session:t
      -> socket:(Net.Socket.t, Tls.Tls_socket.t) union2
      -> bool
      [@@js.call "emit"]

    val emit''' :
         t
      -> event:([ `stream ][@js.enum])
      -> stream:Client_http2_stream.t
      -> headers:
           ( Incoming_http_headers.t
           , Incoming_http_status_header.t )
           intersection2
      -> flags:int
      -> bool
      [@@js.call "emit"]

    val emit'''' :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val on :
         t
      -> event:([ `altsvc ][@js.enum])
      -> listener:(alt:string -> origin:string -> stream:int -> unit)
      -> t
      [@@js.call "on"]

    val on' :
         t
      -> event:([ `origin ][@js.enum])
      -> listener:(origins:string list -> unit)
      -> t
      [@@js.call "on"]

    val on'' :
         t
      -> event:([ `connect ][@js.enum])
      -> listener:
           (session:t -> socket:(Net.Socket.t, Tls.Tls_socket.t) union2 -> unit)
      -> t
      [@@js.call "on"]

    val on''' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Client_http2_stream.t
            -> headers:
                 ( Incoming_http_headers.t
                 , Incoming_http_status_header.t )
                 intersection2
            -> flags:int
            -> unit)
      -> t
      [@@js.call "on"]

    val on'''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "on"]

    val once :
         t
      -> event:([ `altsvc ][@js.enum])
      -> listener:(alt:string -> origin:string -> stream:int -> unit)
      -> t
      [@@js.call "once"]

    val once' :
         t
      -> event:([ `origin ][@js.enum])
      -> listener:(origins:string list -> unit)
      -> t
      [@@js.call "once"]

    val once'' :
         t
      -> event:([ `connect ][@js.enum])
      -> listener:
           (session:t -> socket:(Net.Socket.t, Tls.Tls_socket.t) union2 -> unit)
      -> t
      [@@js.call "once"]

    val once''' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Client_http2_stream.t
            -> headers:
                 ( Incoming_http_headers.t
                 , Incoming_http_status_header.t )
                 intersection2
            -> flags:int
            -> unit)
      -> t
      [@@js.call "once"]

    val once'''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "once"]

    val prepend_listener :
         t
      -> event:([ `altsvc ][@js.enum])
      -> listener:(alt:string -> origin:string -> stream:int -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener' :
         t
      -> event:([ `origin ][@js.enum])
      -> listener:(origins:string list -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener'' :
         t
      -> event:([ `connect ][@js.enum])
      -> listener:
           (session:t -> socket:(Net.Socket.t, Tls.Tls_socket.t) union2 -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener''' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Client_http2_stream.t
            -> headers:
                 ( Incoming_http_headers.t
                 , Incoming_http_status_header.t )
                 intersection2
            -> flags:int
            -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener'''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_once_listener :
         t
      -> event:([ `altsvc ][@js.enum])
      -> listener:(alt:string -> origin:string -> stream:int -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener' :
         t
      -> event:([ `origin ][@js.enum])
      -> listener:(origins:string list -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'' :
         t
      -> event:([ `connect ][@js.enum])
      -> listener:
           (session:t -> socket:(Net.Socket.t, Tls.Tls_socket.t) union2 -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Client_http2_stream.t
            -> headers:
                 ( Incoming_http_headers.t
                 , Incoming_http_status_header.t )
                 intersection2
            -> flags:int
            -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependOnceListener"]
  end
  [@@js.scope "ClientHttp2Session"]

  module Alternative_service_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_origin : t -> Url.Url.t or_string or_number [@@js.get "origin"]

    val set_origin : t -> Url.Url.t or_string or_number -> unit
      [@@js.set "origin"]
  end
  [@@js.scope "AlternativeServiceOptions"]

  module Session_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_max_deflate_dynamic_table_size : t -> int
      [@@js.get "maxDeflateDynamicTableSize"]

    val set_max_deflate_dynamic_table_size : t -> int -> unit
      [@@js.set "maxDeflateDynamicTableSize"]

    val get_max_session_memory : t -> int [@@js.get "maxSessionMemory"]

    val set_max_session_memory : t -> int -> unit [@@js.set "maxSessionMemory"]

    val get_max_header_list_pairs : t -> int [@@js.get "maxHeaderListPairs"]

    val set_max_header_list_pairs : t -> int -> unit
      [@@js.set "maxHeaderListPairs"]

    val get_max_outstanding_pings : t -> int [@@js.get "maxOutstandingPings"]

    val set_max_outstanding_pings : t -> int -> unit
      [@@js.set "maxOutstandingPings"]

    val get_max_send_header_block_length : t -> int
      [@@js.get "maxSendHeaderBlockLength"]

    val set_max_send_header_block_length : t -> int -> unit
      [@@js.set "maxSendHeaderBlockLength"]

    val get_padding_strategy : t -> int [@@js.get "paddingStrategy"]

    val set_padding_strategy : t -> int -> unit [@@js.set "paddingStrategy"]

    val get_peer_max_concurrent_streams : t -> int
      [@@js.get "peerMaxConcurrentStreams"]

    val set_peer_max_concurrent_streams : t -> int -> unit
      [@@js.set "peerMaxConcurrentStreams"]

    val get_settings : t -> Settings.t [@@js.get "settings"]

    val set_settings : t -> Settings.t -> unit [@@js.set "settings"]

    val select_padding : t -> frame_len:int -> max_frame_len:int -> int
      [@@js.call "selectPadding"]

    val create_connection :
      t -> authority:Url.Url.t -> option:t -> Stream.Duplex.t
      [@@js.call "createConnection"]
  end
  [@@js.scope "SessionOptions"]

  module Client_session_options : sig
    include module type of struct
      include Session_options
    end

    val get_max_reserved_remote_streams : t -> int
      [@@js.get "maxReservedRemoteStreams"]

    val set_max_reserved_remote_streams : t -> int -> unit
      [@@js.set "maxReservedRemoteStreams"]

    val create_connection :
      t -> authority:Url.Url.t -> option:Session_options.t -> Stream.Duplex.t
      [@@js.call "createConnection"]

    val get_protocol :
      t -> ([ `http_ [@js "http:"] | `https_ [@js "https:"] ][@js.enum])
      [@@js.get "protocol"]

    val set_protocol : t -> ([ `http_ | `https_ ][@js.enum]) -> unit
      [@@js.set "protocol"]
  end
  [@@js.scope "ClientSessionOptions"]

  module Server_session_options : sig
    include module type of struct
      include Session_options
    end

    val get_http1IncomingMessage :
      t -> (* FIXME: unknown type 'typeof IncomingMessage' *) any
      [@@js.get "Http1IncomingMessage"]

    val set_http1IncomingMessage :
      t -> (* FIXME: unknown type 'typeof IncomingMessage' *) any -> unit
      [@@js.set "Http1IncomingMessage"]

    val get_http1ServerResponse :
      t -> (* FIXME: unknown type 'typeof ServerResponse' *) any
      [@@js.get "Http1ServerResponse"]

    val set_http1ServerResponse :
      t -> (* FIXME: unknown type 'typeof ServerResponse' *) any -> unit
      [@@js.set "Http1ServerResponse"]

    val get_http2ServerRequest :
      t -> (* FIXME: unknown type 'typeof Http2ServerRequest' *) any
      [@@js.get "Http2ServerRequest"]

    val set_http2ServerRequest :
      t -> (* FIXME: unknown type 'typeof Http2ServerRequest' *) any -> unit
      [@@js.set "Http2ServerRequest"]

    val get_http2ServerResponse :
      t -> (* FIXME: unknown type 'typeof Http2ServerResponse' *) any
      [@@js.get "Http2ServerResponse"]

    val set_http2ServerResponse :
      t -> (* FIXME: unknown type 'typeof Http2ServerResponse' *) any -> unit
      [@@js.set "Http2ServerResponse"]
  end
  [@@js.scope "ServerSessionOptions"]

  module Secure_client_session_options : sig
    include module type of struct
      include Client_session_options
    end

    val cast' : t -> Tls.Connection_options.t [@@js.cast]
  end

  module Secure_server_session_options : sig
    include module type of struct
      include Server_session_options
    end

    val cast' : t -> Tls.Tls_options.t [@@js.cast]
  end

  module Server_options : sig
    include module type of struct
      include Server_session_options
    end
  end

  module Secure_server_options : sig
    include module type of struct
      include Secure_server_session_options
    end

    val get_allow_http1 : t -> bool [@@js.get "allowHTTP1"]

    val set_allow_http1 : t -> bool -> unit [@@js.set "allowHTTP1"]

    val get_origins : t -> string list [@@js.get "origins"]

    val set_origins : t -> string list -> unit [@@js.set "origins"]
  end
  [@@js.scope "SecureServerOptions"]

  module Http2_server_request : sig
    include module type of struct
      include Stream.Readable
    end

    val create :
         stream:Server_http2_stream.t
      -> headers:Incoming_http_headers.t
      -> options:Stream.Readable_options.t
      -> raw_headers:string list
      -> t
      [@@js.create]

    val get_aborted : t -> bool [@@js.get "aborted"]

    val get_authority : t -> string [@@js.get "authority"]

    val get_connection : t -> (Net.Socket.t, Tls.Tls_socket.t) union2
      [@@js.get "connection"]

    val get_complete : t -> bool [@@js.get "complete"]

    val get_headers : t -> Incoming_http_headers.t [@@js.get "headers"]

    val get_http_version : t -> string [@@js.get "httpVersion"]

    val get_http_version_minor : t -> int [@@js.get "httpVersionMinor"]

    val get_http_version_major : t -> int [@@js.get "httpVersionMajor"]

    val get_method : t -> string [@@js.get "method"]

    val get_raw_headers : t -> string list [@@js.get "rawHeaders"]

    val get_raw_trailers : t -> string list [@@js.get "rawTrailers"]

    val get_scheme : t -> string [@@js.get "scheme"]

    val get_socket : t -> (Net.Socket.t, Tls.Tls_socket.t) union2
      [@@js.get "socket"]

    val get_stream : t -> Server_http2_stream.t [@@js.get "stream"]

    val get_trailers : t -> Incoming_http_headers.t [@@js.get "trailers"]

    val get_url : t -> string [@@js.get "url"]

    val set_timeout : t -> msecs:int -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "setTimeout"]

    val read : t -> ?size:int -> unit -> Buffer.t or_string or_null
      [@@js.call "read"]

    val add_listener :
         t
      -> event:([ `aborted ][@js.enum])
      -> listener:(hadError:bool -> code:int -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener' :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'' :
         t
      -> event:([ `data ][@js.enum])
      -> listener:(chunk:Buffer.t or_string -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''' :
      t -> event:([ `end_ ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''' :
      t -> event:([ `readable ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener''''' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "addListener"]

    val emit :
      t -> event:([ `aborted ][@js.enum]) -> had_error:bool -> code:int -> bool
      [@@js.call "emit"]

    val emit' : t -> event:([ `close ][@js.enum]) -> bool [@@js.call "emit"]

    val emit'' :
      t -> event:([ `data ][@js.enum]) -> chunk:Buffer.t or_string -> bool
      [@@js.call "emit"]

    val emit''' : t -> event:([ `end_ ][@js.enum]) -> bool [@@js.call "emit"]

    val emit'''' : t -> event:([ `readable ][@js.enum]) -> bool
      [@@js.call "emit"]

    val emit''''' : t -> event:([ `error ][@js.enum]) -> err:Error.t -> bool
      [@@js.call "emit"]

    val emit'''''' :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val on :
         t
      -> event:([ `aborted ][@js.enum])
      -> listener:(hadError:bool -> code:int -> unit)
      -> t
      [@@js.call "on"]

    val on' : t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on'' :
         t
      -> event:([ `data ][@js.enum])
      -> listener:(chunk:Buffer.t or_string -> unit)
      -> t
      [@@js.call "on"]

    val on''' : t -> event:([ `end_ ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on'''' :
      t -> event:([ `readable ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on''''' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "on"]

    val on'''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "on"]

    val once :
         t
      -> event:([ `aborted ][@js.enum])
      -> listener:(hadError:bool -> code:int -> unit)
      -> t
      [@@js.call "once"]

    val once' :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once'' :
         t
      -> event:([ `data ][@js.enum])
      -> listener:(chunk:Buffer.t or_string -> unit)
      -> t
      [@@js.call "once"]

    val once''' :
      t -> event:([ `end_ ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once'''' :
      t -> event:([ `readable ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once''''' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "once"]

    val once'''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "once"]

    val prepend_listener :
         t
      -> event:([ `aborted ][@js.enum])
      -> listener:(hadError:bool -> code:int -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener' :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'' :
         t
      -> event:([ `data ][@js.enum])
      -> listener:(chunk:Buffer.t or_string -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener''' :
      t -> event:([ `end_ ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'''' :
      t -> event:([ `readable ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener''''' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_once_listener :
         t
      -> event:([ `aborted ][@js.enum])
      -> listener:(hadError:bool -> code:int -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener' :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'' :
         t
      -> event:([ `data ][@js.enum])
      -> listener:(chunk:Buffer.t or_string -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''' :
      t -> event:([ `end_ ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''' :
      t -> event:([ `readable ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''''' :
      t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependOnceListener"]
  end
  [@@js.scope "Http2ServerRequest"]

  module Http2_server_response : sig
    include module type of struct
      include Stream.Writable
    end

    val create : stream:Server_http2_stream.t -> t [@@js.create]

    val get_connection : t -> (Net.Socket.t, Tls.Tls_socket.t) union2
      [@@js.get "connection"]

    val get_finished : t -> bool [@@js.get "finished"]

    val get_headers_sent : t -> bool [@@js.get "headersSent"]

    val get_socket : t -> (Net.Socket.t, Tls.Tls_socket.t) union2
      [@@js.get "socket"]

    val get_stream : t -> Server_http2_stream.t [@@js.get "stream"]

    val get_send_date : t -> bool [@@js.get "sendDate"]

    val set_send_date : t -> bool -> unit [@@js.set "sendDate"]

    val get_status_code : t -> int [@@js.get "statusCode"]

    val set_status_code : t -> int -> unit [@@js.set "statusCode"]

    val get_status_message : t -> ([ `L_s0 [@js ""] ][@js.enum])
      [@@js.get "statusMessage"]

    val set_status_message : t -> ([ `L_s0 ][@js.enum]) -> unit
      [@@js.set "statusMessage"]

    val add_trailers :
      t -> trailers:Node_http.Http.Outgoing_http_headers.t -> unit
      [@@js.call "addTrailers"]

    val end_ : t -> ?callback:(unit -> unit) -> unit -> unit [@@js.call "end"]

    val end_' :
         t
      -> data:Uint8_array.t or_string
      -> ?callback:(unit -> unit)
      -> unit
      -> unit
      [@@js.call "end"]

    val end_'' :
         t
      -> data:Uint8_array.t or_string
      -> encoding:Buffer_encoding.t
      -> ?callback:(unit -> unit)
      -> unit
      -> unit
      [@@js.call "end"]

    val get_header : t -> name:string -> string [@@js.call "getHeader"]

    val get_header_names : t -> string list [@@js.call "getHeaderNames"]

    val get_headers : t -> Node_http.Http.Outgoing_http_headers.t
      [@@js.call "getHeaders"]

    val has_header : t -> name:string -> bool [@@js.call "hasHeader"]

    val remove_header : t -> name:string -> unit [@@js.call "removeHeader"]

    val set_header : t -> name:string -> value:string list or_number -> unit
      [@@js.call "setHeader"]

    val set_timeout : t -> msecs:int -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "setTimeout"]

    val write :
         t
      -> chunk:Uint8_array.t or_string
      -> ?callback:(err:Error.t -> unit)
      -> unit
      -> bool
      [@@js.call "write"]

    val write' :
         t
      -> chunk:Uint8_array.t or_string
      -> encoding:Buffer_encoding.t
      -> ?callback:(err:Error.t -> unit)
      -> unit
      -> bool
      [@@js.call "write"]

    val write_continue : t -> unit [@@js.call "writeContinue"]

    val write_head :
         t
      -> status_code:int
      -> ?headers:Node_http.Http.Outgoing_http_headers.t
      -> unit
      -> t
      [@@js.call "writeHead"]

    val write_head' :
         t
      -> status_code:int
      -> status_message:string
      -> ?headers:Node_http.Http.Outgoing_http_headers.t
      -> unit
      -> t
      [@@js.call "writeHead"]

    val create_push_response :
         t
      -> headers:Node_http.Http.Outgoing_http_headers.t
      -> callback:(err:Error.t or_null -> res:t -> unit)
      -> unit
      [@@js.call "createPushResponse"]

    val add_listener :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener' :
      t -> event:([ `drain ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'' :
      t -> event:([ `error ][@js.enum]) -> listener:(error:Error.t -> unit) -> t
      [@@js.call "addListener"]

    val add_listener''' :
      t -> event:([ `finish ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''' :
         t
      -> event:([ `pipe ][@js.enum])
      -> listener:(src:Stream.Readable.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''''' :
         t
      -> event:([ `unpipe ][@js.enum])
      -> listener:(src:Stream.Readable.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "addListener"]

    val emit : t -> event:([ `close ][@js.enum]) -> bool [@@js.call "emit"]

    val emit' : t -> event:([ `drain ][@js.enum]) -> bool [@@js.call "emit"]

    val emit'' : t -> event:([ `error ][@js.enum]) -> error:Error.t -> bool
      [@@js.call "emit"]

    val emit''' : t -> event:([ `finish ][@js.enum]) -> bool [@@js.call "emit"]

    val emit'''' :
      t -> event:([ `pipe ][@js.enum]) -> src:Stream.Readable.t -> bool
      [@@js.call "emit"]

    val emit''''' :
      t -> event:([ `unpipe ][@js.enum]) -> src:Stream.Readable.t -> bool
      [@@js.call "emit"]

    val emit'''''' :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val on : t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on' : t -> event:([ `drain ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on'' :
      t -> event:([ `error ][@js.enum]) -> listener:(error:Error.t -> unit) -> t
      [@@js.call "on"]

    val on''' :
      t -> event:([ `finish ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on'''' :
         t
      -> event:([ `pipe ][@js.enum])
      -> listener:(src:Stream.Readable.t -> unit)
      -> t
      [@@js.call "on"]

    val on''''' :
         t
      -> event:([ `unpipe ][@js.enum])
      -> listener:(src:Stream.Readable.t -> unit)
      -> t
      [@@js.call "on"]

    val on'''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "on"]

    val once : t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once' :
      t -> event:([ `drain ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once'' :
      t -> event:([ `error ][@js.enum]) -> listener:(error:Error.t -> unit) -> t
      [@@js.call "once"]

    val once''' :
      t -> event:([ `finish ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once'''' :
         t
      -> event:([ `pipe ][@js.enum])
      -> listener:(src:Stream.Readable.t -> unit)
      -> t
      [@@js.call "once"]

    val once''''' :
         t
      -> event:([ `unpipe ][@js.enum])
      -> listener:(src:Stream.Readable.t -> unit)
      -> t
      [@@js.call "once"]

    val once'''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "once"]

    val prepend_listener :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener' :
      t -> event:([ `drain ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'' :
      t -> event:([ `error ][@js.enum]) -> listener:(error:Error.t -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener''' :
      t -> event:([ `finish ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'''' :
         t
      -> event:([ `pipe ][@js.enum])
      -> listener:(src:Stream.Readable.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener''''' :
         t
      -> event:([ `unpipe ][@js.enum])
      -> listener:(src:Stream.Readable.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener'''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_once_listener :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener' :
      t -> event:([ `drain ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'' :
      t -> event:([ `error ][@js.enum]) -> listener:(error:Error.t -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''' :
      t -> event:([ `finish ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''' :
         t
      -> event:([ `pipe ][@js.enum])
      -> listener:(src:Stream.Readable.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''''' :
         t
      -> event:([ `unpipe ][@js.enum])
      -> listener:(src:Stream.Readable.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependOnceListener"]
  end
  [@@js.scope "Http2ServerResponse"]

  module Server_http2_session : sig
    include module type of struct
      include Http2_session
    end

    (* val get_server : t -> (Http2_secure_server.t, Http2_server.t) union2
       [@@js.get "server"] *)

    val altsvc :
         t
      -> alt:string
      -> origin_or_stream:
           (Alternative_service_options.t, Url.Url.t) union2 or_string or_number
      -> unit
      [@@js.call "altsvc"]

    val origin :
         t
      -> args:
           (* FIXME: type 'Array<union<String | ?url.URL | {..}>>' cannot be
              used for variadic argument *) (any list[@js.variadic])
      -> unit
      [@@js.call "origin"]

    val add_listener :
         t
      -> event:([ `connect ][@js.enum])
      -> listener:
           (session:t -> socket:(Net.Socket.t, Tls.Tls_socket.t) union2 -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Server_http2_stream.t
            -> headers:Incoming_http_headers.t
            -> flags:int
            -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "addListener"]

    val emit :
         t
      -> event:([ `connect ][@js.enum])
      -> session:t
      -> socket:(Net.Socket.t, Tls.Tls_socket.t) union2
      -> bool
      [@@js.call "emit"]

    val emit' :
         t
      -> event:([ `stream ][@js.enum])
      -> stream:Server_http2_stream.t
      -> headers:Incoming_http_headers.t
      -> flags:int
      -> bool
      [@@js.call "emit"]

    val emit'' :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val on :
         t
      -> event:([ `connect ][@js.enum])
      -> listener:
           (session:t -> socket:(Net.Socket.t, Tls.Tls_socket.t) union2 -> unit)
      -> t
      [@@js.call "on"]

    val on' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Server_http2_stream.t
            -> headers:Incoming_http_headers.t
            -> flags:int
            -> unit)
      -> t
      [@@js.call "on"]

    val on'' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "on"]

    val once :
         t
      -> event:([ `connect ][@js.enum])
      -> listener:
           (session:t -> socket:(Net.Socket.t, Tls.Tls_socket.t) union2 -> unit)
      -> t
      [@@js.call "once"]

    val once' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Server_http2_stream.t
            -> headers:Incoming_http_headers.t
            -> flags:int
            -> unit)
      -> t
      [@@js.call "once"]

    val once'' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "once"]

    val prepend_listener :
         t
      -> event:([ `connect ][@js.enum])
      -> listener:
           (session:t -> socket:(Net.Socket.t, Tls.Tls_socket.t) union2 -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Server_http2_stream.t
            -> headers:Incoming_http_headers.t
            -> flags:int
            -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener'' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_once_listener :
         t
      -> event:([ `connect ][@js.enum])
      -> listener:
           (session:t -> socket:(Net.Socket.t, Tls.Tls_socket.t) union2 -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Server_http2_stream.t
            -> headers:Incoming_http_headers.t
            -> flags:int
            -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependOnceListener"]
  end
  [@@js.scope "ServerHttp2Session"]

  module Http2_server : sig
    include module type of struct
      include Net.Server
    end

    val add_listener :
         t
      -> event:([ `checkContinue ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener' :
         t
      -> event:([ `request ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'' :
         t
      -> event:([ `session ][@js.enum])
      -> listener:(session:Server_http2_session.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''' :
         t
      -> event:([ `sessionError ][@js.enum])
      -> listener:(err:Error.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'''' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Server_http2_stream.t
            -> headers:Incoming_http_headers.t
            -> flags:int
            -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "addListener"]

    val emit :
         t
      -> event:([ `checkContinue ][@js.enum])
      -> request:Http2_server_request.t
      -> response:Http2_server_response.t
      -> bool
      [@@js.call "emit"]

    val emit' :
         t
      -> event:([ `request ][@js.enum])
      -> request:Http2_server_request.t
      -> response:Http2_server_response.t
      -> bool
      [@@js.call "emit"]

    val emit'' :
         t
      -> event:([ `session ][@js.enum])
      -> session:Server_http2_session.t
      -> bool
      [@@js.call "emit"]

    val emit''' :
      t -> event:([ `sessionError ][@js.enum]) -> err:Error.t -> bool
      [@@js.call "emit"]

    val emit'''' :
         t
      -> event:([ `stream ][@js.enum])
      -> stream:Server_http2_stream.t
      -> headers:Incoming_http_headers.t
      -> flags:int
      -> bool
      [@@js.call "emit"]

    val emit''''' : t -> event:([ `timeout ][@js.enum]) -> bool
      [@@js.call "emit"]

    val emit'''''' :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val on :
         t
      -> event:([ `checkContinue ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "on"]

    val on' :
         t
      -> event:([ `request ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "on"]

    val on'' :
         t
      -> event:([ `session ][@js.enum])
      -> listener:(session:Server_http2_session.t -> unit)
      -> t
      [@@js.call "on"]

    val on''' :
         t
      -> event:([ `sessionError ][@js.enum])
      -> listener:(err:Error.t -> unit)
      -> t
      [@@js.call "on"]

    val on'''' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Server_http2_stream.t
            -> headers:Incoming_http_headers.t
            -> flags:int
            -> unit)
      -> t
      [@@js.call "on"]

    val on''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on'''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "on"]

    val once :
         t
      -> event:([ `checkContinue ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "once"]

    val once' :
         t
      -> event:([ `request ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "once"]

    val once'' :
         t
      -> event:([ `session ][@js.enum])
      -> listener:(session:Server_http2_session.t -> unit)
      -> t
      [@@js.call "once"]

    val once''' :
         t
      -> event:([ `sessionError ][@js.enum])
      -> listener:(err:Error.t -> unit)
      -> t
      [@@js.call "once"]

    val once'''' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Server_http2_stream.t
            -> headers:Incoming_http_headers.t
            -> flags:int
            -> unit)
      -> t
      [@@js.call "once"]

    val once''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once'''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "once"]

    val prepend_listener :
         t
      -> event:([ `checkContinue ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener' :
         t
      -> event:([ `request ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener'' :
         t
      -> event:([ `session ][@js.enum])
      -> listener:(session:Server_http2_session.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener''' :
         t
      -> event:([ `sessionError ][@js.enum])
      -> listener:(err:Error.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener'''' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Server_http2_stream.t
            -> headers:Incoming_http_headers.t
            -> flags:int
            -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_once_listener :
         t
      -> event:([ `checkContinue ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener' :
         t
      -> event:([ `request ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'' :
         t
      -> event:([ `session ][@js.enum])
      -> listener:(session:Server_http2_session.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''' :
         t
      -> event:([ `sessionError ][@js.enum])
      -> listener:(err:Error.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Server_http2_stream.t
            -> headers:Incoming_http_headers.t
            -> flags:int
            -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val set_timeout : t -> ?msec:int -> ?callback:(unit -> unit) -> unit -> t
      [@@js.call "setTimeout"]
  end
  [@@js.scope "Http2Server"]

  module Http2_secure_server : sig
    include module type of struct
      include Tls.Server
    end

    val add_listener :
         t
      -> event:([ `checkContinue ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener' :
         t
      -> event:([ `request ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'' :
         t
      -> event:([ `session ][@js.enum])
      -> listener:(session:Server_http2_session.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''' :
         t
      -> event:([ `sessionError ][@js.enum])
      -> listener:(err:Error.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener'''' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Server_http2_stream.t
            -> headers:Incoming_http_headers.t
            -> flags:int
            -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''''' :
         t
      -> event:([ `unknownProtocol ][@js.enum])
      -> listener:(socket:Tls.Tls_socket.t -> unit)
      -> t
      [@@js.call "addListener"]

    val add_listener''''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "addListener"]

    val emit :
         t
      -> event:([ `checkContinue ][@js.enum])
      -> request:Http2_server_request.t
      -> response:Http2_server_response.t
      -> bool
      [@@js.call "emit"]

    val emit' :
         t
      -> event:([ `request ][@js.enum])
      -> request:Http2_server_request.t
      -> response:Http2_server_response.t
      -> bool
      [@@js.call "emit"]

    val emit'' :
         t
      -> event:([ `session ][@js.enum])
      -> session:Server_http2_session.t
      -> bool
      [@@js.call "emit"]

    val emit''' :
      t -> event:([ `sessionError ][@js.enum]) -> err:Error.t -> bool
      [@@js.call "emit"]

    val emit'''' :
         t
      -> event:([ `stream ][@js.enum])
      -> stream:Server_http2_stream.t
      -> headers:Incoming_http_headers.t
      -> flags:int
      -> bool
      [@@js.call "emit"]

    val emit''''' : t -> event:([ `timeout ][@js.enum]) -> bool
      [@@js.call "emit"]

    val emit'''''' :
         t
      -> event:([ `unknownProtocol ][@js.enum])
      -> socket:Tls.Tls_socket.t
      -> bool
      [@@js.call "emit"]

    val emit''''''' :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val on :
         t
      -> event:([ `checkContinue ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "on"]

    val on' :
         t
      -> event:([ `request ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "on"]

    val on'' :
         t
      -> event:([ `session ][@js.enum])
      -> listener:(session:Server_http2_session.t -> unit)
      -> t
      [@@js.call "on"]

    val on''' :
         t
      -> event:([ `sessionError ][@js.enum])
      -> listener:(err:Error.t -> unit)
      -> t
      [@@js.call "on"]

    val on'''' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Server_http2_stream.t
            -> headers:Incoming_http_headers.t
            -> flags:int
            -> unit)
      -> t
      [@@js.call "on"]

    val on''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on'''''' :
         t
      -> event:([ `unknownProtocol ][@js.enum])
      -> listener:(socket:Tls.Tls_socket.t -> unit)
      -> t
      [@@js.call "on"]

    val on''''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "on"]

    val once :
         t
      -> event:([ `checkContinue ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "once"]

    val once' :
         t
      -> event:([ `request ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "once"]

    val once'' :
         t
      -> event:([ `session ][@js.enum])
      -> listener:(session:Server_http2_session.t -> unit)
      -> t
      [@@js.call "once"]

    val once''' :
         t
      -> event:([ `sessionError ][@js.enum])
      -> listener:(err:Error.t -> unit)
      -> t
      [@@js.call "once"]

    val once'''' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Server_http2_stream.t
            -> headers:Incoming_http_headers.t
            -> flags:int
            -> unit)
      -> t
      [@@js.call "once"]

    val once''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once'''''' :
         t
      -> event:([ `unknownProtocol ][@js.enum])
      -> listener:(socket:Tls.Tls_socket.t -> unit)
      -> t
      [@@js.call "once"]

    val once''''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "once"]

    val prepend_listener :
         t
      -> event:([ `checkContinue ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener' :
         t
      -> event:([ `request ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener'' :
         t
      -> event:([ `session ][@js.enum])
      -> listener:(session:Server_http2_session.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener''' :
         t
      -> event:([ `sessionError ][@js.enum])
      -> listener:(err:Error.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener'''' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Server_http2_stream.t
            -> headers:Incoming_http_headers.t
            -> flags:int
            -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'''''' :
         t
      -> event:([ `unknownProtocol ][@js.enum])
      -> listener:(socket:Tls.Tls_socket.t -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_listener''''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependListener"]

    val prepend_once_listener :
         t
      -> event:([ `checkContinue ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener' :
         t
      -> event:([ `request ][@js.enum])
      -> listener:
           (   request:Http2_server_request.t
            -> response:Http2_server_response.t
            -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'' :
         t
      -> event:([ `session ][@js.enum])
      -> listener:(session:Server_http2_session.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''' :
         t
      -> event:([ `sessionError ][@js.enum])
      -> listener:(err:Error.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''' :
         t
      -> event:([ `stream ][@js.enum])
      -> listener:
           (   stream:Server_http2_stream.t
            -> headers:Incoming_http_headers.t
            -> flags:int
            -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''''' :
      t -> event:([ `timeout ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''''' :
         t
      -> event:([ `unknownProtocol ][@js.enum])
      -> listener:(socket:Tls.Tls_socket.t -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''''''' :
         t
      -> event:symbol or_string
      -> listener:(args:(any list[@js.variadic]) -> unit)
      -> t
      [@@js.call "prependOnceListener"]

    val set_timeout : t -> ?msec:int -> ?callback:(unit -> unit) -> unit -> t
      [@@js.call "setTimeout"]
  end
  [@@js.scope "Http2SecureServer"]

  module Constants : sig
    val ngsession_server : int [@@js.global "NGHTTP2_SESSION_SERVER"]

    val ngsession_client : int [@@js.global "NGHTTP2_SESSION_CLIENT"]

    val ngstream_state_idle : int [@@js.global "NGHTTP2_STREAM_STATE_IDLE"]

    val ngstream_state_open : int [@@js.global "NGHTTP2_STREAM_STATE_OPEN"]

    val ngstream_state_reserved_local : int
      [@@js.global "NGHTTP2_STREAM_STATE_RESERVED_LOCAL"]

    val ngstream_state_reserved_remote : int
      [@@js.global "NGHTTP2_STREAM_STATE_RESERVED_REMOTE"]

    val ngstream_state_half_closed_local : int
      [@@js.global "NGHTTP2_STREAM_STATE_HALF_CLOSED_LOCAL"]

    val ngstream_state_half_closed_remote : int
      [@@js.global "NGHTTP2_STREAM_STATE_HALF_CLOSED_REMOTE"]

    val ngstream_state_closed : int [@@js.global "NGHTTP2_STREAM_STATE_CLOSED"]

    val ngno_error : int [@@js.global "NGHTTP2_NO_ERROR"]

    val ngprotocol_error : int [@@js.global "NGHTTP2_PROTOCOL_ERROR"]

    val nginternal_error : int [@@js.global "NGHTTP2_INTERNAL_ERROR"]

    val ngflow_control_error : int [@@js.global "NGHTTP2_FLOW_CONTROL_ERROR"]

    val ngsettings_timeout : int [@@js.global "NGHTTP2_SETTINGS_TIMEOUT"]

    val ngstream_closed : int [@@js.global "NGHTTP2_STREAM_CLOSED"]

    val ngframe_size_error : int [@@js.global "NGHTTP2_FRAME_SIZE_ERROR"]

    val ngrefused_stream : int [@@js.global "NGHTTP2_REFUSED_STREAM"]

    val ngcancel : int [@@js.global "NGHTTP2_CANCEL"]

    val ngcompression_error : int [@@js.global "NGHTTP2_COMPRESSION_ERROR"]

    val ngconnect_error : int [@@js.global "NGHTTP2_CONNECT_ERROR"]

    val ngenhance_your_calm : int [@@js.global "NGHTTP2_ENHANCE_YOUR_CALM"]

    val nginadequate_security : int [@@js.global "NGHTTP2_INADEQUATE_SECURITY"]

    val nghttp_1_1_required : int [@@js.global "NGHTTP2_HTTP_1_1_REQUIRED"]

    val ngerr_frame_size_error : int
      [@@js.global "NGHTTP2_ERR_FRAME_SIZE_ERROR"]

    val ngflag_none : int [@@js.global "NGHTTP2_FLAG_NONE"]

    val ngflag_end_stream : int [@@js.global "NGHTTP2_FLAG_END_STREAM"]

    val ngflag_end_headers : int [@@js.global "NGHTTP2_FLAG_END_HEADERS"]

    val ngflag_ack : int [@@js.global "NGHTTP2_FLAG_ACK"]

    val ngflag_padded : int [@@js.global "NGHTTP2_FLAG_PADDED"]

    val ngflag_priority : int [@@js.global "NGHTTP2_FLAG_PRIORITY"]

    val default_settings_header_table_size : int
      [@@js.global "DEFAULT_SETTINGS_HEADER_TABLE_SIZE"]

    val default_settings_enable_push : int
      [@@js.global "DEFAULT_SETTINGS_ENABLE_PUSH"]

    val default_settings_initial_window_size : int
      [@@js.global "DEFAULT_SETTINGS_INITIAL_WINDOW_SIZE"]

    val default_settings_max_frame_size : int
      [@@js.global "DEFAULT_SETTINGS_MAX_FRAME_SIZE"]

    val max_max_frame_size : int [@@js.global "MAX_MAX_FRAME_SIZE"]

    val min_max_frame_size : int [@@js.global "MIN_MAX_FRAME_SIZE"]

    val max_initial_window_size : int [@@js.global "MAX_INITIAL_WINDOW_SIZE"]

    val ngdefault_weight : int [@@js.global "NGHTTP2_DEFAULT_WEIGHT"]

    val ngsettings_header_table_size : int
      [@@js.global "NGHTTP2_SETTINGS_HEADER_TABLE_SIZE"]

    val ngsettings_enable_push : int
      [@@js.global "NGHTTP2_SETTINGS_ENABLE_PUSH"]

    val ngsettings_max_concurrent_streams : int
      [@@js.global "NGHTTP2_SETTINGS_MAX_CONCURRENT_STREAMS"]

    val ngsettings_initial_window_size : int
      [@@js.global "NGHTTP2_SETTINGS_INITIAL_WINDOW_SIZE"]

    val ngsettings_max_frame_size : int
      [@@js.global "NGHTTP2_SETTINGS_MAX_FRAME_SIZE"]

    val ngsettings_max_header_list_size : int
      [@@js.global "NGHTTP2_SETTINGS_MAX_HEADER_LIST_SIZE"]

    val padding_strategy_none : int [@@js.global "PADDING_STRATEGY_NONE"]

    val padding_strategy_max : int [@@js.global "PADDING_STRATEGY_MAX"]

    val padding_strategy_callback : int
      [@@js.global "PADDING_STRATEGY_CALLBACK"]

    val http2_HEADER_STATUS : string [@@js.global "HTTP2_HEADER_STATUS"]

    val http2_HEADER_METHOD : string [@@js.global "HTTP2_HEADER_METHOD"]

    val http2_HEADER_AUTHORITY : string [@@js.global "HTTP2_HEADER_AUTHORITY"]

    val http2_HEADER_SCHEME : string [@@js.global "HTTP2_HEADER_SCHEME"]

    val http2_HEADER_PATH : string [@@js.global "HTTP2_HEADER_PATH"]

    val http2_HEADER_ACCEPT_CHARSET : string
      [@@js.global "HTTP2_HEADER_ACCEPT_CHARSET"]

    val http2_HEADER_ACCEPT_ENCODING : string
      [@@js.global "HTTP2_HEADER_ACCEPT_ENCODING"]

    val http2_HEADER_ACCEPT_LANGUAGE : string
      [@@js.global "HTTP2_HEADER_ACCEPT_LANGUAGE"]

    val http2_HEADER_ACCEPT_RANGES : string
      [@@js.global "HTTP2_HEADER_ACCEPT_RANGES"]

    val http2_HEADER_ACCEPT : string [@@js.global "HTTP2_HEADER_ACCEPT"]

    val http2_HEADER_ACCESS_CONTROL_ALLOW_ORIGIN : string
      [@@js.global "HTTP2_HEADER_ACCESS_CONTROL_ALLOW_ORIGIN"]

    val http2_HEADER_AGE : string [@@js.global "HTTP2_HEADER_AGE"]

    val http2_HEADER_ALLOW : string [@@js.global "HTTP2_HEADER_ALLOW"]

    val http2_HEADER_AUTHORIZATION : string
      [@@js.global "HTTP2_HEADER_AUTHORIZATION"]

    val http2_HEADER_CACHE_CONTROL : string
      [@@js.global "HTTP2_HEADER_CACHE_CONTROL"]

    val http2_HEADER_CONNECTION : string [@@js.global "HTTP2_HEADER_CONNECTION"]

    val http2_HEADER_CONTENT_DISPOSITION : string
      [@@js.global "HTTP2_HEADER_CONTENT_DISPOSITION"]

    val http2_HEADER_CONTENT_ENCODING : string
      [@@js.global "HTTP2_HEADER_CONTENT_ENCODING"]

    val http2_HEADER_CONTENT_LANGUAGE : string
      [@@js.global "HTTP2_HEADER_CONTENT_LANGUAGE"]

    val http2_HEADER_CONTENT_LENGTH : string
      [@@js.global "HTTP2_HEADER_CONTENT_LENGTH"]

    val http2_HEADER_CONTENT_LOCATION : string
      [@@js.global "HTTP2_HEADER_CONTENT_LOCATION"]

    val http2_HEADER_CONTENT_MD5 : string
      [@@js.global "HTTP2_HEADER_CONTENT_MD5"]

    val http2_HEADER_CONTENT_RANGE : string
      [@@js.global "HTTP2_HEADER_CONTENT_RANGE"]

    val http2_HEADER_CONTENT_TYPE : string
      [@@js.global "HTTP2_HEADER_CONTENT_TYPE"]

    val http2_HEADER_COOKIE : string [@@js.global "HTTP2_HEADER_COOKIE"]

    val http2_HEADER_DATE : string [@@js.global "HTTP2_HEADER_DATE"]

    val http2_HEADER_ETAG : string [@@js.global "HTTP2_HEADER_ETAG"]

    val http2_HEADER_EXPECT : string [@@js.global "HTTP2_HEADER_EXPECT"]

    val http2_HEADER_EXPIRES : string [@@js.global "HTTP2_HEADER_EXPIRES"]

    val http2_HEADER_FROM : string [@@js.global "HTTP2_HEADER_FROM"]

    val http2_HEADER_HOST : string [@@js.global "HTTP2_HEADER_HOST"]

    val http2_HEADER_IF_MATCH : string [@@js.global "HTTP2_HEADER_IF_MATCH"]

    val http2_HEADER_IF_MODIFIED_SINCE : string
      [@@js.global "HTTP2_HEADER_IF_MODIFIED_SINCE"]

    val http2_HEADER_IF_NONE_MATCH : string
      [@@js.global "HTTP2_HEADER_IF_NONE_MATCH"]

    val http2_HEADER_IF_RANGE : string [@@js.global "HTTP2_HEADER_IF_RANGE"]

    val http2_HEADER_IF_UNMODIFIED_SINCE : string
      [@@js.global "HTTP2_HEADER_IF_UNMODIFIED_SINCE"]

    val http2_HEADER_LAST_MODIFIED : string
      [@@js.global "HTTP2_HEADER_LAST_MODIFIED"]

    val http2_HEADER_LINK : string [@@js.global "HTTP2_HEADER_LINK"]

    val http2_HEADER_LOCATION : string [@@js.global "HTTP2_HEADER_LOCATION"]

    val http2_HEADER_MAX_FORWARDS : string
      [@@js.global "HTTP2_HEADER_MAX_FORWARDS"]

    val http2_HEADER_PREFER : string [@@js.global "HTTP2_HEADER_PREFER"]

    val http2_HEADER_PROXY_AUTHENTICATE : string
      [@@js.global "HTTP2_HEADER_PROXY_AUTHENTICATE"]

    val http2_HEADER_PROXY_AUTHORIZATION : string
      [@@js.global "HTTP2_HEADER_PROXY_AUTHORIZATION"]

    val http2_HEADER_RANGE : string [@@js.global "HTTP2_HEADER_RANGE"]

    val http2_HEADER_REFERER : string [@@js.global "HTTP2_HEADER_REFERER"]

    val http2_HEADER_REFRESH : string [@@js.global "HTTP2_HEADER_REFRESH"]

    val http2_HEADER_RETRY_AFTER : string
      [@@js.global "HTTP2_HEADER_RETRY_AFTER"]

    val http2_HEADER_SERVER : string [@@js.global "HTTP2_HEADER_SERVER"]

    val http2_HEADER_SET_COOKIE : string [@@js.global "HTTP2_HEADER_SET_COOKIE"]

    val http2_HEADER_STRICT_TRANSPORT_SECURITY : string
      [@@js.global "HTTP2_HEADER_STRICT_TRANSPORT_SECURITY"]

    val http2_HEADER_TRANSFER_ENCODING : string
      [@@js.global "HTTP2_HEADER_TRANSFER_ENCODING"]

    val http2_HEADER_TE : string [@@js.global "HTTP2_HEADER_TE"]

    val http2_HEADER_UPGRADE : string [@@js.global "HTTP2_HEADER_UPGRADE"]

    val http2_HEADER_USER_AGENT : string [@@js.global "HTTP2_HEADER_USER_AGENT"]

    val http2_HEADER_VARY : string [@@js.global "HTTP2_HEADER_VARY"]

    val http2_HEADER_VIA : string [@@js.global "HTTP2_HEADER_VIA"]

    val http2_HEADER_WWW_AUTHENTICATE : string
      [@@js.global "HTTP2_HEADER_WWW_AUTHENTICATE"]

    val http2_HEADER_HTTP2_SETTINGS : string
      [@@js.global "HTTP2_HEADER_HTTP2_SETTINGS"]

    val http2_HEADER_KEEP_ALIVE : string [@@js.global "HTTP2_HEADER_KEEP_ALIVE"]

    val http2_HEADER_PROXY_CONNECTION : string
      [@@js.global "HTTP2_HEADER_PROXY_CONNECTION"]

    val http2_METHOD_ACL : string [@@js.global "HTTP2_METHOD_ACL"]

    val http2_METHOD_BASELINE_CONTROL : string
      [@@js.global "HTTP2_METHOD_BASELINE_CONTROL"]

    val http2_METHOD_BIND : string [@@js.global "HTTP2_METHOD_BIND"]

    val http2_METHOD_CHECKIN : string [@@js.global "HTTP2_METHOD_CHECKIN"]

    val http2_METHOD_CHECKOUT : string [@@js.global "HTTP2_METHOD_CHECKOUT"]

    val http2_METHOD_CONNECT : string [@@js.global "HTTP2_METHOD_CONNECT"]

    val http2_METHOD_COPY : string [@@js.global "HTTP2_METHOD_COPY"]

    val http2_METHOD_DELETE : string [@@js.global "HTTP2_METHOD_DELETE"]

    val http2_METHOD_GET : string [@@js.global "HTTP2_METHOD_GET"]

    val http2_METHOD_HEAD : string [@@js.global "HTTP2_METHOD_HEAD"]

    val http2_METHOD_LABEL : string [@@js.global "HTTP2_METHOD_LABEL"]

    val http2_METHOD_LINK : string [@@js.global "HTTP2_METHOD_LINK"]

    val http2_METHOD_LOCK : string [@@js.global "HTTP2_METHOD_LOCK"]

    val http2_METHOD_MERGE : string [@@js.global "HTTP2_METHOD_MERGE"]

    val http2_METHOD_MKACTIVITY : string [@@js.global "HTTP2_METHOD_MKACTIVITY"]

    val http2_METHOD_MKCALENDAR : string [@@js.global "HTTP2_METHOD_MKCALENDAR"]

    val http2_METHOD_MKCOL : string [@@js.global "HTTP2_METHOD_MKCOL"]

    val http2_METHOD_MKREDIRECTREF : string
      [@@js.global "HTTP2_METHOD_MKREDIRECTREF"]

    val http2_METHOD_MKWORKSPACE : string
      [@@js.global "HTTP2_METHOD_MKWORKSPACE"]

    val http2_METHOD_MOVE : string [@@js.global "HTTP2_METHOD_MOVE"]

    val http2_METHOD_OPTIONS : string [@@js.global "HTTP2_METHOD_OPTIONS"]

    val http2_METHOD_ORDERPATCH : string [@@js.global "HTTP2_METHOD_ORDERPATCH"]

    val http2_METHOD_PATCH : string [@@js.global "HTTP2_METHOD_PATCH"]

    val http2_METHOD_POST : string [@@js.global "HTTP2_METHOD_POST"]

    val http2_METHOD_PRI : string [@@js.global "HTTP2_METHOD_PRI"]

    val http2_METHOD_PROPFIND : string [@@js.global "HTTP2_METHOD_PROPFIND"]

    val http2_METHOD_PROPPATCH : string [@@js.global "HTTP2_METHOD_PROPPATCH"]

    val http2_METHOD_PUT : string [@@js.global "HTTP2_METHOD_PUT"]

    val http2_METHOD_REBIND : string [@@js.global "HTTP2_METHOD_REBIND"]

    val http2_METHOD_REPORT : string [@@js.global "HTTP2_METHOD_REPORT"]

    val http2_METHOD_SEARCH : string [@@js.global "HTTP2_METHOD_SEARCH"]

    val http2_METHOD_TRACE : string [@@js.global "HTTP2_METHOD_TRACE"]

    val http2_METHOD_UNBIND : string [@@js.global "HTTP2_METHOD_UNBIND"]

    val http2_METHOD_UNCHECKOUT : string [@@js.global "HTTP2_METHOD_UNCHECKOUT"]

    val http2_METHOD_UNLINK : string [@@js.global "HTTP2_METHOD_UNLINK"]

    val http2_METHOD_UNLOCK : string [@@js.global "HTTP2_METHOD_UNLOCK"]

    val http2_METHOD_UPDATE : string [@@js.global "HTTP2_METHOD_UPDATE"]

    val http2_METHOD_UPDATEREDIRECTREF : string
      [@@js.global "HTTP2_METHOD_UPDATEREDIRECTREF"]

    val http2_METHOD_VERSION_CONTROL : string
      [@@js.global "HTTP2_METHOD_VERSION_CONTROL"]

    val http_status_continue : int [@@js.global "HTTP_STATUS_CONTINUE"]

    val http_status_switching_protocols : int
      [@@js.global "HTTP_STATUS_SWITCHING_PROTOCOLS"]

    val http_status_processing : int [@@js.global "HTTP_STATUS_PROCESSING"]

    val http_status_ok : int [@@js.global "HTTP_STATUS_OK"]

    val http_status_created : int [@@js.global "HTTP_STATUS_CREATED"]

    val http_status_accepted : int [@@js.global "HTTP_STATUS_ACCEPTED"]

    val http_status_non_authoritative_information : int
      [@@js.global "HTTP_STATUS_NON_AUTHORITATIVE_INFORMATION"]

    val http_status_no_content : int [@@js.global "HTTP_STATUS_NO_CONTENT"]

    val http_status_reset_content : int
      [@@js.global "HTTP_STATUS_RESET_CONTENT"]

    val http_status_partial_content : int
      [@@js.global "HTTP_STATUS_PARTIAL_CONTENT"]

    val http_status_multi_status : int [@@js.global "HTTP_STATUS_MULTI_STATUS"]

    val http_status_already_reported : int
      [@@js.global "HTTP_STATUS_ALREADY_REPORTED"]

    val http_status_im_used : int [@@js.global "HTTP_STATUS_IM_USED"]

    val http_status_multiple_choices : int
      [@@js.global "HTTP_STATUS_MULTIPLE_CHOICES"]

    val http_status_moved_permanently : int
      [@@js.global "HTTP_STATUS_MOVED_PERMANENTLY"]

    val http_status_found : int [@@js.global "HTTP_STATUS_FOUND"]

    val http_status_see_other : int [@@js.global "HTTP_STATUS_SEE_OTHER"]

    val http_status_not_modified : int [@@js.global "HTTP_STATUS_NOT_MODIFIED"]

    val http_status_use_proxy : int [@@js.global "HTTP_STATUS_USE_PROXY"]

    val http_status_temporary_redirect : int
      [@@js.global "HTTP_STATUS_TEMPORARY_REDIRECT"]

    val http_status_permanent_redirect : int
      [@@js.global "HTTP_STATUS_PERMANENT_REDIRECT"]

    val http_status_bad_request : int [@@js.global "HTTP_STATUS_BAD_REQUEST"]

    val http_status_unauthorized : int [@@js.global "HTTP_STATUS_UNAUTHORIZED"]

    val http_status_payment_required : int
      [@@js.global "HTTP_STATUS_PAYMENT_REQUIRED"]

    val http_status_forbidden : int [@@js.global "HTTP_STATUS_FORBIDDEN"]

    val http_status_not_found : int [@@js.global "HTTP_STATUS_NOT_FOUND"]

    val http_status_method_not_allowed : int
      [@@js.global "HTTP_STATUS_METHOD_NOT_ALLOWED"]

    val http_status_not_acceptable : int
      [@@js.global "HTTP_STATUS_NOT_ACCEPTABLE"]

    val http_status_proxy_authentication_required : int
      [@@js.global "HTTP_STATUS_PROXY_AUTHENTICATION_REQUIRED"]

    val http_status_request_timeout : int
      [@@js.global "HTTP_STATUS_REQUEST_TIMEOUT"]

    val http_status_conflict : int [@@js.global "HTTP_STATUS_CONFLICT"]

    val http_status_gone : int [@@js.global "HTTP_STATUS_GONE"]

    val http_status_length_required : int
      [@@js.global "HTTP_STATUS_LENGTH_REQUIRED"]

    val http_status_precondition_failed : int
      [@@js.global "HTTP_STATUS_PRECONDITION_FAILED"]

    val http_status_payload_too_large : int
      [@@js.global "HTTP_STATUS_PAYLOAD_TOO_LARGE"]

    val http_status_uri_too_long : int [@@js.global "HTTP_STATUS_URI_TOO_LONG"]

    val http_status_unsupported_media_type : int
      [@@js.global "HTTP_STATUS_UNSUPPORTED_MEDIA_TYPE"]

    val http_status_range_not_satisfiable : int
      [@@js.global "HTTP_STATUS_RANGE_NOT_SATISFIABLE"]

    val http_status_expectation_failed : int
      [@@js.global "HTTP_STATUS_EXPECTATION_FAILED"]

    val http_status_teapot : int [@@js.global "HTTP_STATUS_TEAPOT"]

    val http_status_misdirected_request : int
      [@@js.global "HTTP_STATUS_MISDIRECTED_REQUEST"]

    val http_status_unprocessable_entity : int
      [@@js.global "HTTP_STATUS_UNPROCESSABLE_ENTITY"]

    val http_status_locked : int [@@js.global "HTTP_STATUS_LOCKED"]

    val http_status_failed_dependency : int
      [@@js.global "HTTP_STATUS_FAILED_DEPENDENCY"]

    val http_status_unordered_collection : int
      [@@js.global "HTTP_STATUS_UNORDERED_COLLECTION"]

    val http_status_upgrade_required : int
      [@@js.global "HTTP_STATUS_UPGRADE_REQUIRED"]

    val http_status_precondition_required : int
      [@@js.global "HTTP_STATUS_PRECONDITION_REQUIRED"]

    val http_status_too_many_requests : int
      [@@js.global "HTTP_STATUS_TOO_MANY_REQUESTS"]

    val http_status_request_header_fields_too_large : int
      [@@js.global "HTTP_STATUS_REQUEST_HEADER_FIELDS_TOO_LARGE"]

    val http_status_unavailable_for_legal_reasons : int
      [@@js.global "HTTP_STATUS_UNAVAILABLE_FOR_LEGAL_REASONS"]

    val http_status_internal_server_error : int
      [@@js.global "HTTP_STATUS_INTERNAL_SERVER_ERROR"]

    val http_status_not_implemented : int
      [@@js.global "HTTP_STATUS_NOT_IMPLEMENTED"]

    val http_status_bad_gateway : int [@@js.global "HTTP_STATUS_BAD_GATEWAY"]

    val http_status_service_unavailable : int
      [@@js.global "HTTP_STATUS_SERVICE_UNAVAILABLE"]

    val http_status_gateway_timeout : int
      [@@js.global "HTTP_STATUS_GATEWAY_TIMEOUT"]

    val http_status_http_version_not_supported : int
      [@@js.global "HTTP_STATUS_HTTP_VERSION_NOT_SUPPORTED"]

    val http_status_variant_also_negotiates : int
      [@@js.global "HTTP_STATUS_VARIANT_ALSO_NEGOTIATES"]

    val http_status_insufficient_storage : int
      [@@js.global "HTTP_STATUS_INSUFFICIENT_STORAGE"]

    val http_status_loop_detected : int
      [@@js.global "HTTP_STATUS_LOOP_DETECTED"]

    val http_status_bandwidth_limit_exceeded : int
      [@@js.global "HTTP_STATUS_BANDWIDTH_LIMIT_EXCEEDED"]

    val http_status_not_extended : int [@@js.global "HTTP_STATUS_NOT_EXTENDED"]

    val http_status_network_authentication_required : int
      [@@js.global "HTTP_STATUS_NETWORK_AUTHENTICATION_REQUIRED"]
  end
  [@@js.scope "constants"]

  val get_default_settings : unit -> Settings.t
    [@@js.global "getDefaultSettings"]

  val get_packed_settings : settings:Settings.t -> Buffer.t
    [@@js.global "getPackedSettings"]

  val get_unpacked_settings : buf:Uint8_array.t -> Settings.t
    [@@js.global "getUnpackedSettings"]

  val create_server :
       ?on_request_handler:
         (   request:Http2_server_request.t
          -> response:Http2_server_response.t
          -> unit)
    -> unit
    -> Http2_server.t
    [@@js.global "createServer"]

  val create_server :
       options:Server_options.t
    -> ?on_request_handler:
         (   request:Http2_server_request.t
          -> response:Http2_server_response.t
          -> unit)
    -> unit
    -> Http2_server.t
    [@@js.global "createServer"]

  val create_secure_server :
       ?on_request_handler:
         (   request:Http2_server_request.t
          -> response:Http2_server_response.t
          -> unit)
    -> unit
    -> Http2_secure_server.t
    [@@js.global "createSecureServer"]

  val create_secure_server :
       options:Secure_server_options.t
    -> ?on_request_handler:
         (   request:Http2_server_request.t
          -> response:Http2_server_response.t
          -> unit)
    -> unit
    -> Http2_secure_server.t
    [@@js.global "createSecureServer"]

  val connect :
       authority:Url.Url.t or_string
    -> listener:
         (   session:Client_http2_session.t
          -> socket:(Net.Socket.t, Tls.Tls_socket.t) union2
          -> unit)
    -> Client_http2_session.t
    [@@js.global "connect"]

  val connect :
       authority:Url.Url.t or_string
    -> ?options:
         ([ `U_s15_http_ of
            (Client_session_options.t, Secure_client_session_options.t) union2
          | `U_s16_https_ of
            (Client_session_options.t, Secure_client_session_options.t) union2
          ]
         [@js.union on_field "protocol"])
    -> ?listener:
         (   session:Client_http2_session.t
          -> socket:(Net.Socket.t, Tls.Tls_socket.t) union2
          -> unit)
    -> unit
    -> Client_http2_session.t
    [@@js.global "connect"]
end
[@@js.scope Import.http2]
