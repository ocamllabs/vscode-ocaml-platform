[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - NodeJS.Immediate
  - NodeJS.Timeout
  - Promise<T1>
 *)
[@@@js.stop]
module type Missing = sig
  module NodeJS : sig
    module Immediate : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Timeout : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
  end
  module Promise : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module NodeJS : sig
      module Immediate : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module Timeout : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
    end
    module Promise : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
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
  module[@js.scope "node:timers"] Node_timers : sig
    (* export * from 'timers'; *)
  end
  module[@js.scope "timers"] Timers : sig
    val setTimeout: callback:(args:(any list [@js.variadic]) -> unit) -> ?ms:float -> args:(any list [@js.variadic]) -> NodeJS.Timeout.t_0 [@@js.global "setTimeout"]
    module[@js.scope "setTimeout"] SetTimeout : sig
      val __promisify__: ms:float -> unit Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: ms:float -> value:'T -> 'T Promise.t_1 [@@js.global "__promisify__"]
    end
    val clearTimeout: timeoutId:NodeJS.Timeout.t_0 -> unit [@@js.global "clearTimeout"]
    val setInterval: callback:(args:(any list [@js.variadic]) -> unit) -> ?ms:float -> args:(any list [@js.variadic]) -> NodeJS.Timeout.t_0 [@@js.global "setInterval"]
    val clearInterval: intervalId:NodeJS.Timeout.t_0 -> unit [@@js.global "clearInterval"]
    val setImmediate: callback:(args:(any list [@js.variadic]) -> unit) -> args:(any list [@js.variadic]) -> NodeJS.Immediate.t_0 [@@js.global "setImmediate"]
    module[@js.scope "setImmediate"] SetImmediate : sig
      val __promisify__: unit -> unit Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: value:'T -> 'T Promise.t_1 [@@js.global "__promisify__"]
    end
    val clearImmediate: immediateId:NodeJS.Immediate.t_0 -> unit [@@js.global "clearImmediate"]
  end
end
