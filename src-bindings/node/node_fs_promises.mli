[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals
open Node_fs.Fs

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bigint : t -> ([ `L_b_false [@js false] ][@js.enum])
    [@@js.get "bigint"]

  val set_bigint : t -> ([ `L_b_false ][@js.enum]) -> unit [@@js.set "bigint"]
end

module Anonymous_interface1 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bigint : t -> ([ `L_b_true [@js true] ][@js.enum]) [@@js.get "bigint"]

  val set_bigint : t -> ([ `L_b_true ][@js.enum]) -> unit [@@js.set "bigint"]
end

module Anonymous_interface2 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bytes_read : t -> int [@@js.get "bytesRead"]

  val set_bytes_read : t -> int -> unit [@@js.set "bytesRead"]

  val get_buffer : t -> 'TBuffer [@@js.get "buffer"]

  val set_buffer : t -> 'TBuffer -> unit [@@js.set "buffer"]
end

module Anonymous_interface3 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bytes_written : t -> int [@@js.get "bytesWritten"]

  val set_bytes_written : t -> int -> unit [@@js.set "bytesWritten"]

  val get_buffer : t -> 'TBuffer [@@js.get "buffer"]

  val set_buffer : t -> 'TBuffer -> unit [@@js.set "buffer"]
end

module Anonymous_interface4 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_bytes_written : t -> int [@@js.get "bytesWritten"]

  val set_bytes_written : t -> int -> unit [@@js.set "bytesWritten"]

  val get_buffer : t -> string [@@js.get "buffer"]

  val set_buffer : t -> string -> unit [@@js.set "buffer"]
end

module Anonymous_interface5 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_encoding : t -> Buffer_encoding.t [@@js.get "encoding"]

  val set_encoding : t -> Buffer_encoding.t -> unit [@@js.set "encoding"]

  val get_flag : t -> Open_mode.t [@@js.get "flag"]

  val set_flag : t -> Open_mode.t -> unit [@@js.set "flag"]
end

module Read_file_options : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_encoding : t -> never or_null [@@js.get "encoding"]

  val set_encoding : t -> never or_null -> unit [@@js.set "encoding"]

  val get_flag : t -> Open_mode.t [@@js.get "flag"]

  val set_flag : t -> Open_mode.t -> unit [@@js.set "flag"]
end

module Readdir_options : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_encoding : t -> ([ `buffer [@js "buffer"] ][@js.enum])
    [@@js.get "encoding"]

  val set_encoding : t -> ([ `buffer ][@js.enum]) -> unit [@@js.set "encoding"]

  val get_with_file_types : t -> ([ `L_b_false [@js false] ][@js.enum])
    [@@js.get "withFileTypes"]

  val set_with_file_types : t -> ([ `L_b_false ][@js.enum]) -> unit
    [@@js.set "withFileTypes"]
end

module Anonymous_interface8 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_flag : t -> Open_mode.t [@@js.get "flag"]

  val set_flag : t -> Open_mode.t -> unit [@@js.set "flag"]
end

module Anonymous_interface9 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_mode : t -> Mode.t [@@js.get "mode"]

  val set_mode : t -> Mode.t -> unit [@@js.set "mode"]

  val get_flag : t -> Open_mode.t [@@js.get "flag"]

  val set_flag : t -> Open_mode.t -> unit [@@js.set "flag"]
end

module Anonymous_interface10 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_recursive : t -> ([ `L_b_false [@js false] ][@js.enum])
    [@@js.get "recursive"]

  val set_recursive : t -> ([ `L_b_false ][@js.enum]) -> unit
    [@@js.set "recursive"]
end

module Anonymous_interface11 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_recursive : t -> ([ `L_b_true [@js true] ][@js.enum])
    [@@js.get "recursive"]

  val set_recursive : t -> ([ `L_b_true ][@js.enum]) -> unit
    [@@js.set "recursive"]
end

module Anonymous_interface12 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_with_file_types : t -> ([ `L_b_false [@js false] ][@js.enum])
    [@@js.get "withFileTypes"]

  val set_with_file_types : t -> ([ `L_b_false ][@js.enum]) -> unit
    [@@js.set "withFileTypes"]
end

module Anonymous_interface13 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_with_file_types : t -> ([ `L_b_true [@js true] ][@js.enum])
    [@@js.get "withFileTypes"]

  val set_with_file_types : t -> ([ `L_b_true ][@js.enum]) -> unit
    [@@js.set "withFileTypes"]
end

module Fs_promises : sig
  module File_handle : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_fd : t -> int [@@js.get "fd"]

    val append_file :
         t
      -> data:Uint8_array.t or_string
      -> ?options:Buffer_encoding.t or_null
      -> unit
      -> unit Promise.t
      [@@js.call "appendFile"]

    val chown : t -> uid:int -> gid:int -> unit Promise.t [@@js.call "chown"]

    val chmod : t -> mode:Mode.t -> unit Promise.t [@@js.call "chmod"]

    val datasync : t -> unit Promise.t [@@js.call "datasync"]

    val sync : t -> unit Promise.t [@@js.call "sync"]

    val read :
         t
      -> buffer:'TBuffer
      -> ?offset:int or_null
      -> ?length:int or_null
      -> ?position:int or_null
      -> unit
      -> Anonymous_interface2.t Promise.t
      [@@js.call "read"]

    val read_file :
      t -> ?options:Read_file_options.t or_null -> unit -> Buffer.t Promise.t
      [@@js.call "readFile"]

    val read_file' :
         t
      -> options:(Buffer_encoding.t, Anonymous_interface5.t) union2
      -> string Promise.t
      [@@js.call "readFile"]

    val read_file'' :
         t
      -> ?options:Buffer_encoding.t or_null
      -> unit
      -> Buffer.t or_string Promise.t
      [@@js.call "readFile"]

    val stat :
         t
      -> ?opts:(Stat_options.t, Anonymous_interface0.t) intersection2
      -> unit
      -> Stats.t Promise.t
      [@@js.call "stat"]

    val stat' :
         t
      -> opts:(Stat_options.t, Anonymous_interface1.t) intersection2
      -> Big_int_stats.t Promise.t
      [@@js.call "stat"]

    val stat'' :
         t
      -> ?opts:Stat_options.t
      -> unit
      -> (Big_int_stats.t, Stats.t) union2 Promise.t
      [@@js.call "stat"]

    val truncate : t -> ?len:int -> unit -> unit Promise.t
      [@@js.call "truncate"]

    val utimes :
         t
      -> atime:Date.t or_string or_number
      -> mtime:Date.t or_string or_number
      -> unit Promise.t
      [@@js.call "utimes"]

    val write :
         t
      -> buffer:'TBuffer
      -> ?offset:int or_null
      -> ?length:int or_null
      -> ?position:int or_null
      -> unit
      -> Anonymous_interface3.t Promise.t
      [@@js.call "write"]

    val write' :
         t
      -> data:Uint8_array.t or_string
      -> ?position:int or_null
      -> ?encoding:Buffer_encoding.t or_null
      -> unit
      -> Anonymous_interface4.t Promise.t
      [@@js.call "write"]

    val write_file :
         t
      -> data:Uint8_array.t or_string
      -> ?options:Buffer_encoding.t or_null
      -> unit
      -> unit Promise.t
      [@@js.call "writeFile"]

    val writev :
         t
      -> buffers:Array_buffer_view.t list
      -> ?position:int
      -> unit
      -> Write_v_result.t Promise.t
      [@@js.call "writev"]

    val readv :
         t
      -> buffers:Array_buffer_view.t list
      -> ?position:int
      -> unit
      -> Read_v_result.t Promise.t
      [@@js.call "readv"]

    val close : t -> unit Promise.t [@@js.call "close"]
  end
  [@@js.scope "FileHandle"]

  val access : string -> ?mode:int -> unit -> unit Promise.t
    [@@js.global "access"]

  val copy_file :
    src:string -> dest:string -> ?flags:int -> unit -> unit Promise.t
    [@@js.global "copyFile"]

  val open_ :
       string
    -> flags:string or_number
    -> ?mode:Mode.t
    -> unit
    -> File_handle.t Promise.t
    [@@js.global "open"]

  val read :
       handle:File_handle.t
    -> buffer:'TBuffer
    -> ?offset:int or_null
    -> ?length:int or_null
    -> ?position:int or_null
    -> unit
    -> Anonymous_interface2.t Promise.t
    [@@js.global "read"]

  val write :
       handle:File_handle.t
    -> buffer:'TBuffer
    -> ?offset:int or_null
    -> ?length:int or_null
    -> ?position:int or_null
    -> unit
    -> Anonymous_interface3.t Promise.t
    [@@js.global "write"]

  val write :
       handle:File_handle.t
    -> string:string
    -> ?position:int or_null
    -> ?encoding:Buffer_encoding.t or_null
    -> unit
    -> Anonymous_interface4.t Promise.t
    [@@js.global "write"]

  val rename : old_path:string -> new_path:string -> unit Promise.t
    [@@js.global "rename"]

  val truncate : string -> ?len:int -> unit -> unit Promise.t
    [@@js.global "truncate"]

  val ftruncate : handle:File_handle.t -> ?len:int -> unit -> unit Promise.t
    [@@js.global "ftruncate"]

  val rmdir : string -> ?options:Rm_dir_options.t -> unit -> unit Promise.t
    [@@js.global "rmdir"]

  val rm : string -> ?options:Rm_options.t -> unit -> unit Promise.t
    [@@js.global "rm"]

  val fdatasync : handle:File_handle.t -> unit Promise.t
    [@@js.global "fdatasync"]

  val fsync : handle:File_handle.t -> unit Promise.t [@@js.global "fsync"]

  val mkdir :
       string
    -> options:(Make_directory_options.t, Anonymous_interface11.t) intersection2
    -> string or_undefined Promise.t
    [@@js.global "mkdir"]

  val mkdir : string -> ?options:Mode.t or_null -> unit -> unit Promise.t
    [@@js.global "mkdir"]

  val mkdir :
       string
    -> ?options:(Make_directory_options.t, Mode.t) union2 or_null
    -> unit
    -> string or_undefined Promise.t
    [@@js.global "mkdir"]

  val readdir : string -> string list Promise.t [@@js.global "readdir"]

  val readlink :
       string
    -> ?options:(Base_encoding_options.t, Buffer_encoding.t) union2 or_null
    -> unit
    -> string Promise.t
    [@@js.global "readlink"]

  val readlink :
    string -> options:Buffer_encoding_option.t -> Buffer.t Promise.t
    [@@js.global "readlink"]

  val readlink :
       string
    -> ?options:Base_encoding_options.t or_string or_null
    -> unit
    -> Buffer.t or_string Promise.t
    [@@js.global "readlink"]

  val symlink :
    target:string -> string -> ?type_:string or_null -> unit -> unit Promise.t
    [@@js.global "symlink"]

  val lstat :
       string
    -> ?opts:(Stat_options.t, Anonymous_interface0.t) intersection2
    -> unit
    -> Stats.t Promise.t
    [@@js.global "lstat"]

  val lstat :
       string
    -> opts:(Stat_options.t, Anonymous_interface1.t) intersection2
    -> Big_int_stats.t Promise.t
    [@@js.global "lstat"]

  val lstat :
       string
    -> ?opts:Stat_options.t
    -> unit
    -> (Big_int_stats.t, Stats.t) union2 Promise.t
    [@@js.global "lstat"]

  val stat :
       string
    -> ?opts:(Stat_options.t, Anonymous_interface0.t) intersection2
    -> unit
    -> Stats.t Promise.t
    [@@js.global "stat"]

  val stat :
       string
    -> opts:(Stat_options.t, Anonymous_interface1.t) intersection2
    -> Big_int_stats.t Promise.t
    [@@js.global "stat"]

  val stat :
       string
    -> ?opts:Stat_options.t
    -> unit
    -> (Big_int_stats.t, Stats.t) union2 Promise.t
    [@@js.global "stat"]

  val link : existing_path:string -> new_path:string -> unit Promise.t
    [@@js.global "link"]

  val unlink : string -> unit Promise.t [@@js.global "unlink"]

  val fchmod : handle:File_handle.t -> mode:Mode.t -> unit Promise.t
    [@@js.global "fchmod"]

  val chmod : string -> mode:Mode.t -> unit Promise.t [@@js.global "chmod"]

  val lchmod : string -> mode:Mode.t -> unit Promise.t [@@js.global "lchmod"]

  val lchown : string -> uid:int -> gid:int -> unit Promise.t
    [@@js.global "lchown"]

  val lutimes :
       string
    -> atime:Date.t or_string or_number
    -> mtime:Date.t or_string or_number
    -> unit Promise.t
    [@@js.global "lutimes"]

  val fchown : handle:File_handle.t -> uid:int -> gid:int -> unit Promise.t
    [@@js.global "fchown"]

  val chown : string -> uid:int -> gid:int -> unit Promise.t
    [@@js.global "chown"]

  val utimes :
       string
    -> atime:Date.t or_string or_number
    -> mtime:Date.t or_string or_number
    -> unit Promise.t
    [@@js.global "utimes"]

  val futimes :
       handle:File_handle.t
    -> atime:Date.t or_string or_number
    -> mtime:Date.t or_string or_number
    -> unit Promise.t
    [@@js.global "futimes"]

  val realpath :
       string
    -> ?options:(Base_encoding_options.t, Buffer_encoding.t) union2 or_null
    -> unit
    -> string Promise.t
    [@@js.global "realpath"]

  val realpath :
    string -> options:Buffer_encoding_option.t -> Buffer.t Promise.t
    [@@js.global "realpath"]

  val realpath :
       string
    -> ?options:(Base_encoding_options.t, Buffer_encoding.t) union2 or_null
    -> unit
    -> Buffer.t or_string Promise.t
    [@@js.global "realpath"]

  val mkdtemp :
       prefix:string
    -> ?options:(Base_encoding_options.t, Buffer_encoding.t) union2 or_null
    -> unit
    -> string Promise.t
    [@@js.global "mkdtemp"]

  val mkdtemp :
    prefix:string -> options:Buffer_encoding_option.t -> Buffer.t Promise.t
    [@@js.global "mkdtemp"]

  val mkdtemp :
       prefix:string
    -> ?options:(Base_encoding_options.t, Buffer_encoding.t) union2 or_null
    -> unit
    -> Buffer.t or_string Promise.t
    [@@js.global "mkdtemp"]

  val write_file :
       (File_handle.t, string) union2
    -> data:Uint8_array.t or_string
    -> ?options:Buffer_encoding.t or_null
    -> unit
    -> unit Promise.t
    [@@js.global "writeFile"]

  val append_file :
       (File_handle.t, string) union2
    -> data:Uint8_array.t or_string
    -> ?options:Buffer_encoding.t or_null
    -> unit
    -> unit Promise.t
    [@@js.global "appendFile"]

  val read_file :
    string -> ?options:Read_file_options.t or_null -> unit -> string Promise.t
    [@@js.global "readFile"]

  val read_file_handle :
       File_handle.t
    -> ?options:Read_file_options.t or_null
    -> unit
    -> string Promise.t
    [@@js.global "readFile"]

  val opendir : string -> ?options:Open_dir_options.t -> unit -> Dir.t Promise.t
    [@@js.global "opendir"]
end
[@@js.scope Import.fs_promises]
