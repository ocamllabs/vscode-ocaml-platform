[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020

module Path : sig
  module Parsed_path : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val root : t -> string [@@js.get "root"]

    val set_root : t -> string -> unit [@@js.set "root"]

    val dir : t -> string [@@js.get "dir"]

    val set_dir : t -> string -> unit [@@js.set "dir"]

    val base : t -> string [@@js.get "base"]

    val set_base : t -> string -> unit [@@js.set "base"]

    val ext : t -> string [@@js.get "ext"]

    val set_ext : t -> string -> unit [@@js.set "ext"]

    val name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]
  end
  [@@js.scope "ParsedPath"]

  module Format_input_path_object : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val root : t -> string [@@js.get "root"]

    val set_root : t -> string -> unit [@@js.set "root"]

    val dir : t -> string [@@js.get "dir"]

    val set_dir : t -> string -> unit [@@js.set "dir"]

    val base : t -> string [@@js.get "base"]

    val set_base : t -> string -> unit [@@js.set "base"]

    val ext : t -> string [@@js.get "ext"]

    val set_ext : t -> string -> unit [@@js.set "ext"]

    val name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]
  end
  [@@js.scope "FormatInputPathObject"]

  module Platform_path : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val normalize : t -> string -> string [@@js.call "normalize"]

    val join : t -> (string list[@js.variadic]) -> string [@@js.call "join"]

    val resolve : t -> (string list[@js.variadic]) -> string
      [@@js.call "resolve"]

    val is_absolute : t -> string -> bool [@@js.call "isAbsolute"]

    val relative : t -> from:string -> to_:string -> string
      [@@js.call "relative"]

    val dirname : t -> string -> string [@@js.call "dirname"]

    val basename : t -> string -> ?ext:string -> unit -> string
      [@@js.call "basename"]

    val extname : t -> string -> string [@@js.call "extname"]

    val sep : t -> string [@@js.get "sep"]

    val delimiter : t -> string [@@js.get "delimiter"]

    val parse : t -> string -> Parsed_path.t [@@js.call "parse"]

    val format : t -> Format_input_path_object.t -> string [@@js.call "format"]

    val to_namespaced_path : t -> string -> string
      [@@js.call "toNamespacedPath"]

    val posix : t -> t [@@js.get "posix"]

    val win32 : t -> t [@@js.get "win32"]
  end
  [@@js.scope "PlatformPath"]

  val normalize : string -> string [@@js.global "normalize"]

  val join : (string list[@js.variadic]) -> string [@@js.global "join"]

  val resolve : (string list[@js.variadic]) -> string [@@js.global "resolve"]

  val is_absolute : string -> bool [@@js.global "isAbsolute"]

  val relative : from:string -> to_:string -> string [@@js.global "relative"]

  val dirname : string -> string [@@js.global "dirname"]

  val basename : string -> ?ext:string -> unit -> string
    [@@js.global "basename"]

  val extname : string -> string [@@js.global "extname"]

  val sep : string [@@js.global "sep"]

  val delimiter : string [@@js.global "delimiter"]

  val parse : string -> Parsed_path.t [@@js.global "parse"]

  val format : Format_input_path_object.t -> string [@@js.global "format"]

  val to_namespaced_path : string -> string [@@js.call "toNamespacedPath"]
end
[@@js.scope Import.path]
