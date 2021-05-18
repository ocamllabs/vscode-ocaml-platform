[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - ArrayBuffer
  - AsyncIterableIterator<T1>
  - BigInt64Array
  - BigUint64Array
  - Console
  - DataView
  - Error
  - EventEmitter
  - Float32Array
  - Float64Array
  - Int16Array
  - Int32Array
  - Int8Array
  - IterableIterator<T1>
  - MapConstructor
  - NodeJS.Process
  - Promise<T1>
  - SetConstructor
  - SharedArrayBuffer
  - Uint16Array
  - Uint32Array
  - Uint8Array
  - Uint8ClampedArray
  - WeakMapConstructor
  - WeakSetConstructor
 *)
[@@@js.stop]
module type Missing = sig
  module ArrayBuffer : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module AsyncIterableIterator : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module BigInt64Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module BigUint64Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Console : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module DataView : sig
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
  module Float32Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Float64Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Int16Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Int32Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Int8Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module IterableIterator : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module MapConstructor : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module NodeJS : sig
    module Process : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
  end
  module Promise : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module SetConstructor : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module SharedArrayBuffer : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Uint16Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Uint32Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Uint8Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Uint8ClampedArray : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module WeakMapConstructor : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module WeakSetConstructor : sig
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
    module AsyncIterableIterator : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module BigInt64Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module BigUint64Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Console : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module DataView : sig
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
    module Float32Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Float64Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Int16Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Int32Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Int8Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module IterableIterator : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module MapConstructor : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module NodeJS : sig
      module Process : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
    end
    module Promise : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module SetConstructor : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module SharedArrayBuffer : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Uint16Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Uint32Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Uint8Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Uint8ClampedArray : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module WeakMapConstructor : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module WeakSetConstructor : sig
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
      type anonymous_interface_1 = [`anonymous_interface_1] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_2 = [`anonymous_interface_2] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_3 = [`anonymous_interface_3] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
    module Types : sig
      open AnonymousInterfaces
      type _Buffer = [`Buffer] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _BufferEncoding = ([`L_s1_ascii[@js "ascii"] | `L_s2_base64[@js "base64"] | `L_s3_binary[@js "binary"] | `L_s5_hex[@js "hex"] | `L_s6_latin1[@js "latin1"] | `L_s8_ucs_2[@js "ucs-2"] | `L_s9_ucs2[@js "ucs2"] | `L_s10_utf_8[@js "utf-8"] | `L_s11_utf16le[@js "utf16le"] | `L_s12_utf8[@js "utf8"]] [@js.enum])
      and _ErrorConstructor = [`ErrorConstructor] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _ImportMeta = [`ImportMeta] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NodeJS_ArrayBufferView = (DataView.t_0, _NodeJS_TypedArray) union2
      and _NodeJS_CallSite = [`NodeJS_CallSite] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T _NodeJS_Dict = [`NodeJS_Dict of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and _NodeJS_ErrnoException = [`NodeJS_ErrnoException] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NodeJS_Global = [`NodeJS_Global] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NodeJS_Immediate = [`NodeJS_Immediate | `NodeJS_RefCounted] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NodeJS_InspectOptions = [`NodeJS_InspectOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NodeJS_Module = [`NodeJS_Module] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T _NodeJS_ReadOnlyDict = [`NodeJS_ReadOnlyDict of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and _NodeJS_ReadWriteStream = [`NodeJS_ReadWriteStream | `NodeJS_ReadableStream | `NodeJS_WritableStream] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NodeJS_ReadableStream = [`NodeJS_ReadableStream] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NodeJS_RefCounted = [`NodeJS_RefCounted] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NodeJS_Require = [`NodeJS_Require] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NodeJS_RequireExtensions = [`NodeJS_RequireExtensions | `NodeJS_Dict of m:_NodeJS_Module -> filename:string -> any] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NodeJS_RequireResolve = [`NodeJS_RequireResolve] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NodeJS_Timeout = [`NodeJS_Timeout | `NodeJS_RefCounted | `NodeJS_Timer] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NodeJS_Timer = [`NodeJS_Timer | `NodeJS_RefCounted] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NodeJS_TypedArray = ((((Float64Array.t_0, Int16Array.t_0, Int32Array.t_0, Int8Array.t_0, Uint16Array.t_0, Uint32Array.t_0, Uint8Array.t_0, Uint8ClampedArray.t_0) union8, Float32Array.t_0) or_, BigUint64Array.t_0) or_, BigInt64Array.t_0) or_
      and _NodeJS_WritableStream = [`NodeJS_WritableStream] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NodeModule = [`NodeModule | `NodeJS_Module] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _NodeRequire = [`NodeRequire | `NodeJS_Require] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _RequireResolve = [`RequireResolve | `NodeJS_RequireResolve] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and _String = [`String] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T _WithImplicitCoercion = ('T, anonymous_interface_3) union2
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
    val get_end: t -> bool [@@js.get "end"]
    val set_end: t -> bool -> unit [@@js.set "end"]
  end
  module AnonymousInterface1 : sig
    type t = anonymous_interface_1
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_paths: t -> string list [@@js.get "paths"]
    val set_paths: t -> string list -> unit [@@js.set "paths"]
  end
  module AnonymousInterface2 : sig
    type t = anonymous_interface_2
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_type: t -> ([`L_s0_Buffer[@js "Buffer"]] [@js.enum]) [@@js.get "type"]
    val set_type: t -> ([`L_s0_Buffer] [@js.enum]) -> unit [@@js.set "type"]
    val get_data: t -> float list [@@js.get "data"]
    val set_data: t -> float list -> unit [@@js.set "data"]
  end
  module AnonymousInterface3 : sig
    type t = anonymous_interface_3
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val valueOf: t -> 'T [@@js.call "valueOf"]
  end
  module[@js.scope "ErrorConstructor"] ErrorConstructor : sig
    type t = _ErrorConstructor
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val captureStackTrace: t -> targetObject:untyped_object -> ?constructorOpt:untyped_function -> unit -> unit [@@js.call "captureStackTrace"]
    val prepareStackTrace: t -> err:Error.t_0 -> stackTraces:_NodeJS_CallSite list -> any [@@js.call "prepareStackTrace"]
    val get_stackTraceLimit: t -> float [@@js.get "stackTraceLimit"]
    val set_stackTraceLimit: t -> float -> unit [@@js.set "stackTraceLimit"]
  end
  module[@js.scope "String"] String : sig
    type t = _String
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val trimLeft: t -> string [@@js.call "trimLeft"]
    val trimRight: t -> string [@@js.call "trimRight"]
    val trimStart: t -> string [@@js.call "trimStart"]
    val trimEnd: t -> string [@@js.call "trimEnd"]
    val to_ml: t -> string [@@js.cast]
    val of_ml: string -> t [@@js.cast]
  end
  module[@js.scope "ImportMeta"] ImportMeta : sig
    type t = _ImportMeta
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_url: t -> string [@@js.get "url"]
    val set_url: t -> string -> unit [@@js.set "url"]
  end
  module[@js.scope "NodeRequire"] NodeRequire : sig
    type t = _NodeRequire
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val cast: t -> _NodeJS_Require [@@js.cast]
  end
  module[@js.scope "RequireResolve"] RequireResolve : sig
    type t = _RequireResolve
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val cast: t -> _NodeJS_RequireResolve [@@js.cast]
  end
  module[@js.scope "NodeModule"] NodeModule : sig
    type t = _NodeModule
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val cast: t -> _NodeJS_Module [@@js.cast]
  end
  val process: NodeJS.Process.t_0 [@@js.global "process"]
  val console: Console.t_0 [@@js.global "console"]
  val __filename: string [@@js.global "__filename"]
  val __dirname: string [@@js.global "__dirname"]
  val setTimeout: callback:(args:(any list [@js.variadic]) -> unit) -> ?ms:float -> args:(any list [@js.variadic]) -> _NodeJS_Timeout [@@js.global "setTimeout"]
  module[@js.scope "setTimeout"] SetTimeout : sig
    val __promisify__: ms:float -> unit Promise.t_1 [@@js.global "__promisify__"]
    val __promisify__: ms:float -> value:'T -> 'T Promise.t_1 [@@js.global "__promisify__"]
  end
  val clearTimeout: timeoutId:_NodeJS_Timeout -> unit [@@js.global "clearTimeout"]
  val setInterval: callback:(args:(any list [@js.variadic]) -> unit) -> ?ms:float -> args:(any list [@js.variadic]) -> _NodeJS_Timeout [@@js.global "setInterval"]
  val clearInterval: intervalId:_NodeJS_Timeout -> unit [@@js.global "clearInterval"]
  val setImmediate: callback:(args:(any list [@js.variadic]) -> unit) -> args:(any list [@js.variadic]) -> _NodeJS_Immediate [@@js.global "setImmediate"]
  module[@js.scope "setImmediate"] SetImmediate : sig
    val __promisify__: unit -> unit Promise.t_1 [@@js.global "__promisify__"]
    val __promisify__: value:'T -> 'T Promise.t_1 [@@js.global "__promisify__"]
  end
  val clearImmediate: immediateId:_NodeJS_Immediate -> unit [@@js.global "clearImmediate"]
  val queueMicrotask: callback:(unit -> unit) -> unit [@@js.global "queueMicrotask"]
  val require: _NodeRequire [@@js.global "require"]
  val module_: _NodeModule [@@js.global "module"]
  val exports: any [@@js.global "exports"]
  module BufferEncoding : sig
    type t = _BufferEncoding
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module WithImplicitCoercion : sig
    type 'T t = 'T _WithImplicitCoercion
    val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
    val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
    type 'T t_1 = 'T t
    val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
  end
  module[@js.scope "Buffer"] Buffer : sig
    type t = _Buffer
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val create: str:string -> ?encoding:_BufferEncoding -> unit -> t [@@js.create]
    val create': size:float -> t [@@js.create]
    val create'': array:Uint8Array.t_0 -> t [@@js.create]
    val create''': arrayBuffer:(ArrayBuffer.t_0, SharedArrayBuffer.t_0) union2 -> t [@@js.create]
    val create'''': array:any list -> t [@@js.create]
    val create''''': buffer:t -> t [@@js.create]
    val from: arrayBuffer:(ArrayBuffer.t_0, SharedArrayBuffer.t_0) union2 _WithImplicitCoercion -> ?byteOffset:float -> ?length:float -> unit -> t [@@js.global "from"]
    val from': data:(Uint8Array.t_0, float list) union2 -> t [@@js.global "from"]
    val from'': data:(Uint8Array.t_0, float list) union2 or_string _WithImplicitCoercion -> t [@@js.global "from"]
    val of_: items:(float list [@js.variadic]) -> t [@@js.global "of"]
    val isBuffer: obj:any -> bool [@@js.global "isBuffer"]
    val isEncoding: encoding:string -> bool [@@js.global "isEncoding"]
    val byteLength: string:(ArrayBuffer.t_0, _NodeJS_ArrayBufferView, SharedArrayBuffer.t_0) union3 or_string -> ?encoding:_BufferEncoding -> unit -> float [@@js.global "byteLength"]
    val concat: list:Uint8Array.t_0 list -> ?totalLength:float -> unit -> t [@@js.global "concat"]
    val compare: buf1:Uint8Array.t_0 -> buf2:Uint8Array.t_0 -> float [@@js.global "compare"]
    val alloc: size:float -> ?fill:t or_string or_number -> ?encoding:_BufferEncoding -> unit -> t [@@js.global "alloc"]
    val allocUnsafe: size:float -> t [@@js.global "allocUnsafe"]
    val allocUnsafeSlow: size:float -> t [@@js.global "allocUnsafeSlow"]
    val get_poolSize: unit -> float [@@js.get "poolSize"]
    val set_poolSize: float -> unit [@@js.set "poolSize"]
    val write: t -> string:string -> ?encoding:_BufferEncoding -> unit -> float [@@js.call "write"]
    val write': t -> string:string -> offset:float -> ?encoding:_BufferEncoding -> unit -> float [@@js.call "write"]
    val write'': t -> string:string -> offset:float -> length:float -> ?encoding:_BufferEncoding -> unit -> float [@@js.call "write"]
    val toString: t -> ?encoding:_BufferEncoding -> ?start:float -> ?end_:float -> unit -> string [@@js.call "toString"]
    val toJSON: t -> anonymous_interface_2 [@@js.call "toJSON"]
    val equals: t -> otherBuffer:Uint8Array.t_0 -> bool [@@js.call "equals"]
    val compare': t -> otherBuffer:Uint8Array.t_0 -> ?targetStart:float -> ?targetEnd:float -> ?sourceStart:float -> ?sourceEnd:float -> unit -> float [@@js.call "compare"]
    val copy: t -> targetBuffer:Uint8Array.t_0 -> ?targetStart:float -> ?sourceStart:float -> ?sourceEnd:float -> unit -> float [@@js.call "copy"]
    val slice: t -> ?begin_:float -> ?end_:float -> unit -> t [@@js.call "slice"]
    val subarray: t -> ?begin_:float -> ?end_:float -> unit -> t [@@js.call "subarray"]
    val writeBigInt64BE: t -> value:bigint -> ?offset:float -> unit -> float [@@js.call "writeBigInt64BE"]
    val writeBigInt64LE: t -> value:bigint -> ?offset:float -> unit -> float [@@js.call "writeBigInt64LE"]
    val writeBigUInt64BE: t -> value:bigint -> ?offset:float -> unit -> float [@@js.call "writeBigUInt64BE"]
    val writeBigUInt64LE: t -> value:bigint -> ?offset:float -> unit -> float [@@js.call "writeBigUInt64LE"]
    val writeUIntLE: t -> value:float -> offset:float -> byteLength:float -> float [@@js.call "writeUIntLE"]
    val writeUIntBE: t -> value:float -> offset:float -> byteLength:float -> float [@@js.call "writeUIntBE"]
    val writeIntLE: t -> value:float -> offset:float -> byteLength:float -> float [@@js.call "writeIntLE"]
    val writeIntBE: t -> value:float -> offset:float -> byteLength:float -> float [@@js.call "writeIntBE"]
    val readBigUInt64BE: t -> ?offset:float -> unit -> bigint [@@js.call "readBigUInt64BE"]
    val readBigUInt64LE: t -> ?offset:float -> unit -> bigint [@@js.call "readBigUInt64LE"]
    val readBigInt64BE: t -> ?offset:float -> unit -> bigint [@@js.call "readBigInt64BE"]
    val readBigInt64LE: t -> ?offset:float -> unit -> bigint [@@js.call "readBigInt64LE"]
    val readUIntLE: t -> offset:float -> byteLength:float -> float [@@js.call "readUIntLE"]
    val readUIntBE: t -> offset:float -> byteLength:float -> float [@@js.call "readUIntBE"]
    val readIntLE: t -> offset:float -> byteLength:float -> float [@@js.call "readIntLE"]
    val readIntBE: t -> offset:float -> byteLength:float -> float [@@js.call "readIntBE"]
    val readUInt8: t -> ?offset:float -> unit -> float [@@js.call "readUInt8"]
    val readUInt16LE: t -> ?offset:float -> unit -> float [@@js.call "readUInt16LE"]
    val readUInt16BE: t -> ?offset:float -> unit -> float [@@js.call "readUInt16BE"]
    val readUInt32LE: t -> ?offset:float -> unit -> float [@@js.call "readUInt32LE"]
    val readUInt32BE: t -> ?offset:float -> unit -> float [@@js.call "readUInt32BE"]
    val readInt8: t -> ?offset:float -> unit -> float [@@js.call "readInt8"]
    val readInt16LE: t -> ?offset:float -> unit -> float [@@js.call "readInt16LE"]
    val readInt16BE: t -> ?offset:float -> unit -> float [@@js.call "readInt16BE"]
    val readInt32LE: t -> ?offset:float -> unit -> float [@@js.call "readInt32LE"]
    val readInt32BE: t -> ?offset:float -> unit -> float [@@js.call "readInt32BE"]
    val readFloatLE: t -> ?offset:float -> unit -> float [@@js.call "readFloatLE"]
    val readFloatBE: t -> ?offset:float -> unit -> float [@@js.call "readFloatBE"]
    val readDoubleLE: t -> ?offset:float -> unit -> float [@@js.call "readDoubleLE"]
    val readDoubleBE: t -> ?offset:float -> unit -> float [@@js.call "readDoubleBE"]
    val reverse: t -> t [@@js.call "reverse"]
    val swap16: t -> t [@@js.call "swap16"]
    val swap32: t -> t [@@js.call "swap32"]
    val swap64: t -> t [@@js.call "swap64"]
    val writeUInt8: t -> value:float -> ?offset:float -> unit -> float [@@js.call "writeUInt8"]
    val writeUInt16LE: t -> value:float -> ?offset:float -> unit -> float [@@js.call "writeUInt16LE"]
    val writeUInt16BE: t -> value:float -> ?offset:float -> unit -> float [@@js.call "writeUInt16BE"]
    val writeUInt32LE: t -> value:float -> ?offset:float -> unit -> float [@@js.call "writeUInt32LE"]
    val writeUInt32BE: t -> value:float -> ?offset:float -> unit -> float [@@js.call "writeUInt32BE"]
    val writeInt8: t -> value:float -> ?offset:float -> unit -> float [@@js.call "writeInt8"]
    val writeInt16LE: t -> value:float -> ?offset:float -> unit -> float [@@js.call "writeInt16LE"]
    val writeInt16BE: t -> value:float -> ?offset:float -> unit -> float [@@js.call "writeInt16BE"]
    val writeInt32LE: t -> value:float -> ?offset:float -> unit -> float [@@js.call "writeInt32LE"]
    val writeInt32BE: t -> value:float -> ?offset:float -> unit -> float [@@js.call "writeInt32BE"]
    val writeFloatLE: t -> value:float -> ?offset:float -> unit -> float [@@js.call "writeFloatLE"]
    val writeFloatBE: t -> value:float -> ?offset:float -> unit -> float [@@js.call "writeFloatBE"]
    val writeDoubleLE: t -> value:float -> ?offset:float -> unit -> float [@@js.call "writeDoubleLE"]
    val writeDoubleBE: t -> value:float -> ?offset:float -> unit -> float [@@js.call "writeDoubleBE"]
    val fill: t -> value:Uint8Array.t_0 or_string or_number -> ?offset:float -> ?end_:float -> ?encoding:_BufferEncoding -> unit -> t [@@js.call "fill"]
    val indexOf: t -> value:Uint8Array.t_0 or_string or_number -> ?byteOffset:float -> ?encoding:_BufferEncoding -> unit -> float [@@js.call "indexOf"]
    val lastIndexOf: t -> value:Uint8Array.t_0 or_string or_number -> ?byteOffset:float -> ?encoding:_BufferEncoding -> unit -> float [@@js.call "lastIndexOf"]
    val entries: t -> (float * float) IterableIterator.t_1 [@@js.call "entries"]
    val includes: t -> value:t or_string or_number -> ?byteOffset:float -> ?encoding:_BufferEncoding -> unit -> bool [@@js.call "includes"]
    val keys: t -> float IterableIterator.t_1 [@@js.call "keys"]
    val values: t -> float IterableIterator.t_1 [@@js.call "values"]
    val cast: t -> Uint8Array.t_0 [@@js.cast]
  end
  module[@js.scope "NodeJS"] NodeJS : sig
    module[@js.scope "InspectOptions"] InspectOptions : sig
      type t = _NodeJS_InspectOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_getters: t -> ([`L_s4_get[@js "get"] | `L_s7_set[@js "set"]] [@js.enum]) or_boolean [@@js.get "getters"]
      val set_getters: t -> ([`L_s4_get | `L_s7_set] [@js.enum]) or_boolean -> unit [@@js.set "getters"]
      val get_showHidden: t -> bool [@@js.get "showHidden"]
      val set_showHidden: t -> bool -> unit [@@js.set "showHidden"]
      val get_depth: t -> float or_null [@@js.get "depth"]
      val set_depth: t -> float or_null -> unit [@@js.set "depth"]
      val get_colors: t -> bool [@@js.get "colors"]
      val set_colors: t -> bool -> unit [@@js.set "colors"]
      val get_customInspect: t -> bool [@@js.get "customInspect"]
      val set_customInspect: t -> bool -> unit [@@js.set "customInspect"]
      val get_showProxy: t -> bool [@@js.get "showProxy"]
      val set_showProxy: t -> bool -> unit [@@js.set "showProxy"]
      val get_maxArrayLength: t -> float or_null [@@js.get "maxArrayLength"]
      val set_maxArrayLength: t -> float or_null -> unit [@@js.set "maxArrayLength"]
      val get_maxStringLength: t -> float or_null [@@js.get "maxStringLength"]
      val set_maxStringLength: t -> float or_null -> unit [@@js.set "maxStringLength"]
      val get_breakLength: t -> float [@@js.get "breakLength"]
      val set_breakLength: t -> float -> unit [@@js.set "breakLength"]
      val get_compact: t -> bool or_number [@@js.get "compact"]
      val set_compact: t -> bool or_number -> unit [@@js.set "compact"]
      val get_sorted: t -> (a:string -> b:string -> float) or_boolean [@@js.get "sorted"]
      val set_sorted: t -> (a:string -> b:string -> float) or_boolean -> unit [@@js.set "sorted"]
    end
    module[@js.scope "CallSite"] CallSite : sig
      type t = _NodeJS_CallSite
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val getThis: t -> any [@@js.call "getThis"]
      val getTypeName: t -> string or_null [@@js.call "getTypeName"]
      val getFunction: t -> untyped_function or_undefined [@@js.call "getFunction"]
      val getFunctionName: t -> string or_null [@@js.call "getFunctionName"]
      val getMethodName: t -> string or_null [@@js.call "getMethodName"]
      val getFileName: t -> string or_null [@@js.call "getFileName"]
      val getLineNumber: t -> float or_null [@@js.call "getLineNumber"]
      val getColumnNumber: t -> float or_null [@@js.call "getColumnNumber"]
      val getEvalOrigin: t -> string or_undefined [@@js.call "getEvalOrigin"]
      val isToplevel: t -> bool [@@js.call "isToplevel"]
      val isEval: t -> bool [@@js.call "isEval"]
      val isNative: t -> bool [@@js.call "isNative"]
      val isConstructor: t -> bool [@@js.call "isConstructor"]
    end
    module[@js.scope "ErrnoException"] ErrnoException : sig
      type t = _NodeJS_ErrnoException
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_errno: t -> float [@@js.get "errno"]
      val set_errno: t -> float -> unit [@@js.set "errno"]
      val get_code: t -> string [@@js.get "code"]
      val set_code: t -> string -> unit [@@js.set "code"]
      val get_path: t -> string [@@js.get "path"]
      val set_path: t -> string -> unit [@@js.set "path"]
      val get_syscall: t -> string [@@js.get "syscall"]
      val set_syscall: t -> string -> unit [@@js.set "syscall"]
      val get_stack: t -> string [@@js.get "stack"]
      val set_stack: t -> string -> unit [@@js.set "stack"]
      val cast: t -> Error.t_0 [@@js.cast]
    end
    module[@js.scope "ReadableStream"] ReadableStream : sig
      type t = _NodeJS_ReadableStream
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_readable: t -> bool [@@js.get "readable"]
      val set_readable: t -> bool -> unit [@@js.set "readable"]
      val read: t -> ?size:float -> unit -> _Buffer or_string [@@js.call "read"]
      val setEncoding: t -> encoding:_BufferEncoding -> t [@@js.call "setEncoding"]
      val pause: t -> t [@@js.call "pause"]
      val resume: t -> t [@@js.call "resume"]
      val isPaused: t -> bool [@@js.call "isPaused"]
      val pipe: t -> destination:'T -> ?options:anonymous_interface_0 -> unit -> 'T [@@js.call "pipe"]
      val unpipe: t -> ?destination:_NodeJS_WritableStream -> unit -> t [@@js.call "unpipe"]
      val unshift: t -> chunk:Uint8Array.t_0 or_string -> ?encoding:_BufferEncoding -> unit -> unit [@@js.call "unshift"]
      val wrap: t -> oldStream:t -> t [@@js.call "wrap"]
      val _Symbol_asyncIterator_: t -> _Buffer or_string AsyncIterableIterator.t_1 [@@js.call "[Symbol.asyncIterator]"]
      val cast: t -> EventEmitter.t_0 [@@js.cast]
    end
    module[@js.scope "WritableStream"] WritableStream : sig
      type t = _NodeJS_WritableStream
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_writable: t -> bool [@@js.get "writable"]
      val set_writable: t -> bool -> unit [@@js.set "writable"]
      val write: t -> buffer:Uint8Array.t_0 or_string -> ?cb:(?err:Error.t_0 or_null -> unit -> unit) -> unit -> bool [@@js.call "write"]
      val write': t -> str:string -> ?encoding:_BufferEncoding -> ?cb:(?err:Error.t_0 or_null -> unit -> unit) -> unit -> bool [@@js.call "write"]
      val end_: t -> ?cb:(unit -> unit) -> unit -> unit [@@js.call "end"]
      val end_': t -> data:Uint8Array.t_0 or_string -> ?cb:(unit -> unit) -> unit -> unit [@@js.call "end"]
      val end_'': t -> str:string -> ?encoding:_BufferEncoding -> ?cb:(unit -> unit) -> unit -> unit [@@js.call "end"]
      val cast: t -> EventEmitter.t_0 [@@js.cast]
    end
    module[@js.scope "ReadWriteStream"] ReadWriteStream : sig
      type t = _NodeJS_ReadWriteStream
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val cast: t -> _NodeJS_ReadableStream [@@js.cast]
      val cast': t -> _NodeJS_WritableStream [@@js.cast]
    end
    module[@js.scope "Global"] Global : sig
      type t = _NodeJS_Global
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_Array: t -> (* FIXME: unknown type 'typeof Array' *)any [@@js.get "Array"]
      val set_Array: t -> (* FIXME: unknown type 'typeof Array' *)any -> unit [@@js.set "Array"]
      val get_ArrayBuffer: t -> (* FIXME: unknown type 'typeof ArrayBuffer' *)any [@@js.get "ArrayBuffer"]
      val set_ArrayBuffer: t -> (* FIXME: unknown type 'typeof ArrayBuffer' *)any -> unit [@@js.set "ArrayBuffer"]
      val get_Boolean: t -> (* FIXME: unknown type 'typeof Boolean' *)any [@@js.get "Boolean"]
      val set_Boolean: t -> (* FIXME: unknown type 'typeof Boolean' *)any -> unit [@@js.set "Boolean"]
      val get_Buffer: t -> (* FIXME: unknown type 'typeof Buffer' *)any [@@js.get "Buffer"]
      val set_Buffer: t -> (* FIXME: unknown type 'typeof Buffer' *)any -> unit [@@js.set "Buffer"]
      val get_DataView: t -> (* FIXME: unknown type 'typeof DataView' *)any [@@js.get "DataView"]
      val set_DataView: t -> (* FIXME: unknown type 'typeof DataView' *)any -> unit [@@js.set "DataView"]
      val get_Date: t -> (* FIXME: unknown type 'typeof Date' *)any [@@js.get "Date"]
      val set_Date: t -> (* FIXME: unknown type 'typeof Date' *)any -> unit [@@js.set "Date"]
      val get_Error: t -> (* FIXME: unknown type 'typeof Error' *)any [@@js.get "Error"]
      val set_Error: t -> (* FIXME: unknown type 'typeof Error' *)any -> unit [@@js.set "Error"]
      val get_EvalError: t -> (* FIXME: unknown type 'typeof EvalError' *)any [@@js.get "EvalError"]
      val set_EvalError: t -> (* FIXME: unknown type 'typeof EvalError' *)any -> unit [@@js.set "EvalError"]
      val get_Float32Array: t -> (* FIXME: unknown type 'typeof Float32Array' *)any [@@js.get "Float32Array"]
      val set_Float32Array: t -> (* FIXME: unknown type 'typeof Float32Array' *)any -> unit [@@js.set "Float32Array"]
      val get_Float64Array: t -> (* FIXME: unknown type 'typeof Float64Array' *)any [@@js.get "Float64Array"]
      val set_Float64Array: t -> (* FIXME: unknown type 'typeof Float64Array' *)any -> unit [@@js.set "Float64Array"]
      val get_Function: t -> (* FIXME: unknown type 'typeof Function' *)any [@@js.get "Function"]
      val set_Function: t -> (* FIXME: unknown type 'typeof Function' *)any -> unit [@@js.set "Function"]
      val get_Infinity: t -> (* FIXME: unknown type 'typeof Infinity' *)any [@@js.get "Infinity"]
      val set_Infinity: t -> (* FIXME: unknown type 'typeof Infinity' *)any -> unit [@@js.set "Infinity"]
      val get_Int16Array: t -> (* FIXME: unknown type 'typeof Int16Array' *)any [@@js.get "Int16Array"]
      val set_Int16Array: t -> (* FIXME: unknown type 'typeof Int16Array' *)any -> unit [@@js.set "Int16Array"]
      val get_Int32Array: t -> (* FIXME: unknown type 'typeof Int32Array' *)any [@@js.get "Int32Array"]
      val set_Int32Array: t -> (* FIXME: unknown type 'typeof Int32Array' *)any -> unit [@@js.set "Int32Array"]
      val get_Int8Array: t -> (* FIXME: unknown type 'typeof Int8Array' *)any [@@js.get "Int8Array"]
      val set_Int8Array: t -> (* FIXME: unknown type 'typeof Int8Array' *)any -> unit [@@js.set "Int8Array"]
      val get_Intl: t -> (* FIXME: unknown type 'typeof Intl' *)any [@@js.get "Intl"]
      val set_Intl: t -> (* FIXME: unknown type 'typeof Intl' *)any -> unit [@@js.set "Intl"]
      val get_JSON: t -> (* FIXME: unknown type 'typeof JSON' *)any [@@js.get "JSON"]
      val set_JSON: t -> (* FIXME: unknown type 'typeof JSON' *)any -> unit [@@js.set "JSON"]
      val get_Map: t -> MapConstructor.t_0 [@@js.get "Map"]
      val set_Map: t -> MapConstructor.t_0 -> unit [@@js.set "Map"]
      val get_Math: t -> (* FIXME: unknown type 'typeof Math' *)any [@@js.get "Math"]
      val set_Math: t -> (* FIXME: unknown type 'typeof Math' *)any -> unit [@@js.set "Math"]
      val get_NaN: t -> (* FIXME: unknown type 'typeof NaN' *)any [@@js.get "NaN"]
      val set_NaN: t -> (* FIXME: unknown type 'typeof NaN' *)any -> unit [@@js.set "NaN"]
      val get_Number: t -> (* FIXME: unknown type 'typeof Number' *)any [@@js.get "Number"]
      val set_Number: t -> (* FIXME: unknown type 'typeof Number' *)any -> unit [@@js.set "Number"]
      val get_Object: t -> (* FIXME: unknown type 'typeof Object' *)any [@@js.get "Object"]
      val set_Object: t -> (* FIXME: unknown type 'typeof Object' *)any -> unit [@@js.set "Object"]
      val get_Promise: t -> (* FIXME: unknown type 'typeof Promise' *)any [@@js.get "Promise"]
      val set_Promise: t -> (* FIXME: unknown type 'typeof Promise' *)any -> unit [@@js.set "Promise"]
      val get_RangeError: t -> (* FIXME: unknown type 'typeof RangeError' *)any [@@js.get "RangeError"]
      val set_RangeError: t -> (* FIXME: unknown type 'typeof RangeError' *)any -> unit [@@js.set "RangeError"]
      val get_ReferenceError: t -> (* FIXME: unknown type 'typeof ReferenceError' *)any [@@js.get "ReferenceError"]
      val set_ReferenceError: t -> (* FIXME: unknown type 'typeof ReferenceError' *)any -> unit [@@js.set "ReferenceError"]
      val get_RegExp: t -> (* FIXME: unknown type 'typeof RegExp' *)any [@@js.get "RegExp"]
      val set_RegExp: t -> (* FIXME: unknown type 'typeof RegExp' *)any -> unit [@@js.set "RegExp"]
      val get_Set: t -> SetConstructor.t_0 [@@js.get "Set"]
      val set_Set: t -> SetConstructor.t_0 -> unit [@@js.set "Set"]
      val get_String: t -> (* FIXME: unknown type 'typeof String' *)any [@@js.get "String"]
      val set_String: t -> (* FIXME: unknown type 'typeof String' *)any -> unit [@@js.set "String"]
      val get_Symbol: t -> untyped_function [@@js.get "Symbol"]
      val set_Symbol: t -> untyped_function -> unit [@@js.set "Symbol"]
      val get_SyntaxError: t -> (* FIXME: unknown type 'typeof SyntaxError' *)any [@@js.get "SyntaxError"]
      val set_SyntaxError: t -> (* FIXME: unknown type 'typeof SyntaxError' *)any -> unit [@@js.set "SyntaxError"]
      val get_TypeError: t -> (* FIXME: unknown type 'typeof TypeError' *)any [@@js.get "TypeError"]
      val set_TypeError: t -> (* FIXME: unknown type 'typeof TypeError' *)any -> unit [@@js.set "TypeError"]
      val get_URIError: t -> (* FIXME: unknown type 'typeof URIError' *)any [@@js.get "URIError"]
      val set_URIError: t -> (* FIXME: unknown type 'typeof URIError' *)any -> unit [@@js.set "URIError"]
      val get_Uint16Array: t -> (* FIXME: unknown type 'typeof Uint16Array' *)any [@@js.get "Uint16Array"]
      val set_Uint16Array: t -> (* FIXME: unknown type 'typeof Uint16Array' *)any -> unit [@@js.set "Uint16Array"]
      val get_Uint32Array: t -> (* FIXME: unknown type 'typeof Uint32Array' *)any [@@js.get "Uint32Array"]
      val set_Uint32Array: t -> (* FIXME: unknown type 'typeof Uint32Array' *)any -> unit [@@js.set "Uint32Array"]
      val get_Uint8Array: t -> (* FIXME: unknown type 'typeof Uint8Array' *)any [@@js.get "Uint8Array"]
      val set_Uint8Array: t -> (* FIXME: unknown type 'typeof Uint8Array' *)any -> unit [@@js.set "Uint8Array"]
      val get_Uint8ClampedArray: t -> (* FIXME: unknown type 'typeof Uint8ClampedArray' *)any [@@js.get "Uint8ClampedArray"]
      val set_Uint8ClampedArray: t -> (* FIXME: unknown type 'typeof Uint8ClampedArray' *)any -> unit [@@js.set "Uint8ClampedArray"]
      val get_WeakMap: t -> WeakMapConstructor.t_0 [@@js.get "WeakMap"]
      val set_WeakMap: t -> WeakMapConstructor.t_0 -> unit [@@js.set "WeakMap"]
      val get_WeakSet: t -> WeakSetConstructor.t_0 [@@js.get "WeakSet"]
      val set_WeakSet: t -> WeakSetConstructor.t_0 -> unit [@@js.set "WeakSet"]
      val clearImmediate: t -> immediateId:_NodeJS_Immediate -> unit [@@js.call "clearImmediate"]
      val clearInterval: t -> intervalId:_NodeJS_Timeout -> unit [@@js.call "clearInterval"]
      val clearTimeout: t -> timeoutId:_NodeJS_Timeout -> unit [@@js.call "clearTimeout"]
      val get_decodeURI: t -> (* FIXME: unknown type 'typeof decodeURI' *)any [@@js.get "decodeURI"]
      val set_decodeURI: t -> (* FIXME: unknown type 'typeof decodeURI' *)any -> unit [@@js.set "decodeURI"]
      val get_decodeURIComponent: t -> (* FIXME: unknown type 'typeof decodeURIComponent' *)any [@@js.get "decodeURIComponent"]
      val set_decodeURIComponent: t -> (* FIXME: unknown type 'typeof decodeURIComponent' *)any -> unit [@@js.set "decodeURIComponent"]
      val get_encodeURI: t -> (* FIXME: unknown type 'typeof encodeURI' *)any [@@js.get "encodeURI"]
      val set_encodeURI: t -> (* FIXME: unknown type 'typeof encodeURI' *)any -> unit [@@js.set "encodeURI"]
      val get_encodeURIComponent: t -> (* FIXME: unknown type 'typeof encodeURIComponent' *)any [@@js.get "encodeURIComponent"]
      val set_encodeURIComponent: t -> (* FIXME: unknown type 'typeof encodeURIComponent' *)any -> unit [@@js.set "encodeURIComponent"]
      val escape: t -> str:string -> string [@@js.call "escape"]
      val get_eval: t -> (* FIXME: unknown type 'typeof eval' *)any [@@js.get "eval"]
      val set_eval: t -> (* FIXME: unknown type 'typeof eval' *)any -> unit [@@js.set "eval"]
      val get_global: t -> t [@@js.get "global"]
      val set_global: t -> t -> unit [@@js.set "global"]
      val get_isFinite: t -> (* FIXME: unknown type 'typeof isFinite' *)any [@@js.get "isFinite"]
      val set_isFinite: t -> (* FIXME: unknown type 'typeof isFinite' *)any -> unit [@@js.set "isFinite"]
      val get_isNaN: t -> (* FIXME: unknown type 'typeof isNaN' *)any [@@js.get "isNaN"]
      val set_isNaN: t -> (* FIXME: unknown type 'typeof isNaN' *)any -> unit [@@js.set "isNaN"]
      val get_parseFloat: t -> (* FIXME: unknown type 'typeof parseFloat' *)any [@@js.get "parseFloat"]
      val set_parseFloat: t -> (* FIXME: unknown type 'typeof parseFloat' *)any -> unit [@@js.set "parseFloat"]
      val get_parseInt: t -> (* FIXME: unknown type 'typeof parseInt' *)any [@@js.get "parseInt"]
      val set_parseInt: t -> (* FIXME: unknown type 'typeof parseInt' *)any -> unit [@@js.set "parseInt"]
      val setImmediate: t -> callback:(args:(any list [@js.variadic]) -> unit) -> args:(any list [@js.variadic]) -> _NodeJS_Immediate [@@js.call "setImmediate"]
      val setInterval: t -> callback:(args:(any list [@js.variadic]) -> unit) -> ?ms:float -> args:(any list [@js.variadic]) -> _NodeJS_Timeout [@@js.call "setInterval"]
      val setTimeout: t -> callback:(args:(any list [@js.variadic]) -> unit) -> ?ms:float -> args:(any list [@js.variadic]) -> _NodeJS_Timeout [@@js.call "setTimeout"]
      val queueMicrotask: t -> callback:(unit -> unit) -> unit [@@js.call "queueMicrotask"]
      val get_undefined: t -> (* FIXME: unknown type 'typeof undefined' *)any [@@js.get "undefined"]
      val set_undefined: t -> (* FIXME: unknown type 'typeof undefined' *)any -> unit [@@js.set "undefined"]
      val unescape: t -> str:string -> string [@@js.call "unescape"]
      val gc: t -> unit [@@js.call "gc"]
      val get_v8debug: t -> any [@@js.get "v8debug"]
      val set_v8debug: t -> any -> unit [@@js.set "v8debug"]
    end
    module[@js.scope "RefCounted"] RefCounted : sig
      type t = _NodeJS_RefCounted
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val ref: t -> t [@@js.call "ref"]
      val unref: t -> t [@@js.call "unref"]
    end
    module[@js.scope "Timer"] Timer : sig
      type t = _NodeJS_Timer
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val hasRef: t -> bool [@@js.call "hasRef"]
      val refresh: t -> t [@@js.call "refresh"]
      val _Symbol_toPrimitive_: t -> float [@@js.call "[Symbol.toPrimitive]"]
      val cast: t -> _NodeJS_RefCounted [@@js.cast]
    end
    module[@js.scope "Immediate"] Immediate : sig
      type t = _NodeJS_Immediate
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val hasRef: t -> bool [@@js.call "hasRef"]
      val get__onImmediate: t -> untyped_function [@@js.get "_onImmediate"]
      val set__onImmediate: t -> untyped_function -> unit [@@js.set "_onImmediate"]
      val cast: t -> _NodeJS_RefCounted [@@js.cast]
    end
    module[@js.scope "Timeout"] Timeout : sig
      type t = _NodeJS_Timeout
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val hasRef: t -> bool [@@js.call "hasRef"]
      val refresh: t -> t [@@js.call "refresh"]
      val _Symbol_toPrimitive_: t -> float [@@js.call "[Symbol.toPrimitive]"]
      val cast: t -> _NodeJS_Timer [@@js.cast]
    end
    module TypedArray : sig
      type t = _NodeJS_TypedArray
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ArrayBufferView : sig
      type t = _NodeJS_ArrayBufferView
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "Require"] Require : sig
      type t = _NodeJS_Require
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val apply: t -> id:string -> any [@@js.apply]
      val get_resolve: t -> _NodeJS_RequireResolve [@@js.get "resolve"]
      val set_resolve: t -> _NodeJS_RequireResolve -> unit [@@js.set "resolve"]
      val get_cache: t -> _NodeModule _NodeJS_Dict [@@js.get "cache"]
      val set_cache: t -> _NodeModule _NodeJS_Dict -> unit [@@js.set "cache"]
      val get_extensions: t -> _NodeJS_RequireExtensions [@@js.get "extensions"]
      val set_extensions: t -> _NodeJS_RequireExtensions -> unit [@@js.set "extensions"]
      val get_main: t -> _NodeJS_Module or_undefined [@@js.get "main"]
      val set_main: t -> _NodeJS_Module or_undefined -> unit [@@js.set "main"]
    end
    module[@js.scope "RequireResolve"] RequireResolve : sig
      type t = _NodeJS_RequireResolve
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val apply: t -> id:string -> ?options:anonymous_interface_1 -> unit -> string [@@js.apply]
      val paths: t -> request:string -> string list or_null [@@js.call "paths"]
    end
    module[@js.scope "RequireExtensions"] RequireExtensions : sig
      type t = _NodeJS_RequireExtensions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val _js: t -> m:_NodeJS_Module -> filename:string -> any [@@js.call ".js"]
      val _json: t -> m:_NodeJS_Module -> filename:string -> any [@@js.call ".json"]
      val _node: t -> m:_NodeJS_Module -> filename:string -> any [@@js.call ".node"]
      val cast: t -> (m:_NodeJS_Module -> filename:string -> any) _NodeJS_Dict [@@js.cast]
    end
    module[@js.scope "Module"] Module : sig
      type t = _NodeJS_Module
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_exports: t -> any [@@js.get "exports"]
      val set_exports: t -> any -> unit [@@js.set "exports"]
      val get_require: t -> _NodeJS_Require [@@js.get "require"]
      val set_require: t -> _NodeJS_Require -> unit [@@js.set "require"]
      val get_id: t -> string [@@js.get "id"]
      val set_id: t -> string -> unit [@@js.set "id"]
      val get_filename: t -> string [@@js.get "filename"]
      val set_filename: t -> string -> unit [@@js.set "filename"]
      val get_loaded: t -> bool [@@js.get "loaded"]
      val set_loaded: t -> bool -> unit [@@js.set "loaded"]
      val get_parent: t -> t or_null_or_undefined [@@js.get "parent"]
      val set_parent: t -> t or_null_or_undefined -> unit [@@js.set "parent"]
      val get_children: t -> t list [@@js.get "children"]
      val set_children: t -> t list -> unit [@@js.set "children"]
      val get_path: t -> string [@@js.get "path"]
      val set_path: t -> string -> unit [@@js.set "path"]
      val get_paths: t -> string list [@@js.get "paths"]
      val set_paths: t -> string list -> unit [@@js.set "paths"]
    end
    module[@js.scope "Dict"] Dict : sig
      type 'T t = 'T _NodeJS_Dict
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val get: 'T t -> string -> 'T or_undefined [@@js.index_get]
      val set: 'T t -> string -> 'T or_undefined -> unit [@@js.index_set]
    end
    module[@js.scope "ReadOnlyDict"] ReadOnlyDict : sig
      type 'T t = 'T _NodeJS_ReadOnlyDict
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val get: 'T t -> string -> 'T or_undefined [@@js.index_get]
    end
  end
end
