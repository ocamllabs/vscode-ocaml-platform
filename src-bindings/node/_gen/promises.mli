[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - BaseEncodingOptions
  - BigIntStats
  - Buffer
  - BufferEncoding
  - BufferEncodingOption
  - Date
  - Dir
  - Dirent
  - MakeDirectoryOptions
  - Mode
  - NodeJS.ArrayBufferView
  - OpenDirOptions
  - OpenMode
  - PathLike
  - Promise<T1>
  - ReadVResult
  - RmDirOptions
  - RmOptions
  - StatOptions
  - Stats
  - Uint8Array
  - WriteVResult
 *)
[@@@js.stop]
module type Missing = sig
  module BaseEncodingOptions : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module BigIntStats : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
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
  module BufferEncodingOption : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Date : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Dir : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Dirent : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module MakeDirectoryOptions : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Mode : sig
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
  end
  module OpenDirOptions : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module OpenMode : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module PathLike : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Promise : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module ReadVResult : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module RmDirOptions : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module RmOptions : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module StatOptions : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Stats : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module Uint8Array : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
  module WriteVResult : sig
    type t_0
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module BaseEncodingOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module BigIntStats : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
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
    module BufferEncodingOption : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Date : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Dir : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Dirent : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module MakeDirectoryOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Mode : sig
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
    end
    module OpenDirOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module OpenMode : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module PathLike : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Promise : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module ReadVResult : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module RmDirOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module RmOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module StatOptions : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Stats : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module Uint8Array : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module WriteVResult : sig
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
    end
    module Types : sig
      open AnonymousInterfaces
      type node_fs_promises_FileHandle = [`Node_fs_promises_FileHandle] intf
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
    val get_flag: t -> OpenMode.t_0 [@@js.get "flag"]
    val set_flag: t -> OpenMode.t_0 -> unit [@@js.set "flag"]
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
    val get_flag: t -> OpenMode.t_0 [@@js.get "flag"]
    val set_flag: t -> OpenMode.t_0 -> unit [@@js.set "flag"]
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
    val get_withFileTypes: t -> ([`L_b_false[@js false]] [@js.enum]) [@@js.get "withFileTypes"]
    val set_withFileTypes: t -> ([`L_b_false] [@js.enum]) -> unit [@@js.set "withFileTypes"]
  end
  module AnonymousInterface8 : sig
    type t = anonymous_interface_8
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_flag: t -> OpenMode.t_0 [@@js.get "flag"]
    val set_flag: t -> OpenMode.t_0 -> unit [@@js.set "flag"]
  end
  module AnonymousInterface9 : sig
    type t = anonymous_interface_9
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_mode: t -> Mode.t_0 [@@js.get "mode"]
    val set_mode: t -> Mode.t_0 -> unit [@@js.set "mode"]
    val get_flag: t -> OpenMode.t_0 [@@js.get "flag"]
    val set_flag: t -> OpenMode.t_0 -> unit [@@js.set "flag"]
  end
  module AnonymousInterface10 : sig
    type t = anonymous_interface_10
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_recursive: t -> ([`L_b_false[@js false]] [@js.enum]) [@@js.get "recursive"]
    val set_recursive: t -> ([`L_b_false] [@js.enum]) -> unit [@@js.set "recursive"]
  end
  module AnonymousInterface11 : sig
    type t = anonymous_interface_11
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_recursive: t -> ([`L_b_true[@js true]] [@js.enum]) [@@js.get "recursive"]
    val set_recursive: t -> ([`L_b_true] [@js.enum]) -> unit [@@js.set "recursive"]
  end
  module AnonymousInterface12 : sig
    type t = anonymous_interface_12
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_withFileTypes: t -> ([`L_b_false[@js false]] [@js.enum]) [@@js.get "withFileTypes"]
    val set_withFileTypes: t -> ([`L_b_false] [@js.enum]) -> unit [@@js.set "withFileTypes"]
  end
  module AnonymousInterface13 : sig
    type t = anonymous_interface_13
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_withFileTypes: t -> ([`L_b_true[@js true]] [@js.enum]) [@@js.get "withFileTypes"]
    val set_withFileTypes: t -> ([`L_b_true] [@js.enum]) -> unit [@@js.set "withFileTypes"]
  end
  module[@js.scope "fs/promises"] Fs_promises : sig
    (* export * from 'node:fs/promises'; *)
  end
  module[@js.scope "node:fs/promises"] Node_fs_promises : sig
    (* import {
            Stats,
            BigIntStats,
            StatOptions,
            WriteVResult,
            ReadVResult,
            PathLike,
            RmDirOptions,
            RmOptions,
            MakeDirectoryOptions,
            Dirent,
            OpenDirOptions,
            Dir,
            BaseEncodingOptions,
            BufferEncodingOption,
            OpenMode,
            Mode,
        } from 'node:fs'; *)
    module[@js.scope "FileHandle"] FileHandle : sig
      type t = node_fs_promises_FileHandle
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val get_fd: t -> float [@@js.get "fd"]
      val appendFile: t -> data:Uint8Array.t_0 or_string -> ?options:BufferEncoding.t_0 or_null -> unit -> unit Promise.t_1 [@@js.call "appendFile"]
      val chown: t -> uid:float -> gid:float -> unit Promise.t_1 [@@js.call "chown"]
      val chmod: t -> mode:Mode.t_0 -> unit Promise.t_1 [@@js.call "chmod"]
      val datasync: t -> unit Promise.t_1 [@@js.call "datasync"]
      val sync: t -> unit Promise.t_1 [@@js.call "sync"]
      val read: t -> buffer:'TBuffer -> ?offset:float or_null -> ?length:float or_null -> ?position:float or_null -> unit -> anonymous_interface_2 Promise.t_1 [@@js.call "read"]
      val readFile: t -> ?options:anonymous_interface_6 or_null -> unit -> Buffer.t_0 Promise.t_1 [@@js.call "readFile"]
      val readFile': t -> options:(BufferEncoding.t_0, anonymous_interface_5) union2 -> string Promise.t_1 [@@js.call "readFile"]
      val readFile'': t -> ?options:BufferEncoding.t_0 or_null -> unit -> Buffer.t_0 or_string Promise.t_1 [@@js.call "readFile"]
      val stat: t -> ?opts:(StatOptions.t_0, anonymous_interface_0) intersection2 -> unit -> Stats.t_0 Promise.t_1 [@@js.call "stat"]
      val stat': t -> opts:(StatOptions.t_0, anonymous_interface_1) intersection2 -> BigIntStats.t_0 Promise.t_1 [@@js.call "stat"]
      val stat'': t -> ?opts:StatOptions.t_0 -> unit -> (BigIntStats.t_0, Stats.t_0) union2 Promise.t_1 [@@js.call "stat"]
      val truncate: t -> ?len:float -> unit -> unit Promise.t_1 [@@js.call "truncate"]
      val utimes: t -> atime:Date.t_0 or_string or_number -> mtime:Date.t_0 or_string or_number -> unit Promise.t_1 [@@js.call "utimes"]
      val write: t -> buffer:'TBuffer -> ?offset:float or_null -> ?length:float or_null -> ?position:float or_null -> unit -> anonymous_interface_3 Promise.t_1 [@@js.call "write"]
      val write': t -> data:Uint8Array.t_0 or_string -> ?position:float or_null -> ?encoding:BufferEncoding.t_0 or_null -> unit -> anonymous_interface_4 Promise.t_1 [@@js.call "write"]
      val writeFile: t -> data:Uint8Array.t_0 or_string -> ?options:BufferEncoding.t_0 or_null -> unit -> unit Promise.t_1 [@@js.call "writeFile"]
      val writev: t -> buffers:NodeJS.ArrayBufferView.t_0 list -> ?position:float -> unit -> WriteVResult.t_0 Promise.t_1 [@@js.call "writev"]
      val readv: t -> buffers:NodeJS.ArrayBufferView.t_0 list -> ?position:float -> unit -> ReadVResult.t_0 Promise.t_1 [@@js.call "readv"]
      val close: t -> unit Promise.t_1 [@@js.call "close"]
    end
    val access: path:PathLike.t_0 -> ?mode:float -> unit -> unit Promise.t_1 [@@js.global "access"]
    val copyFile: src:PathLike.t_0 -> dest:PathLike.t_0 -> ?flags:float -> unit -> unit Promise.t_1 [@@js.global "copyFile"]
    val open_: path:PathLike.t_0 -> flags:string or_number -> ?mode:Mode.t_0 -> unit -> node_fs_promises_FileHandle Promise.t_1 [@@js.global "open"]
    val read: handle:node_fs_promises_FileHandle -> buffer:'TBuffer -> ?offset:float or_null -> ?length:float or_null -> ?position:float or_null -> unit -> anonymous_interface_2 Promise.t_1 [@@js.global "read"]
    val write: handle:node_fs_promises_FileHandle -> buffer:'TBuffer -> ?offset:float or_null -> ?length:float or_null -> ?position:float or_null -> unit -> anonymous_interface_3 Promise.t_1 [@@js.global "write"]
    val write: handle:node_fs_promises_FileHandle -> string:string -> ?position:float or_null -> ?encoding:BufferEncoding.t_0 or_null -> unit -> anonymous_interface_4 Promise.t_1 [@@js.global "write"]
    val rename: oldPath:PathLike.t_0 -> newPath:PathLike.t_0 -> unit Promise.t_1 [@@js.global "rename"]
    val truncate: path:PathLike.t_0 -> ?len:float -> unit -> unit Promise.t_1 [@@js.global "truncate"]
    val ftruncate: handle:node_fs_promises_FileHandle -> ?len:float -> unit -> unit Promise.t_1 [@@js.global "ftruncate"]
    val rmdir: path:PathLike.t_0 -> ?options:RmDirOptions.t_0 -> unit -> unit Promise.t_1 [@@js.global "rmdir"]
    val rm: path:PathLike.t_0 -> ?options:RmOptions.t_0 -> unit -> unit Promise.t_1 [@@js.global "rm"]
    val fdatasync: handle:node_fs_promises_FileHandle -> unit Promise.t_1 [@@js.global "fdatasync"]
    val fsync: handle:node_fs_promises_FileHandle -> unit Promise.t_1 [@@js.global "fsync"]
    val mkdir: path:PathLike.t_0 -> options:(MakeDirectoryOptions.t_0, anonymous_interface_11) intersection2 -> string or_undefined Promise.t_1 [@@js.global "mkdir"]
    val mkdir: path:PathLike.t_0 -> ?options:Mode.t_0 or_null -> unit -> unit Promise.t_1 [@@js.global "mkdir"]
    val mkdir: path:PathLike.t_0 -> ?options:(MakeDirectoryOptions.t_0, Mode.t_0) union2 or_null -> unit -> string or_undefined Promise.t_1 [@@js.global "mkdir"]
    val readdir: path:PathLike.t_0 -> ?options:BufferEncoding.t_0 or_null -> unit -> string list Promise.t_1 [@@js.global "readdir"]
    val readdir: path:PathLike.t_0 -> options:(anonymous_interface_7, ([`L_s0_buffer] [@js.enum])) or_enum -> Buffer.t_0 list Promise.t_1 [@@js.global "readdir"]
    val readdir: path:PathLike.t_0 -> ?options:BufferEncoding.t_0 or_null -> unit -> Buffer.t_0 or_string list Promise.t_1 [@@js.global "readdir"]
    val readdir: path:PathLike.t_0 -> options:(BaseEncodingOptions.t_0, anonymous_interface_13) intersection2 -> Dirent.t_0 list Promise.t_1 [@@js.global "readdir"]
    val readlink: path:PathLike.t_0 -> ?options:(BaseEncodingOptions.t_0, BufferEncoding.t_0) union2 or_null -> unit -> string Promise.t_1 [@@js.global "readlink"]
    val readlink: path:PathLike.t_0 -> options:BufferEncodingOption.t_0 -> Buffer.t_0 Promise.t_1 [@@js.global "readlink"]
    val readlink: path:PathLike.t_0 -> ?options:BaseEncodingOptions.t_0 or_string or_null -> unit -> Buffer.t_0 or_string Promise.t_1 [@@js.global "readlink"]
    val symlink: target:PathLike.t_0 -> path:PathLike.t_0 -> ?type_:string or_null -> unit -> unit Promise.t_1 [@@js.global "symlink"]
    val lstat: path:PathLike.t_0 -> ?opts:(StatOptions.t_0, anonymous_interface_0) intersection2 -> unit -> Stats.t_0 Promise.t_1 [@@js.global "lstat"]
    val lstat: path:PathLike.t_0 -> opts:(StatOptions.t_0, anonymous_interface_1) intersection2 -> BigIntStats.t_0 Promise.t_1 [@@js.global "lstat"]
    val lstat: path:PathLike.t_0 -> ?opts:StatOptions.t_0 -> unit -> (BigIntStats.t_0, Stats.t_0) union2 Promise.t_1 [@@js.global "lstat"]
    val stat: path:PathLike.t_0 -> ?opts:(StatOptions.t_0, anonymous_interface_0) intersection2 -> unit -> Stats.t_0 Promise.t_1 [@@js.global "stat"]
    val stat: path:PathLike.t_0 -> opts:(StatOptions.t_0, anonymous_interface_1) intersection2 -> BigIntStats.t_0 Promise.t_1 [@@js.global "stat"]
    val stat: path:PathLike.t_0 -> ?opts:StatOptions.t_0 -> unit -> (BigIntStats.t_0, Stats.t_0) union2 Promise.t_1 [@@js.global "stat"]
    val link: existingPath:PathLike.t_0 -> newPath:PathLike.t_0 -> unit Promise.t_1 [@@js.global "link"]
    val unlink: path:PathLike.t_0 -> unit Promise.t_1 [@@js.global "unlink"]
    val fchmod: handle:node_fs_promises_FileHandle -> mode:Mode.t_0 -> unit Promise.t_1 [@@js.global "fchmod"]
    val chmod: path:PathLike.t_0 -> mode:Mode.t_0 -> unit Promise.t_1 [@@js.global "chmod"]
    val lchmod: path:PathLike.t_0 -> mode:Mode.t_0 -> unit Promise.t_1 [@@js.global "lchmod"]
    val lchown: path:PathLike.t_0 -> uid:float -> gid:float -> unit Promise.t_1 [@@js.global "lchown"]
    val lutimes: path:PathLike.t_0 -> atime:Date.t_0 or_string or_number -> mtime:Date.t_0 or_string or_number -> unit Promise.t_1 [@@js.global "lutimes"]
    val fchown: handle:node_fs_promises_FileHandle -> uid:float -> gid:float -> unit Promise.t_1 [@@js.global "fchown"]
    val chown: path:PathLike.t_0 -> uid:float -> gid:float -> unit Promise.t_1 [@@js.global "chown"]
    val utimes: path:PathLike.t_0 -> atime:Date.t_0 or_string or_number -> mtime:Date.t_0 or_string or_number -> unit Promise.t_1 [@@js.global "utimes"]
    val futimes: handle:node_fs_promises_FileHandle -> atime:Date.t_0 or_string or_number -> mtime:Date.t_0 or_string or_number -> unit Promise.t_1 [@@js.global "futimes"]
    val realpath: path:PathLike.t_0 -> ?options:(BaseEncodingOptions.t_0, BufferEncoding.t_0) union2 or_null -> unit -> string Promise.t_1 [@@js.global "realpath"]
    val realpath: path:PathLike.t_0 -> options:BufferEncodingOption.t_0 -> Buffer.t_0 Promise.t_1 [@@js.global "realpath"]
    val realpath: path:PathLike.t_0 -> ?options:(BaseEncodingOptions.t_0, BufferEncoding.t_0) union2 or_null -> unit -> Buffer.t_0 or_string Promise.t_1 [@@js.global "realpath"]
    val mkdtemp: prefix:string -> ?options:(BaseEncodingOptions.t_0, BufferEncoding.t_0) union2 or_null -> unit -> string Promise.t_1 [@@js.global "mkdtemp"]
    val mkdtemp: prefix:string -> options:BufferEncodingOption.t_0 -> Buffer.t_0 Promise.t_1 [@@js.global "mkdtemp"]
    val mkdtemp: prefix:string -> ?options:(BaseEncodingOptions.t_0, BufferEncoding.t_0) union2 or_null -> unit -> Buffer.t_0 or_string Promise.t_1 [@@js.global "mkdtemp"]
    val writeFile: path:(node_fs_promises_FileHandle, PathLike.t_0) union2 -> data:Uint8Array.t_0 or_string -> ?options:BufferEncoding.t_0 or_null -> unit -> unit Promise.t_1 [@@js.global "writeFile"]
    val appendFile: path:(node_fs_promises_FileHandle, PathLike.t_0) union2 -> data:Uint8Array.t_0 or_string -> ?options:BufferEncoding.t_0 or_null -> unit -> unit Promise.t_1 [@@js.global "appendFile"]
    val readFile: path:(node_fs_promises_FileHandle, PathLike.t_0) union2 -> ?options:anonymous_interface_6 or_null -> unit -> Buffer.t_0 Promise.t_1 [@@js.global "readFile"]
    val readFile: path:(node_fs_promises_FileHandle, PathLike.t_0) union2 -> options:(BufferEncoding.t_0, anonymous_interface_5) union2 -> string Promise.t_1 [@@js.global "readFile"]
    val readFile: path:(node_fs_promises_FileHandle, PathLike.t_0) union2 -> ?options:BufferEncoding.t_0 or_null -> unit -> Buffer.t_0 or_string Promise.t_1 [@@js.global "readFile"]
    val opendir: path:string -> ?options:OpenDirOptions.t_0 -> unit -> Dir.t_0 Promise.t_1 [@@js.global "opendir"]
  end
end
