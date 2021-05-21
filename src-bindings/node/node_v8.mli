[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module V8 : sig
  open Node_stream

  module Heap_space_info : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_space_name : t -> string [@@js.get "space_name"]

    val set_space_name : t -> string -> unit [@@js.set "space_name"]

    val get_space_size : t -> int [@@js.get "space_size"]

    val set_space_size : t -> int -> unit [@@js.set "space_size"]

    val get_space_used_size : t -> int [@@js.get "space_used_size"]

    val set_space_used_size : t -> int -> unit [@@js.set "space_used_size"]

    val get_space_available_size : t -> int [@@js.get "space_available_size"]

    val set_space_available_size : t -> int -> unit
      [@@js.set "space_available_size"]

    val get_physical_space_size : t -> int [@@js.get "physical_space_size"]

    val set_physical_space_size : t -> int -> unit
      [@@js.set "physical_space_size"]
  end
  [@@js.scope "HeapSpaceInfo"]

  module Does_zap_code_space_flag : sig
    type t =
      ([ `L_n_0 [@js 0]
       | `L_n_1 [@js 1]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Heap_info : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_total_heap_size : t -> int [@@js.get "total_heap_size"]

    val set_total_heap_size : t -> int -> unit [@@js.set "total_heap_size"]

    val get_total_heap_size_executable : t -> int
      [@@js.get "total_heap_size_executable"]

    val set_total_heap_size_executable : t -> int -> unit
      [@@js.set "total_heap_size_executable"]

    val get_total_physical_size : t -> int [@@js.get "total_physical_size"]

    val set_total_physical_size : t -> int -> unit
      [@@js.set "total_physical_size"]

    val get_total_available_size : t -> int [@@js.get "total_available_size"]

    val set_total_available_size : t -> int -> unit
      [@@js.set "total_available_size"]

    val get_used_heap_size : t -> int [@@js.get "used_heap_size"]

    val set_used_heap_size : t -> int -> unit [@@js.set "used_heap_size"]

    val get_heap_size_limit : t -> int [@@js.get "heap_size_limit"]

    val set_heap_size_limit : t -> int -> unit [@@js.set "heap_size_limit"]

    val get_malloced_memory : t -> int [@@js.get "malloced_memory"]

    val set_malloced_memory : t -> int -> unit [@@js.set "malloced_memory"]

    val get_peak_malloced_memory : t -> int [@@js.get "peak_malloced_memory"]

    val set_peak_malloced_memory : t -> int -> unit
      [@@js.set "peak_malloced_memory"]

    val get_does_zap_garbage : t -> Does_zap_code_space_flag.t
      [@@js.get "does_zap_garbage"]

    val set_does_zap_garbage : t -> Does_zap_code_space_flag.t -> unit
      [@@js.set "does_zap_garbage"]

    val get_number_of_native_contexts : t -> int
      [@@js.get "number_of_native_contexts"]

    val set_number_of_native_contexts : t -> int -> unit
      [@@js.set "number_of_native_contexts"]

    val get_number_of_detached_contexts : t -> int
      [@@js.get "number_of_detached_contexts"]

    val set_number_of_detached_contexts : t -> int -> unit
      [@@js.set "number_of_detached_contexts"]
  end
  [@@js.scope "HeapInfo"]

  module Heap_code_statistics : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_code_and_metadata_size : t -> int
      [@@js.get "code_and_metadata_size"]

    val set_code_and_metadata_size : t -> int -> unit
      [@@js.set "code_and_metadata_size"]

    val get_bytecode_and_metadata_size : t -> int
      [@@js.get "bytecode_and_metadata_size"]

    val set_bytecode_and_metadata_size : t -> int -> unit
      [@@js.set "bytecode_and_metadata_size"]

    val get_external_script_source_size : t -> int
      [@@js.get "external_script_source_size"]

    val set_external_script_source_size : t -> int -> unit
      [@@js.set "external_script_source_size"]
  end
  [@@js.scope "HeapCodeStatistics"]

  val cached_data_version_tag : unit -> int [@@js.global "cachedDataVersionTag"]

  val get_heap_statistics : unit -> Heap_info.t
    [@@js.global "getHeapStatistics"]

  val get_heap_space_statistics : unit -> Heap_space_info.t list
    [@@js.global "getHeapSpaceStatistics"]

  val set_flags_from_string : flags:string -> unit
    [@@js.global "setFlagsFromString"]

  val get_heap_snapshot : unit -> Stream.Readable.t
    [@@js.global "getHeapSnapshot"]

  val write_heap_snapshot : ?file_name:string -> unit -> string
    [@@js.global "writeHeapSnapshot"]

  val get_heap_code_statistics : unit -> Heap_code_statistics.t
    [@@js.global "getHeapCodeStatistics"]

  module Serializer : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val write_header : t -> unit [@@js.call "writeHeader"]

    val write_value : t -> val_:any -> bool [@@js.call "writeValue"]

    val release_buffer : t -> Buffer.t [@@js.call "releaseBuffer"]

    val transfer_array_buffer :
      t -> id:int -> array_buffer:Array_buffer.t -> unit
      [@@js.call "transferArrayBuffer"]

    val write_uint32 : t -> value:int -> unit [@@js.call "writeUint32"]

    val write_uint64 : t -> hi:int -> lo:int -> unit [@@js.call "writeUint64"]

    val write_double : t -> value:int -> unit [@@js.call "writeDouble"]

    val write_raw_bytes : t -> buffer:Typed_array.t -> unit
      [@@js.call "writeRawBytes"]
  end
  [@@js.scope "Serializer"]

  module Default_serializer : sig
    include module type of struct
      include Serializer
    end
  end

  module Deserializer : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create : data:Typed_array.t -> t [@@js.create]

    val read_header : t -> bool [@@js.call "readHeader"]

    val read_value : t -> any [@@js.call "readValue"]

    val transfer_array_buffer :
      t -> id:int -> array_buffer:Array_buffer.t -> unit
      [@@js.call "transferArrayBuffer"]

    val get_wire_format_version : t -> int [@@js.call "getWireFormatVersion"]

    val read_uint32 : t -> int [@@js.call "readUint32"]

    val read_uint64 : t -> int * int [@@js.call "readUint64"]

    val read_double : t -> int [@@js.call "readDouble"]

    val read_raw_bytes : t -> length:int -> Buffer.t [@@js.call "readRawBytes"]
  end
  [@@js.scope "Deserializer"]

  module Default_deserializer : sig
    include module type of struct
      include Deserializer
    end
  end

  val serialize : value:any -> Buffer.t [@@js.global "serialize"]

  val deserialize : data:Typed_array.t -> any [@@js.global "deserialize"]
end
[@@js.scope Import.v8]
