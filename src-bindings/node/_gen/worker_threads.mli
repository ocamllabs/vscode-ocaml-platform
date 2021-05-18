[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - ArrayBuffer
  - Context
  - Error
  - EventEmitter
  - FileHandle
  - NodeJS.Dict<T1>
  - Promise<T1>
  - Readable
  - URL
  - Writable
 *)
[@@@js.stop]
module type Missing = sig
  module ArrayBuffer : sig
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
  module EventEmitter : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module FileHandle : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module NodeJS : sig
    module Dict : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
  end
  module Promise : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module Readable : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module URL : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Writable : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module ArrayBuffer : sig
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
    module EventEmitter : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module FileHandle : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module NodeJS : sig
      module Dict : sig
        type 'T1 t_1
        val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
        val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
      end
    end
    module Promise : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module Readable : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module URL : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Writable : sig
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
      type worker_threads_MessageChannel = [`Worker_threads_MessageChannel] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and worker_threads_MessagePort = [`Worker_threads_MessagePort] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and worker_threads_ResourceLimits = [`Worker_threads_ResourceLimits] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and worker_threads_TransferListItem = (ArrayBuffer.t_0, FileHandle.t_0, worker_threads_MessagePort) union3
      and worker_threads_Worker = [`Worker_threads_Worker] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and worker_threads_WorkerOptions = [`Worker_threads_WorkerOptions] intf
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
    val get_message: t -> any [@@js.get "message"]
    val set_message: t -> any -> unit [@@js.set "message"]
  end
  module[@js.scope "node:worker_threads"] Node_worker_threads : sig
    (* export * from 'worker_threads'; *)
  end
  module[@js.scope "worker_threads"] Worker_threads : sig
    (* import { Context } from 'node:vm'; *)
    (* import EventEmitter = require('node:events'); *)
    (* import { Readable, Writable } from 'node:stream'; *)
    (* import { URL } from 'node:url'; *)
    (* import { FileHandle } from 'node:fs/promises'; *)
    val isMainThread: bool [@@js.global "isMainThread"]
    val parentPort: worker_threads_MessagePort or_null [@@js.global "parentPort"]
    val resourceLimits: worker_threads_ResourceLimits [@@js.global "resourceLimits"]
    val sHARE_ENV: (* FIXME: unknown type 'unique symbol' *)any [@@js.global "SHARE_ENV"]
    val threadId: float [@@js.global "threadId"]
    val workerData: any [@@js.global "workerData"]
    module[@js.scope "MessageChannel"] MessageChannel : sig
      type t = worker_threads_MessageChannel
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_port1: t -> worker_threads_MessagePort [@@js.get "port1"]
      val get_port2: t -> worker_threads_MessagePort [@@js.get "port2"]
    end
    module TransferListItem : sig
      type t = worker_threads_TransferListItem
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "MessagePort"] MessagePort : sig
      type t = worker_threads_MessagePort
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val close: t -> unit [@@js.call "close"]
      val postMessage: t -> value:any -> ?transferList:worker_threads_TransferListItem list -> unit -> unit [@@js.call "postMessage"]
      val ref: t -> unit [@@js.call "ref"]
      val unref: t -> unit [@@js.call "unref"]
      val start: t -> unit [@@js.call "start"]
      val addListener: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener': t -> event:([`L_s3_message] [@js.enum]) -> listener:(value:any -> unit) -> t [@@js.call "addListener"]
      val addListener'': t -> event:([`L_s4_messageerror] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "addListener"]
      val addListener''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "addListener"]
      val emit: t -> event:([`L_s0_close] [@js.enum]) -> bool [@@js.call "emit"]
      val emit': t -> event:([`L_s3_message] [@js.enum]) -> value:any -> bool [@@js.call "emit"]
      val emit'': t -> event:([`L_s4_messageerror] [@js.enum]) -> error:Error.t_0 -> bool [@@js.call "emit"]
      val emit''': t -> event:symbol or_string -> args:(any list [@js.variadic]) -> bool [@@js.call "emit"]
      val on: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on': t -> event:([`L_s3_message] [@js.enum]) -> listener:(value:any -> unit) -> t [@@js.call "on"]
      val on'': t -> event:([`L_s4_messageerror] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "on"]
      val on''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "on"]
      val once: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once': t -> event:([`L_s3_message] [@js.enum]) -> listener:(value:any -> unit) -> t [@@js.call "once"]
      val once'': t -> event:([`L_s4_messageerror] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "once"]
      val once''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "once"]
      val prependListener: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener': t -> event:([`L_s3_message] [@js.enum]) -> listener:(value:any -> unit) -> t [@@js.call "prependListener"]
      val prependListener'': t -> event:([`L_s4_messageerror] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "prependListener"]
      val prependListener''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependListener"]
      val prependOnceListener: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener': t -> event:([`L_s3_message] [@js.enum]) -> listener:(value:any -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'': t -> event:([`L_s4_messageerror] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependOnceListener"]
      val removeListener: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "removeListener"]
      val removeListener': t -> event:([`L_s3_message] [@js.enum]) -> listener:(value:any -> unit) -> t [@@js.call "removeListener"]
      val removeListener'': t -> event:([`L_s4_messageerror] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "removeListener"]
      val removeListener''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "removeListener"]
      val off: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "off"]
      val off': t -> event:([`L_s3_message] [@js.enum]) -> listener:(value:any -> unit) -> t [@@js.call "off"]
      val off'': t -> event:([`L_s4_messageerror] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "off"]
      val off''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "off"]
      val cast: t -> EventEmitter.t_0 [@@js.cast]
    end
    module[@js.scope "WorkerOptions"] WorkerOptions : sig
      type t = worker_threads_WorkerOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_argv: t -> any list [@@js.get "argv"]
      val set_argv: t -> any list -> unit [@@js.set "argv"]
      val get_env: t -> (string NodeJS.Dict.t_1, (* FIXME: unknown type 'unique symbol' *)any) union2 [@@js.get "env"]
      val set_env: t -> (string NodeJS.Dict.t_1, (* FIXME: unknown type 'unique symbol' *)any) union2 -> unit [@@js.set "env"]
      val get_eval: t -> bool [@@js.get "eval"]
      val set_eval: t -> bool -> unit [@@js.set "eval"]
      val get_workerData: t -> any [@@js.get "workerData"]
      val set_workerData: t -> any -> unit [@@js.set "workerData"]
      val get_stdin: t -> bool [@@js.get "stdin"]
      val set_stdin: t -> bool -> unit [@@js.set "stdin"]
      val get_stdout: t -> bool [@@js.get "stdout"]
      val set_stdout: t -> bool -> unit [@@js.set "stdout"]
      val get_stderr: t -> bool [@@js.get "stderr"]
      val set_stderr: t -> bool -> unit [@@js.set "stderr"]
      val get_execArgv: t -> string list [@@js.get "execArgv"]
      val set_execArgv: t -> string list -> unit [@@js.set "execArgv"]
      val get_resourceLimits: t -> worker_threads_ResourceLimits [@@js.get "resourceLimits"]
      val set_resourceLimits: t -> worker_threads_ResourceLimits -> unit [@@js.set "resourceLimits"]
      val get_transferList: t -> worker_threads_TransferListItem list [@@js.get "transferList"]
      val set_transferList: t -> worker_threads_TransferListItem list -> unit [@@js.set "transferList"]
      val get_trackUnmanagedFds: t -> bool [@@js.get "trackUnmanagedFds"]
      val set_trackUnmanagedFds: t -> bool -> unit [@@js.set "trackUnmanagedFds"]
    end
    module[@js.scope "ResourceLimits"] ResourceLimits : sig
      type t = worker_threads_ResourceLimits
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_maxYoungGenerationSizeMb: t -> float [@@js.get "maxYoungGenerationSizeMb"]
      val set_maxYoungGenerationSizeMb: t -> float -> unit [@@js.set "maxYoungGenerationSizeMb"]
      val get_maxOldGenerationSizeMb: t -> float [@@js.get "maxOldGenerationSizeMb"]
      val set_maxOldGenerationSizeMb: t -> float -> unit [@@js.set "maxOldGenerationSizeMb"]
      val get_codeRangeSizeMb: t -> float [@@js.get "codeRangeSizeMb"]
      val set_codeRangeSizeMb: t -> float -> unit [@@js.set "codeRangeSizeMb"]
      val get_stackSizeMb: t -> float [@@js.get "stackSizeMb"]
      val set_stackSizeMb: t -> float -> unit [@@js.set "stackSizeMb"]
    end
    module[@js.scope "Worker"] Worker : sig
      type t = worker_threads_Worker
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_stdin: t -> Writable.t_0 or_null [@@js.get "stdin"]
      val get_stdout: t -> Readable.t_0 [@@js.get "stdout"]
      val get_stderr: t -> Readable.t_0 [@@js.get "stderr"]
      val get_threadId: t -> float [@@js.get "threadId"]
      val get_resourceLimits: t -> worker_threads_ResourceLimits [@@js.get "resourceLimits"]
      val create: filename:URL.t_0 or_string -> ?options:worker_threads_WorkerOptions -> unit -> t [@@js.create]
      val postMessage: t -> value:any -> ?transferList:worker_threads_TransferListItem list -> unit -> unit [@@js.call "postMessage"]
      val ref: t -> unit [@@js.call "ref"]
      val unref: t -> unit [@@js.call "unref"]
      val terminate: t -> float Promise.t_1 [@@js.call "terminate"]
      val getHeapSnapshot: t -> Readable.t_0 Promise.t_1 [@@js.call "getHeapSnapshot"]
      val addListener: t -> event:([`L_s1_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "addListener"]
      val addListener': t -> event:([`L_s2_exit] [@js.enum]) -> listener:(exitCode:float -> unit) -> t [@@js.call "addListener"]
      val addListener'': t -> event:([`L_s3_message] [@js.enum]) -> listener:(value:any -> unit) -> t [@@js.call "addListener"]
      val addListener''': t -> event:([`L_s4_messageerror] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "addListener"]
      val addListener'''': t -> event:([`L_s5_online] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "addListener"]
      val emit: t -> event:([`L_s1_error] [@js.enum]) -> err:Error.t_0 -> bool [@@js.call "emit"]
      val emit': t -> event:([`L_s2_exit] [@js.enum]) -> exitCode:float -> bool [@@js.call "emit"]
      val emit'': t -> event:([`L_s3_message] [@js.enum]) -> value:any -> bool [@@js.call "emit"]
      val emit''': t -> event:([`L_s4_messageerror] [@js.enum]) -> error:Error.t_0 -> bool [@@js.call "emit"]
      val emit'''': t -> event:([`L_s5_online] [@js.enum]) -> bool [@@js.call "emit"]
      val emit''''': t -> event:symbol or_string -> args:(any list [@js.variadic]) -> bool [@@js.call "emit"]
      val on: t -> event:([`L_s1_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "on"]
      val on': t -> event:([`L_s2_exit] [@js.enum]) -> listener:(exitCode:float -> unit) -> t [@@js.call "on"]
      val on'': t -> event:([`L_s3_message] [@js.enum]) -> listener:(value:any -> unit) -> t [@@js.call "on"]
      val on''': t -> event:([`L_s4_messageerror] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "on"]
      val on'''': t -> event:([`L_s5_online] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "on"]
      val once: t -> event:([`L_s1_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "once"]
      val once': t -> event:([`L_s2_exit] [@js.enum]) -> listener:(exitCode:float -> unit) -> t [@@js.call "once"]
      val once'': t -> event:([`L_s3_message] [@js.enum]) -> listener:(value:any -> unit) -> t [@@js.call "once"]
      val once''': t -> event:([`L_s4_messageerror] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "once"]
      val once'''': t -> event:([`L_s5_online] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "once"]
      val prependListener: t -> event:([`L_s1_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "prependListener"]
      val prependListener': t -> event:([`L_s2_exit] [@js.enum]) -> listener:(exitCode:float -> unit) -> t [@@js.call "prependListener"]
      val prependListener'': t -> event:([`L_s3_message] [@js.enum]) -> listener:(value:any -> unit) -> t [@@js.call "prependListener"]
      val prependListener''': t -> event:([`L_s4_messageerror] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''': t -> event:([`L_s5_online] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependListener"]
      val prependOnceListener: t -> event:([`L_s1_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener': t -> event:([`L_s2_exit] [@js.enum]) -> listener:(exitCode:float -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'': t -> event:([`L_s3_message] [@js.enum]) -> listener:(value:any -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''': t -> event:([`L_s4_messageerror] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''': t -> event:([`L_s5_online] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependOnceListener"]
      val removeListener: t -> event:([`L_s1_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "removeListener"]
      val removeListener': t -> event:([`L_s2_exit] [@js.enum]) -> listener:(exitCode:float -> unit) -> t [@@js.call "removeListener"]
      val removeListener'': t -> event:([`L_s3_message] [@js.enum]) -> listener:(value:any -> unit) -> t [@@js.call "removeListener"]
      val removeListener''': t -> event:([`L_s4_messageerror] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "removeListener"]
      val removeListener'''': t -> event:([`L_s5_online] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "removeListener"]
      val removeListener''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "removeListener"]
      val off: t -> event:([`L_s1_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "off"]
      val off': t -> event:([`L_s2_exit] [@js.enum]) -> listener:(exitCode:float -> unit) -> t [@@js.call "off"]
      val off'': t -> event:([`L_s3_message] [@js.enum]) -> listener:(value:any -> unit) -> t [@@js.call "off"]
      val off''': t -> event:([`L_s4_messageerror] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "off"]
      val off'''': t -> event:([`L_s5_online] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "off"]
      val off''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "off"]
      val cast: t -> EventEmitter.t_0 [@@js.cast]
    end
    val markAsUntransferable: object_:untyped_object -> unit [@@js.global "markAsUntransferable"]
    val moveMessagePortToContext: port:worker_threads_MessagePort -> context:Context.t_0 -> worker_threads_MessagePort [@@js.global "moveMessagePortToContext"]
    val receiveMessageOnPort: port:worker_threads_MessagePort -> anonymous_interface_0 or_undefined [@@js.global "receiveMessageOnPort"]
  end
end
