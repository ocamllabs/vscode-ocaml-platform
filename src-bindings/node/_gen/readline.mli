[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - AsyncIterableIterator<T1>
  - Buffer
  - Error
  - EventEmitter
  - NodeJS.ReadableStream
  - NodeJS.WritableStream
 *)
[@@@js.stop]
module type Missing = sig
  module AsyncIterableIterator : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module Buffer : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Error : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module EventEmitter : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module NodeJS : sig
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
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module AsyncIterableIterator : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module Buffer : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Error : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module EventEmitter : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module NodeJS : sig
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
  end
]
module Make (M: Missing) : sig
  open M
  module Internal : sig
    module AnonymousInterfaces : sig
      
    end
    module Types : sig
      open AnonymousInterfaces
      type readline_AsyncCompleter = [`Readline_AsyncCompleter] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and readline_Completer = [`Readline_Completer] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and readline_CompleterResult = (string list * string)
      and readline_CursorPos = [`Readline_CursorPos] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and readline_Direction = ([`L_n_minus1[@js -1] | `L_n_0[@js 0] | `L_n_1[@js 1]] [@js.enum])
      and readline_Interface = [`Readline_Interface] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and readline_Key = [`Readline_Key] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and readline_ReadLine = readline_Interface
      and readline_ReadLineOptions = [`Readline_ReadLineOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "node:readline"] Node_readline : sig
    (* export * from 'readline'; *)
  end
  module[@js.scope "readline"] Readline : sig
    (* import EventEmitter = require('node:events'); *)
    module[@js.scope "Key"] Key : sig
      type t = readline_Key
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_sequence: t -> string [@@js.get "sequence"]
      val set_sequence: t -> string -> unit [@@js.set "sequence"]
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_ctrl: t -> bool [@@js.get "ctrl"]
      val set_ctrl: t -> bool -> unit [@@js.set "ctrl"]
      val get_meta: t -> bool [@@js.get "meta"]
      val set_meta: t -> bool -> unit [@@js.set "meta"]
      val get_shift: t -> bool [@@js.get "shift"]
      val set_shift: t -> bool -> unit [@@js.set "shift"]
    end
    module[@js.scope "Interface"] Interface : sig
      type t = readline_Interface
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_terminal: t -> bool [@@js.get "terminal"]
      val get_line: t -> string [@@js.get "line"]
      val get_cursor: t -> float [@@js.get "cursor"]
      val create: input:NodeJS.ReadableStream.t_0 -> ?output:NodeJS.WritableStream.t_0 -> ?completer:(readline_AsyncCompleter, readline_Completer) union2 -> ?terminal:bool -> unit -> t [@@js.create]
      val create': options:readline_ReadLineOptions -> t [@@js.create]
      val setPrompt: t -> prompt:string -> unit [@@js.call "setPrompt"]
      val prompt: t -> ?preserveCursor:bool -> unit -> unit [@@js.call "prompt"]
      val question: t -> query:string -> callback:(answer:string -> unit) -> unit [@@js.call "question"]
      val pause: t -> t [@@js.call "pause"]
      val resume: t -> t [@@js.call "resume"]
      val close: t -> unit [@@js.call "close"]
      val write: t -> data:Buffer.t_0 or_string -> ?key:readline_Key -> unit -> unit [@@js.call "write"]
      val getCursorPos: t -> readline_CursorPos [@@js.call "getCursorPos"]
      val addListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "addListener"]
      val addListener': t -> event:([`L_s3_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener'': t -> event:([`L_s4_line] [@js.enum]) -> listener:(input:string -> unit) -> t [@@js.call "addListener"]
      val addListener''': t -> event:([`L_s5_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener'''': t -> event:([`L_s6_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener''''': t -> event:([`L_s0_SIGCONT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener'''''': t -> event:([`L_s1_SIGINT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener''''''': t -> event:([`L_s2_SIGTSTP] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val emit: t -> event:symbol or_string -> args:(any list [@js.variadic]) -> bool [@@js.call "emit"]
      val emit': t -> event:([`L_s3_close] [@js.enum]) -> bool [@@js.call "emit"]
      val emit'': t -> event:([`L_s4_line] [@js.enum]) -> input:string -> bool [@@js.call "emit"]
      val emit''': t -> event:([`L_s5_pause] [@js.enum]) -> bool [@@js.call "emit"]
      val emit'''': t -> event:([`L_s6_resume] [@js.enum]) -> bool [@@js.call "emit"]
      val emit''''': t -> event:([`L_s0_SIGCONT] [@js.enum]) -> bool [@@js.call "emit"]
      val emit'''''': t -> event:([`L_s1_SIGINT] [@js.enum]) -> bool [@@js.call "emit"]
      val emit''''''': t -> event:([`L_s2_SIGTSTP] [@js.enum]) -> bool [@@js.call "emit"]
      val on: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "on"]
      val on': t -> event:([`L_s3_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on'': t -> event:([`L_s4_line] [@js.enum]) -> listener:(input:string -> unit) -> t [@@js.call "on"]
      val on''': t -> event:([`L_s5_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on'''': t -> event:([`L_s6_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on''''': t -> event:([`L_s0_SIGCONT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on'''''': t -> event:([`L_s1_SIGINT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on''''''': t -> event:([`L_s2_SIGTSTP] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val once: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "once"]
      val once': t -> event:([`L_s3_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once'': t -> event:([`L_s4_line] [@js.enum]) -> listener:(input:string -> unit) -> t [@@js.call "once"]
      val once''': t -> event:([`L_s5_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once'''': t -> event:([`L_s6_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once''''': t -> event:([`L_s0_SIGCONT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once'''''': t -> event:([`L_s1_SIGINT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once''''''': t -> event:([`L_s2_SIGTSTP] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val prependListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependListener"]
      val prependListener': t -> event:([`L_s3_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener'': t -> event:([`L_s4_line] [@js.enum]) -> listener:(input:string -> unit) -> t [@@js.call "prependListener"]
      val prependListener''': t -> event:([`L_s5_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''': t -> event:([`L_s6_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''': t -> event:([`L_s0_SIGCONT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''': t -> event:([`L_s1_SIGINT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''': t -> event:([`L_s2_SIGTSTP] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependOnceListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener': t -> event:([`L_s3_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'': t -> event:([`L_s4_line] [@js.enum]) -> listener:(input:string -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''': t -> event:([`L_s5_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''': t -> event:([`L_s6_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''': t -> event:([`L_s0_SIGCONT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''': t -> event:([`L_s1_SIGINT] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''': t -> event:([`L_s2_SIGTSTP] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val _Symbol_asyncIterator_: t -> string AsyncIterableIterator.t_1 [@@js.call "[Symbol.asyncIterator]"]
      val cast: t -> EventEmitter.t_0 [@@js.cast]
    end
    module ReadLine : sig
      type t = readline_ReadLine
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "Completer"] Completer : sig
      type t = readline_Completer
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val apply: t -> line:string -> readline_CompleterResult [@@js.apply]
    end
    module[@js.scope "AsyncCompleter"] AsyncCompleter : sig
      type t = readline_AsyncCompleter
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val apply: t -> line:string -> callback:(?err:Error.t_0 or_null -> ?result:readline_CompleterResult -> unit -> unit) -> any [@@js.apply]
    end
    module CompleterResult : sig
      type t = readline_CompleterResult
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "ReadLineOptions"] ReadLineOptions : sig
      type t = readline_ReadLineOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_input: t -> NodeJS.ReadableStream.t_0 [@@js.get "input"]
      val set_input: t -> NodeJS.ReadableStream.t_0 -> unit [@@js.set "input"]
      val get_output: t -> NodeJS.WritableStream.t_0 [@@js.get "output"]
      val set_output: t -> NodeJS.WritableStream.t_0 -> unit [@@js.set "output"]
      val get_completer: t -> (readline_AsyncCompleter, readline_Completer) union2 [@@js.get "completer"]
      val set_completer: t -> (readline_AsyncCompleter, readline_Completer) union2 -> unit [@@js.set "completer"]
      val get_terminal: t -> bool [@@js.get "terminal"]
      val set_terminal: t -> bool -> unit [@@js.set "terminal"]
      val get_historySize: t -> float [@@js.get "historySize"]
      val set_historySize: t -> float -> unit [@@js.set "historySize"]
      val get_prompt: t -> string [@@js.get "prompt"]
      val set_prompt: t -> string -> unit [@@js.set "prompt"]
      val get_crlfDelay: t -> float [@@js.get "crlfDelay"]
      val set_crlfDelay: t -> float -> unit [@@js.set "crlfDelay"]
      val get_removeHistoryDuplicates: t -> bool [@@js.get "removeHistoryDuplicates"]
      val set_removeHistoryDuplicates: t -> bool -> unit [@@js.set "removeHistoryDuplicates"]
      val get_escapeCodeTimeout: t -> float [@@js.get "escapeCodeTimeout"]
      val set_escapeCodeTimeout: t -> float -> unit [@@js.set "escapeCodeTimeout"]
      val get_tabSize: t -> float [@@js.get "tabSize"]
      val set_tabSize: t -> float -> unit [@@js.set "tabSize"]
    end
    val createInterface: input:NodeJS.ReadableStream.t_0 -> ?output:NodeJS.WritableStream.t_0 -> ?completer:(readline_AsyncCompleter, readline_Completer) union2 -> ?terminal:bool -> unit -> readline_Interface [@@js.global "createInterface"]
    val createInterface: options:readline_ReadLineOptions -> readline_Interface [@@js.global "createInterface"]
    val emitKeypressEvents: stream:NodeJS.ReadableStream.t_0 -> ?readlineInterface:readline_Interface -> unit -> unit [@@js.global "emitKeypressEvents"]
    module Direction : sig
      type t = readline_Direction
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "CursorPos"] CursorPos : sig
      type t = readline_CursorPos
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_rows: t -> float [@@js.get "rows"]
      val set_rows: t -> float -> unit [@@js.set "rows"]
      val get_cols: t -> float [@@js.get "cols"]
      val set_cols: t -> float -> unit [@@js.set "cols"]
    end
    val clearLine: stream:NodeJS.WritableStream.t_0 -> dir:readline_Direction -> ?callback:(unit -> unit) -> unit -> bool [@@js.global "clearLine"]
    val clearScreenDown: stream:NodeJS.WritableStream.t_0 -> ?callback:(unit -> unit) -> unit -> bool [@@js.global "clearScreenDown"]
    val cursorTo: stream:NodeJS.WritableStream.t_0 -> x:float -> ?y:float -> ?callback:(unit -> unit) -> unit -> bool [@@js.global "cursorTo"]
    val moveCursor: stream:NodeJS.WritableStream.t_0 -> dx:float -> dy:float -> ?callback:(unit -> unit) -> unit -> bool [@@js.global "moveCursor"]
  end
end
