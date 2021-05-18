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
    type path_path_FormatInputPathObject = [`Path_path_FormatInputPathObject] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and path_path_ParsedPath = [`Path_path_ParsedPath] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    and path_path_PlatformPath = [`Path_path_PlatformPath] intf
    [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
  end
end

open Internal
open AnonymousInterfaces
open Types
module[@js.scope "node:path"] Node_path : sig
  (* import path = require('path'); *)
  
end
module[@js.scope "path"] Path : sig
  module[@js.scope "path"] Path : sig
    module[@js.scope "ParsedPath"] ParsedPath : sig
      type t = path_path_ParsedPath
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_root: t -> string [@@js.get "root"]
      val set_root: t -> string -> unit [@@js.set "root"]
      val get_dir: t -> string [@@js.get "dir"]
      val set_dir: t -> string -> unit [@@js.set "dir"]
      val get_base: t -> string [@@js.get "base"]
      val set_base: t -> string -> unit [@@js.set "base"]
      val get_ext: t -> string [@@js.get "ext"]
      val set_ext: t -> string -> unit [@@js.set "ext"]
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
    end
    module[@js.scope "FormatInputPathObject"] FormatInputPathObject : sig
      type t = path_path_FormatInputPathObject
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_root: t -> string [@@js.get "root"]
      val set_root: t -> string -> unit [@@js.set "root"]
      val get_dir: t -> string [@@js.get "dir"]
      val set_dir: t -> string -> unit [@@js.set "dir"]
      val get_base: t -> string [@@js.get "base"]
      val set_base: t -> string -> unit [@@js.set "base"]
      val get_ext: t -> string [@@js.get "ext"]
      val set_ext: t -> string -> unit [@@js.set "ext"]
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
    end
    module[@js.scope "PlatformPath"] PlatformPath : sig
      type t = path_path_PlatformPath
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val normalize: t -> p:string -> string [@@js.call "normalize"]
      val join: t -> paths:(string list [@js.variadic]) -> string [@@js.call "join"]
      val resolve: t -> pathSegments:(string list [@js.variadic]) -> string [@@js.call "resolve"]
      val isAbsolute: t -> p:string -> bool [@@js.call "isAbsolute"]
      val relative: t -> from:string -> to_:string -> string [@@js.call "relative"]
      val dirname: t -> p:string -> string [@@js.call "dirname"]
      val basename: t -> p:string -> ?ext:string -> unit -> string [@@js.call "basename"]
      val extname: t -> p:string -> string [@@js.call "extname"]
      val get_sep: t -> string [@@js.get "sep"]
      val get_delimiter: t -> string [@@js.get "delimiter"]
      val parse: t -> p:string -> path_path_ParsedPath [@@js.call "parse"]
      val format: t -> pP:path_path_FormatInputPathObject -> string [@@js.call "format"]
      val toNamespacedPath: t -> path:string -> string [@@js.call "toNamespacedPath"]
      val get_posix: t -> t [@@js.get "posix"]
      val get_win32: t -> t [@@js.get "win32"]
    end
  end
  val path: path_path_PlatformPath [@@js.global "path"]
  
end
