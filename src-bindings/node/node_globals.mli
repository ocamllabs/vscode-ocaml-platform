[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_end : t -> bool [@@js.get "end"]

  val set_end : t -> bool -> unit [@@js.set "end"]
end

module Anonymous_interface1 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_paths : t -> string list [@@js.get "paths"]

  val set_paths : t -> string list -> unit [@@js.set "paths"]
end

module Anonymous_interface2 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_type : t -> ([ `Buffer [@js "Buffer"] ][@js.enum]) [@@js.get "type"]

  val set_type : t -> ([ `Buffer ][@js.enum]) -> unit [@@js.set "type"]

  val get_data : t -> int list [@@js.get "data"]

  val set_data : t -> int list -> unit [@@js.set "data"]
end

module Anonymous_interface3 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val value_of : t -> 'T [@@js.call "valueOf"]
end

module Call_site : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_this : t -> any [@@js.call "getThis"]

  val get_type_name : t -> string or_null [@@js.call "getTypeName"]

  val get_function : t -> untyped_function or_undefined
    [@@js.call "getFunction"]

  val get_function_name : t -> string or_null [@@js.call "getFunctionName"]

  val get_method_name : t -> string or_null [@@js.call "getMethodName"]

  val get_file_name : t -> string or_null [@@js.call "getFileName"]

  val get_line_number : t -> int or_null [@@js.call "getLineNumber"]

  val get_column_number : t -> int or_null [@@js.call "getColumnNumber"]

  val get_eval_origin : t -> string or_undefined [@@js.call "getEvalOrigin"]

  val is_toplevel : t -> bool [@@js.call "isToplevel"]

  val is_eval : t -> bool [@@js.call "isEval"]

  val is_native : t -> bool [@@js.call "isNative"]

  val is_constructor : t -> bool [@@js.call "isConstructor"]
end
[@@js.scope "CallSite"]

module Error_constructor : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val capture_stack_trace :
       t
    -> target_object:untyped_object
    -> ?constructor_opt:untyped_function
    -> unit
    -> unit
    [@@js.call "captureStackTrace"]

  val prepare_stack_trace :
    t -> err:Error.t -> stack_traces:Call_site.t list -> any
    [@@js.call "prepareStackTrace"]

  val get_stack_trace_limit : t -> int [@@js.get "stackTraceLimit"]

  val set_stack_trace_limit : t -> int -> unit [@@js.set "stackTraceLimit"]
end
[@@js.scope "ErrorConstructor"]

module String : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val trim_left : t -> string [@@js.call "trimLeft"]

  val trim_right : t -> string [@@js.call "trimRight"]

  val trim_start : t -> string [@@js.call "trimStart"]

  val trim_end : t -> string [@@js.call "trimEnd"]

  val to_ml : t -> string [@@js.cast]

  val of_ml : string -> t [@@js.cast]
end
[@@js.scope "String"]

module Import_meta : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_url : t -> string [@@js.get "url"]

  val set_url : t -> string -> unit [@@js.set "url"]
end
[@@js.scope "ImportMeta"]

module Buffer_encoding : sig
  type t =
    ([ `ascii [@js "ascii"]
     | `base64 [@js "base64"]
     | `binary [@js "binary"]
     | `hex [@js "hex"]
     | `latin1 [@js "latin1"]
     | `ucs_2 [@js "ucs-2"]
     | `ucs2 [@js "ucs2"]
     | `utf_8 [@js "utf-8"]
     | `utf16le [@js "utf16le"]
     | `utf8 [@js "utf8"]
     | `buffer [@js "buffer"]
     ]
    [@js.enum])

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t
end

module With_implicit_coercion : sig
  type 'T t = ('T, Anonymous_interface3.t) union2

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t
end

module Buffer : sig
  include module type of struct
    include Uint8_array
  end

  val create : string -> ?encoding:Buffer_encoding.t -> unit -> t [@@js.create]

  val create' : int -> t [@@js.create]

  val create'' : Uint8_array.t -> t [@@js.create]

  val create''' : (Array_buffer.t, Shared_array_buffer.t) union2 -> t
    [@@js.create]

  val create'''' : any list -> t [@@js.create]

  val create''''' : t -> t [@@js.create]

  val from :
       array_buffer:
         (Array_buffer.t, Shared_array_buffer.t) union2 With_implicit_coercion.t
    -> ?byte_offset:int
    -> ?length:int
    -> unit
    -> t
    [@@js.global "from"]

  val from' : (Uint8_array.t, int list) union2 -> t [@@js.global "from"]

  val from'' :
    (Uint8_array.t, int list) union2 or_string With_implicit_coercion.t -> t
    [@@js.global "from"]

  val of_ : (int list[@js.variadic]) -> t [@@js.global "of"]

  val is_buffer : obj:any -> bool [@@js.global "isBuffer"]

  val is_encoding : encoding:string -> bool [@@js.global "isEncoding"]

  val byte_length :
       string:
         (Array_buffer.t, Array_buffer_view.t, Shared_array_buffer.t) union3
         or_string
    -> ?encoding:Buffer_encoding.t
    -> unit
    -> int
    [@@js.global "byteLength"]

  val concat : Uint8_array.t list -> ?total_length:int -> unit -> t
    [@@js.global "concat"]

  val compare : Uint8_array.t -> Uint8_array.t -> int [@@js.global "compare"]

  val alloc :
       int
    -> ?fill:t or_string or_number
    -> ?encoding:Buffer_encoding.t
    -> unit
    -> t
    [@@js.global "alloc"]

  val alloc_unsafe : int -> t [@@js.global "allocUnsafe"]

  val alloc_unsafe_slow : int -> t [@@js.global "allocUnsafeSlow"]

  val get_pool_size : unit -> int [@@js.get "poolSize"]

  val set_pool_size : int -> unit [@@js.set "poolSize"]

  val write : t -> string -> ?encoding:Buffer_encoding.t -> unit -> int
    [@@js.call "write"]

  val write' :
    t -> string -> offset:int -> ?encoding:Buffer_encoding.t -> unit -> int
    [@@js.call "write"]

  val write'' :
       t
    -> string
    -> offset:int
    -> length:int
    -> ?encoding:Buffer_encoding.t
    -> unit
    -> int
    [@@js.call "write"]

  val to_string :
       t
    -> ?encoding:Buffer_encoding.t
    -> ?start:int
    -> ?end_:int
    -> unit
    -> string
    [@@js.call "toString"]

  val to_json : t -> Anonymous_interface2.t [@@js.call "toJSON"]

  val equals : t -> other_buffer:Uint8_array.t -> bool [@@js.call "equals"]

  val compare' :
       t
    -> other_buffer:Uint8_array.t
    -> ?target_start:int
    -> ?target_end:int
    -> ?source_start:int
    -> ?source_end:int
    -> unit
    -> int
    [@@js.call "compare"]

  val copy :
       t
    -> target_buffer:Uint8_array.t
    -> ?target_start:int
    -> ?source_start:int
    -> ?source_end:int
    -> unit
    -> int
    [@@js.call "copy"]

  val slice : t -> ?begin_:int -> ?end_:int -> unit -> t [@@js.call "slice"]

  val subarray : t -> ?begin_:int -> ?end_:int -> unit -> t
    [@@js.call "subarray"]

  val write_big_int64_be : t -> bigint -> ?offset:int -> unit -> int
    [@@js.call "writeBigInt64BE"]

  val write_big_int64_le : t -> bigint -> ?offset:int -> unit -> int
    [@@js.call "writeBigInt64LE"]

  val write_big_u_int64_be : t -> bigint -> ?offset:int -> unit -> int
    [@@js.call "writeBigUInt64BE"]

  val write_big_u_int64_le : t -> bigint -> ?offset:int -> unit -> int
    [@@js.call "writeBigUInt64LE"]

  val write_u_int_le : t -> value:int -> offset:int -> byte_length:int -> int
    [@@js.call "writeUIntLE"]

  val write_u_int_be : t -> value:int -> offset:int -> byte_length:int -> int
    [@@js.call "writeUIntBE"]

  val write_int_le : t -> value:int -> offset:int -> byte_length:int -> int
    [@@js.call "writeIntLE"]

  val write_int_be : t -> value:int -> offset:int -> byte_length:int -> int
    [@@js.call "writeIntBE"]

  val read_big_u_int64_be : t -> ?offset:int -> unit -> bigint
    [@@js.call "readBigUInt64BE"]

  val read_big_u_int64_le : t -> ?offset:int -> unit -> bigint
    [@@js.call "readBigUInt64LE"]

  val read_big_int64_be : t -> ?offset:int -> unit -> bigint
    [@@js.call "readBigInt64BE"]

  val read_big_int64_le : t -> ?offset:int -> unit -> bigint
    [@@js.call "readBigInt64LE"]

  val read_u_int_le : t -> offset:int -> byte_length:int -> int
    [@@js.call "readUIntLE"]

  val read_u_int_be : t -> offset:int -> byte_length:int -> int
    [@@js.call "readUIntBE"]

  val read_int_le : t -> offset:int -> byte_length:int -> int
    [@@js.call "readIntLE"]

  val read_int_be : t -> offset:int -> byte_length:int -> int
    [@@js.call "readIntBE"]

  val read_u_int8 : t -> ?offset:int -> unit -> int [@@js.call "readUInt8"]

  val read_u_int16_le : t -> ?offset:int -> unit -> int
    [@@js.call "readUInt16LE"]

  val read_u_int16_be : t -> ?offset:int -> unit -> int
    [@@js.call "readUInt16BE"]

  val read_u_int32_le : t -> ?offset:int -> unit -> int
    [@@js.call "readUInt32LE"]

  val read_u_int32_be : t -> ?offset:int -> unit -> int
    [@@js.call "readUInt32BE"]

  val read_int8 : t -> ?offset:int -> unit -> int [@@js.call "readInt8"]

  val read_int16_le : t -> ?offset:int -> unit -> int [@@js.call "readInt16LE"]

  val read_int16_be : t -> ?offset:int -> unit -> int [@@js.call "readInt16BE"]

  val read_int32_le : t -> ?offset:int -> unit -> int [@@js.call "readInt32LE"]

  val read_int32_be : t -> ?offset:int -> unit -> int [@@js.call "readInt32BE"]

  val read_float_le : t -> ?offset:int -> unit -> int [@@js.call "readFloatLE"]

  val read_float_be : t -> ?offset:int -> unit -> int [@@js.call "readFloatBE"]

  val read_double_le : t -> ?offset:int -> unit -> int
    [@@js.call "readDoubleLE"]

  val read_double_be : t -> ?offset:int -> unit -> int
    [@@js.call "readDoubleBE"]

  val reverse : t -> t [@@js.call "reverse"]

  val swap16 : t -> t [@@js.call "swap16"]

  val swap32 : t -> t [@@js.call "swap32"]

  val swap64 : t -> t [@@js.call "swap64"]

  val write_u_int8 : t -> int -> ?offset:int -> unit -> int
    [@@js.call "writeUInt8"]

  val write_u_int16_le : t -> int -> ?offset:int -> unit -> int
    [@@js.call "writeUInt16LE"]

  val write_u_int16_be : t -> int -> ?offset:int -> unit -> int
    [@@js.call "writeUInt16BE"]

  val write_u_int32_le : t -> int -> ?offset:int -> unit -> int
    [@@js.call "writeUInt32LE"]

  val write_u_int32_be : t -> int -> ?offset:int -> unit -> int
    [@@js.call "writeUInt32BE"]

  val write_int8 : t -> int -> ?offset:int -> unit -> int
    [@@js.call "writeInt8"]

  val write_int16_le : t -> int -> ?offset:int -> unit -> int
    [@@js.call "writeInt16LE"]

  val write_int16_be : t -> int -> ?offset:int -> unit -> int
    [@@js.call "writeInt16BE"]

  val write_int32_le : t -> int -> ?offset:int -> unit -> int
    [@@js.call "writeInt32LE"]

  val write_int32_be : t -> int -> ?offset:int -> unit -> int
    [@@js.call "writeInt32BE"]

  val write_float_le : t -> int -> ?offset:int -> unit -> int
    [@@js.call "writeFloatLE"]

  val write_float_be : t -> int -> ?offset:int -> unit -> int
    [@@js.call "writeFloatBE"]

  val write_double_le : t -> int -> ?offset:int -> unit -> int
    [@@js.call "writeDoubleLE"]

  val write_double_be : t -> int -> ?offset:int -> unit -> int
    [@@js.call "writeDoubleBE"]

  val fill :
       t
    -> value:Uint8_array.t or_string or_number
    -> ?offset:int
    -> ?end_:int
    -> ?encoding:Buffer_encoding.t
    -> unit
    -> t
    [@@js.call "fill"]

  val index_of :
       t
    -> value:Uint8_array.t or_string or_number
    -> ?byte_offset:int
    -> ?encoding:Buffer_encoding.t
    -> unit
    -> int
    [@@js.call "indexOf"]

  val last_index_of :
       t
    -> value:Uint8_array.t or_string or_number
    -> ?byte_offset:int
    -> ?encoding:Buffer_encoding.t
    -> unit
    -> int
    [@@js.call "lastIndexOf"]

  val entries : t -> (int * int) Iterable_iterator.t [@@js.call "entries"]

  val includes :
       t
    -> value:t or_string or_number
    -> ?byte_offset:int
    -> ?encoding:Buffer_encoding.t
    -> unit
    -> bool
    [@@js.call "includes"]

  val keys : t -> int Iterable_iterator.t [@@js.call "keys"]

  val values : t -> int Iterable_iterator.t [@@js.call "values"]
end
[@@js.scope "Buffer"]

module Inspect_options : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_getters :
    t -> ([ `get [@js "get"] | `set [@js "set"] ][@js.enum]) or_boolean
    [@@js.get "getters"]

  val set_getters : t -> ([ `get | `set ][@js.enum]) or_boolean -> unit
    [@@js.set "getters"]

  val get_show_hidden : t -> bool [@@js.get "showHidden"]

  val set_show_hidden : t -> bool -> unit [@@js.set "showHidden"]

  val get_depth : t -> int or_null [@@js.get "depth"]

  val set_depth : t -> int or_null -> unit [@@js.set "depth"]

  val get_colors : t -> bool [@@js.get "colors"]

  val set_colors : t -> bool -> unit [@@js.set "colors"]

  val get_custom_inspect : t -> bool [@@js.get "customInspect"]

  val set_custom_inspect : t -> bool -> unit [@@js.set "customInspect"]

  val get_show_proxy : t -> bool [@@js.get "showProxy"]

  val set_show_proxy : t -> bool -> unit [@@js.set "showProxy"]

  val get_max_array_length : t -> int or_null [@@js.get "maxArrayLength"]

  val set_max_array_length : t -> int or_null -> unit
    [@@js.set "maxArrayLength"]

  val get_max_string_length : t -> int or_null [@@js.get "maxStringLength"]

  val set_max_string_length : t -> int or_null -> unit
    [@@js.set "maxStringLength"]

  val get_break_length : t -> int [@@js.get "breakLength"]

  val set_break_length : t -> int -> unit [@@js.set "breakLength"]

  val get_compact : t -> bool or_number [@@js.get "compact"]

  val set_compact : t -> bool or_number -> unit [@@js.set "compact"]

  val get_sorted : t -> (a:string -> b:string -> int) or_boolean
    [@@js.get "sorted"]

  val set_sorted : t -> (a:string -> b:string -> int) or_boolean -> unit
    [@@js.set "sorted"]
end
[@@js.scope "InspectOptions"]

module Errno_exception : sig
  include module type of struct
    include Error
  end

  val get_errno : t -> int [@@js.get "errno"]

  val set_errno : t -> int -> unit [@@js.set "errno"]

  val get_code : t -> string [@@js.get "code"]

  val set_code : t -> string -> unit [@@js.set "code"]

  val get_path : t -> string [@@js.get "path"]

  val set_path : t -> string -> unit [@@js.set "path"]

  val get_syscall : t -> string [@@js.get "syscall"]

  val set_syscall : t -> string -> unit [@@js.set "syscall"]

  val get_stack : t -> string [@@js.get "stack"]

  val set_stack : t -> string -> unit [@@js.set "stack"]
end
[@@js.scope "ErrnoException"]

type stream

val stream_to_js : stream -> Ojs.t

val stream_of_js : Ojs.t -> stream

module Writable_stream : sig
  type t = stream

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_writable : t -> bool [@@js.get "writable"]

  val set_writable : t -> bool -> unit [@@js.set "writable"]

  val write :
       t
    -> buffer:Uint8_array.t or_string
    -> ?cb:(?err:Error.t or_null -> unit -> unit)
    -> unit
    -> bool
    [@@js.call "write"]

  val write' :
       t
    -> str:string
    -> ?encoding:Buffer_encoding.t
    -> ?cb:(?err:Error.t or_null -> unit -> unit)
    -> unit
    -> bool
    [@@js.call "write"]

  val end_ : t -> ?cb:(unit -> unit) -> unit -> unit [@@js.call "end"]

  val end' :
    t -> data:Uint8_array.t or_string -> ?cb:(unit -> unit) -> unit -> unit
    [@@js.call "end"]

  val end'' :
       t
    -> str:string
    -> ?encoding:Buffer_encoding.t
    -> ?cb:(unit -> unit)
    -> unit
    -> unit
    [@@js.call "end"]
end
[@@js.scope "WritableStream"]

module Readable_stream : sig
  type t = stream

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_readable : t -> bool [@@js.get "readable"]

  val set_readable : t -> bool -> unit [@@js.set "readable"]

  val read : t -> ?size:int -> unit -> Buffer.t or_string [@@js.call "read"]

  val set_encoding : t -> encoding:Buffer_encoding.t -> t
    [@@js.call "setEncoding"]

  val pause : t -> t [@@js.call "pause"]

  val resume : t -> t [@@js.call "resume"]

  val is_paused : t -> bool [@@js.call "isPaused"]

  val pipe :
    t -> destination:'T -> ?options:Anonymous_interface0.t -> unit -> 'T
    [@@js.call "pipe"]

  val unpipe : t -> ?destination:Writable_stream.t -> unit -> t
    [@@js.call "unpipe"]

  val unshift :
       t
    -> chunk:Uint8_array.t or_string
    -> ?encoding:Buffer_encoding.t
    -> unit
    -> unit
    [@@js.call "unshift"]

  val wrap : t -> old_stream:t -> t [@@js.call "wrap"]
end
[@@js.scope "ReadableStream"]

module Read_write_stream : sig
  include module type of struct
    include Readable_stream
  end

  val cast' : t -> Writable_stream.t [@@js.cast]
end
[@@js.scope "ReadWriteStream"]

module Ref_counted : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val ref : t -> t [@@js.call "ref"]

  val unref : t -> t [@@js.call "unref"]
end
[@@js.scope "RefCounted"]

module Timer : sig
  include module type of struct
    include Ref_counted
  end

  val has_ref : t -> bool [@@js.call "hasRef"]

  val refresh : t -> t [@@js.call "refresh"]
end
[@@js.scope "Timer"]

module Immediate : sig
  include module type of struct
    include Ref_counted
  end

  val has_ref : t -> bool [@@js.call "hasRef"]

  val get_on_immediate : t -> untyped_function [@@js.get "_onImmediate"]

  val set_on_immediate : t -> untyped_function -> unit [@@js.set "_onImmediate"]
end
[@@js.scope "Immediate"]

module Timeout : sig
  include module type of struct
    include Timer
  end

  val has_ref : t -> bool [@@js.call "hasRef"]

  val refresh : t -> t [@@js.call "refresh"]
end
[@@js.scope "Timeout"]

module Global : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_array : t -> (* FIXME: unknown type 'typeof Array' *) any
    [@@js.get "Array"]

  val set_array : t -> (* FIXME: unknown type 'typeof Array' *) any -> unit
    [@@js.set "Array"]

  val get_array_buffer : t -> (* FIXME: unknown type 'typeof ArrayBuffer' *) any
    [@@js.get "ArrayBuffer"]

  val set_array_buffer :
    t -> (* FIXME: unknown type 'typeof ArrayBuffer' *) any -> unit
    [@@js.set "ArrayBuffer"]

  val get_boolean : t -> (* FIXME: unknown type 'typeof Boolean' *) any
    [@@js.get "Boolean"]

  val set_boolean : t -> (* FIXME: unknown type 'typeof Boolean' *) any -> unit
    [@@js.set "Boolean"]

  val get_buffer : t -> (* FIXME: unknown type 'typeof Buffer' *) any
    [@@js.get "Buffer"]

  val set_buffer : t -> (* FIXME: unknown type 'typeof Buffer' *) any -> unit
    [@@js.set "Buffer"]

  val get_data_view : t -> (* FIXME: unknown type 'typeof DataView' *) any
    [@@js.get "DataView"]

  val set_data_view :
    t -> (* FIXME: unknown type 'typeof DataView' *) any -> unit
    [@@js.set "DataView"]

  val get_date : t -> (* FIXME: unknown type 'typeof Date' *) any
    [@@js.get "Date"]

  val set_date : t -> (* FIXME: unknown type 'typeof Date' *) any -> unit
    [@@js.set "Date"]

  val get_error : t -> (* FIXME: unknown type 'typeof Error' *) any
    [@@js.get "Error"]

  val set_error : t -> (* FIXME: unknown type 'typeof Error' *) any -> unit
    [@@js.set "Error"]

  val get_eval_error : t -> (* FIXME: unknown type 'typeof EvalError' *) any
    [@@js.get "EvalError"]

  val set_eval_error :
    t -> (* FIXME: unknown type 'typeof EvalError' *) any -> unit
    [@@js.set "EvalError"]

  val get_float32_array :
    t -> (* FIXME: unknown type 'typeof Float32Array' *) any
    [@@js.get "Float32Array"]

  val set_float32_array :
    t -> (* FIXME: unknown type 'typeof Float32Array' *) any -> unit
    [@@js.set "Float32Array"]

  val get_float64_array :
    t -> (* FIXME: unknown type 'typeof Float64Array' *) any
    [@@js.get "Float64Array"]

  val set_float64_array :
    t -> (* FIXME: unknown type 'typeof Float64Array' *) any -> unit
    [@@js.set "Float64Array"]

  val get_function : t -> (* FIXME: unknown type 'typeof Function' *) any
    [@@js.get "Function"]

  val set_function :
    t -> (* FIXME: unknown type 'typeof Function' *) any -> unit
    [@@js.set "Function"]

  val get_infinity : t -> (* FIXME: unknown type 'typeof Infinity' *) any
    [@@js.get "Infinity"]

  val set_infinity :
    t -> (* FIXME: unknown type 'typeof Infinity' *) any -> unit
    [@@js.set "Infinity"]

  val get_int16_array : t -> (* FIXME: unknown type 'typeof Int16Array' *) any
    [@@js.get "Int16Array"]

  val set_int16_array :
    t -> (* FIXME: unknown type 'typeof Int16Array' *) any -> unit
    [@@js.set "Int16Array"]

  val get_int32_array : t -> (* FIXME: unknown type 'typeof Int32Array' *) any
    [@@js.get "Int32Array"]

  val set_int32_array :
    t -> (* FIXME: unknown type 'typeof Int32Array' *) any -> unit
    [@@js.set "Int32Array"]

  val get_int8_array : t -> (* FIXME: unknown type 'typeof Int8Array' *) any
    [@@js.get "Int8Array"]

  val set_int8_array :
    t -> (* FIXME: unknown type 'typeof Int8Array' *) any -> unit
    [@@js.set "Int8Array"]

  val get_intl : t -> (* FIXME: unknown type 'typeof Intl' *) any
    [@@js.get "Intl"]

  val set_intl : t -> (* FIXME: unknown type 'typeof Intl' *) any -> unit
    [@@js.set "Intl"]

  val get_json : t -> (* FIXME: unknown type 'typeof JSON' *) any
    [@@js.get "JSON"]

  val set_json : t -> (* FIXME: unknown type 'typeof JSON' *) any -> unit
    [@@js.set "JSON"]

  val get_map : t -> Map_constructor.t [@@js.get "Map"]

  val set_map : t -> Map_constructor.t -> unit [@@js.set "Map"]

  val get_math : t -> (* FIXME: unknown type 'typeof Math' *) any
    [@@js.get "Math"]

  val set_math : t -> (* FIXME: unknown type 'typeof Math' *) any -> unit
    [@@js.set "Math"]

  val get_nan : t -> (* FIXME: unknown type 'typeof NaN' *) any [@@js.get "NaN"]

  val set_nan : t -> (* FIXME: unknown type 'typeof NaN' *) any -> unit
    [@@js.set "NaN"]

  val get_number : t -> (* FIXME: unknown type 'typeof Number' *) any
    [@@js.get "Number"]

  val set_number : t -> (* FIXME: unknown type 'typeof Number' *) any -> unit
    [@@js.set "Number"]

  val get_object : t -> (* FIXME: unknown type 'typeof Object' *) any
    [@@js.get "Object"]

  val set_object : t -> (* FIXME: unknown type 'typeof Object' *) any -> unit
    [@@js.set "Object"]

  val get_promise : t -> (* FIXME: unknown type 'typeof Promise' *) any
    [@@js.get "Promise"]

  val set_promise : t -> (* FIXME: unknown type 'typeof Promise' *) any -> unit
    [@@js.set "Promise"]

  val get_range_error : t -> (* FIXME: unknown type 'typeof RangeError' *) any
    [@@js.get "RangeError"]

  val set_range_error :
    t -> (* FIXME: unknown type 'typeof RangeError' *) any -> unit
    [@@js.set "RangeError"]

  val get_reference_error :
    t -> (* FIXME: unknown type 'typeof ReferenceError' *) any
    [@@js.get "ReferenceError"]

  val set_reference_error :
    t -> (* FIXME: unknown type 'typeof ReferenceError' *) any -> unit
    [@@js.set "ReferenceError"]

  val get_reg_exp : t -> (* FIXME: unknown type 'typeof RegExp' *) any
    [@@js.get "RegExp"]

  val set_reg_exp : t -> (* FIXME: unknown type 'typeof RegExp' *) any -> unit
    [@@js.set "RegExp"]

  val get_set : t -> Set_constructor.t [@@js.get "Set"]

  val set_set : t -> Set_constructor.t -> unit [@@js.set "Set"]

  val get_string : t -> (* FIXME: unknown type 'typeof String' *) any
    [@@js.get "String"]

  val set_string : t -> (* FIXME: unknown type 'typeof String' *) any -> unit
    [@@js.set "String"]

  val get_symbol : t -> untyped_function [@@js.get "Symbol"]

  val set_symbol : t -> untyped_function -> unit [@@js.set "Symbol"]

  val get_syntax_error : t -> (* FIXME: unknown type 'typeof SyntaxError' *) any
    [@@js.get "SyntaxError"]

  val set_syntax_error :
    t -> (* FIXME: unknown type 'typeof SyntaxError' *) any -> unit
    [@@js.set "SyntaxError"]

  val get_type_error : t -> (* FIXME: unknown type 'typeof TypeError' *) any
    [@@js.get "TypeError"]

  val set_type_error :
    t -> (* FIXME: unknown type 'typeof TypeError' *) any -> unit
    [@@js.set "TypeError"]

  val get_uri_error : t -> (* FIXME: unknown type 'typeof URIError' *) any
    [@@js.get "URIError"]

  val set_uri_error :
    t -> (* FIXME: unknown type 'typeof URIError' *) any -> unit
    [@@js.set "URIError"]

  val get_uint16_array : t -> (* FIXME: unknown type 'typeof Uint16Array' *) any
    [@@js.get "Uint16Array"]

  val set_uint16_array :
    t -> (* FIXME: unknown type 'typeof Uint16Array' *) any -> unit
    [@@js.set "Uint16Array"]

  val get_uint32_array : t -> (* FIXME: unknown type 'typeof Uint32Array' *) any
    [@@js.get "Uint32Array"]

  val set_uint32_array :
    t -> (* FIXME: unknown type 'typeof Uint32Array' *) any -> unit
    [@@js.set "Uint32Array"]

  val get_uint8_array : t -> (* FIXME: unknown type 'typeof Uint8Array' *) any
    [@@js.get "Uint8Array"]

  val set_uint8_array :
    t -> (* FIXME: unknown type 'typeof Uint8Array' *) any -> unit
    [@@js.set "Uint8Array"]

  val get_uint8_clamped_array :
    t -> (* FIXME: unknown type 'typeof Uint8ClampedArray' *) any
    [@@js.get "Uint8ClampedArray"]

  val set_uint8_clamped_array :
    t -> (* FIXME: unknown type 'typeof Uint8ClampedArray' *) any -> unit
    [@@js.set "Uint8ClampedArray"]

  val get_weak_map : t -> Weak_map_constructor.t [@@js.get "WeakMap"]

  val set_weak_map : t -> Weak_map_constructor.t -> unit [@@js.set "WeakMap"]

  val get_weak_set : t -> Weak_set_constructor.t [@@js.get "WeakSet"]

  val set_weak_set : t -> Weak_set_constructor.t -> unit [@@js.set "WeakSet"]

  val clear_immediate : t -> immediate_id:Immediate.t -> unit
    [@@js.call "clearImmediate"]

  val clear_interval : t -> interval_id:Timeout.t -> unit
    [@@js.call "clearInterval"]

  val clear_timeout : t -> timeout_id:Timeout.t -> unit
    [@@js.call "clearTimeout"]

  val get_decode_uri : t -> (* FIXME: unknown type 'typeof decodeURI' *) any
    [@@js.get "decodeURI"]

  val set_decode_uri :
    t -> (* FIXME: unknown type 'typeof decodeURI' *) any -> unit
    [@@js.set "decodeURI"]

  val get_decode_uri_component :
    t -> (* FIXME: unknown type 'typeof decodeURIComponent' *) any
    [@@js.get "decodeURIComponent"]

  val set_decode_uri_component :
    t -> (* FIXME: unknown type 'typeof decodeURIComponent' *) any -> unit
    [@@js.set "decodeURIComponent"]

  val get_encode_uri : t -> (* FIXME: unknown type 'typeof encodeURI' *) any
    [@@js.get "encodeURI"]

  val set_encode_uri :
    t -> (* FIXME: unknown type 'typeof encodeURI' *) any -> unit
    [@@js.set "encodeURI"]

  val get_encode_uri_component :
    t -> (* FIXME: unknown type 'typeof encodeURIComponent' *) any
    [@@js.get "encodeURIComponent"]

  val set_encode_uri_component :
    t -> (* FIXME: unknown type 'typeof encodeURIComponent' *) any -> unit
    [@@js.set "encodeURIComponent"]

  val escape : t -> str:string -> string [@@js.call "escape"]

  val get_eval : t -> (* FIXME: unknown type 'typeof eval' *) any
    [@@js.get "eval"]

  val set_eval : t -> (* FIXME: unknown type 'typeof eval' *) any -> unit
    [@@js.set "eval"]

  val get_global : t -> t [@@js.get "global"]

  val set_global : t -> t -> unit [@@js.set "global"]

  val get_is_finite : t -> (* FIXME: unknown type 'typeof isFinite' *) any
    [@@js.get "isFinite"]

  val set_is_finite :
    t -> (* FIXME: unknown type 'typeof isFinite' *) any -> unit
    [@@js.set "isFinite"]

  val get_is_nan : t -> (* FIXME: unknown type 'typeof isNaN' *) any
    [@@js.get "isNaN"]

  val set_is_nan : t -> (* FIXME: unknown type 'typeof isNaN' *) any -> unit
    [@@js.set "isNaN"]

  val get_parse_float : t -> (* FIXME: unknown type 'typeof parseFloat' *) any
    [@@js.get "parseFloat"]

  val set_parse_float :
    t -> (* FIXME: unknown type 'typeof parseFloat' *) any -> unit
    [@@js.set "parseFloat"]

  val get_parse_int : t -> (* FIXME: unknown type 'typeof parseInt' *) any
    [@@js.get "parseInt"]

  val set_parse_int :
    t -> (* FIXME: unknown type 'typeof parseInt' *) any -> unit
    [@@js.set "parseInt"]

  val set_immediate :
    t -> ((any list[@js.variadic]) -> unit) -> unit -> Immediate.t
    [@@js.call "setImmediate"]

  val set_interval :
    t -> ((any list[@js.variadic]) -> unit) -> ?ms:int -> unit -> Timeout.t
    [@@js.call "setInterval"]

  val set_timeout :
    t -> ((any list[@js.variadic]) -> unit) -> ?ms:int -> unit -> Timeout.t
    [@@js.call "setTimeout"]

  val queue_microtask : t -> callback:(unit -> unit) -> unit
    [@@js.call "queueMicrotask"]

  val get_undefined : t -> (* FIXME: unknown type 'typeof undefined' *) any
    [@@js.get "undefined"]

  val set_undefined :
    t -> (* FIXME: unknown type 'typeof undefined' *) any -> unit
    [@@js.set "undefined"]

  val unescape : t -> str:string -> string [@@js.call "unescape"]

  val gc : t -> unit [@@js.call "gc"]

  val get_v8debug : t -> any [@@js.get "v8debug"]

  val set_v8debug : t -> any -> unit [@@js.set "v8debug"]
end
[@@js.scope "Global"]

module Typed_array : sig
  type t =
    | Float64Array of Float64_array.t
    | Int16Array of Int16_array.t
    | Int32Array of Int32_array.t
    | Int8Array of Int8_array.t
    | Uint16Array of Uint16_array.t
    | Uint32Array of Uint32_array.t
    | Uint8Array of Uint8_array.t
    | Uint8ClampedArray of Uint8_clamped_array.t
    | Float32Array of Float32_array.t
    | BigUint64Array of Big_uint64_array.t
    | BigInt64Array of Big_int64_array.t
  [@@js.union]

  [@@@js.stop]

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  [@@@js.start]

  [@@@js.implem
  let t_to_js = function
    | Float64Array x -> Obj.magic x
    | Int16Array x -> Obj.magic x
    | Int32Array x -> Obj.magic x
    | Int8Array x -> Obj.magic x
    | Uint16Array x -> Obj.magic x
    | Uint32Array x -> Obj.magic x
    | Uint8Array x -> Obj.magic x
    | Uint8ClampedArray x -> Obj.magic x
    | Float32Array x -> Obj.magic x
    | BigUint64Array x -> Obj.magic x
    | BigInt64Array x -> Obj.magic x

  let t_of_js js =
    match Ojs.obj_type js with
    | "Float64Array" -> Float64Array (Obj.magic js)
    | "Int16Array" -> Int16Array (Obj.magic js)
    | "Int32Array" -> Int32Array (Obj.magic js)
    | "Int8Array" -> Int8Array (Obj.magic js)
    | "Uint16Array" -> Uint16Array (Obj.magic js)
    | "Uint32Array" -> Uint32Array (Obj.magic js)
    | "Uint8Array" -> Uint8Array (Obj.magic js)
    | "Uint8ClampedArray" -> Uint8ClampedArray (Obj.magic js)
    | "Float32Array" -> Float32Array (Obj.magic js)
    | "BigUint64Array" -> BigUint64Array (Obj.magic js)
    | "BigInt64Array" -> BigInt64Array (Obj.magic js)
    | _ -> assert false]
end

module Array_buffer_view : sig
  type t = (Data_view.t, Typed_array.t) union2

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t
end

module Dict : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

  val get : 'T t -> string -> 'T or_undefined [@@js.index_get]

  val set : 'T t -> string -> 'T or_undefined -> unit [@@js.index_set]
end
[@@js.scope "Dict"]

module Read_only_dict : sig
  type 'T t

  val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

  val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

  val get : 'T t -> string -> 'T or_undefined [@@js.index_get]
end
[@@js.scope "ReadOnlyDict"]

module Module : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_exports : t -> any [@@js.get "exports"]

  val set_exports : t -> any -> unit [@@js.set "exports"]

  (* val get_require : t -> Require.t [@@js.get "require"] *)

  (* val set_require : t -> Require.t -> unit [@@js.set "require"] *)

  val get_id : t -> string [@@js.get "id"]

  val set_id : t -> string -> unit [@@js.set "id"]

  val get_filename : t -> string [@@js.get "filename"]

  val set_filename : t -> string -> unit [@@js.set "filename"]

  val get_loaded : t -> bool [@@js.get "loaded"]

  val set_loaded : t -> bool -> unit [@@js.set "loaded"]

  val get_parent : t -> t or_null_or_undefined [@@js.get "parent"]

  val set_parent : t -> t or_null_or_undefined -> unit [@@js.set "parent"]

  val get_children : t -> t list [@@js.get "children"]

  val set_children : t -> t list -> unit [@@js.set "children"]

  val get_path : t -> string [@@js.get "path"]

  val set_path : t -> string -> unit [@@js.set "path"]

  val get_paths : t -> string list [@@js.get "paths"]

  val set_paths : t -> string list -> unit [@@js.set "paths"]
end
[@@js.scope "Module"]

module Require_resolve : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val apply :
    t -> id:string -> ?options:Anonymous_interface1.t -> unit -> string
    [@@js.apply]

  val paths : t -> request:string -> string list or_null [@@js.call "paths"]
end
[@@js.scope "RequireResolve"]

module Require_extensions : sig
  type t = (m:Module.t -> filename:string -> any) Dict.t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  (* val js.t : t -> m:Module.t -> filename:string -> any [@@js.call ".js"] *)

  (* val json.t : t -> m:Module.t -> filename:string -> any [@@js.call ".json"] *)

  (* val node.t : t -> m:Module.t -> filename:string -> any [@@js.call ".node"] *)
end

module Node_module : sig
  include module type of struct
    include Module
  end
end

module Require : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val apply : t -> id:string -> any [@@js.apply]

  val get_resolve : t -> Require_resolve.t [@@js.get "resolve"]

  val set_resolve : t -> Require_resolve.t -> unit [@@js.set "resolve"]

  val get_cache : t -> Node_module.t Dict.t [@@js.get "cache"]

  val set_cache : t -> Node_module.t Dict.t -> unit [@@js.set "cache"]

  val get_extensions : t -> Require_extensions.t [@@js.get "extensions"]

  val set_extensions : t -> Require_extensions.t -> unit [@@js.set "extensions"]

  val get_main : t -> Module.t or_undefined [@@js.get "main"]

  val set_main : t -> Module.t or_undefined -> unit [@@js.set "main"]
end
[@@js.scope "Require"]

(* val process : Node_process.Process.t [@@js.global "process"] *)

(* val console : Console.t [@@js.global "console"] *)

module Node_require : sig
  include module type of struct
    include Require
  end
end

[@@@js.stop]

val __filename : unit -> string

val __dirname : unit -> string

[@@@js.start]

[@@@js.implem
let __filename () =
  Js_of_ocaml.Js.Unsafe.eval_string "__filename" |> Js_of_ocaml.Js.to_string

let __dirname () =
  Js_of_ocaml.Js.Unsafe.eval_string "__dirname" |> Js_of_ocaml.Js.to_string]

val set_timeout :
  ((any list[@js.variadic]) -> unit) -> ?ms:int -> unit -> Timeout.t
  [@@js.global "setTimeout"]

module Set_timeout : sig
  val __promisify__ : ms:int -> unit Promise.t [@@js.global "__promisify__"]

  val __promisify__ : ms:int -> value:'T -> 'T Promise.t
    [@@js.global "__promisify__"]
end
[@@js.scope "setTimeout"]

val clear_timeout : timeout_id:Timeout.t -> unit [@@js.global "clearTimeout"]

val set_interval :
  ((any list[@js.variadic]) -> unit) -> ?ms:int -> unit -> Timeout.t
  [@@js.global "setInterval"]

val clear_interval : interval_id:Timeout.t -> unit [@@js.global "clearInterval"]

val set_immediate : ((any list[@js.variadic]) -> unit) -> unit -> Immediate.t
  [@@js.global "setImmediate"]

module Set_immediate : sig
  val __promisify__ : unit -> unit Promise.t [@@js.global "__promisify__"]

  val __promisify__ : value:'T -> 'T Promise.t [@@js.global "__promisify__"]
end
[@@js.scope "setImmediate"]

val clear_immediate : immediate_id:Immediate.t -> unit
  [@@js.global "clearImmediate"]

val queue_microtask : callback:(unit -> unit) -> unit
  [@@js.global "queueMicrotask"]

val require : Node_require.t [@@js.global "require"]

val module_ : Node_module.t [@@js.global "module"]

val exports : any [@@js.global "exports"]
