[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - AsyncCompleter
  - Completer
  - Context
  - Error
  - InspectOptions
  - Interface
  - NodeJS.ReadOnlyDict<T1>
  - NodeJS.ReadableStream
  - NodeJS.WritableStream
  - SyntaxError
 *)
[@@@js.stop]
module type Missing = sig
  module AsyncCompleter : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Completer : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Context : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Error : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module InspectOptions : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Interface : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module NodeJS : sig
    module ReadOnlyDict : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module ReadableStream : sig
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
  module SyntaxError : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module AsyncCompleter : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Completer : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Context : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Error : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module InspectOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Interface : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module NodeJS : sig
      module ReadOnlyDict : sig
        type 'T1 t_1
        val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
        val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
      end
      module ReadableStream : sig
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
    module SyntaxError : sig
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
      type anonymous_interface_0 = [`anonymous_interface_0] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
    module Types : sig
      open AnonymousInterfaces
      type repl_REPLCommand = [`Repl_REPLCommand] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and repl_REPLCommandAction = [`Repl_REPLCommandAction] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and repl_REPLEval = [`Repl_REPLEval] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and repl_REPLServer = [`Repl_REPLServer] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and repl_REPLWriter = [`Repl_REPLWriter] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and repl_Recoverable = [`Repl_Recoverable] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and repl_ReplOptions = [`Repl_ReplOptions] intf
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
    val get_options: t -> InspectOptions.t_0 [@@js.get "options"]
    val set_options: t -> InspectOptions.t_0 -> unit [@@js.set "options"]
  end
  module[@js.scope "node:repl"] Node_repl : sig
    (* export * from 'repl'; *)
  end
  module[@js.scope "repl"] Repl : sig
    (* import { Interface, Completer, AsyncCompleter } from 'node:readline'; *)
    (* import { Context } from 'node:vm'; *)
    (* import { InspectOptions } from 'node:util'; *)
    module[@js.scope "ReplOptions"] ReplOptions : sig
      type t = repl_ReplOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_prompt: t -> string [@@js.get "prompt"]
      val set_prompt: t -> string -> unit [@@js.set "prompt"]
      val get_input: t -> NodeJS.ReadableStream.t_0 [@@js.get "input"]
      val set_input: t -> NodeJS.ReadableStream.t_0 -> unit [@@js.set "input"]
      val get_output: t -> NodeJS.WritableStream.t_0 [@@js.get "output"]
      val set_output: t -> NodeJS.WritableStream.t_0 -> unit [@@js.set "output"]
      val get_terminal: t -> bool [@@js.get "terminal"]
      val set_terminal: t -> bool -> unit [@@js.set "terminal"]
      val get_eval: t -> repl_REPLEval [@@js.get "eval"]
      val set_eval: t -> repl_REPLEval -> unit [@@js.set "eval"]
      val get_preview: t -> bool [@@js.get "preview"]
      val set_preview: t -> bool -> unit [@@js.set "preview"]
      val get_useColors: t -> bool [@@js.get "useColors"]
      val set_useColors: t -> bool -> unit [@@js.set "useColors"]
      val get_useGlobal: t -> bool [@@js.get "useGlobal"]
      val set_useGlobal: t -> bool -> unit [@@js.set "useGlobal"]
      val get_ignoreUndefined: t -> bool [@@js.get "ignoreUndefined"]
      val set_ignoreUndefined: t -> bool -> unit [@@js.set "ignoreUndefined"]
      val get_writer: t -> repl_REPLWriter [@@js.get "writer"]
      val set_writer: t -> repl_REPLWriter -> unit [@@js.set "writer"]
      val get_completer: t -> (AsyncCompleter.t_0, Completer.t_0) union2 [@@js.get "completer"]
      val set_completer: t -> (AsyncCompleter.t_0, Completer.t_0) union2 -> unit [@@js.set "completer"]
      val get_replMode: t -> (* FIXME: unknown type 'unique symbol' *)any [@@js.get "replMode"]
      val set_replMode: t -> (* FIXME: unknown type 'unique symbol' *)any -> unit [@@js.set "replMode"]
      val get_breakEvalOnSigint: t -> bool [@@js.get "breakEvalOnSigint"]
      val set_breakEvalOnSigint: t -> bool -> unit [@@js.set "breakEvalOnSigint"]
    end
    module[@js.scope "REPLEval"] REPLEval : sig
      type t = repl_REPLEval
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val apply: t -> this:repl_REPLServer -> evalCmd:string -> context:Context.t_0 -> file:string -> cb:(err:Error.t_0 or_null -> result:any -> unit) -> unit [@@js.apply]
    end
    module[@js.scope "REPLWriter"] REPLWriter : sig
      type t = repl_REPLWriter
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val apply: t -> this:repl_REPLServer -> obj:any -> string [@@js.apply]
    end
    val writer: (repl_REPLWriter, anonymous_interface_0) intersection2 [@@js.global "writer"]
    module[@js.scope "REPLCommandAction"] REPLCommandAction : sig
      type t = repl_REPLCommandAction
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val apply: t -> this:repl_REPLServer -> text:string -> unit [@@js.apply]
    end
    module[@js.scope "REPLCommand"] REPLCommand : sig
      type t = repl_REPLCommand
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_help: t -> string [@@js.get "help"]
      val set_help: t -> string -> unit [@@js.set "help"]
      val get_action: t -> repl_REPLCommandAction [@@js.get "action"]
      val set_action: t -> repl_REPLCommandAction -> unit [@@js.set "action"]
    end
    module[@js.scope "REPLServer"] REPLServer : sig
      type t = repl_REPLServer
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_context: t -> Context.t_0 [@@js.get "context"]
      val get_inputStream: t -> NodeJS.ReadableStream.t_0 [@@js.get "inputStream"]
      val get_outputStream: t -> NodeJS.WritableStream.t_0 [@@js.get "outputStream"]
      val get_input: t -> NodeJS.ReadableStream.t_0 [@@js.get "input"]
      val get_output: t -> NodeJS.WritableStream.t_0 [@@js.get "output"]
      val get_commands: t -> repl_REPLCommand NodeJS.ReadOnlyDict.t_1 [@@js.get "commands"]
      val get_editorMode: t -> bool [@@js.get "editorMode"]
      val get_underscoreAssigned: t -> bool [@@js.get "underscoreAssigned"]
      val get_last: t -> any [@@js.get "last"]
      val get_underscoreErrAssigned: t -> bool [@@js.get "underscoreErrAssigned"]
      val get_lastError: t -> any [@@js.get "lastError"]
      val get_eval: t -> repl_REPLEval [@@js.get "eval"]
      val get_useColors: t -> bool [@@js.get "useColors"]
      val get_useGlobal: t -> bool [@@js.get "useGlobal"]
      val get_ignoreUndefined: t -> bool [@@js.get "ignoreUndefined"]
      val get_writer: t -> repl_REPLWriter [@@js.get "writer"]
      val get_completer: t -> (AsyncCompleter.t_0, Completer.t_0) union2 [@@js.get "completer"]
      val get_replMode: t -> (* FIXME: unknown type 'unique symbol' *)any [@@js.get "replMode"]
      val create: unit -> t [@@js.create]
      val defineCommand: t -> keyword:string -> cmd:(repl_REPLCommand, repl_REPLCommandAction) union2 -> unit [@@js.call "defineCommand"]
      val displayPrompt: t -> ?preserveCursor:bool -> unit -> unit [@@js.call "displayPrompt"]
      val clearBufferedCommand: t -> unit [@@js.call "clearBufferedCommand"]
      val setupHistory: t -> path:string -> cb:(err:Error.t_0 or_null -> repl:t -> unit) -> unit [@@js.call "setupHistory"]
      val addListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "addListener"]
      val addListener': t -> event:([`L_s3_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener'': t -> event:([`L_s5_line] [@js.enum]) -> listener:(input:string -> unit) -> t [@@js.call "addListener"]
      val addListener''': t -> event:([`L_s6_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener'''': t -> event:([`L_s8_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener''''': t -> event:([`L_s0_SIGCONT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener'''''': t -> event:([`L_s1_SIGINT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener''''''': t -> event:([`L_s2_SIGTSTP] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener'''''''': t -> event:([`L_s4_exit] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener''''''''': t -> event:([`L_s7_reset] [@js.enum]) -> listener:(context:Context.t_0 -> unit) -> t [@@js.call "addListener"]
      val emit: t -> event:symbol or_string -> args:(any list [@js.variadic]) -> bool [@@js.call "emit"]
      val emit': t -> event:([`L_s3_close] [@js.enum]) -> bool [@@js.call "emit"]
      val emit'': t -> event:([`L_s5_line] [@js.enum]) -> input:string -> bool [@@js.call "emit"]
      val emit''': t -> event:([`L_s6_pause] [@js.enum]) -> bool [@@js.call "emit"]
      val emit'''': t -> event:([`L_s8_resume] [@js.enum]) -> bool [@@js.call "emit"]
      val emit''''': t -> event:([`L_s0_SIGCONT] [@js.enum]) -> bool [@@js.call "emit"]
      val emit'''''': t -> event:([`L_s1_SIGINT] [@js.enum]) -> bool [@@js.call "emit"]
      val emit''''''': t -> event:([`L_s2_SIGTSTP] [@js.enum]) -> bool [@@js.call "emit"]
      val emit'''''''': t -> event:([`L_s4_exit] [@js.enum]) -> bool [@@js.call "emit"]
      val emit''''''''': t -> event:([`L_s7_reset] [@js.enum]) -> context:Context.t_0 -> bool [@@js.call "emit"]
      val on: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "on"]
      val on': t -> event:([`L_s3_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on'': t -> event:([`L_s5_line] [@js.enum]) -> listener:(input:string -> unit) -> t [@@js.call "on"]
      val on''': t -> event:([`L_s6_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on'''': t -> event:([`L_s8_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on''''': t -> event:([`L_s0_SIGCONT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on'''''': t -> event:([`L_s1_SIGINT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on''''''': t -> event:([`L_s2_SIGTSTP] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on'''''''': t -> event:([`L_s4_exit] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on''''''''': t -> event:([`L_s7_reset] [@js.enum]) -> listener:(context:Context.t_0 -> unit) -> t [@@js.call "on"]
      val once: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "once"]
      val once': t -> event:([`L_s3_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once'': t -> event:([`L_s5_line] [@js.enum]) -> listener:(input:string -> unit) -> t [@@js.call "once"]
      val once''': t -> event:([`L_s6_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once'''': t -> event:([`L_s8_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once''''': t -> event:([`L_s0_SIGCONT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once'''''': t -> event:([`L_s1_SIGINT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once''''''': t -> event:([`L_s2_SIGTSTP] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once'''''''': t -> event:([`L_s4_exit] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once''''''''': t -> event:([`L_s7_reset] [@js.enum]) -> listener:(context:Context.t_0 -> unit) -> t [@@js.call "once"]
      val prependListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependListener"]
      val prependListener': t -> event:([`L_s3_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener'': t -> event:([`L_s5_line] [@js.enum]) -> listener:(input:string -> unit) -> t [@@js.call "prependListener"]
      val prependListener''': t -> event:([`L_s6_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''': t -> event:([`L_s8_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''': t -> event:([`L_s0_SIGCONT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''': t -> event:([`L_s1_SIGINT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''': t -> event:([`L_s2_SIGTSTP] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''''': t -> event:([`L_s4_exit] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''''': t -> event:([`L_s7_reset] [@js.enum]) -> listener:(context:Context.t_0 -> unit) -> t [@@js.call "prependListener"]
      val prependOnceListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener': t -> event:([`L_s3_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'': t -> event:([`L_s5_line] [@js.enum]) -> listener:(input:string -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''': t -> event:([`L_s6_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''': t -> event:([`L_s8_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''': t -> event:([`L_s0_SIGCONT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''': t -> event:([`L_s1_SIGINT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''': t -> event:([`L_s2_SIGTSTP] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''''': t -> event:([`L_s4_exit] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''''': t -> event:([`L_s7_reset] [@js.enum]) -> listener:(context:Context.t_0 -> unit) -> t [@@js.call "prependOnceListener"]
      val cast: t -> Interface.t_0 [@@js.cast]
    end
    val rEPL_MODE_SLOPPY: (* FIXME: unknown type 'unique symbol' *)any [@@js.global "REPL_MODE_SLOPPY"]
    val rEPL_MODE_STRICT: (* FIXME: unknown type 'unique symbol' *)any [@@js.global "REPL_MODE_STRICT"]
    val start: ?options:repl_ReplOptions or_string -> unit -> repl_REPLServer [@@js.global "start"]
    module[@js.scope "Recoverable"] Recoverable : sig
      type t = repl_Recoverable
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_err: t -> Error.t_0 [@@js.get "err"]
      val set_err: t -> Error.t_0 -> unit [@@js.set "err"]
      val create: err:Error.t_0 -> t [@@js.create]
      val cast: t -> SyntaxError.t_0 [@@js.cast]
    end
  end
end
