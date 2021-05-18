[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib

module Internal : sig
  module AnonymousInterfaces : sig
    type anonymous_interface_0 = [`anonymous_interface_0] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
  end
  module Types : sig
    open AnonymousInterfaces
    type _RegExp = regexp
    and _RegExpExecArray = [`RegExpExecArray] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and _RegExpMatchArray = [`RegExpMatchArray] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
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
  val get: t -> string -> string [@@js.index_get]
  val set: t -> string -> string -> unit [@@js.index_set]
end
module[@js.scope "RegExpMatchArray"] RegExpMatchArray : sig
  type t = _RegExpMatchArray
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_groups: t -> anonymous_interface_0 [@@js.get "groups"]
  val set_groups: t -> anonymous_interface_0 -> unit [@@js.set "groups"]
end
module[@js.scope "RegExpExecArray"] RegExpExecArray : sig
  type t = _RegExpExecArray
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_groups: t -> anonymous_interface_0 [@@js.get "groups"]
  val set_groups: t -> anonymous_interface_0 -> unit [@@js.set "groups"]
end
module[@js.scope "RegExp"] RegExp : sig
  type t = _RegExp
  val t_to_js: t -> Ojs.t
  val t_of_js: Ojs.t -> t
  type t_0 = t
  val t_0_to_js: t_0 -> Ojs.t
  val t_0_of_js: Ojs.t -> t_0
  val get_dotAll: t -> bool [@@js.get "dotAll"]
end
