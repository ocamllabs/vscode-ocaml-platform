[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - SignalConstants
 *)
[@@@js.stop]
module type Missing = sig
  module SignalConstants : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module SignalConstants : sig
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
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "node:constants"] Node_constants : sig
    (* import exp = require('constants'); *)
    
  end
  module[@js.scope "constants"] Constants : sig
    (* import { constants as osConstants, SignalConstants } from 'node:os'; *)
    (* import { constants as cryptoConstants } from 'node:crypto'; *)
    (* import { constants as fsConstants } from 'node:fs'; *)
    val exp: ((* FIXME: unknown type 'typeof osConstants.errno' *)any, (* FIXME: unknown type 'typeof osConstants.priority' *)any, SignalConstants.t_0, (* FIXME: unknown type 'typeof cryptoConstants' *)any, (* FIXME: unknown type 'typeof fsConstants' *)any) intersection5 [@@js.global "exp"]
    
  end
end
