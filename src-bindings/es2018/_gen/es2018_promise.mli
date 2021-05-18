[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib

module Internal : sig
  module AnonymousInterfaces : sig
    
  end
  module Types : sig
    open AnonymousInterfaces
    type 'T _Promise = [`Promise of 'T] intf
    [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
  end
end

open Internal
open AnonymousInterfaces
open Types
module[@js.scope "Promise"] Promise : sig
  type 'T t = 'T _Promise
  val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
  val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
  type 'T t_1 = 'T t
  val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
  val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
  val finally: 'T t -> ?onfinally:(unit -> unit) or_null_or_undefined -> unit -> 'T t [@@js.call "finally"]
end
