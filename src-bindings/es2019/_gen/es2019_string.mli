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
    type _String = [`String] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
  end
end

open Internal
open AnonymousInterfaces
open Types
module[@js.scope "String"] String : sig
  type t = _String
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val trimEnd: t -> string [@@js.call "trimEnd"]
  val trimStart: t -> string [@@js.call "trimStart"]
  val trimLeft: t -> string [@@js.call "trimLeft"]
  val trimRight: t -> string [@@js.call "trimRight"]
  val to_ml: t -> string [@@js.cast]
  val of_ml: string -> t [@@js.cast]
end
