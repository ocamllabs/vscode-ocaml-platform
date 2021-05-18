[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - URL
  - http.Agent
  - http.AgentOptions
  - http.ClientRequest
  - http.HttpBase
  - http.IncomingMessage
  - http.RequestListener
  - http.RequestOptions
  - http.ServerOptions
  - tls.ConnectionOptions
  - tls.SecureContextOptions
  - tls.Server
  - tls.TlsOptions
 *)
[@@@js.stop]
module type Missing = sig
  module URL : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module http : sig
    module Agent : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module AgentOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ClientRequest : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module HttpBase : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module IncomingMessage : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module RequestListener : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module RequestOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ServerOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
  end
  module tls : sig
    module ConnectionOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module SecureContextOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Server : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module TlsOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module URL : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module http : sig
      module Agent : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module AgentOptions : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module ClientRequest : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module HttpBase : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module IncomingMessage : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module RequestListener : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module RequestOptions : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module ServerOptions : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
    end
    module tls : sig
      module ConnectionOptions : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module SecureContextOptions : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module Server : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module TlsOptions : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
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
      type https_Agent = [`Https_Agent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and https_AgentOptions = [`Https_AgentOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and https_RequestOptions = (Http.RequestOptions.t_0, Tls.SecureContextOptions.t_0, anonymous_interface_0) intersection3
      and https_Server = [`Https_Server] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and https_Server = [`Https_Server] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and https_ServerOptions = (Tls.SecureContextOptions.t_0, Tls.TlsOptions.t_0, Http.ServerOptions.t_0) intersection3
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
    val get_rejectUnauthorized: t -> bool [@@js.get "rejectUnauthorized"]
    val set_rejectUnauthorized: t -> bool -> unit [@@js.set "rejectUnauthorized"]
    val get_servername: t -> string [@@js.get "servername"]
    val set_servername: t -> string -> unit [@@js.set "servername"]
  end
  module[@js.scope "node:https"] Node_https : sig
    (* export * from 'https'; *)
  end
  module[@js.scope "https"] Https : sig
    (* import * as tls from 'node:tls'; *)
    (* import * as http from 'node:http'; *)
    (* import { URL } from 'node:url'; *)
    module ServerOptions : sig
      type t = https_ServerOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module RequestOptions : sig
      type t = https_RequestOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "AgentOptions"] AgentOptions : sig
      type t = https_AgentOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_rejectUnauthorized: t -> bool [@@js.get "rejectUnauthorized"]
      val set_rejectUnauthorized: t -> bool -> unit [@@js.set "rejectUnauthorized"]
      val get_maxCachedSessions: t -> float [@@js.get "maxCachedSessions"]
      val set_maxCachedSessions: t -> float -> unit [@@js.set "maxCachedSessions"]
      val cast: t -> Http.AgentOptions.t_0 [@@js.cast]
      val cast': t -> Tls.ConnectionOptions.t_0 [@@js.cast]
    end
    module[@js.scope "Agent"] Agent : sig
      type t = https_Agent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: ?options:https_AgentOptions -> unit -> t [@@js.create]
      val get_options: t -> https_AgentOptions [@@js.get "options"]
      val set_options: t -> https_AgentOptions -> unit [@@js.set "options"]
      val cast: t -> Http.Agent.t_0 [@@js.cast]
    end
    module[@js.scope "Server"] Server : sig
      type t = https_Server
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val cast: t -> Http.HttpBase.t_0 [@@js.cast]
    end
    module[@js.scope "Server"] Server : sig
      type t = https_Server
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: ?requestListener:Http.RequestListener.t_0 -> unit -> t [@@js.create]
      val create': options:https_ServerOptions -> ?requestListener:Http.RequestListener.t_0 -> unit -> t [@@js.create]
      val cast: t -> Tls.Server.t_0 [@@js.cast]
    end
    val createServer: ?requestListener:Http.RequestListener.t_0 -> unit -> https_Server [@@js.global "createServer"]
    val createServer: options:https_ServerOptions -> ?requestListener:Http.RequestListener.t_0 -> unit -> https_Server [@@js.global "createServer"]
    val request: options:(https_RequestOptions, URL.t_0) union2 or_string -> ?callback:(res:Http.IncomingMessage.t_0 -> unit) -> unit -> Http.ClientRequest.t_0 [@@js.global "request"]
    val request: url:URL.t_0 or_string -> options:https_RequestOptions -> ?callback:(res:Http.IncomingMessage.t_0 -> unit) -> unit -> Http.ClientRequest.t_0 [@@js.global "request"]
    val get_: options:(https_RequestOptions, URL.t_0) union2 or_string -> ?callback:(res:Http.IncomingMessage.t_0 -> unit) -> unit -> Http.ClientRequest.t_0 [@@js.global "get"]
    val get_: url:URL.t_0 or_string -> options:https_RequestOptions -> ?callback:(res:Http.IncomingMessage.t_0 -> unit) -> unit -> Http.ClientRequest.t_0 [@@js.global "get"]
    val globalAgent: https_Agent [@@js.global "globalAgent"]
  end
end
