[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - AsyncIterableIterator<T1>
  - Buffer
  - BufferEncoding
  - Date
  - Error
  - EventEmitter
  - NodeJS.ArrayBufferView
  - NodeJS.ErrnoException
  - Promise<T1>
  - URL
  - Uint8Array
  - stream.Readable
  - stream.Writable
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
  module BufferEncoding : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Date : sig
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
    module ArrayBufferView : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ErrnoException : sig
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
  module URL : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Uint8Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module stream : sig
    module Readable : sig
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
    module BufferEncoding : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Date : sig
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
      module ArrayBufferView : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module ErrnoException : sig
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
    module URL : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Uint8Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module stream : sig
      module Readable : sig
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
      type anonymous_interface_4 = [`anonymous_interface_4] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_5 = [`anonymous_interface_5] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_6 = [`anonymous_interface_6] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_7 = [`anonymous_interface_7] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_8 = [`anonymous_interface_8] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_9 = [`anonymous_interface_9] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_10 = [`anonymous_interface_10] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_11 = [`anonymous_interface_11] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_12 = [`anonymous_interface_12] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_13 = [`anonymous_interface_13] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_14 = [`anonymous_interface_14] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_15 = [`anonymous_interface_15] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_16 = [`anonymous_interface_16] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_17 = [`anonymous_interface_17] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_18 = [`anonymous_interface_18] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_19 = [`anonymous_interface_19] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      type anonymous_interface_20 = [`anonymous_interface_20] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
    end
    module Types : sig
      open AnonymousInterfaces
      type fs_BaseEncodingOptions = [`Fs_BaseEncodingOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_BigIntOptions = [`Fs_BigIntOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_BigIntStats = [`Fs_BigIntStats | `Fs_StatsBase of bigint] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_BigIntStats = [`Fs_BigIntStats | `Fs_StatsBase of bigint] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_BufferEncodingOption = (anonymous_interface_7, ([`L_s0_buffer[@js "buffer"]] [@js.enum])) or_enum
      and fs_Dir = [`Fs_Dir] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_Dirent = [`Fs_Dirent] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_FSWatcher = [`Fs_FSWatcher] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_MakeDirectoryOptions = [`Fs_MakeDirectoryOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_Mode = string or_number
      and fs_NoParamCallback = [`Fs_NoParamCallback] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_OpenDirOptions = [`Fs_OpenDirOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_OpenMode = string or_number
      and fs_PathLike = (Buffer.t_0, URL.t_0) union2 or_string
      and fs_ReadStream = [`Fs_ReadStream] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_ReadSyncOptions = [`Fs_ReadSyncOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_ReadVResult = [`Fs_ReadVResult] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_RmDirOptions = [`Fs_RmDirOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_RmOptions = [`Fs_RmOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_StatOptions = [`Fs_StatOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_Stats = [`Fs_Stats | `Fs_StatsBase of float] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_Stats = [`Fs_Stats | `Fs_StatsBase of float] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and 'T fs_StatsBase = [`Fs_StatsBase of 'T] intf
      [@@js.custom { of_js=(fun _T -> Obj.magic); to_js=(fun _T -> Obj.magic) }]
      and fs_WriteFileOptions = (fs_BaseEncodingOptions, anonymous_interface_15) intersection2 or_string or_null
      and fs_WriteStream = [`Fs_WriteStream] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_WriteVResult = [`Fs_WriteVResult] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and fs_symlink_Type = ([`L_s4_dir[@js "dir"] | `L_s8_file[@js "file"] | `L_s10_junction[@js "junction"]] [@js.enum])
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
    val get_bigint: t -> ([`L_b_false[@js false]] [@js.enum]) [@@js.get "bigint"]
    val set_bigint: t -> ([`L_b_false] [@js.enum]) -> unit [@@js.set "bigint"]
  end
  module AnonymousInterface1 : sig
    type t = anonymous_interface_1
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_bigint: t -> ([`L_b_true[@js true]] [@js.enum]) [@@js.get "bigint"]
    val set_bigint: t -> ([`L_b_true] [@js.enum]) -> unit [@@js.set "bigint"]
  end
  module AnonymousInterface2 : sig
    type t = anonymous_interface_2
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_bytesRead: t -> float [@@js.get "bytesRead"]
    val set_bytesRead: t -> float -> unit [@@js.set "bytesRead"]
    val get_buffer: t -> 'TBuffer [@@js.get "buffer"]
    val set_buffer: t -> 'TBuffer -> unit [@@js.set "buffer"]
  end
  module AnonymousInterface3 : sig
    type t = anonymous_interface_3
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_bytesWritten: t -> float [@@js.get "bytesWritten"]
    val set_bytesWritten: t -> float -> unit [@@js.set "bytesWritten"]
    val get_buffer: t -> 'TBuffer [@@js.get "buffer"]
    val set_buffer: t -> 'TBuffer -> unit [@@js.set "buffer"]
  end
  module AnonymousInterface4 : sig
    type t = anonymous_interface_4
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_bytesWritten: t -> float [@@js.get "bytesWritten"]
    val set_bytesWritten: t -> float -> unit [@@js.set "bytesWritten"]
    val get_buffer: t -> string [@@js.get "buffer"]
    val set_buffer: t -> string -> unit [@@js.set "buffer"]
  end
  module AnonymousInterface5 : sig
    type t = anonymous_interface_5
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_encoding: t -> BufferEncoding.t_0 [@@js.get "encoding"]
    val set_encoding: t -> BufferEncoding.t_0 -> unit [@@js.set "encoding"]
    val get_flag: t -> string [@@js.get "flag"]
    val set_flag: t -> string -> unit [@@js.set "flag"]
  end
  module AnonymousInterface6 : sig
    type t = anonymous_interface_6
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_encoding: t -> never or_null [@@js.get "encoding"]
    val set_encoding: t -> never or_null -> unit [@@js.set "encoding"]
    val get_flag: t -> string [@@js.get "flag"]
    val set_flag: t -> string -> unit [@@js.set "flag"]
  end
  module AnonymousInterface7 : sig
    type t = anonymous_interface_7
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_encoding: t -> ([`L_s0_buffer[@js "buffer"]] [@js.enum]) [@@js.get "encoding"]
    val set_encoding: t -> ([`L_s0_buffer] [@js.enum]) -> unit [@@js.set "encoding"]
  end
  module AnonymousInterface8 : sig
    type t = anonymous_interface_8
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_encoding: t -> ([`L_s0_buffer[@js "buffer"]] [@js.enum]) [@@js.get "encoding"]
    val set_encoding: t -> ([`L_s0_buffer] [@js.enum]) -> unit [@@js.set "encoding"]
    val get_persistent: t -> bool [@@js.get "persistent"]
    val set_persistent: t -> bool -> unit [@@js.set "persistent"]
    val get_recursive: t -> bool [@@js.get "recursive"]
    val set_recursive: t -> bool -> unit [@@js.set "recursive"]
  end
  module AnonymousInterface9 : sig
    type t = anonymous_interface_9
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_encoding: t -> ([`L_s0_buffer[@js "buffer"]] [@js.enum]) [@@js.get "encoding"]
    val set_encoding: t -> ([`L_s0_buffer] [@js.enum]) -> unit [@@js.set "encoding"]
    val get_withFileTypes: t -> ([`L_b_false[@js false]] [@js.enum]) [@@js.get "withFileTypes"]
    val set_withFileTypes: t -> ([`L_b_false] [@js.enum]) -> unit [@@js.set "withFileTypes"]
  end
  module AnonymousInterface10 : sig
    type t = anonymous_interface_10
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_encoding: t -> BufferEncoding.t_0 or_null [@@js.get "encoding"]
    val set_encoding: t -> BufferEncoding.t_0 or_null -> unit [@@js.set "encoding"]
    val get_persistent: t -> bool [@@js.get "persistent"]
    val set_persistent: t -> bool -> unit [@@js.set "persistent"]
    val get_recursive: t -> bool [@@js.get "recursive"]
    val set_recursive: t -> bool -> unit [@@js.set "recursive"]
  end
  module AnonymousInterface11 : sig
    type t = anonymous_interface_11
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_encoding: t -> BufferEncoding.t_0 or_null [@@js.get "encoding"]
    val set_encoding: t -> BufferEncoding.t_0 or_null -> unit [@@js.set "encoding"]
    val get_withFileTypes: t -> ([`L_b_false[@js false]] [@js.enum]) [@@js.get "withFileTypes"]
    val set_withFileTypes: t -> ([`L_b_false] [@js.enum]) -> unit [@@js.set "withFileTypes"]
  end
  module AnonymousInterface12 : sig
    type t = anonymous_interface_12
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_flag: t -> string [@@js.get "flag"]
    val set_flag: t -> string -> unit [@@js.set "flag"]
  end
  module AnonymousInterface13 : sig
    type t = anonymous_interface_13
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_flags: t -> string [@@js.get "flags"]
    val set_flags: t -> string -> unit [@@js.set "flags"]
    val get_encoding: t -> BufferEncoding.t_0 [@@js.get "encoding"]
    val set_encoding: t -> BufferEncoding.t_0 -> unit [@@js.set "encoding"]
    val get_fd: t -> float [@@js.get "fd"]
    val set_fd: t -> float -> unit [@@js.set "fd"]
    val get_mode: t -> float [@@js.get "mode"]
    val set_mode: t -> float -> unit [@@js.set "mode"]
    val get_autoClose: t -> bool [@@js.get "autoClose"]
    val set_autoClose: t -> bool -> unit [@@js.set "autoClose"]
    val get_emitClose: t -> bool [@@js.get "emitClose"]
    val set_emitClose: t -> bool -> unit [@@js.set "emitClose"]
    val get_start: t -> float [@@js.get "start"]
    val set_start: t -> float -> unit [@@js.set "start"]
    val get_end: t -> float [@@js.get "end"]
    val set_end: t -> float -> unit [@@js.set "end"]
    val get_highWaterMark: t -> float [@@js.get "highWaterMark"]
    val set_highWaterMark: t -> float -> unit [@@js.set "highWaterMark"]
  end
  module AnonymousInterface14 : sig
    type t = anonymous_interface_14
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_flags: t -> string [@@js.get "flags"]
    val set_flags: t -> string -> unit [@@js.set "flags"]
    val get_encoding: t -> BufferEncoding.t_0 [@@js.get "encoding"]
    val set_encoding: t -> BufferEncoding.t_0 -> unit [@@js.set "encoding"]
    val get_fd: t -> float [@@js.get "fd"]
    val set_fd: t -> float -> unit [@@js.set "fd"]
    val get_mode: t -> float [@@js.get "mode"]
    val set_mode: t -> float -> unit [@@js.set "mode"]
    val get_autoClose: t -> bool [@@js.get "autoClose"]
    val set_autoClose: t -> bool -> unit [@@js.set "autoClose"]
    val get_emitClose: t -> bool [@@js.get "emitClose"]
    val set_emitClose: t -> bool -> unit [@@js.set "emitClose"]
    val get_start: t -> float [@@js.get "start"]
    val set_start: t -> float -> unit [@@js.set "start"]
    val get_highWaterMark: t -> float [@@js.get "highWaterMark"]
    val set_highWaterMark: t -> float -> unit [@@js.set "highWaterMark"]
  end
  module AnonymousInterface15 : sig
    type t = anonymous_interface_15
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_mode: t -> fs_Mode [@@js.get "mode"]
    val set_mode: t -> fs_Mode -> unit [@@js.set "mode"]
    val get_flag: t -> string [@@js.get "flag"]
    val set_flag: t -> string -> unit [@@js.set "flag"]
  end
  module AnonymousInterface16 : sig
    type t = anonymous_interface_16
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_persistent: t -> bool [@@js.get "persistent"]
    val set_persistent: t -> bool -> unit [@@js.set "persistent"]
    val get_interval: t -> float [@@js.get "interval"]
    val set_interval: t -> float -> unit [@@js.set "interval"]
  end
  module AnonymousInterface17 : sig
    type t = anonymous_interface_17
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_recursive: t -> ([`L_b_false[@js false]] [@js.enum]) [@@js.get "recursive"]
    val set_recursive: t -> ([`L_b_false] [@js.enum]) -> unit [@@js.set "recursive"]
  end
  module AnonymousInterface18 : sig
    type t = anonymous_interface_18
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_recursive: t -> ([`L_b_true[@js true]] [@js.enum]) [@@js.get "recursive"]
    val set_recursive: t -> ([`L_b_true] [@js.enum]) -> unit [@@js.set "recursive"]
  end
  module AnonymousInterface19 : sig
    type t = anonymous_interface_19
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_withFileTypes: t -> ([`L_b_false[@js false]] [@js.enum]) [@@js.get "withFileTypes"]
    val set_withFileTypes: t -> ([`L_b_false] [@js.enum]) -> unit [@@js.set "withFileTypes"]
  end
  module AnonymousInterface20 : sig
    type t = anonymous_interface_20
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_withFileTypes: t -> ([`L_b_true[@js true]] [@js.enum]) [@@js.get "withFileTypes"]
    val set_withFileTypes: t -> ([`L_b_true] [@js.enum]) -> unit [@@js.set "withFileTypes"]
  end
  module[@js.scope "node:fs"] Node_fs : sig
    (* export * from 'fs'; *)
  end
  module[@js.scope "fs"] Fs : sig
    (* import * as stream from 'node:stream'; *)
    (* import EventEmitter = require('node:events'); *)
    (* import { URL } from 'node:url'; *)
    (* import * as promises from 'node:fs/promises'; *)
    
    module PathLike : sig
      type t = fs_PathLike
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "NoParamCallback"] NoParamCallback : sig
      type t = fs_NoParamCallback
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val apply: t -> err:NodeJS.ErrnoException.t_0 or_null -> unit [@@js.apply]
    end
    module BufferEncodingOption : sig
      type t = fs_BufferEncodingOption
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "BaseEncodingOptions"] BaseEncodingOptions : sig
      type t = fs_BaseEncodingOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_encoding: t -> BufferEncoding.t_0 or_null [@@js.get "encoding"]
      val set_encoding: t -> BufferEncoding.t_0 or_null -> unit [@@js.set "encoding"]
    end
    module OpenMode : sig
      type t = fs_OpenMode
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Mode : sig
      type t = fs_Mode
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "StatsBase"] StatsBase : sig
      type 'T t = 'T fs_StatsBase
      val t_to_js: ('T -> Ojs.t) -> 'T t -> Ojs.t
      val t_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t
      type 'T t_1 = 'T t
      val t_1_to_js: ('T -> Ojs.t) -> 'T t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T) -> Ojs.t -> 'T t_1
      val isFile: 'T t -> bool [@@js.call "isFile"]
      val isDirectory: 'T t -> bool [@@js.call "isDirectory"]
      val isBlockDevice: 'T t -> bool [@@js.call "isBlockDevice"]
      val isCharacterDevice: 'T t -> bool [@@js.call "isCharacterDevice"]
      val isSymbolicLink: 'T t -> bool [@@js.call "isSymbolicLink"]
      val isFIFO: 'T t -> bool [@@js.call "isFIFO"]
      val isSocket: 'T t -> bool [@@js.call "isSocket"]
      val get_dev: 'T t -> 'T [@@js.get "dev"]
      val set_dev: 'T t -> 'T -> unit [@@js.set "dev"]
      val get_ino: 'T t -> 'T [@@js.get "ino"]
      val set_ino: 'T t -> 'T -> unit [@@js.set "ino"]
      val get_mode: 'T t -> 'T [@@js.get "mode"]
      val set_mode: 'T t -> 'T -> unit [@@js.set "mode"]
      val get_nlink: 'T t -> 'T [@@js.get "nlink"]
      val set_nlink: 'T t -> 'T -> unit [@@js.set "nlink"]
      val get_uid: 'T t -> 'T [@@js.get "uid"]
      val set_uid: 'T t -> 'T -> unit [@@js.set "uid"]
      val get_gid: 'T t -> 'T [@@js.get "gid"]
      val set_gid: 'T t -> 'T -> unit [@@js.set "gid"]
      val get_rdev: 'T t -> 'T [@@js.get "rdev"]
      val set_rdev: 'T t -> 'T -> unit [@@js.set "rdev"]
      val get_size: 'T t -> 'T [@@js.get "size"]
      val set_size: 'T t -> 'T -> unit [@@js.set "size"]
      val get_blksize: 'T t -> 'T [@@js.get "blksize"]
      val set_blksize: 'T t -> 'T -> unit [@@js.set "blksize"]
      val get_blocks: 'T t -> 'T [@@js.get "blocks"]
      val set_blocks: 'T t -> 'T -> unit [@@js.set "blocks"]
      val get_atimeMs: 'T t -> 'T [@@js.get "atimeMs"]
      val set_atimeMs: 'T t -> 'T -> unit [@@js.set "atimeMs"]
      val get_mtimeMs: 'T t -> 'T [@@js.get "mtimeMs"]
      val set_mtimeMs: 'T t -> 'T -> unit [@@js.set "mtimeMs"]
      val get_ctimeMs: 'T t -> 'T [@@js.get "ctimeMs"]
      val set_ctimeMs: 'T t -> 'T -> unit [@@js.set "ctimeMs"]
      val get_birthtimeMs: 'T t -> 'T [@@js.get "birthtimeMs"]
      val set_birthtimeMs: 'T t -> 'T -> unit [@@js.set "birthtimeMs"]
      val get_atime: 'T t -> Date.t_0 [@@js.get "atime"]
      val set_atime: 'T t -> Date.t_0 -> unit [@@js.set "atime"]
      val get_mtime: 'T t -> Date.t_0 [@@js.get "mtime"]
      val set_mtime: 'T t -> Date.t_0 -> unit [@@js.set "mtime"]
      val get_ctime: 'T t -> Date.t_0 [@@js.get "ctime"]
      val set_ctime: 'T t -> Date.t_0 -> unit [@@js.set "ctime"]
      val get_birthtime: 'T t -> Date.t_0 [@@js.get "birthtime"]
      val set_birthtime: 'T t -> Date.t_0 -> unit [@@js.set "birthtime"]
    end
    module[@js.scope "Stats"] Stats : sig
      type t = fs_Stats
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val cast: t -> float fs_StatsBase [@@js.cast]
    end
    module Stats : sig
      type t = fs_Stats
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "Dirent"] Dirent : sig
      type t = fs_Dirent
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val isFile: t -> bool [@@js.call "isFile"]
      val isDirectory: t -> bool [@@js.call "isDirectory"]
      val isBlockDevice: t -> bool [@@js.call "isBlockDevice"]
      val isCharacterDevice: t -> bool [@@js.call "isCharacterDevice"]
      val isSymbolicLink: t -> bool [@@js.call "isSymbolicLink"]
      val isFIFO: t -> bool [@@js.call "isFIFO"]
      val isSocket: t -> bool [@@js.call "isSocket"]
      val get_name: t -> string [@@js.get "name"]
      val set_name: t -> string -> unit [@@js.set "name"]
    end
    module[@js.scope "Dir"] Dir : sig
      type t = fs_Dir
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_path: t -> string [@@js.get "path"]
      val _Symbol_asyncIterator_: t -> fs_Dirent AsyncIterableIterator.t_1 [@@js.call "[Symbol.asyncIterator]"]
      val close: t -> unit Promise.t_1 [@@js.call "close"]
      val close': t -> cb:fs_NoParamCallback -> unit [@@js.call "close"]
      val closeSync: t -> unit [@@js.call "closeSync"]
      val read: t -> fs_Dirent or_null Promise.t_1 [@@js.call "read"]
      val read': t -> cb:(err:NodeJS.ErrnoException.t_0 or_null -> dirEnt:fs_Dirent or_null -> unit) -> unit [@@js.call "read"]
      val readSync: t -> fs_Dirent or_null [@@js.call "readSync"]
    end
    module[@js.scope "FSWatcher"] FSWatcher : sig
      type t = fs_FSWatcher
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val close: t -> unit [@@js.call "close"]
      val addListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "addListener"]
      val addListener': t -> event:([`L_s1_change] [@js.enum]) -> listener:(eventType:string -> filename:Buffer.t_0 or_string -> unit) -> t [@@js.call "addListener"]
      val addListener'': t -> event:([`L_s7_error] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "addListener"]
      val addListener''': t -> event:([`L_s2_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val on: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "on"]
      val on': t -> event:([`L_s1_change] [@js.enum]) -> listener:(eventType:string -> filename:Buffer.t_0 or_string -> unit) -> t [@@js.call "on"]
      val on'': t -> event:([`L_s7_error] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "on"]
      val on''': t -> event:([`L_s2_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val once: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "once"]
      val once': t -> event:([`L_s1_change] [@js.enum]) -> listener:(eventType:string -> filename:Buffer.t_0 or_string -> unit) -> t [@@js.call "once"]
      val once'': t -> event:([`L_s7_error] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "once"]
      val once''': t -> event:([`L_s2_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val prependListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependListener"]
      val prependListener': t -> event:([`L_s1_change] [@js.enum]) -> listener:(eventType:string -> filename:Buffer.t_0 or_string -> unit) -> t [@@js.call "prependListener"]
      val prependListener'': t -> event:([`L_s7_error] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "prependListener"]
      val prependListener''': t -> event:([`L_s2_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependOnceListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener': t -> event:([`L_s1_change] [@js.enum]) -> listener:(eventType:string -> filename:Buffer.t_0 or_string -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'': t -> event:([`L_s7_error] [@js.enum]) -> listener:(error:Error.t_0 -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''': t -> event:([`L_s2_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val cast: t -> EventEmitter.t_0 [@@js.cast]
    end
    module[@js.scope "ReadStream"] ReadStream : sig
      type t = fs_ReadStream
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val close: t -> unit [@@js.call "close"]
      val get_bytesRead: t -> float [@@js.get "bytesRead"]
      val set_bytesRead: t -> float -> unit [@@js.set "bytesRead"]
      val get_path: t -> Buffer.t_0 or_string [@@js.get "path"]
      val set_path: t -> Buffer.t_0 or_string -> unit [@@js.set "path"]
      val get_pending: t -> bool [@@js.get "pending"]
      val set_pending: t -> bool -> unit [@@js.set "pending"]
      val addListener: t -> event:([`L_s2_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener': t -> event:([`L_s3_data] [@js.enum]) -> listener:(chunk:Buffer.t_0 or_string -> unit) -> t [@@js.call "addListener"]
      val addListener'': t -> event:([`L_s6_end] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener''': t -> event:([`L_s7_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "addListener"]
      val addListener'''': t -> event:([`L_s11_open] [@js.enum]) -> listener:(fd:float -> unit) -> t [@@js.call "addListener"]
      val addListener''''': t -> event:([`L_s12_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener'''''': t -> event:([`L_s14_readable] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener''''''': t -> event:([`L_s15_ready] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener'''''''': t -> event:([`L_s17_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener''''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "addListener"]
      val on: t -> event:([`L_s2_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on': t -> event:([`L_s3_data] [@js.enum]) -> listener:(chunk:Buffer.t_0 or_string -> unit) -> t [@@js.call "on"]
      val on'': t -> event:([`L_s6_end] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on''': t -> event:([`L_s7_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "on"]
      val on'''': t -> event:([`L_s11_open] [@js.enum]) -> listener:(fd:float -> unit) -> t [@@js.call "on"]
      val on''''': t -> event:([`L_s12_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on'''''': t -> event:([`L_s14_readable] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on''''''': t -> event:([`L_s15_ready] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on'''''''': t -> event:([`L_s17_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on''''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "on"]
      val once: t -> event:([`L_s2_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once': t -> event:([`L_s3_data] [@js.enum]) -> listener:(chunk:Buffer.t_0 or_string -> unit) -> t [@@js.call "once"]
      val once'': t -> event:([`L_s6_end] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once''': t -> event:([`L_s7_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "once"]
      val once'''': t -> event:([`L_s11_open] [@js.enum]) -> listener:(fd:float -> unit) -> t [@@js.call "once"]
      val once''''': t -> event:([`L_s12_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once'''''': t -> event:([`L_s14_readable] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once''''''': t -> event:([`L_s15_ready] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once'''''''': t -> event:([`L_s17_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once''''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "once"]
      val prependListener: t -> event:([`L_s2_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener': t -> event:([`L_s3_data] [@js.enum]) -> listener:(chunk:Buffer.t_0 or_string -> unit) -> t [@@js.call "prependListener"]
      val prependListener'': t -> event:([`L_s6_end] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener''': t -> event:([`L_s7_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''': t -> event:([`L_s11_open] [@js.enum]) -> listener:(fd:float -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''': t -> event:([`L_s12_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''': t -> event:([`L_s14_readable] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''': t -> event:([`L_s15_ready] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''''': t -> event:([`L_s17_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependListener"]
      val prependOnceListener: t -> event:([`L_s2_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener': t -> event:([`L_s3_data] [@js.enum]) -> listener:(chunk:Buffer.t_0 or_string -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'': t -> event:([`L_s6_end] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''': t -> event:([`L_s7_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''': t -> event:([`L_s11_open] [@js.enum]) -> listener:(fd:float -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''': t -> event:([`L_s12_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''': t -> event:([`L_s14_readable] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''': t -> event:([`L_s15_ready] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''''': t -> event:([`L_s17_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependOnceListener"]
      val cast: t -> Stream.Readable.t_0 [@@js.cast]
    end
    module[@js.scope "WriteStream"] WriteStream : sig
      type t = fs_WriteStream
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val close: t -> unit [@@js.call "close"]
      val get_bytesWritten: t -> float [@@js.get "bytesWritten"]
      val set_bytesWritten: t -> float -> unit [@@js.set "bytesWritten"]
      val get_path: t -> Buffer.t_0 or_string [@@js.get "path"]
      val set_path: t -> Buffer.t_0 or_string -> unit [@@js.set "path"]
      val get_pending: t -> bool [@@js.get "pending"]
      val set_pending: t -> bool -> unit [@@js.set "pending"]
      val addListener: t -> event:([`L_s2_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener': t -> event:([`L_s5_drain] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener'': t -> event:([`L_s7_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "addListener"]
      val addListener''': t -> event:([`L_s9_finish] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener'''': t -> event:([`L_s11_open] [@js.enum]) -> listener:(fd:float -> unit) -> t [@@js.call "addListener"]
      val addListener''''': t -> event:([`L_s13_pipe] [@js.enum]) -> listener:(src:Stream.Readable.t_0 -> unit) -> t [@@js.call "addListener"]
      val addListener'''''': t -> event:([`L_s15_ready] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val addListener''''''': t -> event:([`L_s18_unpipe] [@js.enum]) -> listener:(src:Stream.Readable.t_0 -> unit) -> t [@@js.call "addListener"]
      val addListener'''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "addListener"]
      val on: t -> event:([`L_s2_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on': t -> event:([`L_s5_drain] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on'': t -> event:([`L_s7_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "on"]
      val on''': t -> event:([`L_s9_finish] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on'''': t -> event:([`L_s11_open] [@js.enum]) -> listener:(fd:float -> unit) -> t [@@js.call "on"]
      val on''''': t -> event:([`L_s13_pipe] [@js.enum]) -> listener:(src:Stream.Readable.t_0 -> unit) -> t [@@js.call "on"]
      val on'''''': t -> event:([`L_s15_ready] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val on''''''': t -> event:([`L_s18_unpipe] [@js.enum]) -> listener:(src:Stream.Readable.t_0 -> unit) -> t [@@js.call "on"]
      val on'''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "on"]
      val once: t -> event:([`L_s2_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once': t -> event:([`L_s5_drain] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once'': t -> event:([`L_s7_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "once"]
      val once''': t -> event:([`L_s9_finish] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once'''': t -> event:([`L_s11_open] [@js.enum]) -> listener:(fd:float -> unit) -> t [@@js.call "once"]
      val once''''': t -> event:([`L_s13_pipe] [@js.enum]) -> listener:(src:Stream.Readable.t_0 -> unit) -> t [@@js.call "once"]
      val once'''''': t -> event:([`L_s15_ready] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val once''''''': t -> event:([`L_s18_unpipe] [@js.enum]) -> listener:(src:Stream.Readable.t_0 -> unit) -> t [@@js.call "once"]
      val once'''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "once"]
      val prependListener: t -> event:([`L_s2_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener': t -> event:([`L_s5_drain] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener'': t -> event:([`L_s7_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "prependListener"]
      val prependListener''': t -> event:([`L_s9_finish] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''': t -> event:([`L_s11_open] [@js.enum]) -> listener:(fd:float -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''': t -> event:([`L_s13_pipe] [@js.enum]) -> listener:(src:Stream.Readable.t_0 -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''': t -> event:([`L_s15_ready] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependListener''''''': t -> event:([`L_s18_unpipe] [@js.enum]) -> listener:(src:Stream.Readable.t_0 -> unit) -> t [@@js.call "prependListener"]
      val prependListener'''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependListener"]
      val prependOnceListener: t -> event:([`L_s2_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener': t -> event:([`L_s5_drain] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'': t -> event:([`L_s7_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''': t -> event:([`L_s9_finish] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''': t -> event:([`L_s11_open] [@js.enum]) -> listener:(fd:float -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''': t -> event:([`L_s13_pipe] [@js.enum]) -> listener:(src:Stream.Readable.t_0 -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''': t -> event:([`L_s15_ready] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener''''''': t -> event:([`L_s18_unpipe] [@js.enum]) -> listener:(src:Stream.Readable.t_0 -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener'''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependOnceListener"]
      val cast: t -> Stream.Writable.t_0 [@@js.cast]
    end
    val rename: oldPath:fs_PathLike -> newPath:fs_PathLike -> callback:fs_NoParamCallback -> unit [@@js.global "rename"]
    module[@js.scope "rename"] Rename : sig
      val __promisify__: oldPath:fs_PathLike -> newPath:fs_PathLike -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val renameSync: oldPath:fs_PathLike -> newPath:fs_PathLike -> unit [@@js.global "renameSync"]
    val truncate: path:fs_PathLike -> len:float or_null_or_undefined -> callback:fs_NoParamCallback -> unit [@@js.global "truncate"]
    val truncate: path:fs_PathLike -> callback:fs_NoParamCallback -> unit [@@js.global "truncate"]
    module[@js.scope "truncate"] Truncate : sig
      val __promisify__: path:fs_PathLike -> ?len:float or_null -> unit -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val truncateSync: path:fs_PathLike -> ?len:float or_null -> unit -> unit [@@js.global "truncateSync"]
    val ftruncate: fd:float -> len:float or_null_or_undefined -> callback:fs_NoParamCallback -> unit [@@js.global "ftruncate"]
    val ftruncate: fd:float -> callback:fs_NoParamCallback -> unit [@@js.global "ftruncate"]
    module[@js.scope "ftruncate"] Ftruncate : sig
      val __promisify__: fd:float -> ?len:float or_null -> unit -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val ftruncateSync: fd:float -> ?len:float or_null -> unit -> unit [@@js.global "ftruncateSync"]
    val chown: path:fs_PathLike -> uid:float -> gid:float -> callback:fs_NoParamCallback -> unit [@@js.global "chown"]
    module[@js.scope "chown"] Chown : sig
      val __promisify__: path:fs_PathLike -> uid:float -> gid:float -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val chownSync: path:fs_PathLike -> uid:float -> gid:float -> unit [@@js.global "chownSync"]
    val fchown: fd:float -> uid:float -> gid:float -> callback:fs_NoParamCallback -> unit [@@js.global "fchown"]
    module[@js.scope "fchown"] Fchown : sig
      val __promisify__: fd:float -> uid:float -> gid:float -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val fchownSync: fd:float -> uid:float -> gid:float -> unit [@@js.global "fchownSync"]
    val lchown: path:fs_PathLike -> uid:float -> gid:float -> callback:fs_NoParamCallback -> unit [@@js.global "lchown"]
    module[@js.scope "lchown"] Lchown : sig
      val __promisify__: path:fs_PathLike -> uid:float -> gid:float -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val lchownSync: path:fs_PathLike -> uid:float -> gid:float -> unit [@@js.global "lchownSync"]
    val lutimes: path:fs_PathLike -> atime:Date.t_0 or_string or_number -> mtime:Date.t_0 or_string or_number -> callback:fs_NoParamCallback -> unit [@@js.global "lutimes"]
    module[@js.scope "lutimes"] Lutimes : sig
      val __promisify__: path:fs_PathLike -> atime:Date.t_0 or_string or_number -> mtime:Date.t_0 or_string or_number -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val lutimesSync: path:fs_PathLike -> atime:Date.t_0 or_string or_number -> mtime:Date.t_0 or_string or_number -> unit [@@js.global "lutimesSync"]
    val chmod: path:fs_PathLike -> mode:fs_Mode -> callback:fs_NoParamCallback -> unit [@@js.global "chmod"]
    module[@js.scope "chmod"] Chmod : sig
      val __promisify__: path:fs_PathLike -> mode:fs_Mode -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val chmodSync: path:fs_PathLike -> mode:fs_Mode -> unit [@@js.global "chmodSync"]
    val fchmod: fd:float -> mode:fs_Mode -> callback:fs_NoParamCallback -> unit [@@js.global "fchmod"]
    module[@js.scope "fchmod"] Fchmod : sig
      val __promisify__: fd:float -> mode:fs_Mode -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val fchmodSync: fd:float -> mode:fs_Mode -> unit [@@js.global "fchmodSync"]
    val lchmod: path:fs_PathLike -> mode:fs_Mode -> callback:fs_NoParamCallback -> unit [@@js.global "lchmod"]
    module[@js.scope "lchmod"] Lchmod : sig
      val __promisify__: path:fs_PathLike -> mode:fs_Mode -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val lchmodSync: path:fs_PathLike -> mode:fs_Mode -> unit [@@js.global "lchmodSync"]
    val stat: path:fs_PathLike -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> stats:fs_Stats -> unit) -> unit [@@js.global "stat"]
    val stat: path:fs_PathLike -> options:(fs_StatOptions, anonymous_interface_0) intersection2 or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> stats:fs_Stats -> unit) -> unit [@@js.global "stat"]
    val stat: path:fs_PathLike -> options:(fs_StatOptions, anonymous_interface_1) intersection2 -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> stats:fs_BigIntStats -> unit) -> unit [@@js.global "stat"]
    val stat: path:fs_PathLike -> options:fs_StatOptions or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> stats:(fs_BigIntStats, fs_Stats) union2 -> unit) -> unit [@@js.global "stat"]
    module[@js.scope "stat"] Stat : sig
      val __promisify__: path:fs_PathLike -> ?options:(fs_StatOptions, anonymous_interface_0) intersection2 -> unit -> fs_Stats Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: path:fs_PathLike -> options:(fs_StatOptions, anonymous_interface_1) intersection2 -> fs_BigIntStats Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: path:fs_PathLike -> ?options:fs_StatOptions -> unit -> (fs_BigIntStats, fs_Stats) union2 Promise.t_1 [@@js.global "__promisify__"]
    end
    val statSync: path:fs_PathLike -> ?options:(fs_StatOptions, anonymous_interface_0) intersection2 -> unit -> fs_Stats [@@js.global "statSync"]
    val statSync: path:fs_PathLike -> options:(fs_StatOptions, anonymous_interface_1) intersection2 -> fs_BigIntStats [@@js.global "statSync"]
    val statSync: path:fs_PathLike -> ?options:fs_StatOptions -> unit -> (fs_BigIntStats, fs_Stats) union2 [@@js.global "statSync"]
    val fstat: fd:float -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> stats:fs_Stats -> unit) -> unit [@@js.global "fstat"]
    val fstat: fd:float -> options:(fs_StatOptions, anonymous_interface_0) intersection2 or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> stats:fs_Stats -> unit) -> unit [@@js.global "fstat"]
    val fstat: fd:float -> options:(fs_StatOptions, anonymous_interface_1) intersection2 -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> stats:fs_BigIntStats -> unit) -> unit [@@js.global "fstat"]
    val fstat: fd:float -> options:fs_StatOptions or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> stats:(fs_BigIntStats, fs_Stats) union2 -> unit) -> unit [@@js.global "fstat"]
    module[@js.scope "fstat"] Fstat : sig
      val __promisify__: fd:float -> ?options:(fs_StatOptions, anonymous_interface_0) intersection2 -> unit -> fs_Stats Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: fd:float -> options:(fs_StatOptions, anonymous_interface_1) intersection2 -> fs_BigIntStats Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: fd:float -> ?options:fs_StatOptions -> unit -> (fs_BigIntStats, fs_Stats) union2 Promise.t_1 [@@js.global "__promisify__"]
    end
    val fstatSync: fd:float -> ?options:(fs_StatOptions, anonymous_interface_0) intersection2 -> unit -> fs_Stats [@@js.global "fstatSync"]
    val fstatSync: fd:float -> options:(fs_StatOptions, anonymous_interface_1) intersection2 -> fs_BigIntStats [@@js.global "fstatSync"]
    val fstatSync: fd:float -> ?options:fs_StatOptions -> unit -> (fs_BigIntStats, fs_Stats) union2 [@@js.global "fstatSync"]
    val lstat: path:fs_PathLike -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> stats:fs_Stats -> unit) -> unit [@@js.global "lstat"]
    val lstat: path:fs_PathLike -> options:(fs_StatOptions, anonymous_interface_0) intersection2 or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> stats:fs_Stats -> unit) -> unit [@@js.global "lstat"]
    val lstat: path:fs_PathLike -> options:(fs_StatOptions, anonymous_interface_1) intersection2 -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> stats:fs_BigIntStats -> unit) -> unit [@@js.global "lstat"]
    val lstat: path:fs_PathLike -> options:fs_StatOptions or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> stats:(fs_BigIntStats, fs_Stats) union2 -> unit) -> unit [@@js.global "lstat"]
    module[@js.scope "lstat"] Lstat : sig
      val __promisify__: path:fs_PathLike -> ?options:(fs_StatOptions, anonymous_interface_0) intersection2 -> unit -> fs_Stats Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: path:fs_PathLike -> options:(fs_StatOptions, anonymous_interface_1) intersection2 -> fs_BigIntStats Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: path:fs_PathLike -> ?options:fs_StatOptions -> unit -> (fs_BigIntStats, fs_Stats) union2 Promise.t_1 [@@js.global "__promisify__"]
    end
    val lstatSync: path:fs_PathLike -> ?options:(fs_StatOptions, anonymous_interface_0) intersection2 -> unit -> fs_Stats [@@js.global "lstatSync"]
    val lstatSync: path:fs_PathLike -> options:(fs_StatOptions, anonymous_interface_1) intersection2 -> fs_BigIntStats [@@js.global "lstatSync"]
    val lstatSync: path:fs_PathLike -> ?options:fs_StatOptions -> unit -> (fs_BigIntStats, fs_Stats) union2 [@@js.global "lstatSync"]
    val link: existingPath:fs_PathLike -> newPath:fs_PathLike -> callback:fs_NoParamCallback -> unit [@@js.global "link"]
    module[@js.scope "link"] Link : sig
      val __promisify__: existingPath:fs_PathLike -> newPath:fs_PathLike -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val linkSync: existingPath:fs_PathLike -> newPath:fs_PathLike -> unit [@@js.global "linkSync"]
    val symlink: target:fs_PathLike -> path:fs_PathLike -> type_:fs_symlink_Type or_null_or_undefined -> callback:fs_NoParamCallback -> unit [@@js.global "symlink"]
    val symlink: target:fs_PathLike -> path:fs_PathLike -> callback:fs_NoParamCallback -> unit [@@js.global "symlink"]
    module[@js.scope "symlink"] Symlink : sig
      val __promisify__: target:fs_PathLike -> path:fs_PathLike -> ?type_:string or_null -> unit -> unit Promise.t_1 [@@js.global "__promisify__"]
      module Type : sig
        type t = fs_symlink_Type
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
    end
    val symlinkSync: target:fs_PathLike -> path:fs_PathLike -> ?type_:fs_symlink_Type or_null -> unit -> unit [@@js.global "symlinkSync"]
    val readlink: path:fs_PathLike -> options:(fs_BaseEncodingOptions, BufferEncoding.t_0) union2 or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> linkString:string -> unit) -> unit [@@js.global "readlink"]
    val readlink: path:fs_PathLike -> options:fs_BufferEncodingOption -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> linkString:Buffer.t_0 -> unit) -> unit [@@js.global "readlink"]
    val readlink: path:fs_PathLike -> options:fs_BaseEncodingOptions or_string or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> linkString:Buffer.t_0 or_string -> unit) -> unit [@@js.global "readlink"]
    val readlink: path:fs_PathLike -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> linkString:string -> unit) -> unit [@@js.global "readlink"]
    module[@js.scope "readlink"] Readlink : sig
      val __promisify__: path:fs_PathLike -> ?options:(fs_BaseEncodingOptions, BufferEncoding.t_0) union2 or_null -> unit -> string Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: path:fs_PathLike -> options:fs_BufferEncodingOption -> Buffer.t_0 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: path:fs_PathLike -> ?options:fs_BaseEncodingOptions or_string or_null -> unit -> Buffer.t_0 or_string Promise.t_1 [@@js.global "__promisify__"]
    end
    val readlinkSync: path:fs_PathLike -> ?options:(fs_BaseEncodingOptions, BufferEncoding.t_0) union2 or_null -> unit -> string [@@js.global "readlinkSync"]
    val readlinkSync: path:fs_PathLike -> options:fs_BufferEncodingOption -> Buffer.t_0 [@@js.global "readlinkSync"]
    val readlinkSync: path:fs_PathLike -> ?options:fs_BaseEncodingOptions or_string or_null -> unit -> Buffer.t_0 or_string [@@js.global "readlinkSync"]
    val realpath: path:fs_PathLike -> options:(fs_BaseEncodingOptions, BufferEncoding.t_0) union2 or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> resolvedPath:string -> unit) -> unit [@@js.global "realpath"]
    val realpath: path:fs_PathLike -> options:fs_BufferEncodingOption -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> resolvedPath:Buffer.t_0 -> unit) -> unit [@@js.global "realpath"]
    val realpath: path:fs_PathLike -> options:fs_BaseEncodingOptions or_string or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> resolvedPath:Buffer.t_0 or_string -> unit) -> unit [@@js.global "realpath"]
    val realpath: path:fs_PathLike -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> resolvedPath:string -> unit) -> unit [@@js.global "realpath"]
    module[@js.scope "realpath"] Realpath : sig
      val __promisify__: path:fs_PathLike -> ?options:(fs_BaseEncodingOptions, BufferEncoding.t_0) union2 or_null -> unit -> string Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: path:fs_PathLike -> options:fs_BufferEncodingOption -> Buffer.t_0 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: path:fs_PathLike -> ?options:fs_BaseEncodingOptions or_string or_null -> unit -> Buffer.t_0 or_string Promise.t_1 [@@js.global "__promisify__"]
      val native: path:fs_PathLike -> options:(fs_BaseEncodingOptions, BufferEncoding.t_0) union2 or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> resolvedPath:string -> unit) -> unit [@@js.global "native"]
      val native: path:fs_PathLike -> options:fs_BufferEncodingOption -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> resolvedPath:Buffer.t_0 -> unit) -> unit [@@js.global "native"]
      val native: path:fs_PathLike -> options:fs_BaseEncodingOptions or_string or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> resolvedPath:Buffer.t_0 or_string -> unit) -> unit [@@js.global "native"]
      val native: path:fs_PathLike -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> resolvedPath:string -> unit) -> unit [@@js.global "native"]
    end
    val realpathSync: path:fs_PathLike -> ?options:(fs_BaseEncodingOptions, BufferEncoding.t_0) union2 or_null -> unit -> string [@@js.global "realpathSync"]
    val realpathSync: path:fs_PathLike -> options:fs_BufferEncodingOption -> Buffer.t_0 [@@js.global "realpathSync"]
    val realpathSync: path:fs_PathLike -> ?options:fs_BaseEncodingOptions or_string or_null -> unit -> Buffer.t_0 or_string [@@js.global "realpathSync"]
    module[@js.scope "realpathSync"] RealpathSync : sig
      val native: path:fs_PathLike -> ?options:(fs_BaseEncodingOptions, BufferEncoding.t_0) union2 or_null -> unit -> string [@@js.global "native"]
      val native: path:fs_PathLike -> options:fs_BufferEncodingOption -> Buffer.t_0 [@@js.global "native"]
      val native: path:fs_PathLike -> ?options:fs_BaseEncodingOptions or_string or_null -> unit -> Buffer.t_0 or_string [@@js.global "native"]
    end
    val unlink: path:fs_PathLike -> callback:fs_NoParamCallback -> unit [@@js.global "unlink"]
    module[@js.scope "unlink"] Unlink : sig
      val __promisify__: path:fs_PathLike -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val unlinkSync: path:fs_PathLike -> unit [@@js.global "unlinkSync"]
    module[@js.scope "RmDirOptions"] RmDirOptions : sig
      type t = fs_RmDirOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_maxRetries: t -> float [@@js.get "maxRetries"]
      val set_maxRetries: t -> float -> unit [@@js.set "maxRetries"]
      val get_recursive: t -> bool [@@js.get "recursive"]
      val set_recursive: t -> bool -> unit [@@js.set "recursive"]
      val get_retryDelay: t -> float [@@js.get "retryDelay"]
      val set_retryDelay: t -> float -> unit [@@js.set "retryDelay"]
    end
    val rmdir: path:fs_PathLike -> callback:fs_NoParamCallback -> unit [@@js.global "rmdir"]
    val rmdir: path:fs_PathLike -> options:fs_RmDirOptions -> callback:fs_NoParamCallback -> unit [@@js.global "rmdir"]
    module[@js.scope "rmdir"] Rmdir : sig
      val __promisify__: path:fs_PathLike -> ?options:fs_RmDirOptions -> unit -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val rmdirSync: path:fs_PathLike -> ?options:fs_RmDirOptions -> unit -> unit [@@js.global "rmdirSync"]
    module[@js.scope "RmOptions"] RmOptions : sig
      type t = fs_RmOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_force: t -> bool [@@js.get "force"]
      val set_force: t -> bool -> unit [@@js.set "force"]
      val get_maxRetries: t -> float [@@js.get "maxRetries"]
      val set_maxRetries: t -> float -> unit [@@js.set "maxRetries"]
      val get_recursive: t -> bool [@@js.get "recursive"]
      val set_recursive: t -> bool -> unit [@@js.set "recursive"]
      val get_retryDelay: t -> float [@@js.get "retryDelay"]
      val set_retryDelay: t -> float -> unit [@@js.set "retryDelay"]
    end
    val rm: path:fs_PathLike -> callback:fs_NoParamCallback -> unit [@@js.global "rm"]
    val rm: path:fs_PathLike -> options:fs_RmOptions -> callback:fs_NoParamCallback -> unit [@@js.global "rm"]
    module[@js.scope "rm"] Rm : sig
      val __promisify__: path:fs_PathLike -> ?options:fs_RmOptions -> unit -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val rmSync: path:fs_PathLike -> ?options:fs_RmOptions -> unit -> unit [@@js.global "rmSync"]
    module[@js.scope "MakeDirectoryOptions"] MakeDirectoryOptions : sig
      type t = fs_MakeDirectoryOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_recursive: t -> bool [@@js.get "recursive"]
      val set_recursive: t -> bool -> unit [@@js.set "recursive"]
      val get_mode: t -> fs_Mode [@@js.get "mode"]
      val set_mode: t -> fs_Mode -> unit [@@js.set "mode"]
    end
    val mkdir: path:fs_PathLike -> options:(fs_MakeDirectoryOptions, anonymous_interface_18) intersection2 -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> ?path:string -> unit -> unit) -> unit [@@js.global "mkdir"]
    val mkdir: path:fs_PathLike -> options:fs_Mode or_null_or_undefined -> callback:fs_NoParamCallback -> unit [@@js.global "mkdir"]
    val mkdir: path:fs_PathLike -> options:(fs_MakeDirectoryOptions, fs_Mode) union2 or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> ?path:string -> unit -> unit) -> unit [@@js.global "mkdir"]
    val mkdir: path:fs_PathLike -> callback:fs_NoParamCallback -> unit [@@js.global "mkdir"]
    module[@js.scope "mkdir"] Mkdir : sig
      val __promisify__: path:fs_PathLike -> options:(fs_MakeDirectoryOptions, anonymous_interface_18) intersection2 -> string or_undefined Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: path:fs_PathLike -> ?options:fs_Mode or_null -> unit -> unit Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: path:fs_PathLike -> ?options:(fs_MakeDirectoryOptions, fs_Mode) union2 or_null -> unit -> string or_undefined Promise.t_1 [@@js.global "__promisify__"]
    end
    val mkdirSync: path:fs_PathLike -> options:(fs_MakeDirectoryOptions, anonymous_interface_18) intersection2 -> string or_undefined [@@js.global "mkdirSync"]
    val mkdirSync: path:fs_PathLike -> ?options:fs_Mode or_null -> unit -> unit [@@js.global "mkdirSync"]
    val mkdirSync: path:fs_PathLike -> ?options:(fs_MakeDirectoryOptions, fs_Mode) union2 or_null -> unit -> string or_undefined [@@js.global "mkdirSync"]
    val mkdtemp: prefix:string -> options:(fs_BaseEncodingOptions, BufferEncoding.t_0) union2 or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> folder:string -> unit) -> unit [@@js.global "mkdtemp"]
    val mkdtemp: prefix:string -> options:(anonymous_interface_7, ([`L_s0_buffer] [@js.enum])) or_enum -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> folder:Buffer.t_0 -> unit) -> unit [@@js.global "mkdtemp"]
    val mkdtemp: prefix:string -> options:fs_BaseEncodingOptions or_string or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> folder:Buffer.t_0 or_string -> unit) -> unit [@@js.global "mkdtemp"]
    val mkdtemp: prefix:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> folder:string -> unit) -> unit [@@js.global "mkdtemp"]
    module[@js.scope "mkdtemp"] Mkdtemp : sig
      val __promisify__: prefix:string -> ?options:(fs_BaseEncodingOptions, BufferEncoding.t_0) union2 or_null -> unit -> string Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: prefix:string -> options:fs_BufferEncodingOption -> Buffer.t_0 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: prefix:string -> ?options:fs_BaseEncodingOptions or_string or_null -> unit -> Buffer.t_0 or_string Promise.t_1 [@@js.global "__promisify__"]
    end
    val mkdtempSync: prefix:string -> ?options:(fs_BaseEncodingOptions, BufferEncoding.t_0) union2 or_null -> unit -> string [@@js.global "mkdtempSync"]
    val mkdtempSync: prefix:string -> options:fs_BufferEncodingOption -> Buffer.t_0 [@@js.global "mkdtempSync"]
    val mkdtempSync: prefix:string -> ?options:fs_BaseEncodingOptions or_string or_null -> unit -> Buffer.t_0 or_string [@@js.global "mkdtempSync"]
    val readdir: path:fs_PathLike -> options:(BufferEncoding.t_0, anonymous_interface_11) union2 or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> files:string list -> unit) -> unit [@@js.global "readdir"]
    val readdir: path:fs_PathLike -> options:(anonymous_interface_9, ([`L_s0_buffer] [@js.enum])) or_enum -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> files:Buffer.t_0 list -> unit) -> unit [@@js.global "readdir"]
    val readdir: path:fs_PathLike -> options:BufferEncoding.t_0 or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> files:Buffer.t_0 or_string list -> unit) -> unit [@@js.global "readdir"]
    val readdir: path:fs_PathLike -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> files:string list -> unit) -> unit [@@js.global "readdir"]
    val readdir: path:fs_PathLike -> options:(fs_BaseEncodingOptions, anonymous_interface_20) intersection2 -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> files:fs_Dirent list -> unit) -> unit [@@js.global "readdir"]
    module[@js.scope "readdir"] Readdir : sig
      val __promisify__: path:fs_PathLike -> ?options:(BufferEncoding.t_0, anonymous_interface_11) union2 or_null -> unit -> string list Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: path:fs_PathLike -> options:(anonymous_interface_9, ([`L_s0_buffer] [@js.enum])) or_enum -> Buffer.t_0 list Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: path:fs_PathLike -> ?options:BufferEncoding.t_0 or_null -> unit -> Buffer.t_0 or_string list Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: path:fs_PathLike -> options:(fs_BaseEncodingOptions, anonymous_interface_20) intersection2 -> fs_Dirent list Promise.t_1 [@@js.global "__promisify__"]
    end
    val readdirSync: path:fs_PathLike -> ?options:(BufferEncoding.t_0, anonymous_interface_11) union2 or_null -> unit -> string list [@@js.global "readdirSync"]
    val readdirSync: path:fs_PathLike -> options:(anonymous_interface_9, ([`L_s0_buffer] [@js.enum])) or_enum -> Buffer.t_0 list [@@js.global "readdirSync"]
    val readdirSync: path:fs_PathLike -> ?options:BufferEncoding.t_0 or_null -> unit -> Buffer.t_0 or_string list [@@js.global "readdirSync"]
    val readdirSync: path:fs_PathLike -> options:(fs_BaseEncodingOptions, anonymous_interface_20) intersection2 -> fs_Dirent list [@@js.global "readdirSync"]
    val close: fd:float -> callback:fs_NoParamCallback -> unit [@@js.global "close"]
    module[@js.scope "close"] Close : sig
      val __promisify__: fd:float -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val closeSync: fd:float -> unit [@@js.global "closeSync"]
    val open_: path:fs_PathLike -> flags:fs_OpenMode -> mode:fs_Mode or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> fd:float -> unit) -> unit [@@js.global "open"]
    val open_: path:fs_PathLike -> flags:fs_OpenMode -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> fd:float -> unit) -> unit [@@js.global "open"]
    module[@js.scope "open"] Open : sig
      val __promisify__: path:fs_PathLike -> flags:fs_OpenMode -> ?mode:fs_Mode or_null -> unit -> float Promise.t_1 [@@js.global "__promisify__"]
    end
    val openSync: path:fs_PathLike -> flags:fs_OpenMode -> ?mode:fs_Mode or_null -> unit -> float [@@js.global "openSync"]
    val utimes: path:fs_PathLike -> atime:Date.t_0 or_string or_number -> mtime:Date.t_0 or_string or_number -> callback:fs_NoParamCallback -> unit [@@js.global "utimes"]
    module[@js.scope "utimes"] Utimes : sig
      val __promisify__: path:fs_PathLike -> atime:Date.t_0 or_string or_number -> mtime:Date.t_0 or_string or_number -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val utimesSync: path:fs_PathLike -> atime:Date.t_0 or_string or_number -> mtime:Date.t_0 or_string or_number -> unit [@@js.global "utimesSync"]
    val futimes: fd:float -> atime:Date.t_0 or_string or_number -> mtime:Date.t_0 or_string or_number -> callback:fs_NoParamCallback -> unit [@@js.global "futimes"]
    module[@js.scope "futimes"] Futimes : sig
      val __promisify__: fd:float -> atime:Date.t_0 or_string or_number -> mtime:Date.t_0 or_string or_number -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val futimesSync: fd:float -> atime:Date.t_0 or_string or_number -> mtime:Date.t_0 or_string or_number -> unit [@@js.global "futimesSync"]
    val fsync: fd:float -> callback:fs_NoParamCallback -> unit [@@js.global "fsync"]
    module[@js.scope "fsync"] Fsync : sig
      val __promisify__: fd:float -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val fsyncSync: fd:float -> unit [@@js.global "fsyncSync"]
    val write: fd:float -> buffer:'TBuffer -> offset:float or_null_or_undefined -> length:float or_null_or_undefined -> position:float or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> written:float -> buffer:'TBuffer -> unit) -> unit [@@js.global "write"]
    val write: fd:float -> buffer:'TBuffer -> offset:float or_null_or_undefined -> length:float or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> written:float -> buffer:'TBuffer -> unit) -> unit [@@js.global "write"]
    val write: fd:float -> buffer:'TBuffer -> offset:float or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> written:float -> buffer:'TBuffer -> unit) -> unit [@@js.global "write"]
    val write: fd:float -> buffer:'TBuffer -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> written:float -> buffer:'TBuffer -> unit) -> unit [@@js.global "write"]
    val write: fd:float -> string:string -> position:float or_null_or_undefined -> encoding:BufferEncoding.t_0 or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> written:float -> str:string -> unit) -> unit [@@js.global "write"]
    val write: fd:float -> string:string -> position:float or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> written:float -> str:string -> unit) -> unit [@@js.global "write"]
    val write: fd:float -> string:string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> written:float -> str:string -> unit) -> unit [@@js.global "write"]
    module[@js.scope "write"] Write : sig
      val __promisify__: fd:float -> ?buffer:'TBuffer -> ?offset:float -> ?length:float -> ?position:float or_null -> unit -> anonymous_interface_3 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: fd:float -> string:string -> ?position:float or_null -> ?encoding:BufferEncoding.t_0 or_null -> unit -> anonymous_interface_4 Promise.t_1 [@@js.global "__promisify__"]
    end
    val writeSync: fd:float -> buffer:NodeJS.ArrayBufferView.t_0 -> ?offset:float or_null -> ?length:float or_null -> ?position:float or_null -> unit -> float [@@js.global "writeSync"]
    val writeSync: fd:float -> string:string -> ?position:float or_null -> ?encoding:BufferEncoding.t_0 or_null -> unit -> float [@@js.global "writeSync"]
    val read: fd:float -> buffer:'TBuffer -> offset:float -> length:float -> position:float or_null -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> bytesRead:float -> buffer:'TBuffer -> unit) -> unit [@@js.global "read"]
    module[@js.scope "read"] Read : sig
      val __promisify__: fd:float -> buffer:'TBuffer -> offset:float -> length:float -> position:float or_null -> anonymous_interface_2 Promise.t_1 [@@js.global "__promisify__"]
    end
    module[@js.scope "ReadSyncOptions"] ReadSyncOptions : sig
      type t = fs_ReadSyncOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_offset: t -> float [@@js.get "offset"]
      val set_offset: t -> float -> unit [@@js.set "offset"]
      val get_length: t -> float [@@js.get "length"]
      val set_length: t -> float -> unit [@@js.set "length"]
      val get_position: t -> float or_null [@@js.get "position"]
      val set_position: t -> float or_null -> unit [@@js.set "position"]
    end
    val readSync: fd:float -> buffer:NodeJS.ArrayBufferView.t_0 -> offset:float -> length:float -> position:float or_null -> float [@@js.global "readSync"]
    val readSync: fd:float -> buffer:NodeJS.ArrayBufferView.t_0 -> ?opts:fs_ReadSyncOptions -> unit -> float [@@js.global "readSync"]
    val readFile: path:fs_PathLike or_number -> options:anonymous_interface_6 or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> data:Buffer.t_0 -> unit) -> unit [@@js.global "readFile"]
    val readFile: path:fs_PathLike or_number -> options:anonymous_interface_5 or_string -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> data:string -> unit) -> unit [@@js.global "readFile"]
    val readFile: path:fs_PathLike or_number -> options:(fs_BaseEncodingOptions, anonymous_interface_12) intersection2 or_string or_null_or_undefined -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> data:Buffer.t_0 or_string -> unit) -> unit [@@js.global "readFile"]
    val readFile: path:fs_PathLike or_number -> callback:(err:NodeJS.ErrnoException.t_0 or_null -> data:Buffer.t_0 -> unit) -> unit [@@js.global "readFile"]
    module[@js.scope "readFile"] ReadFile : sig
      val __promisify__: path:fs_PathLike or_number -> ?options:anonymous_interface_6 or_null -> unit -> Buffer.t_0 Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: path:fs_PathLike or_number -> options:anonymous_interface_5 or_string -> string Promise.t_1 [@@js.global "__promisify__"]
      val __promisify__: path:fs_PathLike or_number -> ?options:(fs_BaseEncodingOptions, anonymous_interface_12) intersection2 or_string or_null -> unit -> Buffer.t_0 or_string Promise.t_1 [@@js.global "__promisify__"]
    end
    val readFileSync: path:fs_PathLike or_number -> ?options:anonymous_interface_6 or_null -> unit -> Buffer.t_0 [@@js.global "readFileSync"]
    val readFileSync: path:fs_PathLike or_number -> options:(BufferEncoding.t_0, anonymous_interface_5) union2 -> string [@@js.global "readFileSync"]
    val readFileSync: path:fs_PathLike or_number -> ?options:BufferEncoding.t_0 or_null -> unit -> Buffer.t_0 or_string [@@js.global "readFileSync"]
    module WriteFileOptions : sig
      type t = fs_WriteFileOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    val writeFile: path:fs_PathLike or_number -> data:NodeJS.ArrayBufferView.t_0 or_string -> options:fs_WriteFileOptions -> callback:fs_NoParamCallback -> unit [@@js.global "writeFile"]
    val writeFile: path:fs_PathLike or_number -> data:NodeJS.ArrayBufferView.t_0 or_string -> callback:fs_NoParamCallback -> unit [@@js.global "writeFile"]
    module[@js.scope "writeFile"] WriteFile : sig
      val __promisify__: path:fs_PathLike or_number -> data:NodeJS.ArrayBufferView.t_0 or_string -> ?options:fs_WriteFileOptions -> unit -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val writeFileSync: path:fs_PathLike or_number -> data:NodeJS.ArrayBufferView.t_0 or_string -> ?options:fs_WriteFileOptions -> unit -> unit [@@js.global "writeFileSync"]
    val appendFile: file:fs_PathLike or_number -> data:Uint8Array.t_0 or_string -> options:fs_WriteFileOptions -> callback:fs_NoParamCallback -> unit [@@js.global "appendFile"]
    val appendFile: file:fs_PathLike or_number -> data:Uint8Array.t_0 or_string -> callback:fs_NoParamCallback -> unit [@@js.global "appendFile"]
    module[@js.scope "appendFile"] AppendFile : sig
      val __promisify__: file:fs_PathLike or_number -> data:Uint8Array.t_0 or_string -> ?options:fs_WriteFileOptions -> unit -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val appendFileSync: file:fs_PathLike or_number -> data:Uint8Array.t_0 or_string -> ?options:fs_WriteFileOptions -> unit -> unit [@@js.global "appendFileSync"]
    val watchFile: filename:fs_PathLike -> options:anonymous_interface_16 or_undefined -> listener:(curr:fs_Stats -> prev:fs_Stats -> unit) -> unit [@@js.global "watchFile"]
    val watchFile: filename:fs_PathLike -> listener:(curr:fs_Stats -> prev:fs_Stats -> unit) -> unit [@@js.global "watchFile"]
    val unwatchFile: filename:fs_PathLike -> ?listener:(curr:fs_Stats -> prev:fs_Stats -> unit) -> unit -> unit [@@js.global "unwatchFile"]
    val watch: filename:fs_PathLike -> options:(BufferEncoding.t_0, anonymous_interface_10) union2 or_null_or_undefined -> ?listener:(event:([`L_s1_change[@js "change"] | `L_s16_rename[@js "rename"]] [@js.enum]) -> filename:string -> unit) -> unit -> fs_FSWatcher [@@js.global "watch"]
    val watch: filename:fs_PathLike -> options:(anonymous_interface_8, ([`L_s0_buffer] [@js.enum])) or_enum -> ?listener:(event:([`L_s1_change[@js "change"] | `L_s16_rename[@js "rename"]] [@js.enum]) -> filename:Buffer.t_0 -> unit) -> unit -> fs_FSWatcher [@@js.global "watch"]
    val watch: filename:fs_PathLike -> options:anonymous_interface_10 or_string or_null -> ?listener:(event:([`L_s1_change[@js "change"] | `L_s16_rename[@js "rename"]] [@js.enum]) -> filename:Buffer.t_0 or_string -> unit) -> unit -> fs_FSWatcher [@@js.global "watch"]
    val watch: filename:fs_PathLike -> ?listener:(event:([`L_s1_change[@js "change"] | `L_s16_rename[@js "rename"]] [@js.enum]) -> filename:string -> any) -> unit -> fs_FSWatcher [@@js.global "watch"]
    val exists: path:fs_PathLike -> callback:(exists:bool -> unit) -> unit [@@js.global "exists"]
    module[@js.scope "exists"] Exists : sig
      val __promisify__: path:fs_PathLike -> bool Promise.t_1 [@@js.global "__promisify__"]
    end
    val existsSync: path:fs_PathLike -> bool [@@js.global "existsSync"]
    module[@js.scope "constants"] Constants : sig
      val f_OK: float [@@js.global "F_OK"]
      val r_OK: float [@@js.global "R_OK"]
      val w_OK: float [@@js.global "W_OK"]
      val x_OK: float [@@js.global "X_OK"]
      val cOPYFILE_EXCL: float [@@js.global "COPYFILE_EXCL"]
      val cOPYFILE_FICLONE: float [@@js.global "COPYFILE_FICLONE"]
      val cOPYFILE_FICLONE_FORCE: float [@@js.global "COPYFILE_FICLONE_FORCE"]
      val o_RDONLY: float [@@js.global "O_RDONLY"]
      val o_WRONLY: float [@@js.global "O_WRONLY"]
      val o_RDWR: float [@@js.global "O_RDWR"]
      val o_CREAT: float [@@js.global "O_CREAT"]
      val o_EXCL: float [@@js.global "O_EXCL"]
      val o_NOCTTY: float [@@js.global "O_NOCTTY"]
      val o_TRUNC: float [@@js.global "O_TRUNC"]
      val o_APPEND: float [@@js.global "O_APPEND"]
      val o_DIRECTORY: float [@@js.global "O_DIRECTORY"]
      val o_NOATIME: float [@@js.global "O_NOATIME"]
      val o_NOFOLLOW: float [@@js.global "O_NOFOLLOW"]
      val o_SYNC: float [@@js.global "O_SYNC"]
      val o_DSYNC: float [@@js.global "O_DSYNC"]
      val o_SYMLINK: float [@@js.global "O_SYMLINK"]
      val o_DIRECT: float [@@js.global "O_DIRECT"]
      val o_NONBLOCK: float [@@js.global "O_NONBLOCK"]
      val s_IFMT: float [@@js.global "S_IFMT"]
      val s_IFREG: float [@@js.global "S_IFREG"]
      val s_IFDIR: float [@@js.global "S_IFDIR"]
      val s_IFCHR: float [@@js.global "S_IFCHR"]
      val s_IFBLK: float [@@js.global "S_IFBLK"]
      val s_IFIFO: float [@@js.global "S_IFIFO"]
      val s_IFLNK: float [@@js.global "S_IFLNK"]
      val s_IFSOCK: float [@@js.global "S_IFSOCK"]
      val s_IRWXU: float [@@js.global "S_IRWXU"]
      val s_IRUSR: float [@@js.global "S_IRUSR"]
      val s_IWUSR: float [@@js.global "S_IWUSR"]
      val s_IXUSR: float [@@js.global "S_IXUSR"]
      val s_IRWXG: float [@@js.global "S_IRWXG"]
      val s_IRGRP: float [@@js.global "S_IRGRP"]
      val s_IWGRP: float [@@js.global "S_IWGRP"]
      val s_IXGRP: float [@@js.global "S_IXGRP"]
      val s_IRWXO: float [@@js.global "S_IRWXO"]
      val s_IROTH: float [@@js.global "S_IROTH"]
      val s_IWOTH: float [@@js.global "S_IWOTH"]
      val s_IXOTH: float [@@js.global "S_IXOTH"]
      val uV_FS_O_FILEMAP: float [@@js.global "UV_FS_O_FILEMAP"]
    end
    val access: path:fs_PathLike -> mode:float or_undefined -> callback:fs_NoParamCallback -> unit [@@js.global "access"]
    val access: path:fs_PathLike -> callback:fs_NoParamCallback -> unit [@@js.global "access"]
    module[@js.scope "access"] Access : sig
      val __promisify__: path:fs_PathLike -> ?mode:float -> unit -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val accessSync: path:fs_PathLike -> ?mode:float -> unit -> unit [@@js.global "accessSync"]
    val createReadStream: path:fs_PathLike -> ?options:anonymous_interface_13 or_string -> unit -> fs_ReadStream [@@js.global "createReadStream"]
    val createWriteStream: path:fs_PathLike -> ?options:anonymous_interface_14 or_string -> unit -> fs_WriteStream [@@js.global "createWriteStream"]
    val fdatasync: fd:float -> callback:fs_NoParamCallback -> unit [@@js.global "fdatasync"]
    module[@js.scope "fdatasync"] Fdatasync : sig
      val __promisify__: fd:float -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val fdatasyncSync: fd:float -> unit [@@js.global "fdatasyncSync"]
    val copyFile: src:fs_PathLike -> dest:fs_PathLike -> callback:fs_NoParamCallback -> unit [@@js.global "copyFile"]
    val copyFile: src:fs_PathLike -> dest:fs_PathLike -> flags:float -> callback:fs_NoParamCallback -> unit [@@js.global "copyFile"]
    module[@js.scope "copyFile"] CopyFile : sig
      val __promisify__: src:fs_PathLike -> dst:fs_PathLike -> ?flags:float -> unit -> unit Promise.t_1 [@@js.global "__promisify__"]
    end
    val copyFileSync: src:fs_PathLike -> dest:fs_PathLike -> ?flags:float -> unit -> unit [@@js.global "copyFileSync"]
    val writev: fd:float -> buffers:NodeJS.ArrayBufferView.t_0 list -> cb:(err:NodeJS.ErrnoException.t_0 or_null -> bytesWritten:float -> buffers:NodeJS.ArrayBufferView.t_0 list -> unit) -> unit [@@js.global "writev"]
    val writev: fd:float -> buffers:NodeJS.ArrayBufferView.t_0 list -> position:float -> cb:(err:NodeJS.ErrnoException.t_0 or_null -> bytesWritten:float -> buffers:NodeJS.ArrayBufferView.t_0 list -> unit) -> unit [@@js.global "writev"]
    module[@js.scope "WriteVResult"] WriteVResult : sig
      type t = fs_WriteVResult
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_bytesWritten: t -> float [@@js.get "bytesWritten"]
      val set_bytesWritten: t -> float -> unit [@@js.set "bytesWritten"]
      val get_buffers: t -> NodeJS.ArrayBufferView.t_0 list [@@js.get "buffers"]
      val set_buffers: t -> NodeJS.ArrayBufferView.t_0 list -> unit [@@js.set "buffers"]
    end
    module[@js.scope "writev"] Writev : sig
      val __promisify__: fd:float -> buffers:NodeJS.ArrayBufferView.t_0 list -> ?position:float -> unit -> fs_WriteVResult Promise.t_1 [@@js.global "__promisify__"]
    end
    val writevSync: fd:float -> buffers:NodeJS.ArrayBufferView.t_0 list -> ?position:float -> unit -> float [@@js.global "writevSync"]
    val readv: fd:float -> buffers:NodeJS.ArrayBufferView.t_0 list -> cb:(err:NodeJS.ErrnoException.t_0 or_null -> bytesRead:float -> buffers:NodeJS.ArrayBufferView.t_0 list -> unit) -> unit [@@js.global "readv"]
    val readv: fd:float -> buffers:NodeJS.ArrayBufferView.t_0 list -> position:float -> cb:(err:NodeJS.ErrnoException.t_0 or_null -> bytesRead:float -> buffers:NodeJS.ArrayBufferView.t_0 list -> unit) -> unit [@@js.global "readv"]
    module[@js.scope "ReadVResult"] ReadVResult : sig
      type t = fs_ReadVResult
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_bytesRead: t -> float [@@js.get "bytesRead"]
      val set_bytesRead: t -> float -> unit [@@js.set "bytesRead"]
      val get_buffers: t -> NodeJS.ArrayBufferView.t_0 list [@@js.get "buffers"]
      val set_buffers: t -> NodeJS.ArrayBufferView.t_0 list -> unit [@@js.set "buffers"]
    end
    module[@js.scope "readv"] Readv : sig
      val __promisify__: fd:float -> buffers:NodeJS.ArrayBufferView.t_0 list -> ?position:float -> unit -> fs_ReadVResult Promise.t_1 [@@js.global "__promisify__"]
    end
    val readvSync: fd:float -> buffers:NodeJS.ArrayBufferView.t_0 list -> ?position:float -> unit -> float [@@js.global "readvSync"]
    module[@js.scope "OpenDirOptions"] OpenDirOptions : sig
      type t = fs_OpenDirOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_encoding: t -> BufferEncoding.t_0 [@@js.get "encoding"]
      val set_encoding: t -> BufferEncoding.t_0 -> unit [@@js.set "encoding"]
      val get_bufferSize: t -> float [@@js.get "bufferSize"]
      val set_bufferSize: t -> float -> unit [@@js.set "bufferSize"]
    end
    val opendirSync: path:string -> ?options:fs_OpenDirOptions -> unit -> fs_Dir [@@js.global "opendirSync"]
    val opendir: path:string -> cb:(err:NodeJS.ErrnoException.t_0 or_null -> dir:fs_Dir -> unit) -> unit [@@js.global "opendir"]
    val opendir: path:string -> options:fs_OpenDirOptions -> cb:(err:NodeJS.ErrnoException.t_0 or_null -> dir:fs_Dir -> unit) -> unit [@@js.global "opendir"]
    module[@js.scope "opendir"] Opendir : sig
      val __promisify__: path:string -> ?options:fs_OpenDirOptions -> unit -> fs_Dir Promise.t_1 [@@js.global "__promisify__"]
    end
    module[@js.scope "BigIntStats"] BigIntStats : sig
      type t = fs_BigIntStats
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val cast: t -> bigint fs_StatsBase [@@js.cast]
    end
    module[@js.scope "BigIntStats"] BigIntStats : sig
      type t = fs_BigIntStats
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_atimeNs: t -> bigint [@@js.get "atimeNs"]
      val set_atimeNs: t -> bigint -> unit [@@js.set "atimeNs"]
      val get_mtimeNs: t -> bigint [@@js.get "mtimeNs"]
      val set_mtimeNs: t -> bigint -> unit [@@js.set "mtimeNs"]
      val get_ctimeNs: t -> bigint [@@js.get "ctimeNs"]
      val set_ctimeNs: t -> bigint -> unit [@@js.set "ctimeNs"]
      val get_birthtimeNs: t -> bigint [@@js.get "birthtimeNs"]
      val set_birthtimeNs: t -> bigint -> unit [@@js.set "birthtimeNs"]
    end
    module[@js.scope "BigIntOptions"] BigIntOptions : sig
      type t = fs_BigIntOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_bigint: t -> ([`L_b_true[@js true]] [@js.enum]) [@@js.get "bigint"]
      val set_bigint: t -> ([`L_b_true] [@js.enum]) -> unit [@@js.set "bigint"]
    end
    module[@js.scope "StatOptions"] StatOptions : sig
      type t = fs_StatOptions
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_bigint: t -> bool [@@js.get "bigint"]
      val set_bigint: t -> bool -> unit [@@js.set "bigint"]
    end
  end
end
