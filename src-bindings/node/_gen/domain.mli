[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - EventEmitter
  - NodeJS.Domain
  - NodeJS.Timer
  - Timer
 *)
[@@@js.stop]
module type Missing = sig
  module EventEmitter : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module NodeJS : sig
    module Domain : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Timer : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
  end
  module Timer : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module EventEmitter : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module NodeJS : sig
      module Domain : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module Timer : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
    end
    module Timer : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
  end
]
module Make (M: Missing) : sig
  open M
  module Internal : sig
    module AnonymousInterfaces : sig
      
    end
    module Types : sig
      open AnonymousInterfaces
      type domain_Domain = [`Domain_Domain] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and domain_Domain = [`Domain_Domain] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and domain_global_NodeJS_Domain = [`Domain_global_NodeJS_Domain] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "node:domain"] Node_domain : sig
    (* export * from 'domain'; *)
  end
  module[@js.scope "domain"] Domain : sig
    (* import EventEmitter = require('node:events'); *)
    module[@js.scope "global"] Global : sig
      module[@js.scope "NodeJS"] NodeJS : sig
        module[@js.scope "Domain"] Domain : sig
          type t = domain_global_NodeJS_Domain
          val t_to_js: t -> Ojs.t
          val t_of_js: Ojs.t -> t
          type t_0 = t
          val t_0_to_js: t_0 -> Ojs.t
          val t_0_of_js: Ojs.t -> t_0
          val run: t -> fn:(args:(any list [@js.variadic]) -> 'T) -> args:(any list [@js.variadic]) -> 'T [@@js.call "run"]
          val add: t -> emitter:(EventEmitter.t_0, Timer.t_0) union2 -> unit [@@js.call "add"]
          val remove: t -> emitter:(EventEmitter.t_0, Timer.t_0) union2 -> unit [@@js.call "remove"]
          val bind: t -> cb:'T -> 'T [@@js.call "bind"]
          val intercept: t -> cb:'T -> 'T [@@js.call "intercept"]
          val cast: t -> EventEmitter.t_0 [@@js.cast]
        end
      end
    end
    module[@js.scope "Domain"] Domain : sig
      type t = domain_Domain
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val cast: t -> NodeJS.Domain.t_0 [@@js.cast]
    end
    module[@js.scope "Domain"] Domain : sig
      type t = domain_Domain
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_members: t -> (EventEmitter.t_0, NodeJS.Timer.t_0) union2 list [@@js.get "members"]
      val set_members: t -> (EventEmitter.t_0, NodeJS.Timer.t_0) union2 list -> unit [@@js.set "members"]
      val enter: t -> unit [@@js.call "enter"]
      val exit: t -> unit [@@js.call "exit"]
      val cast: t -> EventEmitter.t_0 [@@js.cast]
    end
    val create_: unit -> domain_Domain [@@js.global "create"]
  end
end
