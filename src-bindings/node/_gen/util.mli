[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - ArrayBuffer
  - NodeJS.ArrayBufferView
  - NodeJS.Dict<T1>
  - NodeJS.ErrnoException
  - NodeJS.InspectOptions
  - Promise<T1>
  - Uint8Array
 *)
[@@@js.stop]
module type Missing = sig
  module ArrayBuffer : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module NodeJS : sig
    module ArrayBufferView : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Dict : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module ErrnoException : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module InspectOptions : sig
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
  module Uint8Array : sig
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
    module NodeJS : sig
      module ArrayBufferView : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module Dict : sig
        type 'T1 t_1
        val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
        val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
      end
      module ErrnoException : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module InspectOptions : sig
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
    module Uint8Array : sig
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
    end
    module Types : sig
      open AnonymousInterfaces
      type util_CustomInspectFunction = [`Util_CustomInspectFunction] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'TCustom util_CustomPromisify = ('TCustom util_CustomPromisifyLegacy, 'TCustom util_CustomPromisifySymbol) union2
      and 'TCustom util_CustomPromisifyLegacy = [`Util_CustomPromisifyLegacy of 'TCustom | `Function] intf
      [@@js.custom { of_js=(fun _TCustom -> Obj.magic); to_js=(fun _TCustom -> Obj.magic) }]
      and 'TCustom util_CustomPromisifySymbol = [`Util_CustomPromisifySymbol of 'TCustom | `Function] intf
      [@@js.custom { of_js=(fun _TCustom -> Obj.magic); to_js=(fun _TCustom -> Obj.magic) }]
      and util_EncodeIntoResult = [`Util_EncodeIntoResult] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and util_InspectOptions = [`Util_InspectOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and util_InspectOptionsStylized = [`Util_InspectOptionsStylized | `Util_InspectOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and util_Style = ([`L_s0_bigint[@js "bigint"] | `L_s1_boolean[@js "boolean"] | `L_s2_date[@js "date"] | `L_s3_module[@js "module"] | `L_s4_null[@js "null"] | `L_s5_number[@js "number"] | `L_s6_regexp[@js "regexp"] | `L_s7_special[@js "special"] | `L_s8_string[@js "string"] | `L_s9_symbol[@js "symbol"] | `L_s10_undefined[@js "undefined"]] [@js.enum])
      and util_TextDecoder = [`Util_TextDecoder] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and util_TextEncoder = [`Util_TextEncoder] intf
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
  end
  module AnonymousInterface1 : sig
    type t = anonymous_interface_1
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_fatal: t -> bool [@@js.get "fatal"]
    val set_fatal: t -> bool -> unit [@@js.set "fatal"]
    val get_ignoreBOM: t -> bool [@@js.get "ignoreBOM"]
    val set_ignoreBOM: t -> bool -> unit [@@js.set "ignoreBOM"]
  end
  module AnonymousInterface2 : sig
    type t = anonymous_interface_2
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_stream: t -> bool [@@js.get "stream"]
    val set_stream: t -> bool -> unit [@@js.set "stream"]
  end
  module[@js.scope "node:util"] Node_util : sig
    (* export * from 'util'; *)
  end
  module[@js.scope "util"] Util : sig
    module[@js.scope "InspectOptions"] InspectOptions : sig
      type t = util_InspectOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val cast: t -> NodeJS.InspectOptions.t_0 [@@js.cast]
    end
    module Style : sig
      type t = util_Style
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "CustomInspectFunction"] CustomInspectFunction : sig
      type t = util_CustomInspectFunction
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val apply: t -> depth:float -> options:util_InspectOptionsStylized -> string [@@js.apply]
    end
    module[@js.scope "InspectOptionsStylized"] InspectOptionsStylized : sig
      type t = util_InspectOptionsStylized
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val stylize: t -> text:string -> styleType:util_Style -> string [@@js.call "stylize"]
      val cast: t -> util_InspectOptions [@@js.cast]
    end
    val format: ?format:any -> param:(any list [@js.variadic]) -> string [@@js.global "format"]
    val formatWithOptions: inspectOptions:util_InspectOptions -> ?format:any -> param:(any list [@js.variadic]) -> string [@@js.global "formatWithOptions"]
    val log: string:string -> unit [@@js.global "log"]
    val inspect: object_:any -> ?showHidden:bool -> ?depth:float or_null -> ?color:bool -> unit -> string [@@js.global "inspect"]
    val inspect: object_:any -> options:util_InspectOptions -> string [@@js.global "inspect"]
    module[@js.scope "inspect"] Inspect : sig
      val colors: (float * float) NodeJS.Dict.t_1 [@@js.global "colors"]
      val styles: (* FIXME: unknown type '{
                  [K in Style]: string
              }' *)any [@@js.global "styles"]
      val defaultOptions: util_InspectOptions [@@js.global "defaultOptions"]
      val replDefaults: util_InspectOptions [@@js.global "replDefaults"]
      val custom: (* FIXME: unknown type 'unique symbol' *)any [@@js.global "custom"]
    end
    val isArray: object_:any -> bool [@@js.global "isArray"]
    val isRegExp: object_:any -> bool [@@js.global "isRegExp"]
    val isDate: object_:any -> bool [@@js.global "isDate"]
    val isError: object_:any -> bool [@@js.global "isError"]
    val inherits: constructor:any -> superConstructor:any -> unit [@@js.global "inherits"]
    val debuglog: key:string -> (msg:string -> param:(any list [@js.variadic]) -> unit [@js.dummy]) [@@js.global "debuglog"]
    val isBoolean: object_:any -> bool [@@js.global "isBoolean"]
    val isBuffer: object_:any -> bool [@@js.global "isBuffer"]
    val isFunction: object_:any -> bool [@@js.global "isFunction"]
    val isNull: object_:any -> bool [@@js.global "isNull"]
    val isNullOrUndefined: object_:any -> bool [@@js.global "isNullOrUndefined"]
    val isNumber: object_:any -> bool [@@js.global "isNumber"]
    val isObject: object_:any -> bool [@@js.global "isObject"]
    val isPrimitive: object_:any -> bool [@@js.global "isPrimitive"]
    val isString: object_:any -> bool [@@js.global "isString"]
    val isSymbol: object_:any -> bool [@@js.global "isSymbol"]
    val isUndefined: object_:any -> bool [@@js.global "isUndefined"]
    val deprecate: fn:'T -> message:string -> ?code:string -> unit -> 'T [@@js.global "deprecate"]
    val isDeepStrictEqual: val1:any -> val2:any -> bool [@@js.global "isDeepStrictEqual"]
    val callbackify: fn:(unit -> unit Promise.t_1) -> (callback:(err:NodeJS.ErrnoException.t_0 -> unit) -> unit [@js.dummy]) [@@js.global "callbackify"]
    val callbackify: fn:(unit -> 'TResult Promise.t_1) -> (callback:(err:NodeJS.ErrnoException.t_0 -> result:'TResult -> unit) -> unit [@js.dummy]) [@@js.global "callbackify"]
    val callbackify: fn:(arg1:'T1 -> unit Promise.t_1) -> (arg1:'T1 -> callback:(err:NodeJS.ErrnoException.t_0 -> unit) -> unit [@js.dummy]) [@@js.global "callbackify"]
    val callbackify: fn:(arg1:'T1 -> 'TResult Promise.t_1) -> (arg1:'T1 -> callback:(err:NodeJS.ErrnoException.t_0 -> result:'TResult -> unit) -> unit [@js.dummy]) [@@js.global "callbackify"]
    val callbackify: fn:(arg1:'T1 -> arg2:'T2 -> unit Promise.t_1) -> (arg1:'T1 -> arg2:'T2 -> callback:(err:NodeJS.ErrnoException.t_0 -> unit) -> unit [@js.dummy]) [@@js.global "callbackify"]
    val callbackify: fn:(arg1:'T1 -> arg2:'T2 -> 'TResult Promise.t_1) -> (arg1:'T1 -> arg2:'T2 -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> result:'TResult -> unit) -> unit [@js.dummy]) [@@js.global "callbackify"]
    val callbackify: fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> unit Promise.t_1) -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> callback:(err:NodeJS.ErrnoException.t_0 -> unit) -> unit [@js.dummy]) [@@js.global "callbackify"]
    val callbackify: fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> 'TResult Promise.t_1) -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> result:'TResult -> unit) -> unit [@js.dummy]) [@@js.global "callbackify"]
    val callbackify: fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> unit Promise.t_1) -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> callback:(err:NodeJS.ErrnoException.t_0 -> unit) -> unit [@js.dummy]) [@@js.global "callbackify"]
    val callbackify: fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> 'TResult Promise.t_1) -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> result:'TResult -> unit) -> unit [@js.dummy]) [@@js.global "callbackify"]
    val callbackify: fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> arg5:'T5 -> unit Promise.t_1) -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> arg5:'T5 -> callback:(err:NodeJS.ErrnoException.t_0 -> unit) -> unit [@js.dummy]) [@@js.global "callbackify"]
    val callbackify: fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> arg5:'T5 -> 'TResult Promise.t_1) -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> arg5:'T5 -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> result:'TResult -> unit) -> unit [@js.dummy]) [@@js.global "callbackify"]
    val callbackify: fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> arg5:'T5 -> arg6:'T6 -> unit Promise.t_1) -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> arg5:'T5 -> arg6:'T6 -> callback:(err:NodeJS.ErrnoException.t_0 -> unit) -> unit [@js.dummy]) [@@js.global "callbackify"]
    val callbackify: fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> arg5:'T5 -> arg6:'T6 -> 'TResult Promise.t_1) -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> arg5:'T5 -> arg6:'T6 -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> result:'TResult -> unit) -> unit [@js.dummy]) [@@js.global "callbackify"]
    module[@js.scope "CustomPromisifyLegacy"] CustomPromisifyLegacy : sig
      type 'TCustom t = 'TCustom util_CustomPromisifyLegacy
      val t_to_js: ('TCustom -> Ojs.t) -> 'TCustom t -> Ojs.t
      val t_of_js: (Ojs.t -> 'TCustom) -> Ojs.t -> 'TCustom t
      type 'TCustom t_1 = 'TCustom t
      val t_1_to_js: ('TCustom -> Ojs.t) -> 'TCustom t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'TCustom) -> Ojs.t -> 'TCustom t_1
      val get___promisify__: 'TCustom t -> 'TCustom [@@js.get "__promisify__"]
      val set___promisify__: 'TCustom t -> 'TCustom -> unit [@@js.set "__promisify__"]
      val cast: 'TCustom t -> untyped_function [@@js.cast]
    end
    module[@js.scope "CustomPromisifySymbol"] CustomPromisifySymbol : sig
      type 'TCustom t = 'TCustom util_CustomPromisifySymbol
      val t_to_js: ('TCustom -> Ojs.t) -> 'TCustom t -> Ojs.t
      val t_of_js: (Ojs.t -> 'TCustom) -> Ojs.t -> 'TCustom t
      type 'TCustom t_1 = 'TCustom t
      val t_1_to_js: ('TCustom -> Ojs.t) -> 'TCustom t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'TCustom) -> Ojs.t -> 'TCustom t_1
      val get__promisify_custom_: 'TCustom t -> 'TCustom [@@js.get "[promisify.custom]"]
      val set__promisify_custom_: 'TCustom t -> 'TCustom -> unit [@@js.set "[promisify.custom]"]
      val cast: 'TCustom t -> untyped_function [@@js.cast]
    end
    module CustomPromisify : sig
      type 'TCustom t = 'TCustom util_CustomPromisify
      val t_to_js: ('TCustom -> Ojs.t) -> 'TCustom t -> Ojs.t
      val t_of_js: (Ojs.t -> 'TCustom) -> Ojs.t -> 'TCustom t
      type 'TCustom t_1 = 'TCustom t
      val t_1_to_js: ('TCustom -> Ojs.t) -> 'TCustom t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'TCustom) -> Ojs.t -> 'TCustom t_1
    end
    val promisify: fn:'TCustom util_CustomPromisify -> 'TCustom [@@js.global "promisify"]
    val promisify: fn:(callback:(err:any -> result:'TResult -> unit) -> unit) -> (unit -> 'TResult Promise.t_1 [@js.dummy]) [@@js.global "promisify"]
    val promisify: fn:(callback:(?err:any -> unit -> unit) -> unit) -> (unit -> unit Promise.t_1 [@js.dummy]) [@@js.global "promisify"]
    val promisify: fn:(arg1:'T1 -> callback:(err:any -> result:'TResult -> unit) -> unit) -> (arg1:'T1 -> 'TResult Promise.t_1 [@js.dummy]) [@@js.global "promisify"]
    val promisify: fn:(arg1:'T1 -> callback:(?err:any -> unit -> unit) -> unit) -> (arg1:'T1 -> unit Promise.t_1 [@js.dummy]) [@@js.global "promisify"]
    val promisify: fn:(arg1:'T1 -> arg2:'T2 -> callback:(err:any -> result:'TResult -> unit) -> unit) -> (arg1:'T1 -> arg2:'T2 -> 'TResult Promise.t_1 [@js.dummy]) [@@js.global "promisify"]
    val promisify: fn:(arg1:'T1 -> arg2:'T2 -> callback:(?err:any -> unit -> unit) -> unit) -> (arg1:'T1 -> arg2:'T2 -> unit Promise.t_1 [@js.dummy]) [@@js.global "promisify"]
    val promisify: fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> callback:(err:any -> result:'TResult -> unit) -> unit) -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> 'TResult Promise.t_1 [@js.dummy]) [@@js.global "promisify"]
    val promisify: fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> callback:(?err:any -> unit -> unit) -> unit) -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> unit Promise.t_1 [@js.dummy]) [@@js.global "promisify"]
    val promisify: fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> callback:(err:any -> result:'TResult -> unit) -> unit) -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> 'TResult Promise.t_1 [@js.dummy]) [@@js.global "promisify"]
    val promisify: fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> callback:(?err:any -> unit -> unit) -> unit) -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> unit Promise.t_1 [@js.dummy]) [@@js.global "promisify"]
    val promisify: fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> arg5:'T5 -> callback:(err:any -> result:'TResult -> unit) -> unit) -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> arg5:'T5 -> 'TResult Promise.t_1 [@js.dummy]) [@@js.global "promisify"]
    val promisify: fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> arg5:'T5 -> callback:(?err:any -> unit -> unit) -> unit) -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> arg5:'T5 -> unit Promise.t_1 [@js.dummy]) [@@js.global "promisify"]
    val promisify: fn:untyped_function -> untyped_function [@@js.global "promisify"]
    module[@js.scope "promisify"] Promisify : sig
      val custom: (* FIXME: unknown type 'unique symbol' *)any [@@js.global "custom"]
    end
    module[@js.scope "types"] Types : sig
      val isAnyArrayBuffer: object_:any -> bool [@@js.global "isAnyArrayBuffer"]
      val isArgumentsObject: object_:any -> bool [@@js.global "isArgumentsObject"]
      val isArrayBuffer: object_:any -> bool [@@js.global "isArrayBuffer"]
      val isArrayBufferView: object_:any -> bool [@@js.global "isArrayBufferView"]
      val isAsyncFunction: object_:any -> bool [@@js.global "isAsyncFunction"]
      val isBigInt64Array: value:any -> bool [@@js.global "isBigInt64Array"]
      val isBigUint64Array: value:any -> bool [@@js.global "isBigUint64Array"]
      val isBooleanObject: object_:any -> bool [@@js.global "isBooleanObject"]
      val isBoxedPrimitive: object_:any -> bool [@@js.global "isBoxedPrimitive"]
      val isDataView: object_:any -> bool [@@js.global "isDataView"]
      val isDate: object_:any -> bool [@@js.global "isDate"]
      val isExternal: object_:any -> bool [@@js.global "isExternal"]
      val isFloat32Array: object_:any -> bool [@@js.global "isFloat32Array"]
      val isFloat64Array: object_:any -> bool [@@js.global "isFloat64Array"]
      val isGeneratorFunction: object_:any -> bool [@@js.global "isGeneratorFunction"]
      val isGeneratorObject: object_:any -> bool [@@js.global "isGeneratorObject"]
      val isInt8Array: object_:any -> bool [@@js.global "isInt8Array"]
      val isInt16Array: object_:any -> bool [@@js.global "isInt16Array"]
      val isInt32Array: object_:any -> bool [@@js.global "isInt32Array"]
      val isMap: object_:('T, anonymous_interface_0) union2 -> bool [@@js.global "isMap"]
      val isMapIterator: object_:any -> bool [@@js.global "isMapIterator"]
      val isModuleNamespaceObject: value:any -> bool [@@js.global "isModuleNamespaceObject"]
      val isNativeError: object_:any -> bool [@@js.global "isNativeError"]
      val isNumberObject: object_:any -> bool [@@js.global "isNumberObject"]
      val isPromise: object_:any -> bool [@@js.global "isPromise"]
      val isProxy: object_:any -> bool [@@js.global "isProxy"]
      val isRegExp: object_:any -> bool [@@js.global "isRegExp"]
      val isSet: object_:('T, anonymous_interface_0) union2 -> bool [@@js.global "isSet"]
      val isSetIterator: object_:any -> bool [@@js.global "isSetIterator"]
      val isSharedArrayBuffer: object_:any -> bool [@@js.global "isSharedArrayBuffer"]
      val isStringObject: object_:any -> bool [@@js.global "isStringObject"]
      val isSymbolObject: object_:any -> bool [@@js.global "isSymbolObject"]
      val isTypedArray: object_:any -> bool [@@js.global "isTypedArray"]
      val isUint8Array: object_:any -> bool [@@js.global "isUint8Array"]
      val isUint8ClampedArray: object_:any -> bool [@@js.global "isUint8ClampedArray"]
      val isUint16Array: object_:any -> bool [@@js.global "isUint16Array"]
      val isUint32Array: object_:any -> bool [@@js.global "isUint32Array"]
      val isWeakMap: object_:any -> bool [@@js.global "isWeakMap"]
      val isWeakSet: object_:any -> bool [@@js.global "isWeakSet"]
    end
    module[@js.scope "TextDecoder"] TextDecoder : sig
      type t = util_TextDecoder
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_encoding: t -> string [@@js.get "encoding"]
      val get_fatal: t -> bool [@@js.get "fatal"]
      val get_ignoreBOM: t -> bool [@@js.get "ignoreBOM"]
      val create: ?encoding:string -> ?options:anonymous_interface_1 -> unit -> t [@@js.create]
      val decode: t -> ?input:(ArrayBuffer.t_0, NodeJS.ArrayBufferView.t_0) union2 or_null -> ?options:anonymous_interface_2 -> unit -> string [@@js.call "decode"]
    end
    module[@js.scope "EncodeIntoResult"] EncodeIntoResult : sig
      type t = util_EncodeIntoResult
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_read: t -> float [@@js.get "read"]
      val set_read: t -> float -> unit [@@js.set "read"]
      val get_written: t -> float [@@js.get "written"]
      val set_written: t -> float -> unit [@@js.set "written"]
    end
    module[@js.scope "TextEncoder"] TextEncoder : sig
      type t = util_TextEncoder
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_encoding: t -> string [@@js.get "encoding"]
      val encode: t -> ?input:string -> unit -> Uint8Array.t_0 [@@js.call "encode"]
      val encodeInto: t -> input:string -> output:Uint8Array.t_0 -> util_EncodeIntoResult [@@js.call "encodeInto"]
    end
  end
end
