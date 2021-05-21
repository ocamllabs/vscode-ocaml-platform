[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2017

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get : t -> string -> string [@@js.index_get]

  val set : t -> string -> string -> unit [@@js.index_set]
end

module Reg_exp_match_array : sig
  include module type of struct
    include Reg_exp_match_array
  end

  val get_groups : t -> Anonymous_interface0.t [@@js.get "groups"]

  val set_groups : t -> Anonymous_interface0.t -> unit [@@js.set "groups"]
end
[@@js.scope "RegExpMatchArray"]

module Reg_exp_exec_array : sig
  include module type of struct
    include Reg_exp_exec_array
  end

  val get_groups : t -> Anonymous_interface0.t [@@js.get "groups"]

  val set_groups : t -> Anonymous_interface0.t -> unit [@@js.set "groups"]
end
[@@js.scope "RegExpExecArray"]

module Reg_exp : sig
  include module type of struct
    include Reg_exp
  end

  val get_dot_all : t -> bool [@@js.get "dotAll"]
end
[@@js.scope "RegExp"]
