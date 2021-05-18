[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - ArrayBuffer
  - Buffer
  - NodeJS.TypedArray
  - Readable
 *)
[@@@js.stop]
module type Missing = sig
  module ArrayBuffer : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Buffer : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module NodeJS : sig
    module TypedArray : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
  end
  module Readable : sig
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
    module Buffer : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module NodeJS : sig
      module TypedArray : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
    end
    module Readable : sig
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
      type v8_DefaultDeserializer = [`V8_DefaultDeserializer | `V8_Deserializer] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and v8_DefaultSerializer = [`V8_DefaultSerializer | `V8_Serializer] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and v8_Deserializer = [`V8_Deserializer] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and v8_DoesZapCodeSpaceFlag = ([`L_n_0[@js 0] | `L_n_1[@js 1]] [@js.enum])
      and v8_HeapCodeStatistics = [`V8_HeapCodeStatistics] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and v8_HeapInfo = [`V8_HeapInfo] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and v8_HeapSpaceInfo = [`V8_HeapSpaceInfo] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and v8_Serializer = [`V8_Serializer] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
  end
  
  open Internal
  open AnonymousInterfaces
  open Types
  module[@js.scope "node:v8"] Node_v8 : sig
    (* export * from 'v8'; *)
  end
  module[@js.scope "v8"] V8 : sig
    (* import { Readable } from 'node:stream'; *)
    module[@js.scope "HeapSpaceInfo"] HeapSpaceInfo : sig
      type t = v8_HeapSpaceInfo
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_space_name: t -> string [@@js.get "space_name"]
      val set_space_name: t -> string -> unit [@@js.set "space_name"]
      val get_space_size: t -> float [@@js.get "space_size"]
      val set_space_size: t -> float -> unit [@@js.set "space_size"]
      val get_space_used_size: t -> float [@@js.get "space_used_size"]
      val set_space_used_size: t -> float -> unit [@@js.set "space_used_size"]
      val get_space_available_size: t -> float [@@js.get "space_available_size"]
      val set_space_available_size: t -> float -> unit [@@js.set "space_available_size"]
      val get_physical_space_size: t -> float [@@js.get "physical_space_size"]
      val set_physical_space_size: t -> float -> unit [@@js.set "physical_space_size"]
    end
    module DoesZapCodeSpaceFlag : sig
      type t = v8_DoesZapCodeSpaceFlag
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "HeapInfo"] HeapInfo : sig
      type t = v8_HeapInfo
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_total_heap_size: t -> float [@@js.get "total_heap_size"]
      val set_total_heap_size: t -> float -> unit [@@js.set "total_heap_size"]
      val get_total_heap_size_executable: t -> float [@@js.get "total_heap_size_executable"]
      val set_total_heap_size_executable: t -> float -> unit [@@js.set "total_heap_size_executable"]
      val get_total_physical_size: t -> float [@@js.get "total_physical_size"]
      val set_total_physical_size: t -> float -> unit [@@js.set "total_physical_size"]
      val get_total_available_size: t -> float [@@js.get "total_available_size"]
      val set_total_available_size: t -> float -> unit [@@js.set "total_available_size"]
      val get_used_heap_size: t -> float [@@js.get "used_heap_size"]
      val set_used_heap_size: t -> float -> unit [@@js.set "used_heap_size"]
      val get_heap_size_limit: t -> float [@@js.get "heap_size_limit"]
      val set_heap_size_limit: t -> float -> unit [@@js.set "heap_size_limit"]
      val get_malloced_memory: t -> float [@@js.get "malloced_memory"]
      val set_malloced_memory: t -> float -> unit [@@js.set "malloced_memory"]
      val get_peak_malloced_memory: t -> float [@@js.get "peak_malloced_memory"]
      val set_peak_malloced_memory: t -> float -> unit [@@js.set "peak_malloced_memory"]
      val get_does_zap_garbage: t -> v8_DoesZapCodeSpaceFlag [@@js.get "does_zap_garbage"]
      val set_does_zap_garbage: t -> v8_DoesZapCodeSpaceFlag -> unit [@@js.set "does_zap_garbage"]
      val get_number_of_native_contexts: t -> float [@@js.get "number_of_native_contexts"]
      val set_number_of_native_contexts: t -> float -> unit [@@js.set "number_of_native_contexts"]
      val get_number_of_detached_contexts: t -> float [@@js.get "number_of_detached_contexts"]
      val set_number_of_detached_contexts: t -> float -> unit [@@js.set "number_of_detached_contexts"]
    end
    module[@js.scope "HeapCodeStatistics"] HeapCodeStatistics : sig
      type t = v8_HeapCodeStatistics
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_code_and_metadata_size: t -> float [@@js.get "code_and_metadata_size"]
      val set_code_and_metadata_size: t -> float -> unit [@@js.set "code_and_metadata_size"]
      val get_bytecode_and_metadata_size: t -> float [@@js.get "bytecode_and_metadata_size"]
      val set_bytecode_and_metadata_size: t -> float -> unit [@@js.set "bytecode_and_metadata_size"]
      val get_external_script_source_size: t -> float [@@js.get "external_script_source_size"]
      val set_external_script_source_size: t -> float -> unit [@@js.set "external_script_source_size"]
    end
    val cachedDataVersionTag: unit -> float [@@js.global "cachedDataVersionTag"]
    val getHeapStatistics: unit -> v8_HeapInfo [@@js.global "getHeapStatistics"]
    val getHeapSpaceStatistics: unit -> v8_HeapSpaceInfo list [@@js.global "getHeapSpaceStatistics"]
    val setFlagsFromString: flags:string -> unit [@@js.global "setFlagsFromString"]
    val getHeapSnapshot: unit -> Readable.t_0 [@@js.global "getHeapSnapshot"]
    val writeHeapSnapshot: ?fileName:string -> unit -> string [@@js.global "writeHeapSnapshot"]
    val getHeapCodeStatistics: unit -> v8_HeapCodeStatistics [@@js.global "getHeapCodeStatistics"]
    module[@js.scope "Serializer"] Serializer : sig
      type t = v8_Serializer
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val writeHeader: t -> unit [@@js.call "writeHeader"]
      val writeValue: t -> val_:any -> bool [@@js.call "writeValue"]
      val releaseBuffer: t -> Buffer.t_0 [@@js.call "releaseBuffer"]
      val transferArrayBuffer: t -> id:float -> arrayBuffer:ArrayBuffer.t_0 -> unit [@@js.call "transferArrayBuffer"]
      val writeUint32: t -> value:float -> unit [@@js.call "writeUint32"]
      val writeUint64: t -> hi:float -> lo:float -> unit [@@js.call "writeUint64"]
      val writeDouble: t -> value:float -> unit [@@js.call "writeDouble"]
      val writeRawBytes: t -> buffer:NodeJS.TypedArray.t_0 -> unit [@@js.call "writeRawBytes"]
    end
    module[@js.scope "DefaultSerializer"] DefaultSerializer : sig
      type t = v8_DefaultSerializer
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val cast: t -> v8_Serializer [@@js.cast]
    end
    module[@js.scope "Deserializer"] Deserializer : sig
      type t = v8_Deserializer
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: data:NodeJS.TypedArray.t_0 -> t [@@js.create]
      val readHeader: t -> bool [@@js.call "readHeader"]
      val readValue: t -> any [@@js.call "readValue"]
      val transferArrayBuffer: t -> id:float -> arrayBuffer:ArrayBuffer.t_0 -> unit [@@js.call "transferArrayBuffer"]
      val getWireFormatVersion: t -> float [@@js.call "getWireFormatVersion"]
      val readUint32: t -> float [@@js.call "readUint32"]
      val readUint64: t -> (float * float) [@@js.call "readUint64"]
      val readDouble: t -> float [@@js.call "readDouble"]
      val readRawBytes: t -> length:float -> Buffer.t_0 [@@js.call "readRawBytes"]
    end
    module[@js.scope "DefaultDeserializer"] DefaultDeserializer : sig
      type t = v8_DefaultDeserializer
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val cast: t -> v8_Deserializer [@@js.cast]
    end
    val serialize: value:any -> Buffer.t_0 [@@js.global "serialize"]
    val deserialize: data:NodeJS.TypedArray.t_0 -> any [@@js.global "deserialize"]
  end
end
