[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals
open Node_http
open Node_tls

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_reject_unauthorized : t -> bool [@@js.get "rejectUnauthorized"]

  val set_reject_unauthorized : t -> bool -> unit
    [@@js.set "rejectUnauthorized"]

  val get_servername : t -> string [@@js.get "servername"]

  val set_servername : t -> string -> unit [@@js.set "servername"]
end

module Https : sig
  open Node_tls
  open Node_http

  module Server_options : sig
    type t =
      ( Tls.Secure_context_options.t
      , Tls.Tls_options.t
      , Http.Server_options.t )
      intersection3

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Request_options : sig
    type t =
      ( Http.Request_options.t
      , Tls.Secure_context_options.t
      , Anonymous_interface0.t )
      intersection3

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Agent_options : sig
    include module type of struct
      include Http.Agent_options
    end

    val get_reject_unauthorized : t -> bool [@@js.get "rejectUnauthorized"]

    val set_reject_unauthorized : t -> bool -> unit
      [@@js.set "rejectUnauthorized"]

    val get_max_cached_sessions : t -> int [@@js.get "maxCachedSessions"]

    val set_max_cached_sessions : t -> int -> unit
      [@@js.set "maxCachedSessions"]

    val cast' : t -> Tls.Connection_options.t [@@js.cast]
  end
  [@@js.scope "AgentOptions"]

  module Agent : sig
    include module type of struct
      include Http.Agent
    end

    val create : ?options:Agent_options.t -> unit -> t [@@js.create]

    val get_options : t -> Agent_options.t [@@js.get "options"]

    val set_options : t -> Agent_options.t -> unit [@@js.set "options"]
  end
  [@@js.scope "Agent"]

  module Server : sig
    include module type of struct
      include Http.Http_base
    end

    include module type of struct
      include Tls.Server
    end

    val create : ?request_listener:Http.Request_listener.t -> unit -> t
      [@@js.create]

    val create' :
         options:Server_options.t
      -> ?request_listener:Http.Request_listener.t
      -> unit
      -> t
      [@@js.create]
  end
  [@@js.scope "Server"]

  val create_server :
       options:Server_options.t
    -> ?request_listener:Http.Request_listener.t
    -> unit
    -> Server.t
    [@@js.global "createServer"]

  val request :
       url:Node_url.Url.Url.t or_string
    -> ?options:Request_options.t
    -> ?callback:(res:Http.Incoming_message.t -> unit)
    -> unit
    -> Http.Client_request.t
    [@@js.global "request"]

  val get :
       url:Node_url.Url.Url.t or_string
    -> ?options:Request_options.t
    -> ?callback:(res:Http.Incoming_message.t -> unit)
    -> unit
    -> Http.Client_request.t
    [@@js.global "get"]

  val global_agent : Agent.t [@@js.global "globalAgent"]
end
[@@js.scope Import.https]
