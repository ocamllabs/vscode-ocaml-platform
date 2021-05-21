[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t
end

module Anonymous_interface1 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_fatal : t -> bool [@@js.get "fatal"]

  val set_fatal : t -> bool -> unit [@@js.set "fatal"]

  val get_ignore_bom : t -> bool [@@js.get "ignoreBOM"]

  val set_ignore_bom : t -> bool -> unit [@@js.set "ignoreBOM"]
end

module Anonymous_interface2 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_stream : t -> bool [@@js.get "stream"]

  val set_stream : t -> bool -> unit [@@js.set "stream"]
end

module Util : sig
  module Inspect_options : sig
    include module type of struct
      include Inspect_options
    end
  end

  module Style : sig
    type t =
      ([ `bigint [@js "bigint"]
       | `boolean [@js "boolean"]
       | `date [@js "date"]
       | `module_ [@js "module"]
       | `null [@js "null"]
       | `number [@js "number"]
       | `regexp [@js "regexp"]
       | `special [@js "special"]
       | `string [@js "string"]
       | `symbol [@js "symbol"]
       | `undefined [@js "undefined"]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Inspect_options_stylized : sig
    include module type of struct
      include Inspect_options
    end

    val stylize : t -> text:string -> style_type:Style.t -> string
      [@@js.call "stylize"]
  end
  [@@js.scope "InspectOptionsStylized"]

  module Custom_inspect_function : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val apply : t -> depth:int -> options:Inspect_options_stylized.t -> string
      [@@js.apply]
  end
  [@@js.scope "CustomInspectFunction"]

  val format : ?format:any -> param:(any list[@js.variadic]) -> unit -> string
    [@@js.global "format"]

  val format_with_options :
       inspect_options:Inspect_options.t
    -> ?format:any
    -> param:(any list[@js.variadic])
    -> unit
    -> string
    [@@js.global "formatWithOptions"]

  val log : string:string -> unit [@@js.global "log"]

  val inspect :
       object_:any
    -> ?show_hidden:bool
    -> ?depth:int or_null
    -> ?color:bool
    -> unit
    -> string
    [@@js.global "inspect"]

  val inspect : object_:any -> options:Inspect_options.t -> string
    [@@js.global "inspect"]

  module Inspect : sig
    val colors : (int * int) Dict.t [@@js.global "colors"]

    val styles : (* FIXME: unknown type '{ [K in Style]: string }' *) any
      [@@js.global "styles"]

    val default_options : Inspect_options.t [@@js.global "defaultOptions"]

    val repl_defaults : Inspect_options.t [@@js.global "replDefaults"]

    val custom : (* FIXME: unknown type 'unique symbol' *) any
      [@@js.global "custom"]
  end
  [@@js.scope "inspect"]

  val is_array : object_:any -> bool [@@js.global "isArray"]

  val is_reg_exp : object_:any -> bool [@@js.global "isRegExp"]

  val is_date : object_:any -> bool [@@js.global "isDate"]

  val is_error : object_:any -> bool [@@js.global "isError"]

  val inherits : constructor:any -> super_constructor:any -> unit
    [@@js.global "inherits"]

  val debuglog :
       key:string
    -> (msg:string -> param:(any list[@js.variadic]) -> unit[@js.dummy])
    [@@js.global "debuglog"]

  val is_boolean : object_:any -> bool [@@js.global "isBoolean"]

  val is_buffer : object_:any -> bool [@@js.global "isBuffer"]

  val is_function : object_:any -> bool [@@js.global "isFunction"]

  val is_null : object_:any -> bool [@@js.global "isNull"]

  val is_null_or_undefined : object_:any -> bool
    [@@js.global "isNullOrUndefined"]

  val is_number : object_:any -> bool [@@js.global "isNumber"]

  val is_object : object_:any -> bool [@@js.global "isObject"]

  val is_primitive : object_:any -> bool [@@js.global "isPrimitive"]

  val is_string : object_:any -> bool [@@js.global "isString"]

  val is_symbol : object_:any -> bool [@@js.global "isSymbol"]

  val is_undefined : object_:any -> bool [@@js.global "isUndefined"]

  val deprecate : fn:'T -> message:string -> ?code:string -> unit -> 'T
    [@@js.global "deprecate"]

  val is_deep_strict_equal : val1:any -> val2:any -> bool
    [@@js.global "isDeepStrictEqual"]

  val callbackify :
       fn:(unit -> unit Promise.t)
    -> (callback:(err:Errno_exception.t -> unit) -> unit[@js.dummy])
    [@@js.global "callbackify"]

  val callbackify :
       fn:(unit -> 'TResult Promise.t)
    -> (callback:(err:Errno_exception.t -> result:'TResult -> unit) -> unit
       [@js.dummy])
    [@@js.global "callbackify"]

  val callbackify :
       fn:(arg1:'T1 -> unit Promise.t)
    -> (arg1:'T1 -> callback:(err:Errno_exception.t -> unit) -> unit[@js.dummy])
    [@@js.global "callbackify"]

  val callbackify :
       fn:(arg1:'T1 -> 'TResult Promise.t)
    -> (   arg1:'T1
        -> callback:(err:Errno_exception.t -> result:'TResult -> unit)
        -> unit
       [@js.dummy])
    [@@js.global "callbackify"]

  val callbackify :
       fn:(arg1:'T1 -> arg2:'T2 -> unit Promise.t)
    -> (arg1:'T1 -> arg2:'T2 -> callback:(err:Errno_exception.t -> unit) -> unit
       [@js.dummy])
    [@@js.global "callbackify"]

  val callbackify :
       fn:(arg1:'T1 -> arg2:'T2 -> 'TResult Promise.t)
    -> (   arg1:'T1
        -> arg2:'T2
        -> callback:(err:Errno_exception.t or_null -> result:'TResult -> unit)
        -> unit
       [@js.dummy])
    [@@js.global "callbackify"]

  val callbackify :
       fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> unit Promise.t)
    -> (   arg1:'T1
        -> arg2:'T2
        -> arg3:'T3
        -> callback:(err:Errno_exception.t -> unit)
        -> unit
       [@js.dummy])
    [@@js.global "callbackify"]

  val callbackify :
       fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> 'TResult Promise.t)
    -> (   arg1:'T1
        -> arg2:'T2
        -> arg3:'T3
        -> callback:(err:Errno_exception.t or_null -> result:'TResult -> unit)
        -> unit
       [@js.dummy])
    [@@js.global "callbackify"]

  val callbackify :
       fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> unit Promise.t)
    -> (   arg1:'T1
        -> arg2:'T2
        -> arg3:'T3
        -> arg4:'T4
        -> callback:(err:Errno_exception.t -> unit)
        -> unit
       [@js.dummy])
    [@@js.global "callbackify"]

  val callbackify :
       fn:(arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> 'TResult Promise.t)
    -> (   arg1:'T1
        -> arg2:'T2
        -> arg3:'T3
        -> arg4:'T4
        -> callback:(err:Errno_exception.t or_null -> result:'TResult -> unit)
        -> unit
       [@js.dummy])
    [@@js.global "callbackify"]

  val callbackify :
       fn:
         (   arg1:'T1
          -> arg2:'T2
          -> arg3:'T3
          -> arg4:'T4
          -> arg5:'T5
          -> unit Promise.t)
    -> (   arg1:'T1
        -> arg2:'T2
        -> arg3:'T3
        -> arg4:'T4
        -> arg5:'T5
        -> callback:(err:Errno_exception.t -> unit)
        -> unit
       [@js.dummy])
    [@@js.global "callbackify"]

  val callbackify :
       fn:
         (   arg1:'T1
          -> arg2:'T2
          -> arg3:'T3
          -> arg4:'T4
          -> arg5:'T5
          -> 'TResult Promise.t)
    -> (   arg1:'T1
        -> arg2:'T2
        -> arg3:'T3
        -> arg4:'T4
        -> arg5:'T5
        -> callback:(err:Errno_exception.t or_null -> result:'TResult -> unit)
        -> unit
       [@js.dummy])
    [@@js.global "callbackify"]

  val callbackify :
       fn:
         (   arg1:'T1
          -> arg2:'T2
          -> arg3:'T3
          -> arg4:'T4
          -> arg5:'T5
          -> arg6:'T6
          -> unit Promise.t)
    -> (   arg1:'T1
        -> arg2:'T2
        -> arg3:'T3
        -> arg4:'T4
        -> arg5:'T5
        -> arg6:'T6
        -> callback:(err:Errno_exception.t -> unit)
        -> unit
       [@js.dummy])
    [@@js.global "callbackify"]

  val callbackify :
       fn:
         (   arg1:'T1
          -> arg2:'T2
          -> arg3:'T3
          -> arg4:'T4
          -> arg5:'T5
          -> arg6:'T6
          -> 'TResult Promise.t)
    -> (   arg1:'T1
        -> arg2:'T2
        -> arg3:'T3
        -> arg4:'T4
        -> arg5:'T5
        -> arg6:'T6
        -> callback:(err:Errno_exception.t or_null -> result:'TResult -> unit)
        -> unit
       [@js.dummy])
    [@@js.global "callbackify"]

  module Custom_promisify_legacy : sig
    type 'TCustom t

    val t_to_js : ('TCustom -> Ojs.t) -> 'TCustom t -> Ojs.t

    val t_of_js : (Ojs.t -> 'TCustom) -> Ojs.t -> 'TCustom t

    val get___promisify__ : 'TCustom t -> 'TCustom [@@js.get "__promisify__"]

    val set___promisify__ : 'TCustom t -> 'TCustom -> unit
      [@@js.set "__promisify__"]

    val cast : 'TCustom t -> untyped_function [@@js.cast]
  end
  [@@js.scope "CustomPromisifyLegacy"]

  module Custom_promisify_symbol : sig
    type 'TCustom t

    val t_to_js : ('TCustom -> Ojs.t) -> 'TCustom t -> Ojs.t

    val t_of_js : (Ojs.t -> 'TCustom) -> Ojs.t -> 'TCustom t

    val get__promisify_custom_ : 'TCustom t -> 'TCustom
      [@@js.get "[promisify.custom]"]

    val set__promisify_custom_ : 'TCustom t -> 'TCustom -> unit
      [@@js.set "[promisify.custom]"]

    val cast : 'TCustom t -> untyped_function [@@js.cast]
  end
  [@@js.scope "CustomPromisifySymbol"]

  module Custom_promisify : sig
    type 'TCustom t =
      ( 'TCustom Custom_promisify_legacy.t
      , 'TCustom Custom_promisify_symbol.t )
      union2

    val t_to_js : ('TCustom -> Ojs.t) -> 'TCustom t -> Ojs.t

    val t_of_js : (Ojs.t -> 'TCustom) -> Ojs.t -> 'TCustom t
  end

  val promisify : fn:'TCustom Custom_promisify.t -> 'TCustom
    [@@js.global "promisify"]

  val promisify :
       fn:(callback:(err:any -> result:'TResult -> unit) -> unit)
    -> (unit -> 'TResult Promise.t[@js.dummy])
    [@@js.global "promisify"]

  val promisify :
       fn:(callback:(?err:any -> unit -> unit) -> unit)
    -> (unit -> unit Promise.t[@js.dummy])
    [@@js.global "promisify"]

  val promisify :
       fn:(arg1:'T1 -> callback:(err:any -> result:'TResult -> unit) -> unit)
    -> (arg1:'T1 -> 'TResult Promise.t[@js.dummy])
    [@@js.global "promisify"]

  val promisify :
       fn:(arg1:'T1 -> callback:(?err:any -> unit -> unit) -> unit)
    -> (arg1:'T1 -> unit Promise.t[@js.dummy])
    [@@js.global "promisify"]

  val promisify :
       fn:
         (   arg1:'T1
          -> arg2:'T2
          -> callback:(err:any -> result:'TResult -> unit)
          -> unit)
    -> (arg1:'T1 -> arg2:'T2 -> 'TResult Promise.t[@js.dummy])
    [@@js.global "promisify"]

  val promisify :
       fn:(arg1:'T1 -> arg2:'T2 -> callback:(?err:any -> unit -> unit) -> unit)
    -> (arg1:'T1 -> arg2:'T2 -> unit Promise.t[@js.dummy])
    [@@js.global "promisify"]

  val promisify :
       fn:
         (   arg1:'T1
          -> arg2:'T2
          -> arg3:'T3
          -> callback:(err:any -> result:'TResult -> unit)
          -> unit)
    -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> 'TResult Promise.t[@js.dummy])
    [@@js.global "promisify"]

  val promisify :
       fn:
         (   arg1:'T1
          -> arg2:'T2
          -> arg3:'T3
          -> callback:(?err:any -> unit -> unit)
          -> unit)
    -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> unit Promise.t[@js.dummy])
    [@@js.global "promisify"]

  val promisify :
       fn:
         (   arg1:'T1
          -> arg2:'T2
          -> arg3:'T3
          -> arg4:'T4
          -> callback:(err:any -> result:'TResult -> unit)
          -> unit)
    -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> 'TResult Promise.t
       [@js.dummy])
    [@@js.global "promisify"]

  val promisify :
       fn:
         (   arg1:'T1
          -> arg2:'T2
          -> arg3:'T3
          -> arg4:'T4
          -> callback:(?err:any -> unit -> unit)
          -> unit)
    -> (arg1:'T1 -> arg2:'T2 -> arg3:'T3 -> arg4:'T4 -> unit Promise.t
       [@js.dummy])
    [@@js.global "promisify"]

  val promisify :
       fn:
         (   arg1:'T1
          -> arg2:'T2
          -> arg3:'T3
          -> arg4:'T4
          -> arg5:'T5
          -> callback:(err:any -> result:'TResult -> unit)
          -> unit)
    -> (   arg1:'T1
        -> arg2:'T2
        -> arg3:'T3
        -> arg4:'T4
        -> arg5:'T5
        -> 'TResult Promise.t
       [@js.dummy])
    [@@js.global "promisify"]

  val promisify :
       fn:
         (   arg1:'T1
          -> arg2:'T2
          -> arg3:'T3
          -> arg4:'T4
          -> arg5:'T5
          -> callback:(?err:any -> unit -> unit)
          -> unit)
    -> (   arg1:'T1
        -> arg2:'T2
        -> arg3:'T3
        -> arg4:'T4
        -> arg5:'T5
        -> unit Promise.t
       [@js.dummy])
    [@@js.global "promisify"]

  val promisify : fn:untyped_function -> untyped_function
    [@@js.global "promisify"]

  module Promisify : sig
    val custom : (* FIXME: unknown type 'unique symbol' *) any
      [@@js.global "custom"]
  end
  [@@js.scope "promisify"]

  module Types : sig
    val is_any_array_buffer : object_:any -> bool
      [@@js.global "isAnyArrayBuffer"]

    val is_arguments_object : object_:any -> bool
      [@@js.global "isArgumentsObject"]

    val is_array_buffer : object_:any -> bool [@@js.global "isArrayBuffer"]

    val is_array_buffer_view : object_:any -> bool
      [@@js.global "isArrayBufferView"]

    val is_async_function : object_:any -> bool [@@js.global "isAsyncFunction"]

    val is_big_int64Array : value:any -> bool [@@js.global "isBigInt64Array"]

    val is_big_uint64Array : value:any -> bool [@@js.global "isBigUint64Array"]

    val is_boolean_object : object_:any -> bool [@@js.global "isBooleanObject"]

    val is_boxed_primitive : object_:any -> bool
      [@@js.global "isBoxedPrimitive"]

    val is_data_view : object_:any -> bool [@@js.global "isDataView"]

    val is_date : object_:any -> bool [@@js.global "isDate"]

    val is_external : object_:any -> bool [@@js.global "isExternal"]

    val is_float32Array : object_:any -> bool [@@js.global "isFloat32Array"]

    val is_float64Array : object_:any -> bool [@@js.global "isFloat64Array"]

    val is_generator_function : object_:any -> bool
      [@@js.global "isGeneratorFunction"]

    val is_generator_object : object_:any -> bool
      [@@js.global "isGeneratorObject"]

    val is_int8Array : object_:any -> bool [@@js.global "isInt8Array"]

    val is_int16Array : object_:any -> bool [@@js.global "isInt16Array"]

    val is_int32Array : object_:any -> bool [@@js.global "isInt32Array"]

    val is_map : object_:('T, Anonymous_interface0.t) union2 -> bool
      [@@js.global "isMap"]

    val is_map_iterator : object_:any -> bool [@@js.global "isMapIterator"]

    val is_module_namespace_object : value:any -> bool
      [@@js.global "isModuleNamespaceObject"]

    val is_native_error : object_:any -> bool [@@js.global "isNativeError"]

    val is_number_object : object_:any -> bool [@@js.global "isNumberObject"]

    val is_promise : object_:any -> bool [@@js.global "isPromise"]

    val is_proxy : object_:any -> bool [@@js.global "isProxy"]

    val is_reg_exp : object_:any -> bool [@@js.global "isRegExp"]

    val is_set : object_:('T, Anonymous_interface0.t) union2 -> bool
      [@@js.global "isSet"]

    val is_set_iterator : object_:any -> bool [@@js.global "isSetIterator"]

    val is_shared_array_buffer : object_:any -> bool
      [@@js.global "isSharedArrayBuffer"]

    val is_string_object : object_:any -> bool [@@js.global "isStringObject"]

    val is_symbol_object : object_:any -> bool [@@js.global "isSymbolObject"]

    val is_typed_array : object_:any -> bool [@@js.global "isTypedArray"]

    val is_uint8Array : object_:any -> bool [@@js.global "isUint8Array"]

    val is_uint8ClampedArray : object_:any -> bool
      [@@js.global "isUint8ClampedArray"]

    val is_uint16Array : object_:any -> bool [@@js.global "isUint16Array"]

    val is_uint32Array : object_:any -> bool [@@js.global "isUint32Array"]

    val is_weak_map : object_:any -> bool [@@js.global "isWeakMap"]

    val is_weak_set : object_:any -> bool [@@js.global "isWeakSet"]
  end
  [@@js.scope "types"]

  module Text_decoder : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_encoding : t -> string [@@js.get "encoding"]

    val get_fatal : t -> bool [@@js.get "fatal"]

    val get_ignore_bom : t -> bool [@@js.get "ignoreBOM"]

    val create :
      ?encoding:string -> ?options:Anonymous_interface1.t -> unit -> t
      [@@js.create]

    val decode :
         t
      -> ?input:(Array_buffer.t, Array_buffer_view.t) union2 or_null
      -> ?options:Anonymous_interface2.t
      -> unit
      -> string
      [@@js.call "decode"]
  end
  [@@js.scope "TextDecoder"]

  module Encode_into_result : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_read : t -> int [@@js.get "read"]

    val set_read : t -> int -> unit [@@js.set "read"]

    val get_written : t -> int [@@js.get "written"]

    val set_written : t -> int -> unit [@@js.set "written"]
  end
  [@@js.scope "EncodeIntoResult"]

  module Text_encoder : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_encoding : t -> string [@@js.get "encoding"]

    val encode : t -> ?input:string -> unit -> Uint8_array.t
      [@@js.call "encode"]

    val encode_into :
      t -> input:string -> output:Uint8_array.t -> Encode_into_result.t
      [@@js.call "encodeInto"]
  end
  [@@js.scope "TextEncoder"]
end
[@@js.scope Import.util]
