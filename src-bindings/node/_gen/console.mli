[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - InspectOptions
  - WritableStream
 *)
[@@@js.stop]
module type Missing = sig
  module InspectOptions : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module WritableStream : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module InspectOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module WritableStream : sig
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
      type console_global_Console = [`Console_global_Console] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and console_global_NodeJS_ConsoleConstructor = [`Console_global_NodeJS_ConsoleConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and console_global_NodeJS_ConsoleConstructorOptions = [`Console_global_NodeJS_ConsoleConstructorOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and console_global_NodeJS_Global = [`Console_global_NodeJS_Global] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "node:console"] Node_console : sig
    
  end
  module[@js.scope "console"] Console : sig
    (* import { InspectOptions } from 'node:util'; *)
    module[@js.scope "global"] Global : sig
      module[@js.scope "Console"] Console : sig
        type t = console_global_Console
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_Console: t -> console_global_NodeJS_ConsoleConstructor [@@js.get "Console"]
        val set_Console: t -> console_global_NodeJS_ConsoleConstructor -> unit [@@js.set "Console"]
        val assert_: t -> value:any -> ?message:string -> optionalParams:(any list [@js.variadic]) -> unit [@@js.call "assert"]
        val clear: t -> unit [@@js.call "clear"]
        val count: t -> ?label:string -> unit -> unit [@@js.call "count"]
        val countReset: t -> ?label:string -> unit -> unit [@@js.call "countReset"]
        val debug: t -> ?message:any -> optionalParams:(any list [@js.variadic]) -> unit [@@js.call "debug"]
        val dir: t -> obj:any -> ?options:InspectOptions.t_0 -> unit -> unit [@@js.call "dir"]
        val dirxml: t -> data:(any list [@js.variadic]) -> unit [@@js.call "dirxml"]
        val error: t -> ?message:any -> optionalParams:(any list [@js.variadic]) -> unit [@@js.call "error"]
        val group: t -> label:(any list [@js.variadic]) -> unit [@@js.call "group"]
        val groupCollapsed: t -> label:(any list [@js.variadic]) -> unit [@@js.call "groupCollapsed"]
        val groupEnd: t -> unit [@@js.call "groupEnd"]
        val info: t -> ?message:any -> optionalParams:(any list [@js.variadic]) -> unit [@@js.call "info"]
        val log: t -> ?message:any -> optionalParams:(any list [@js.variadic]) -> unit [@@js.call "log"]
        val table: t -> tabularData:any -> ?properties:string list -> unit -> unit [@@js.call "table"]
        val time: t -> ?label:string -> unit -> unit [@@js.call "time"]
        val timeEnd: t -> ?label:string -> unit -> unit [@@js.call "timeEnd"]
        val timeLog: t -> ?label:string -> data:(any list [@js.variadic]) -> unit [@@js.call "timeLog"]
        val trace: t -> ?message:any -> optionalParams:(any list [@js.variadic]) -> unit [@@js.call "trace"]
        val warn: t -> ?message:any -> optionalParams:(any list [@js.variadic]) -> unit [@@js.call "warn"]
        val profile: t -> ?label:string -> unit -> unit [@@js.call "profile"]
        val profileEnd: t -> ?label:string -> unit -> unit [@@js.call "profileEnd"]
        val timeStamp: t -> ?label:string -> unit -> unit [@@js.call "timeStamp"]
      end
      val console: console_global_Console [@@js.global "console"]
      module[@js.scope "NodeJS"] NodeJS : sig
        module[@js.scope "ConsoleConstructorOptions"] ConsoleConstructorOptions : sig
          type t = console_global_NodeJS_ConsoleConstructorOptions
          val t_to_js: t -> Ojs.t
          val t_of_js: Ojs.t -> t
          type t_0 = t
          val t_0_to_js: t_0 -> Ojs.t
          val t_0_of_js: Ojs.t -> t_0
          val get_stdout: t -> WritableStream.t_0 [@@js.get "stdout"]
          val set_stdout: t -> WritableStream.t_0 -> unit [@@js.set "stdout"]
          val get_stderr: t -> WritableStream.t_0 [@@js.get "stderr"]
          val set_stderr: t -> WritableStream.t_0 -> unit [@@js.set "stderr"]
          val get_ignoreErrors: t -> bool [@@js.get "ignoreErrors"]
          val set_ignoreErrors: t -> bool -> unit [@@js.set "ignoreErrors"]
          val get_colorMode: t -> ([`L_s0_auto[@js "auto"]] [@js.enum]) or_boolean [@@js.get "colorMode"]
          val set_colorMode: t -> ([`L_s0_auto] [@js.enum]) or_boolean -> unit [@@js.set "colorMode"]
          val get_inspectOptions: t -> InspectOptions.t_0 [@@js.get "inspectOptions"]
          val set_inspectOptions: t -> InspectOptions.t_0 -> unit [@@js.set "inspectOptions"]
        end
        module[@js.scope "ConsoleConstructor"] ConsoleConstructor : sig
          type t = console_global_NodeJS_ConsoleConstructor
          val t_to_js: t -> Ojs.t
          val t_of_js: Ojs.t -> t
          type t_0 = t
          val t_0_to_js: t_0 -> Ojs.t
          val t_0_of_js: Ojs.t -> t_0
          val get_prototype: t -> console_global_Console [@@js.get "prototype"]
          val set_prototype: t -> console_global_Console -> unit [@@js.set "prototype"]
          val create: t -> stdout:WritableStream.t_0 -> ?stderr:WritableStream.t_0 -> ?ignoreErrors:bool -> unit -> console_global_Console [@@js.apply_newable]
          val create': t -> options:console_global_NodeJS_ConsoleConstructorOptions -> console_global_Console [@@js.apply_newable]
        end
        module[@js.scope "Global"] Global : sig
          type t = console_global_NodeJS_Global
          val t_to_js: t -> Ojs.t
          val t_of_js: Ojs.t -> t
          type t_0 = t
          val t_0_to_js: t_0 -> Ojs.t
          val t_0_of_js: Ojs.t -> t_0
          val get_console: t -> console_global_Console [@@js.get "console"]
          val set_console: t -> console_global_Console -> unit [@@js.set "console"]
        end
      end
    end
    
  end
end
