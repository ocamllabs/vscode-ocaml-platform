[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get : t -> int -> string or_undefined [@@js.index_get]

  val set : t -> int -> string or_undefined -> unit [@@js.index_set]

  val get' : t -> string -> string or_undefined [@@js.index_get]

  val set' : t -> string -> string or_undefined -> unit [@@js.index_set]
end

module Http : sig
  open Node_stream

  module Incoming_http_headers : sig
    type t = string list Dict.t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_accept : t -> string [@@js.get "accept"]

    val set_accept : t -> string -> unit [@@js.set "accept"]

    val get_accept_language : t -> string [@@js.get "accept-language"]

    val set_accept_language : t -> string -> unit [@@js.set "accept-language"]

    val get_accept_patch : t -> string [@@js.get "accept-patch"]

    val set_accept_patch : t -> string -> unit [@@js.set "accept-patch"]

    val get_accept_ranges : t -> string [@@js.get "accept-ranges"]

    val set_accept_ranges : t -> string -> unit [@@js.set "accept-ranges"]

    val get_access_control_allow_credentials : t -> string
      [@@js.get "access-control-allow-credentials"]

    val set_access_control_allow_credentials : t -> string -> unit
      [@@js.set "access-control-allow-credentials"]

    val get_access_control_allow_headers : t -> string
      [@@js.get "access-control-allow-headers"]

    val set_access_control_allow_headers : t -> string -> unit
      [@@js.set "access-control-allow-headers"]

    val get_access_control_allow_methods : t -> string
      [@@js.get "access-control-allow-methods"]

    val set_access_control_allow_methods : t -> string -> unit
      [@@js.set "access-control-allow-methods"]

    val get_access_control_allow_origin : t -> string
      [@@js.get "access-control-allow-origin"]

    val set_access_control_allow_origin : t -> string -> unit
      [@@js.set "access-control-allow-origin"]

    val get_access_control_expose_headers : t -> string
      [@@js.get "access-control-expose-headers"]

    val set_access_control_expose_headers : t -> string -> unit
      [@@js.set "access-control-expose-headers"]

    val get_access_control_max_age : t -> string
      [@@js.get "access-control-max-age"]

    val set_access_control_max_age : t -> string -> unit
      [@@js.set "access-control-max-age"]

    val get_access_control_request_headers : t -> string
      [@@js.get "access-control-request-headers"]

    val set_access_control_request_headers : t -> string -> unit
      [@@js.set "access-control-request-headers"]

    val get_access_control_request_method : t -> string
      [@@js.get "access-control-request-method"]

    val set_access_control_request_method : t -> string -> unit
      [@@js.set "access-control-request-method"]

    val get_age : t -> string [@@js.get "age"]

    val set_age : t -> string -> unit [@@js.set "age"]

    val get_allow : t -> string [@@js.get "allow"]

    val set_allow : t -> string -> unit [@@js.set "allow"]

    val get_alt_svc : t -> string [@@js.get "alt-svc"]

    val set_alt_svc : t -> string -> unit [@@js.set "alt-svc"]

    val get_authorization : t -> string [@@js.get "authorization"]

    val set_authorization : t -> string -> unit [@@js.set "authorization"]

    val get_cache_control : t -> string [@@js.get "cache-control"]

    val set_cache_control : t -> string -> unit [@@js.set "cache-control"]

    val get_connection : t -> string [@@js.get "connection"]

    val set_connection : t -> string -> unit [@@js.set "connection"]

    val get_content_disposition : t -> string [@@js.get "content-disposition"]

    val set_content_disposition : t -> string -> unit
      [@@js.set "content-disposition"]

    val get_content_encoding : t -> string [@@js.get "content-encoding"]

    val set_content_encoding : t -> string -> unit [@@js.set "content-encoding"]

    val get_content_language : t -> string [@@js.get "content-language"]

    val set_content_language : t -> string -> unit [@@js.set "content-language"]

    val get_content_length : t -> string [@@js.get "content-length"]

    val set_content_length : t -> string -> unit [@@js.set "content-length"]

    val get_content_location : t -> string [@@js.get "content-location"]

    val set_content_location : t -> string -> unit [@@js.set "content-location"]

    val get_content_range : t -> string [@@js.get "content-range"]

    val set_content_range : t -> string -> unit [@@js.set "content-range"]

    val get_content_type : t -> string [@@js.get "content-type"]

    val set_content_type : t -> string -> unit [@@js.set "content-type"]

    val get_cookie : t -> string [@@js.get "cookie"]

    val set_cookie : t -> string -> unit [@@js.set "cookie"]

    val get_date : t -> string [@@js.get "date"]

    val set_date : t -> string -> unit [@@js.set "date"]

    val get_expect : t -> string [@@js.get "expect"]

    val set_expect : t -> string -> unit [@@js.set "expect"]

    val get_expires : t -> string [@@js.get "expires"]

    val set_expires : t -> string -> unit [@@js.set "expires"]

    val get_forwarded : t -> string [@@js.get "forwarded"]

    val set_forwarded : t -> string -> unit [@@js.set "forwarded"]

    val get_from : t -> string [@@js.get "from"]

    val set_from : t -> string -> unit [@@js.set "from"]

    val get_host : t -> string [@@js.get "host"]

    val set_host : t -> string -> unit [@@js.set "host"]

    val get_if_match : t -> string [@@js.get "if-match"]

    val set_if_match : t -> string -> unit [@@js.set "if-match"]

    val get_if_modified_since : t -> string [@@js.get "if-modified-since"]

    val set_if_modified_since : t -> string -> unit
      [@@js.set "if-modified-since"]

    val get_if_none_match : t -> string [@@js.get "if-none-match"]

    val set_if_none_match : t -> string -> unit [@@js.set "if-none-match"]

    val get_if_unmodified_since : t -> string [@@js.get "if-unmodified-since"]

    val set_if_unmodified_since : t -> string -> unit
      [@@js.set "if-unmodified-since"]

    val get_last_modified : t -> string [@@js.get "last-modified"]

    val set_last_modified : t -> string -> unit [@@js.set "last-modified"]

    val get_location : t -> string [@@js.get "location"]

    val set_location : t -> string -> unit [@@js.set "location"]

    val get_origin : t -> string [@@js.get "origin"]

    val set_origin : t -> string -> unit [@@js.set "origin"]

    val get_pragma : t -> string [@@js.get "pragma"]

    val set_pragma : t -> string -> unit [@@js.set "pragma"]

    val get_proxy_authenticate : t -> string [@@js.get "proxy-authenticate"]

    val set_proxy_authenticate : t -> string -> unit
      [@@js.set "proxy-authenticate"]

    val get_proxy_authorization : t -> string [@@js.get "proxy-authorization"]

    val set_proxy_authorization : t -> string -> unit
      [@@js.set "proxy-authorization"]

    val get_public_key_pins : t -> string [@@js.get "public-key-pins"]

    val set_public_key_pins : t -> string -> unit [@@js.set "public-key-pins"]

    val get_range : t -> string [@@js.get "range"]

    val set_range : t -> string -> unit [@@js.set "range"]

    val get_referer : t -> string [@@js.get "referer"]

    val set_referer : t -> string -> unit [@@js.set "referer"]

    val get_retry_after : t -> string [@@js.get "retry-after"]

    val set_retry_after : t -> string -> unit [@@js.set "retry-after"]

    val get_sec_websocket_accept : t -> string [@@js.get "sec-websocket-accept"]

    val set_sec_websocket_accept : t -> string -> unit
      [@@js.set "sec-websocket-accept"]

    val get_sec_websocket_extensions : t -> string
      [@@js.get "sec-websocket-extensions"]

    val set_sec_websocket_extensions : t -> string -> unit
      [@@js.set "sec-websocket-extensions"]

    val get_sec_websocket_key : t -> string [@@js.get "sec-websocket-key"]

    val set_sec_websocket_key : t -> string -> unit
      [@@js.set "sec-websocket-key"]

    val get_sec_websocket_protocol : t -> string
      [@@js.get "sec-websocket-protocol"]

    val set_sec_websocket_protocol : t -> string -> unit
      [@@js.set "sec-websocket-protocol"]

    val get_sec_websocket_version : t -> string
      [@@js.get "sec-websocket-version"]

    val set_sec_websocket_version : t -> string -> unit
      [@@js.set "sec-websocket-version"]

    val get_set_cookie : t -> string list [@@js.get "set-cookie"]

    val set_set_cookie : t -> string list -> unit [@@js.set "set-cookie"]

    val get_strict_transport_security : t -> string
      [@@js.get "strict-transport-security"]

    val set_strict_transport_security : t -> string -> unit
      [@@js.set "strict-transport-security"]

    val get_tk : t -> string [@@js.get "tk"]

    val set_tk : t -> string -> unit [@@js.set "tk"]

    val get_trailer : t -> string [@@js.get "trailer"]

    val set_trailer : t -> string -> unit [@@js.set "trailer"]

    val get_transfer_encoding : t -> string [@@js.get "transfer-encoding"]

    val set_transfer_encoding : t -> string -> unit
      [@@js.set "transfer-encoding"]

    val get_upgrade : t -> string [@@js.get "upgrade"]

    val set_upgrade : t -> string -> unit [@@js.set "upgrade"]

    val get_user_agent : t -> string [@@js.get "user-agent"]

    val set_user_agent : t -> string -> unit [@@js.set "user-agent"]

    val get_vary : t -> string [@@js.get "vary"]

    val set_vary : t -> string -> unit [@@js.set "vary"]

    val get_via : t -> string [@@js.get "via"]

    val set_via : t -> string -> unit [@@js.set "via"]

    val get_warning : t -> string [@@js.get "warning"]

    val set_warning : t -> string -> unit [@@js.set "warning"]

    val get_www_authenticate : t -> string [@@js.get "www-authenticate"]

    val set_www_authenticate : t -> string -> unit [@@js.set "www-authenticate"]
  end
  [@@js.scope "IncomingHttpHeaders"]

  module Outgoing_http_header : sig
    type t = string list or_number

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Outgoing_http_headers : sig
    type t = Outgoing_http_header.t Dict.t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Incoming_message : sig
    include module type of struct
      include Stream.Readable
    end

    val create : socket:Node_net.Net.Socket.t -> t [@@js.create]

    val get_aborted : t -> bool [@@js.get "aborted"]

    val set_aborted : t -> bool -> unit [@@js.set "aborted"]

    val get_http_version : t -> string [@@js.get "httpVersion"]

    val set_http_version : t -> string -> unit [@@js.set "httpVersion"]

    val get_http_version_major : t -> int [@@js.get "httpVersionMajor"]

    val set_http_version_major : t -> int -> unit [@@js.set "httpVersionMajor"]

    val get_http_version_minor : t -> int [@@js.get "httpVersionMinor"]

    val set_http_version_minor : t -> int -> unit [@@js.set "httpVersionMinor"]

    val get_complete : t -> bool [@@js.get "complete"]

    val set_complete : t -> bool -> unit [@@js.set "complete"]

    val get_connection : t -> Node_net.Net.Socket.t [@@js.get "connection"]

    val set_connection : t -> Node_net.Net.Socket.t -> unit
      [@@js.set "connection"]

    val get_socket : t -> Node_net.Net.Socket.t [@@js.get "socket"]

    val set_socket : t -> Node_net.Net.Socket.t -> unit [@@js.set "socket"]

    val get_headers : t -> Incoming_http_headers.t [@@js.get "headers"]

    val set_headers : t -> Incoming_http_headers.t -> unit [@@js.set "headers"]

    val get_raw_headers : t -> string list [@@js.get "rawHeaders"]

    val set_raw_headers : t -> string list -> unit [@@js.set "rawHeaders"]

    val get_trailers : t -> string Dict.t [@@js.get "trailers"]

    val set_trailers : t -> string Dict.t -> unit [@@js.set "trailers"]

    val get_raw_trailers : t -> string list [@@js.get "rawTrailers"]

    val set_raw_trailers : t -> string list -> unit [@@js.set "rawTrailers"]

    val set_timeout : t -> msecs:int -> ?callback:(unit -> unit) -> unit -> t
      [@@js.call "setTimeout"]

    val get_method : t -> string [@@js.get "method"]

    val set_method : t -> string -> unit [@@js.set "method"]

    val get_url : t -> string [@@js.get "url"]

    val set_url : t -> string -> unit [@@js.set "url"]

    val get_status_code : t -> int [@@js.get "statusCode"]

    val set_status_code : t -> int -> unit [@@js.set "statusCode"]

    val get_status_message : t -> string [@@js.get "statusMessage"]

    val set_status_message : t -> string -> unit [@@js.set "statusMessage"]

    val destroy : t -> ?error:Error.t -> unit -> unit [@@js.call "destroy"]
  end
  [@@js.scope "IncomingMessage"]

  module Server_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_incoming_message :
      t -> (* FIXME: unknown type 'typeof IncomingMessage' *) any
      [@@js.get "IncomingMessage"]

    val set_incoming_message :
      t -> (* FIXME: unknown type 'typeof IncomingMessage' *) any -> unit
      [@@js.set "IncomingMessage"]

    val get_server_response :
      t -> (* FIXME: unknown type 'typeof ServerResponse' *) any
      [@@js.get "ServerResponse"]

    val set_server_response :
      t -> (* FIXME: unknown type 'typeof ServerResponse' *) any -> unit
      [@@js.set "ServerResponse"]

    val get_max_header_size : t -> int [@@js.get "maxHeaderSize"]

    val set_max_header_size : t -> int -> unit [@@js.set "maxHeaderSize"]

    val get_insecure_http_parser : t -> bool [@@js.get "insecureHTTPParser"]

    val set_insecure_http_parser : t -> bool -> unit
      [@@js.set "insecureHTTPParser"]
  end
  [@@js.scope "ServerOptions"]

  module Http_base : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val set_timeout : t -> ?msecs:int -> ?callback:(unit -> unit) -> unit -> t
      [@@js.call "setTimeout"]

    val set_timeout' : t -> callback:(unit -> unit) -> t
      [@@js.call "setTimeout"]

    val get_max_headers_count : t -> int or_null [@@js.get "maxHeadersCount"]

    val set_max_headers_count : t -> int or_null -> unit
      [@@js.set "maxHeadersCount"]

    val get_timeout : t -> int [@@js.get "timeout"]

    val set_timeout : t -> int -> unit [@@js.set "timeout"]

    val get_headers_timeout : t -> int [@@js.get "headersTimeout"]

    val set_headers_timeout : t -> int -> unit [@@js.set "headersTimeout"]

    val get_keep_alive_timeout : t -> int [@@js.get "keepAliveTimeout"]

    val set_keep_alive_timeout : t -> int -> unit [@@js.set "keepAliveTimeout"]

    val get_request_timeout : t -> int [@@js.get "requestTimeout"]

    val set_request_timeout : t -> int -> unit [@@js.set "requestTimeout"]
  end
  [@@js.scope "HttpBase"]

  module Outgoing_message : sig
    include module type of struct
      include Stream.Writable
    end

    val get_upgrading : t -> bool [@@js.get "upgrading"]

    val set_upgrading : t -> bool -> unit [@@js.set "upgrading"]

    val get_chunked_encoding : t -> bool [@@js.get "chunkedEncoding"]

    val set_chunked_encoding : t -> bool -> unit [@@js.set "chunkedEncoding"]

    val get_should_keep_alive : t -> bool [@@js.get "shouldKeepAlive"]

    val set_should_keep_alive : t -> bool -> unit [@@js.set "shouldKeepAlive"]

    val get_use_chunked_encoding_by_default : t -> bool
      [@@js.get "useChunkedEncodingByDefault"]

    val set_use_chunked_encoding_by_default : t -> bool -> unit
      [@@js.set "useChunkedEncodingByDefault"]

    val get_send_date : t -> bool [@@js.get "sendDate"]

    val set_send_date : t -> bool -> unit [@@js.set "sendDate"]

    val get_finished : t -> bool [@@js.get "finished"]

    val set_finished : t -> bool -> unit [@@js.set "finished"]

    val get_headers_sent : t -> bool [@@js.get "headersSent"]

    val set_headers_sent : t -> bool -> unit [@@js.set "headersSent"]

    val get_connection : t -> Node_net.Net.Socket.t or_null
      [@@js.get "connection"]

    val set_connection : t -> Node_net.Net.Socket.t or_null -> unit
      [@@js.set "connection"]

    val get_socket : t -> Node_net.Net.Socket.t or_null [@@js.get "socket"]

    val set_socket : t -> Node_net.Net.Socket.t or_null -> unit
      [@@js.set "socket"]

    val create : unit -> t [@@js.create]

    val set_timeout : t -> msecs:int -> ?callback:(unit -> unit) -> unit -> t
      [@@js.call "setTimeout"]

    val set_header : t -> name:string -> value:string list or_number -> unit
      [@@js.call "setHeader"]

    val get_header : t -> name:string -> string list or_number or_undefined
      [@@js.call "getHeader"]

    val get_headers : t -> Outgoing_http_headers.t [@@js.call "getHeaders"]

    val get_header_names : t -> string list [@@js.call "getHeaderNames"]

    val has_header : t -> name:string -> bool [@@js.call "hasHeader"]

    val remove_header : t -> name:string -> unit [@@js.call "removeHeader"]

    val add_trailers :
         t
      -> headers:(Outgoing_http_headers.t, (string * string) list) union2
      -> unit
      [@@js.call "addTrailers"]

    val flush_headers : t -> unit [@@js.call "flushHeaders"]
  end
  [@@js.scope "OutgoingMessage"]

  module Server_response : sig
    include module type of struct
      include Outgoing_message
    end

    val get_status_code : t -> int [@@js.get "statusCode"]

    val set_status_code : t -> int -> unit [@@js.set "statusCode"]

    val get_status_message : t -> string [@@js.get "statusMessage"]

    val set_status_message : t -> string -> unit [@@js.set "statusMessage"]

    val create : req:Incoming_message.t -> t [@@js.create]

    val assign_socket : t -> socket:Node_net.Net.Socket.t -> unit
      [@@js.call "assignSocket"]

    val detach_socket : t -> socket:Node_net.Net.Socket.t -> unit
      [@@js.call "detachSocket"]

    val write_continue : t -> ?callback:(unit -> unit) -> unit -> unit
      [@@js.call "writeContinue"]

    val write_head :
         t
      -> status_code:int
      -> ?reason_phrase:string
      -> ?headers:(Outgoing_http_headers.t, Outgoing_http_header.t) or_array
      -> unit
      -> t
      [@@js.call "writeHead"]

    val write_head' :
         t
      -> status_code:int
      -> ?headers:(Outgoing_http_headers.t, Outgoing_http_header.t) or_array
      -> unit
      -> t
      [@@js.call "writeHead"]

    val write_processing : t -> unit [@@js.call "writeProcessing"]
  end
  [@@js.scope "ServerResponse"]

  module Request_listener : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val apply : t -> req:Incoming_message.t -> res:Server_response.t -> unit
      [@@js.apply]
  end
  [@@js.scope "RequestListener"]

  module Server : sig
    include module type of struct
      include Http_base
    end

    include module type of struct
      include Node_net.Net.Server
    end

    val create : ?request_listener:Request_listener.t -> unit -> t [@@js.create]

    val create' :
         options:Server_options.t
      -> ?request_listener:Request_listener.t
      -> unit
      -> t
      [@@js.create]
  end
  [@@js.scope "Server"]

  module Information_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_status_code : t -> int [@@js.get "statusCode"]

    val set_status_code : t -> int -> unit [@@js.set "statusCode"]

    val get_status_message : t -> string [@@js.get "statusMessage"]

    val set_status_message : t -> string -> unit [@@js.set "statusMessage"]

    val get_http_version : t -> string [@@js.get "httpVersion"]

    val set_http_version : t -> string -> unit [@@js.set "httpVersion"]

    val get_http_version_major : t -> int [@@js.get "httpVersionMajor"]

    val set_http_version_major : t -> int -> unit [@@js.set "httpVersionMajor"]

    val get_http_version_minor : t -> int [@@js.get "httpVersionMinor"]

    val set_http_version_minor : t -> int -> unit [@@js.set "httpVersionMinor"]

    val get_headers : t -> Incoming_http_headers.t [@@js.get "headers"]

    val set_headers : t -> Incoming_http_headers.t -> unit [@@js.set "headers"]

    val get_raw_headers : t -> string list [@@js.get "rawHeaders"]

    val set_raw_headers : t -> string list -> unit [@@js.set "rawHeaders"]
  end
  [@@js.scope "InformationEvent"]

  module Agent_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_keep_alive : t -> bool [@@js.get "keepAlive"]

    val set_keep_alive : t -> bool -> unit [@@js.set "keepAlive"]

    val get_keep_alive_msecs : t -> int [@@js.get "keepAliveMsecs"]

    val set_keep_alive_msecs : t -> int -> unit [@@js.set "keepAliveMsecs"]

    val get_max_sockets : t -> int [@@js.get "maxSockets"]

    val set_max_sockets : t -> int -> unit [@@js.set "maxSockets"]

    val get_max_total_sockets : t -> int [@@js.get "maxTotalSockets"]

    val set_max_total_sockets : t -> int -> unit [@@js.set "maxTotalSockets"]

    val get_max_free_sockets : t -> int [@@js.get "maxFreeSockets"]

    val set_max_free_sockets : t -> int -> unit [@@js.set "maxFreeSockets"]

    val get_timeout : t -> int [@@js.get "timeout"]

    val set_timeout : t -> int -> unit [@@js.set "timeout"]

    val get_scheduling :
      t -> ([ `fifo [@js "fifo"] | `lifo [@js "lifo"] ][@js.enum])
      [@@js.get "scheduling"]

    val set_scheduling : t -> ([ `fifo | `lifo ][@js.enum]) -> unit
      [@@js.set "scheduling"]
  end
  [@@js.scope "AgentOptions"]

  module Agent : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_max_free_sockets : t -> int [@@js.get "maxFreeSockets"]

    val set_max_free_sockets : t -> int -> unit [@@js.set "maxFreeSockets"]

    val get_max_sockets : t -> int [@@js.get "maxSockets"]

    val set_max_sockets : t -> int -> unit [@@js.set "maxSockets"]

    val get_max_total_sockets : t -> int [@@js.get "maxTotalSockets"]

    val set_max_total_sockets : t -> int -> unit [@@js.set "maxTotalSockets"]

    val get_free_sockets : t -> Node_net.Net.Socket.t list Read_only_dict.t
      [@@js.get "freeSockets"]

    val get_sockets : t -> Node_net.Net.Socket.t list Read_only_dict.t
      [@@js.get "sockets"]

    val get_requests : t -> Incoming_message.t list Read_only_dict.t
      [@@js.get "requests"]

    val create : ?opts:Agent_options.t -> unit -> t [@@js.create]

    val destroy : t -> unit [@@js.call "destroy"]
  end
  [@@js.scope "Agent"]

  module Client_request_args : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_protocol : t -> string or_null [@@js.get "protocol"]

    val set_protocol : t -> string or_null -> unit [@@js.set "protocol"]

    val get_host : t -> string or_null [@@js.get "host"]

    val set_host : t -> string or_null -> unit [@@js.set "host"]

    val get_hostname : t -> string or_null [@@js.get "hostname"]

    val set_hostname : t -> string or_null -> unit [@@js.set "hostname"]

    val get_family : t -> int [@@js.get "family"]

    val set_family : t -> int -> unit [@@js.set "family"]

    val get_port : t -> string or_number or_null [@@js.get "port"]

    val set_port : t -> string or_number or_null -> unit [@@js.set "port"]

    val get_default_port : t -> string or_number [@@js.get "defaultPort"]

    val set_default_port : t -> string or_number -> unit
      [@@js.set "defaultPort"]

    val get_local_address : t -> string [@@js.get "localAddress"]

    val set_local_address : t -> string -> unit [@@js.set "localAddress"]

    val get_socket_path : t -> string [@@js.get "socketPath"]

    val set_socket_path : t -> string -> unit [@@js.set "socketPath"]

    val get_max_header_size : t -> int [@@js.get "maxHeaderSize"]

    val set_max_header_size : t -> int -> unit [@@js.set "maxHeaderSize"]

    val get_method : t -> string [@@js.get "method"]

    val set_method : t -> string -> unit [@@js.set "method"]

    val get_path : t -> string or_null [@@js.get "path"]

    val set_path : t -> string or_null -> unit [@@js.set "path"]

    val get_headers : t -> Outgoing_http_headers.t [@@js.get "headers"]

    val set_headers : t -> Outgoing_http_headers.t -> unit [@@js.set "headers"]

    val get_auth : t -> string or_null [@@js.get "auth"]

    val set_auth : t -> string or_null -> unit [@@js.set "auth"]

    val get_agent : t -> Agent.t or_boolean [@@js.get "agent"]

    val set_agent : t -> Agent.t or_boolean -> unit [@@js.set "agent"]

    val get_default_agent : t -> Agent.t [@@js.get "_defaultAgent"]

    val set_default_agent : t -> Agent.t -> unit [@@js.set "_defaultAgent"]

    val get_timeout : t -> int [@@js.get "timeout"]

    val set_timeout : t -> int -> unit [@@js.set "timeout"]

    val get_set_host : t -> bool [@@js.get "setHost"]

    val set_set_host : t -> bool -> unit [@@js.set "setHost"]

    val create_connection :
         t
      -> options:t
      -> oncreate:(err:Error.t -> socket:Node_net.Net.Socket.t -> unit)
      -> Node_net.Net.Socket.t
      [@@js.call "createConnection"]
  end
  [@@js.scope "ClientRequestArgs"]

  val methods : string list [@@js.global "METHODS"]

  val status_codes : Anonymous_interface0.t [@@js.global "STATUS_CODES"]

  val create_server : ?request_listener:Request_listener.t -> unit -> Server.t
    [@@js.global "createServer"]

  val create_server :
       options:Server_options.t
    -> ?request_listener:Request_listener.t
    -> unit
    -> Server.t
    [@@js.global "createServer"]

  module Request_options : sig
    include module type of struct
      include Client_request_args
    end
  end

  module Client_request : sig
    include module type of struct
      include Outgoing_message
    end

    val get_aborted : t -> bool [@@js.get "aborted"]

    val set_aborted : t -> bool -> unit [@@js.set "aborted"]

    val get_host : t -> string [@@js.get "host"]

    val set_host : t -> string -> unit [@@js.set "host"]

    val get_protocol : t -> string [@@js.get "protocol"]

    val set_protocol : t -> string -> unit [@@js.set "protocol"]

    val create :
         url:(Client_request_args.t, Node_url.Url.Url.t) union2 or_string
      -> ?cb:(res:Incoming_message.t -> unit)
      -> unit
      -> t
      [@@js.create]

    val get_method : t -> string [@@js.get "method"]

    val set_method : t -> string -> unit [@@js.set "method"]

    val get_path : t -> string [@@js.get "path"]

    val set_path : t -> string -> unit [@@js.set "path"]

    val abort : t -> unit [@@js.call "abort"]

    val on_socket : t -> socket:Node_net.Net.Socket.t -> unit
      [@@js.call "onSocket"]

    val set_timeout : t -> timeout:int -> ?callback:(unit -> unit) -> unit -> t
      [@@js.call "setTimeout"]

    val set_no_delay : t -> ?no_delay:bool -> unit -> unit
      [@@js.call "setNoDelay"]

    val set_socket_keep_alive :
      t -> ?enable:bool -> ?initial_delay:int -> unit -> unit
      [@@js.call "setSocketKeepAlive"]

    module Abort_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Connect_listener : sig
      type t =
           response:Incoming_message.t
        -> socket:Node_net.Net.Socket.t
        -> head:Buffer.t
        -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Continue_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Information_listener : sig
      type t = info:Information_event.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Response_listener : sig
      type t = response:Incoming_message.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Socket_listener : sig
      type t = socket:Node_net.Net.Socket.t -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Timeout_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Upgrade_listener : sig
      type t =
           response:Incoming_message.t
        -> socket:Node_net.Net.Socket.t
        -> head:Buffer.t
        -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Close_listener : sig
      type t = unit -> unit

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t
    end

    module Drain_listener : sig
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

    type listener =
      ([ `Abort of Abort_listener.t
       | `Connect of Connect_listener.t
       | `Continue of Continue_listener.t
       | `Information of Information_listener.t
       | `Response of Response_listener.t
       | `Socket of Socket_listener.t
       | `Timeout of Timeout_listener.t
       | `Upgrade of Upgrade_listener.t
       | `Close of Close_listener.t
       | `Drain of Drain_listener.t
       | `Error of Error_listener.t
       | `Finish of Finish_listener.t
       | `Pipe of Pipe_listener.t
       | `Unpipe of Unpipe_listener.t
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
      | `Abort f -> fn t "abort" @@ [%js.of: Abort_listener.t] f
      | `Connect f -> fn t "connect" @@ [%js.of: Connect_listener.t] f
      | `Continue f -> fn t "continue" @@ [%js.of: Continue_listener.t] f
      | `Information f ->
        fn t "information" @@ [%js.of: Information_listener.t] f
      | `Response f -> fn t "response" @@ [%js.of: Response_listener.t] f
      | `Socket f -> fn t "socket" @@ [%js.of: Socket_listener.t] f
      | `Timeout f -> fn t "timeout" @@ [%js.of: Timeout_listener.t] f
      | `Upgrade f -> fn t "upgrade" @@ [%js.of: Upgrade_listener.t] f
      | `Close f -> fn t "close" @@ [%js.of: Close_listener.t] f
      | `Drain f -> fn t "drain" @@ [%js.of: Drain_listener.t] f
      | `Error f -> fn t "error" @@ [%js.of: Error_listener.t] f
      | `Finish f -> fn t "finish" @@ [%js.of: Finish_listener.t] f
      | `Pipe f -> fn t "pipe" @@ [%js.of: Pipe_listener.t] f
      | `Unpipe f -> fn t "unpipe" @@ [%js.of: Unpipe_listener.t] f

    let on = with_listener_fn on

    let add_listener = with_listener_fn add_listener

    let once = with_listener_fn once

    let prepend_listener = with_listener_fn prepend_listener

    let prepend_once_listener = with_listener_fn prepend_once_listener]
  end
  [@@js.scope "ClientRequest"]

  val request :
       options:(Request_options.t, Node_url.Url.Url.t) union2 or_string
    -> ?callback:(res:Incoming_message.t -> unit)
    -> unit
    -> Client_request.t
    [@@js.global "request"]

  val request :
       url:Node_url.Url.Url.t or_string
    -> options:Request_options.t
    -> ?callback:(res:Incoming_message.t -> unit)
    -> unit
    -> Client_request.t
    [@@js.global "request"]

  val get_ :
       options:(Request_options.t, Node_url.Url.Url.t) union2 or_string
    -> ?callback:(res:Incoming_message.t -> unit)
    -> unit
    -> Client_request.t
    [@@js.global "get"]

  val get_ :
       url:Node_url.Url.Url.t or_string
    -> options:Request_options.t
    -> ?callback:(res:Incoming_message.t -> unit)
    -> unit
    -> Client_request.t
    [@@js.global "get"]

  val global_agent : Agent.t [@@js.global "globalAgent"]

  val max_header_size : int [@@js.global "maxHeaderSize"]
end
[@@js.scope Import.http]
