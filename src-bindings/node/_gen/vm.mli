[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - Buffer
  - NodeJS.Dict<T1>
  - Promise<T1>
 *)
[@@@js.stop]
module type Missing = sig
  module Buffer : sig
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
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module Buffer : sig
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
  end
]
module Make (M: Missing) : sig
  open M
  module Internal : sig
    module AnonymousInterfaces : sig
      type anonymous_interface_0 = [`anonymous_interface_0] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_1 = [`anonymous_interface_1] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
    module Types : sig
      open AnonymousInterfaces
      type vm_BaseOptions = [`Vm_BaseOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vm_CompileFunctionOptions = [`Vm_CompileFunctionOptions | `Vm_BaseOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vm_Context = [`Vm_Context] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vm_CreateContextOptions = [`Vm_CreateContextOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vm_MeasureMemoryMode = ([`L_s1_detailed[@js "detailed"] | `L_s2_summary[@js "summary"]] [@js.enum])
      and vm_MeasureMemoryOptions = [`Vm_MeasureMemoryOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vm_MemoryMeasurement = [`Vm_MemoryMeasurement] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vm_RunningScriptOptions = [`Vm_RunningScriptOptions | `Vm_BaseOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vm_Script = [`Vm_Script] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and vm_ScriptOptions = [`Vm_ScriptOptions | `Vm_BaseOptions] intf
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
    val get_jsMemoryEstimate: t -> float [@@js.get "jsMemoryEstimate"]
    val set_jsMemoryEstimate: t -> float -> unit [@@js.set "jsMemoryEstimate"]
    val get_jsMemoryRange: t -> (float * float) [@@js.get "jsMemoryRange"]
    val set_jsMemoryRange: t -> (float * float) -> unit [@@js.set "jsMemoryRange"]
  end
  module AnonymousInterface1 : sig
    type t = anonymous_interface_1
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_strings: t -> bool [@@js.get "strings"]
    val set_strings: t -> bool -> unit [@@js.set "strings"]
    val get_wasm: t -> bool [@@js.get "wasm"]
    val set_wasm: t -> bool -> unit [@@js.set "wasm"]
  end
  module[@js.scope "node:vm"] Node_vm : sig
    (* export * from 'vm'; *)
  end
  module[@js.scope "vm"] Vm : sig
    module[@js.scope "Context"] Context : sig
      type t = vm_Context
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val cast: t -> any NodeJS.Dict.t_1 [@@js.cast]
    end
    module[@js.scope "BaseOptions"] BaseOptions : sig
      type t = vm_BaseOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_filename: t -> string [@@js.get "filename"]
      val set_filename: t -> string -> unit [@@js.set "filename"]
      val get_lineOffset: t -> float [@@js.get "lineOffset"]
      val set_lineOffset: t -> float -> unit [@@js.set "lineOffset"]
      val get_columnOffset: t -> float [@@js.get "columnOffset"]
      val set_columnOffset: t -> float -> unit [@@js.set "columnOffset"]
    end
    module[@js.scope "ScriptOptions"] ScriptOptions : sig
      type t = vm_ScriptOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_displayErrors: t -> bool [@@js.get "displayErrors"]
      val set_displayErrors: t -> bool -> unit [@@js.set "displayErrors"]
      val get_timeout: t -> float [@@js.get "timeout"]
      val set_timeout: t -> float -> unit [@@js.set "timeout"]
      val get_cachedData: t -> Buffer.t_0 [@@js.get "cachedData"]
      val set_cachedData: t -> Buffer.t_0 -> unit [@@js.set "cachedData"]
      val get_produceCachedData: t -> bool [@@js.get "produceCachedData"]
      val set_produceCachedData: t -> bool -> unit [@@js.set "produceCachedData"]
      val cast: t -> vm_BaseOptions [@@js.cast]
    end
    module[@js.scope "RunningScriptOptions"] RunningScriptOptions : sig
      type t = vm_RunningScriptOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_displayErrors: t -> bool [@@js.get "displayErrors"]
      val set_displayErrors: t -> bool -> unit [@@js.set "displayErrors"]
      val get_timeout: t -> float [@@js.get "timeout"]
      val set_timeout: t -> float -> unit [@@js.set "timeout"]
      val get_breakOnSigint: t -> bool [@@js.get "breakOnSigint"]
      val set_breakOnSigint: t -> bool -> unit [@@js.set "breakOnSigint"]
      val get_microtaskMode: t -> ([`L_s0_afterEvaluate[@js "afterEvaluate"]] [@js.enum]) [@@js.get "microtaskMode"]
      val set_microtaskMode: t -> ([`L_s0_afterEvaluate] [@js.enum]) -> unit [@@js.set "microtaskMode"]
      val cast: t -> vm_BaseOptions [@@js.cast]
    end
    module[@js.scope "CompileFunctionOptions"] CompileFunctionOptions : sig
      type t = vm_CompileFunctionOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_cachedData: t -> Buffer.t_0 [@@js.get "cachedData"]
      val set_cachedData: t -> Buffer.t_0 -> unit [@@js.set "cachedData"]
      val get_produceCachedData: t -> bool [@@js.get "produceCachedData"]
      val set_produceCachedData: t -> bool -> unit [@@js.set "produceCachedData"]
      val get_parsingContext: t -> vm_Context [@@js.get "parsingContext"]
      val set_parsingContext: t -> vm_Context -> unit [@@js.set "parsingContext"]
      val get_contextExtensions: t -> untyped_object list [@@js.get "contextExtensions"]
      val set_contextExtensions: t -> untyped_object list -> unit [@@js.set "contextExtensions"]
      val cast: t -> vm_BaseOptions [@@js.cast]
    end
    module[@js.scope "CreateContextOptions"] CreateContextOptions : sig
      type t = vm_CreateContextOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
      val get_origin: t -> string [@@js.get "origin"]
      val set_origin: t -> string -> unit [@@js.set "origin"]
      val get_codeGeneration: t -> anonymous_interface_1 [@@js.get "codeGeneration"]
      val set_codeGeneration: t -> anonymous_interface_1 -> unit [@@js.set "codeGeneration"]
      val get_microtaskMode: t -> ([`L_s0_afterEvaluate[@js "afterEvaluate"]] [@js.enum]) [@@js.get "microtaskMode"]
      val set_microtaskMode: t -> ([`L_s0_afterEvaluate] [@js.enum]) -> unit [@@js.set "microtaskMode"]
    end
    module MeasureMemoryMode : sig
      type t = vm_MeasureMemoryMode
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "MeasureMemoryOptions"] MeasureMemoryOptions : sig
      type t = vm_MeasureMemoryOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_mode: t -> vm_MeasureMemoryMode [@@js.get "mode"]
      val set_mode: t -> vm_MeasureMemoryMode -> unit [@@js.set "mode"]
      val get_context: t -> vm_Context [@@js.get "context"]
      val set_context: t -> vm_Context -> unit [@@js.set "context"]
    end
    module[@js.scope "MemoryMeasurement"] MemoryMeasurement : sig
      type t = vm_MemoryMeasurement
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_total: t -> anonymous_interface_0 [@@js.get "total"]
      val set_total: t -> anonymous_interface_0 -> unit [@@js.set "total"]
    end
    module[@js.scope "Script"] Script : sig
      type t = vm_Script
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: code:string -> ?options:vm_ScriptOptions -> unit -> t [@@js.create]
      val runInContext: t -> contextifiedSandbox:vm_Context -> ?options:vm_RunningScriptOptions -> unit -> any [@@js.call "runInContext"]
      val runInNewContext: t -> ?sandbox:vm_Context -> ?options:vm_RunningScriptOptions -> unit -> any [@@js.call "runInNewContext"]
      val runInThisContext: t -> ?options:vm_RunningScriptOptions -> unit -> any [@@js.call "runInThisContext"]
      val createCachedData: t -> Buffer.t_0 [@@js.call "createCachedData"]
      val get_cachedDataRejected: t -> bool [@@js.get "cachedDataRejected"]
      val set_cachedDataRejected: t -> bool -> unit [@@js.set "cachedDataRejected"]
    end
    val createContext: ?sandbox:vm_Context -> ?options:vm_CreateContextOptions -> unit -> vm_Context [@@js.global "createContext"]
    val isContext: sandbox:vm_Context -> bool [@@js.global "isContext"]
    val runInContext: code:string -> contextifiedSandbox:vm_Context -> ?options:vm_RunningScriptOptions or_string -> unit -> any [@@js.global "runInContext"]
    val runInNewContext: code:string -> ?sandbox:vm_Context -> ?options:vm_RunningScriptOptions or_string -> unit -> any [@@js.global "runInNewContext"]
    val runInThisContext: code:string -> ?options:vm_RunningScriptOptions or_string -> unit -> any [@@js.global "runInThisContext"]
    val compileFunction: code:string -> ?params:string list -> ?options:vm_CompileFunctionOptions -> unit -> untyped_function [@@js.global "compileFunction"]
    val measureMemory: ?options:vm_MeasureMemoryOptions -> unit -> vm_MemoryMeasurement Promise.t_1 [@@js.global "measureMemory"]
  end
end
