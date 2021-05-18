[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - AsyncIterable<T1>
  - AsyncIterableIterator<T1>
  - BufferEncoding
  - Error
  - EventEmitter
  - Iterable<T1>
  - NodeJS.ErrnoException
  - NodeJS.ReadWriteStream
  - NodeJS.ReadableStream
  - NodeJS.WritableStream
  - Promise<T1>
 *)
[@@@js.stop]
module type Missing = sig
  module AsyncIterable : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module AsyncIterableIterator : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module BufferEncoding : sig
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
  module Iterable : sig
    type 'T1 t_1
    val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
    val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
  end
  module NodeJS : sig
    module ErrnoException : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ReadWriteStream : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module ReadableStream : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module WritableStream : sig
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
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module AsyncIterable : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module AsyncIterableIterator : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module BufferEncoding : sig
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
    module Iterable : sig
      type 'T1 t_1
      val t_1_to_js: ('T1 -> Ojs.t) -> 'T1 t_1 -> Ojs.t
      val t_1_of_js: (Ojs.t -> 'T1) -> Ojs.t -> 'T1 t_1
    end
    module NodeJS : sig
      module ErrnoException : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module ReadWriteStream : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module ReadableStream : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module WritableStream : sig
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
      type stream_internal = [`Stream_internal] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and stream_internal_Duplex = [`Stream_internal_Duplex | `Stream_internal_Readable | `Stream_internal_Stream | `Stream_internal_Writable | `Stream_internal] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and stream_internal_DuplexOptions = [`Stream_internal_DuplexOptions | `Stream_internal_ReadableOptions | `Stream_internal_WritableOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and stream_internal_FinishedOptions = [`Stream_internal_FinishedOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and stream_internal_PassThrough = [`Stream_internal_PassThrough | `Stream_internal_Duplex | `Stream_internal_Readable | `Stream_internal_Stream | `Stream_internal_Transform | `Stream_internal_Writable | `Stream_internal] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and stream_internal_Pipe = [`Stream_internal_Pipe] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and stream_internal_Readable = [`Stream_internal_Readable | `Stream_internal_Stream | `Stream_internal] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and stream_internal_ReadableOptions = [`Stream_internal_ReadableOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and stream_internal_Stream = [`Stream_internal_Stream | `Stream_internal] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and stream_internal_Transform = [`Stream_internal_Transform | `Stream_internal_Duplex | `Stream_internal_Readable | `Stream_internal_Stream | `Stream_internal_Writable | `Stream_internal] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and stream_internal_TransformCallback = [`Stream_internal_TransformCallback] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and stream_internal_TransformOptions = [`Stream_internal_TransformOptions | `Stream_internal_DuplexOptions | `Stream_internal_ReadableOptions | `Stream_internal_WritableOptions] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and stream_internal_Writable = [`Stream_internal_Writable | `Stream_internal_Stream | `Stream_internal] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and stream_internal_WritableOptions = [`Stream_internal_WritableOptions] intf
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
    val get_chunk: t -> any [@@js.get "chunk"]
    val set_chunk: t -> any -> unit [@@js.set "chunk"]
    val get_encoding: t -> BufferEncoding.t_0 [@@js.get "encoding"]
    val set_encoding: t -> BufferEncoding.t_0 -> unit [@@js.set "encoding"]
  end
  module AnonymousInterface1 : sig
    type t = anonymous_interface_1
    val t_to_js: t -> Ojs.t
    val t_of_js: Ojs.t -> t
    type t_0 = t
    val t_0_to_js: t_0 -> Ojs.t
    val t_0_of_js: Ojs.t -> t_0
    val get_end: t -> bool [@@js.get "end"]
    val set_end: t -> bool -> unit [@@js.set "end"]
  end
  module[@js.scope "node:stream"] Node_stream : sig
    (* import Stream = require('stream'); *)
    
  end
  module[@js.scope "stream"] Stream : sig
    (* import EventEmitter = require('node:events'); *)
    module[@js.scope "internal"] Internal : sig
      type t = stream_internal
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val pipe: t -> destination:'T -> ?options:anonymous_interface_1 -> unit -> 'T [@@js.call "pipe"]
      val cast: t -> EventEmitter.t_0 [@@js.cast]
    end
    module[@js.scope "internal"] Internal : sig
      module[@js.scope "Stream"] Stream : sig
        type t = stream_internal_Stream
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val create: ?opts:stream_internal_ReadableOptions -> unit -> t [@@js.create]
        val cast: t -> stream_internal [@@js.cast]
      end
      module[@js.scope "ReadableOptions"] ReadableOptions : sig
        type t = stream_internal_ReadableOptions
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_highWaterMark: t -> float [@@js.get "highWaterMark"]
        val set_highWaterMark: t -> float -> unit [@@js.set "highWaterMark"]
        val get_encoding: t -> BufferEncoding.t_0 [@@js.get "encoding"]
        val set_encoding: t -> BufferEncoding.t_0 -> unit [@@js.set "encoding"]
        val get_objectMode: t -> bool [@@js.get "objectMode"]
        val set_objectMode: t -> bool -> unit [@@js.set "objectMode"]
        val read: t -> this:stream_internal_Readable -> size:float -> unit [@@js.call "read"]
        val destroy: t -> this:stream_internal_Readable -> error:Error.t_0 or_null -> callback:(error:Error.t_0 or_null -> unit) -> unit [@@js.call "destroy"]
        val get_autoDestroy: t -> bool [@@js.get "autoDestroy"]
        val set_autoDestroy: t -> bool -> unit [@@js.set "autoDestroy"]
      end
      module[@js.scope "Readable"] Readable : sig
        type t = stream_internal_Readable
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val from: iterable:(any AsyncIterable.t_1, any Iterable.t_1) union2 -> ?options:stream_internal_ReadableOptions -> unit -> t [@@js.global "from"]
        val get_readable: t -> bool [@@js.get "readable"]
        val set_readable: t -> bool -> unit [@@js.set "readable"]
        val get_readableEncoding: t -> BufferEncoding.t_0 or_null [@@js.get "readableEncoding"]
        val get_readableEnded: t -> bool [@@js.get "readableEnded"]
        val get_readableFlowing: t -> bool or_null [@@js.get "readableFlowing"]
        val get_readableHighWaterMark: t -> float [@@js.get "readableHighWaterMark"]
        val get_readableLength: t -> float [@@js.get "readableLength"]
        val get_readableObjectMode: t -> bool [@@js.get "readableObjectMode"]
        val get_destroyed: t -> bool [@@js.get "destroyed"]
        val set_destroyed: t -> bool -> unit [@@js.set "destroyed"]
        val create: ?opts:stream_internal_ReadableOptions -> unit -> t [@@js.create]
        val _read: t -> size:float -> unit [@@js.call "_read"]
        val read: t -> ?size:float -> unit -> any [@@js.call "read"]
        val setEncoding: t -> encoding:BufferEncoding.t_0 -> t [@@js.call "setEncoding"]
        val pause: t -> t [@@js.call "pause"]
        val resume: t -> t [@@js.call "resume"]
        val isPaused: t -> bool [@@js.call "isPaused"]
        val unpipe: t -> ?destination:NodeJS.WritableStream.t_0 -> unit -> t [@@js.call "unpipe"]
        val unshift: t -> chunk:any -> ?encoding:BufferEncoding.t_0 -> unit -> unit [@@js.call "unshift"]
        val wrap: t -> oldStream:NodeJS.ReadableStream.t_0 -> t [@@js.call "wrap"]
        val push: t -> chunk:any -> ?encoding:BufferEncoding.t_0 -> unit -> bool [@@js.call "push"]
        val _destroy: t -> error:Error.t_0 or_null -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "_destroy"]
        val destroy: t -> ?error:Error.t_0 -> unit -> unit [@@js.call "destroy"]
        val addListener: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
        val addListener': t -> event:([`L_s1_data] [@js.enum]) -> listener:(chunk:any -> unit) -> t [@@js.call "addListener"]
        val addListener'': t -> event:([`L_s3_end] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
        val addListener''': t -> event:([`L_s4_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "addListener"]
        val addListener'''': t -> event:([`L_s6_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
        val addListener''''': t -> event:([`L_s8_readable] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
        val addListener'''''': t -> event:([`L_s9_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
        val addListener''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "addListener"]
        val emit: t -> event:([`L_s0_close] [@js.enum]) -> bool [@@js.call "emit"]
        val emit': t -> event:([`L_s1_data] [@js.enum]) -> chunk:any -> bool [@@js.call "emit"]
        val emit'': t -> event:([`L_s3_end] [@js.enum]) -> bool [@@js.call "emit"]
        val emit''': t -> event:([`L_s4_error] [@js.enum]) -> err:Error.t_0 -> bool [@@js.call "emit"]
        val emit'''': t -> event:([`L_s6_pause] [@js.enum]) -> bool [@@js.call "emit"]
        val emit''''': t -> event:([`L_s8_readable] [@js.enum]) -> bool [@@js.call "emit"]
        val emit'''''': t -> event:([`L_s9_resume] [@js.enum]) -> bool [@@js.call "emit"]
        val emit''''''': t -> event:symbol or_string -> args:(any list [@js.variadic]) -> bool [@@js.call "emit"]
        val on: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
        val on': t -> event:([`L_s1_data] [@js.enum]) -> listener:(chunk:any -> unit) -> t [@@js.call "on"]
        val on'': t -> event:([`L_s3_end] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
        val on''': t -> event:([`L_s4_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "on"]
        val on'''': t -> event:([`L_s6_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
        val on''''': t -> event:([`L_s8_readable] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
        val on'''''': t -> event:([`L_s9_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
        val on''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "on"]
        val once: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
        val once': t -> event:([`L_s1_data] [@js.enum]) -> listener:(chunk:any -> unit) -> t [@@js.call "once"]
        val once'': t -> event:([`L_s3_end] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
        val once''': t -> event:([`L_s4_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "once"]
        val once'''': t -> event:([`L_s6_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
        val once''''': t -> event:([`L_s8_readable] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
        val once'''''': t -> event:([`L_s9_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
        val once''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "once"]
        val prependListener: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
        val prependListener': t -> event:([`L_s1_data] [@js.enum]) -> listener:(chunk:any -> unit) -> t [@@js.call "prependListener"]
        val prependListener'': t -> event:([`L_s3_end] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
        val prependListener''': t -> event:([`L_s4_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "prependListener"]
        val prependListener'''': t -> event:([`L_s6_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
        val prependListener''''': t -> event:([`L_s8_readable] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
        val prependListener'''''': t -> event:([`L_s9_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
        val prependListener''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependListener"]
        val prependOnceListener: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
        val prependOnceListener': t -> event:([`L_s1_data] [@js.enum]) -> listener:(chunk:any -> unit) -> t [@@js.call "prependOnceListener"]
        val prependOnceListener'': t -> event:([`L_s3_end] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
        val prependOnceListener''': t -> event:([`L_s4_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "prependOnceListener"]
        val prependOnceListener'''': t -> event:([`L_s6_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
        val prependOnceListener''''': t -> event:([`L_s8_readable] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
        val prependOnceListener'''''': t -> event:([`L_s9_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
        val prependOnceListener''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependOnceListener"]
        val removeListener: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "removeListener"]
        val removeListener': t -> event:([`L_s1_data] [@js.enum]) -> listener:(chunk:any -> unit) -> t [@@js.call "removeListener"]
        val removeListener'': t -> event:([`L_s3_end] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "removeListener"]
        val removeListener''': t -> event:([`L_s4_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "removeListener"]
        val removeListener'''': t -> event:([`L_s6_pause] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "removeListener"]
        val removeListener''''': t -> event:([`L_s8_readable] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "removeListener"]
        val removeListener'''''': t -> event:([`L_s9_resume] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "removeListener"]
        val removeListener''''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "removeListener"]
        val _Symbol_asyncIterator_: t -> any AsyncIterableIterator.t_1 [@@js.call "[Symbol.asyncIterator]"]
        val cast: t -> stream_internal_Stream [@@js.cast]
        val cast': t -> NodeJS.ReadableStream.t_0 [@@js.cast]
      end
      module[@js.scope "WritableOptions"] WritableOptions : sig
        type t = stream_internal_WritableOptions
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_highWaterMark: t -> float [@@js.get "highWaterMark"]
        val set_highWaterMark: t -> float -> unit [@@js.set "highWaterMark"]
        val get_decodeStrings: t -> bool [@@js.get "decodeStrings"]
        val set_decodeStrings: t -> bool -> unit [@@js.set "decodeStrings"]
        val get_defaultEncoding: t -> BufferEncoding.t_0 [@@js.get "defaultEncoding"]
        val set_defaultEncoding: t -> BufferEncoding.t_0 -> unit [@@js.set "defaultEncoding"]
        val get_objectMode: t -> bool [@@js.get "objectMode"]
        val set_objectMode: t -> bool -> unit [@@js.set "objectMode"]
        val get_emitClose: t -> bool [@@js.get "emitClose"]
        val set_emitClose: t -> bool -> unit [@@js.set "emitClose"]
        val write: t -> this:stream_internal_Writable -> chunk:any -> encoding:BufferEncoding.t_0 -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "write"]
        val writev: t -> this:stream_internal_Writable -> chunks:anonymous_interface_0 list -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "writev"]
        val destroy: t -> this:stream_internal_Writable -> error:Error.t_0 or_null -> callback:(error:Error.t_0 or_null -> unit) -> unit [@@js.call "destroy"]
        val final: t -> this:stream_internal_Writable -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "final"]
        val get_autoDestroy: t -> bool [@@js.get "autoDestroy"]
        val set_autoDestroy: t -> bool -> unit [@@js.set "autoDestroy"]
      end
      module[@js.scope "Writable"] Writable : sig
        type t = stream_internal_Writable
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_writable: t -> bool [@@js.get "writable"]
        val get_writableEnded: t -> bool [@@js.get "writableEnded"]
        val get_writableFinished: t -> bool [@@js.get "writableFinished"]
        val get_writableHighWaterMark: t -> float [@@js.get "writableHighWaterMark"]
        val get_writableLength: t -> float [@@js.get "writableLength"]
        val get_writableObjectMode: t -> bool [@@js.get "writableObjectMode"]
        val get_writableCorked: t -> float [@@js.get "writableCorked"]
        val get_destroyed: t -> bool [@@js.get "destroyed"]
        val set_destroyed: t -> bool -> unit [@@js.set "destroyed"]
        val create: ?opts:stream_internal_WritableOptions -> unit -> t [@@js.create]
        val _write: t -> chunk:any -> encoding:BufferEncoding.t_0 -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "_write"]
        val _writev: t -> chunks:anonymous_interface_0 list -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "_writev"]
        val _destroy: t -> error:Error.t_0 or_null -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "_destroy"]
        val _final: t -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "_final"]
        val write: t -> chunk:any -> ?cb:(error:Error.t_0 or_null_or_undefined -> unit) -> unit -> bool [@@js.call "write"]
        val write': t -> chunk:any -> encoding:BufferEncoding.t_0 -> ?cb:(error:Error.t_0 or_null_or_undefined -> unit) -> unit -> bool [@@js.call "write"]
        val setDefaultEncoding: t -> encoding:BufferEncoding.t_0 -> t [@@js.call "setDefaultEncoding"]
        val end_: t -> ?cb:(unit -> unit) -> unit -> unit [@@js.call "end"]
        val end_': t -> chunk:any -> ?cb:(unit -> unit) -> unit -> unit [@@js.call "end"]
        val end_'': t -> chunk:any -> encoding:BufferEncoding.t_0 -> ?cb:(unit -> unit) -> unit -> unit [@@js.call "end"]
        val cork: t -> unit [@@js.call "cork"]
        val uncork: t -> unit [@@js.call "uncork"]
        val destroy: t -> ?error:Error.t_0 -> unit -> unit [@@js.call "destroy"]
        val addListener: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
        val addListener': t -> event:([`L_s2_drain] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
        val addListener'': t -> event:([`L_s4_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "addListener"]
        val addListener''': t -> event:([`L_s5_finish] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
        val addListener'''': t -> event:([`L_s7_pipe] [@js.enum]) -> listener:(src:stream_internal_Readable -> unit) -> t [@@js.call "addListener"]
        val addListener''''': t -> event:([`L_s10_unpipe] [@js.enum]) -> listener:(src:stream_internal_Readable -> unit) -> t [@@js.call "addListener"]
        val addListener'''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "addListener"]
        val emit: t -> event:([`L_s0_close] [@js.enum]) -> bool [@@js.call "emit"]
        val emit': t -> event:([`L_s2_drain] [@js.enum]) -> bool [@@js.call "emit"]
        val emit'': t -> event:([`L_s4_error] [@js.enum]) -> err:Error.t_0 -> bool [@@js.call "emit"]
        val emit''': t -> event:([`L_s5_finish] [@js.enum]) -> bool [@@js.call "emit"]
        val emit'''': t -> event:([`L_s7_pipe] [@js.enum]) -> src:stream_internal_Readable -> bool [@@js.call "emit"]
        val emit''''': t -> event:([`L_s10_unpipe] [@js.enum]) -> src:stream_internal_Readable -> bool [@@js.call "emit"]
        val emit'''''': t -> event:symbol or_string -> args:(any list [@js.variadic]) -> bool [@@js.call "emit"]
        val on: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
        val on': t -> event:([`L_s2_drain] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
        val on'': t -> event:([`L_s4_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "on"]
        val on''': t -> event:([`L_s5_finish] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
        val on'''': t -> event:([`L_s7_pipe] [@js.enum]) -> listener:(src:stream_internal_Readable -> unit) -> t [@@js.call "on"]
        val on''''': t -> event:([`L_s10_unpipe] [@js.enum]) -> listener:(src:stream_internal_Readable -> unit) -> t [@@js.call "on"]
        val on'''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "on"]
        val once: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
        val once': t -> event:([`L_s2_drain] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
        val once'': t -> event:([`L_s4_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "once"]
        val once''': t -> event:([`L_s5_finish] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
        val once'''': t -> event:([`L_s7_pipe] [@js.enum]) -> listener:(src:stream_internal_Readable -> unit) -> t [@@js.call "once"]
        val once''''': t -> event:([`L_s10_unpipe] [@js.enum]) -> listener:(src:stream_internal_Readable -> unit) -> t [@@js.call "once"]
        val once'''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "once"]
        val prependListener: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
        val prependListener': t -> event:([`L_s2_drain] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
        val prependListener'': t -> event:([`L_s4_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "prependListener"]
        val prependListener''': t -> event:([`L_s5_finish] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
        val prependListener'''': t -> event:([`L_s7_pipe] [@js.enum]) -> listener:(src:stream_internal_Readable -> unit) -> t [@@js.call "prependListener"]
        val prependListener''''': t -> event:([`L_s10_unpipe] [@js.enum]) -> listener:(src:stream_internal_Readable -> unit) -> t [@@js.call "prependListener"]
        val prependListener'''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependListener"]
        val prependOnceListener: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
        val prependOnceListener': t -> event:([`L_s2_drain] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
        val prependOnceListener'': t -> event:([`L_s4_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "prependOnceListener"]
        val prependOnceListener''': t -> event:([`L_s5_finish] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
        val prependOnceListener'''': t -> event:([`L_s7_pipe] [@js.enum]) -> listener:(src:stream_internal_Readable -> unit) -> t [@@js.call "prependOnceListener"]
        val prependOnceListener''''': t -> event:([`L_s10_unpipe] [@js.enum]) -> listener:(src:stream_internal_Readable -> unit) -> t [@@js.call "prependOnceListener"]
        val prependOnceListener'''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependOnceListener"]
        val removeListener: t -> event:([`L_s0_close] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "removeListener"]
        val removeListener': t -> event:([`L_s2_drain] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "removeListener"]
        val removeListener'': t -> event:([`L_s4_error] [@js.enum]) -> listener:(err:Error.t_0 -> unit) -> t [@@js.call "removeListener"]
        val removeListener''': t -> event:([`L_s5_finish] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "removeListener"]
        val removeListener'''': t -> event:([`L_s7_pipe] [@js.enum]) -> listener:(src:stream_internal_Readable -> unit) -> t [@@js.call "removeListener"]
        val removeListener''''': t -> event:([`L_s10_unpipe] [@js.enum]) -> listener:(src:stream_internal_Readable -> unit) -> t [@@js.call "removeListener"]
        val removeListener'''''': t -> event:symbol or_string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "removeListener"]
        val cast: t -> stream_internal_Stream [@@js.cast]
        val cast': t -> NodeJS.WritableStream.t_0 [@@js.cast]
      end
      module[@js.scope "DuplexOptions"] DuplexOptions : sig
        type t = stream_internal_DuplexOptions
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_allowHalfOpen: t -> bool [@@js.get "allowHalfOpen"]
        val set_allowHalfOpen: t -> bool -> unit [@@js.set "allowHalfOpen"]
        val get_readableObjectMode: t -> bool [@@js.get "readableObjectMode"]
        val set_readableObjectMode: t -> bool -> unit [@@js.set "readableObjectMode"]
        val get_writableObjectMode: t -> bool [@@js.get "writableObjectMode"]
        val set_writableObjectMode: t -> bool -> unit [@@js.set "writableObjectMode"]
        val get_readableHighWaterMark: t -> float [@@js.get "readableHighWaterMark"]
        val set_readableHighWaterMark: t -> float -> unit [@@js.set "readableHighWaterMark"]
        val get_writableHighWaterMark: t -> float [@@js.get "writableHighWaterMark"]
        val set_writableHighWaterMark: t -> float -> unit [@@js.set "writableHighWaterMark"]
        val get_writableCorked: t -> float [@@js.get "writableCorked"]
        val set_writableCorked: t -> float -> unit [@@js.set "writableCorked"]
        val read: t -> this:stream_internal_Duplex -> size:float -> unit [@@js.call "read"]
        val write: t -> this:stream_internal_Duplex -> chunk:any -> encoding:BufferEncoding.t_0 -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "write"]
        val writev: t -> this:stream_internal_Duplex -> chunks:anonymous_interface_0 list -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "writev"]
        val final: t -> this:stream_internal_Duplex -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "final"]
        val destroy: t -> this:stream_internal_Duplex -> error:Error.t_0 or_null -> callback:(error:Error.t_0 or_null -> unit) -> unit [@@js.call "destroy"]
        val cast: t -> stream_internal_ReadableOptions [@@js.cast]
        val cast': t -> stream_internal_WritableOptions [@@js.cast]
      end
      module[@js.scope "Duplex"] Duplex : sig
        type t = stream_internal_Duplex
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_writable: t -> bool [@@js.get "writable"]
        val get_writableEnded: t -> bool [@@js.get "writableEnded"]
        val get_writableFinished: t -> bool [@@js.get "writableFinished"]
        val get_writableHighWaterMark: t -> float [@@js.get "writableHighWaterMark"]
        val get_writableLength: t -> float [@@js.get "writableLength"]
        val get_writableObjectMode: t -> bool [@@js.get "writableObjectMode"]
        val get_writableCorked: t -> float [@@js.get "writableCorked"]
        val create: ?opts:stream_internal_DuplexOptions -> unit -> t [@@js.create]
        val _write: t -> chunk:any -> encoding:BufferEncoding.t_0 -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "_write"]
        val _writev: t -> chunks:anonymous_interface_0 list -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "_writev"]
        val _destroy: t -> error:Error.t_0 or_null -> callback:(error:Error.t_0 or_null -> unit) -> unit [@@js.call "_destroy"]
        val _final: t -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "_final"]
        val write: t -> chunk:any -> ?encoding:BufferEncoding.t_0 -> ?cb:(error:Error.t_0 or_null_or_undefined -> unit) -> unit -> bool [@@js.call "write"]
        val write': t -> chunk:any -> ?cb:(error:Error.t_0 or_null_or_undefined -> unit) -> unit -> bool [@@js.call "write"]
        val setDefaultEncoding: t -> encoding:BufferEncoding.t_0 -> t [@@js.call "setDefaultEncoding"]
        val end_: t -> ?cb:(unit -> unit) -> unit -> unit [@@js.call "end"]
        val end_': t -> chunk:any -> ?cb:(unit -> unit) -> unit -> unit [@@js.call "end"]
        val end_'': t -> chunk:any -> ?encoding:BufferEncoding.t_0 -> ?cb:(unit -> unit) -> unit -> unit [@@js.call "end"]
        val cork: t -> unit [@@js.call "cork"]
        val uncork: t -> unit [@@js.call "uncork"]
        val cast: t -> stream_internal_Readable [@@js.cast]
        val cast': t -> stream_internal_Writable [@@js.cast]
      end
      module[@js.scope "TransformCallback"] TransformCallback : sig
        type t = stream_internal_TransformCallback
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val apply: t -> ?error:Error.t_0 or_null -> ?data:any -> unit -> unit [@@js.apply]
      end
      module[@js.scope "TransformOptions"] TransformOptions : sig
        type t = stream_internal_TransformOptions
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val read: t -> this:stream_internal_Transform -> size:float -> unit [@@js.call "read"]
        val write: t -> this:stream_internal_Transform -> chunk:any -> encoding:BufferEncoding.t_0 -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "write"]
        val writev: t -> this:stream_internal_Transform -> chunks:anonymous_interface_0 list -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "writev"]
        val final: t -> this:stream_internal_Transform -> callback:(?error:Error.t_0 or_null -> unit -> unit) -> unit [@@js.call "final"]
        val destroy: t -> this:stream_internal_Transform -> error:Error.t_0 or_null -> callback:(error:Error.t_0 or_null -> unit) -> unit [@@js.call "destroy"]
        val transform: t -> this:stream_internal_Transform -> chunk:any -> encoding:BufferEncoding.t_0 -> callback:stream_internal_TransformCallback -> unit [@@js.call "transform"]
        val flush: t -> this:stream_internal_Transform -> callback:stream_internal_TransformCallback -> unit [@@js.call "flush"]
        val cast: t -> stream_internal_DuplexOptions [@@js.cast]
      end
      module[@js.scope "Transform"] Transform : sig
        type t = stream_internal_Transform
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val create: ?opts:stream_internal_TransformOptions -> unit -> t [@@js.create]
        val _transform: t -> chunk:any -> encoding:BufferEncoding.t_0 -> callback:stream_internal_TransformCallback -> unit [@@js.call "_transform"]
        val _flush: t -> callback:stream_internal_TransformCallback -> unit [@@js.call "_flush"]
        val cast: t -> stream_internal_Duplex [@@js.cast]
      end
      module[@js.scope "PassThrough"] PassThrough : sig
        type t = stream_internal_PassThrough
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val cast: t -> stream_internal_Transform [@@js.cast]
      end
      module[@js.scope "FinishedOptions"] FinishedOptions : sig
        type t = stream_internal_FinishedOptions
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val get_error: t -> bool [@@js.get "error"]
        val set_error: t -> bool -> unit [@@js.set "error"]
        val get_readable: t -> bool [@@js.get "readable"]
        val set_readable: t -> bool -> unit [@@js.set "readable"]
        val get_writable: t -> bool [@@js.get "writable"]
        val set_writable: t -> bool -> unit [@@js.set "writable"]
      end
      val finished: stream:(NodeJS.ReadWriteStream.t_0, NodeJS.ReadableStream.t_0, NodeJS.WritableStream.t_0) union3 -> options:stream_internal_FinishedOptions -> callback:(?err:NodeJS.ErrnoException.t_0 or_null -> unit -> unit) -> (unit -> unit [@js.dummy]) [@@js.global "finished"]
      val finished: stream:(NodeJS.ReadWriteStream.t_0, NodeJS.ReadableStream.t_0, NodeJS.WritableStream.t_0) union3 -> callback:(?err:NodeJS.ErrnoException.t_0 or_null -> unit -> unit) -> (unit -> unit [@js.dummy]) [@@js.global "finished"]
      module[@js.scope "finished"] Finished : sig
        val __promisify__: stream:(NodeJS.ReadWriteStream.t_0, NodeJS.ReadableStream.t_0, NodeJS.WritableStream.t_0) union3 -> ?options:stream_internal_FinishedOptions -> unit -> unit Promise.t_1 [@@js.global "__promisify__"]
      end
      val pipeline: stream1:NodeJS.ReadableStream.t_0 -> stream2:'T -> ?callback:(err:NodeJS.ErrnoException.t_0 or_null -> unit) -> unit -> 'T [@@js.global "pipeline"]
      val pipeline: stream1:NodeJS.ReadableStream.t_0 -> stream2:NodeJS.ReadWriteStream.t_0 -> stream3:'T -> ?callback:(err:NodeJS.ErrnoException.t_0 or_null -> unit) -> unit -> 'T [@@js.global "pipeline"]
      val pipeline: stream1:NodeJS.ReadableStream.t_0 -> stream2:NodeJS.ReadWriteStream.t_0 -> stream3:NodeJS.ReadWriteStream.t_0 -> stream4:'T -> ?callback:(err:NodeJS.ErrnoException.t_0 or_null -> unit) -> unit -> 'T [@@js.global "pipeline"]
      val pipeline: stream1:NodeJS.ReadableStream.t_0 -> stream2:NodeJS.ReadWriteStream.t_0 -> stream3:NodeJS.ReadWriteStream.t_0 -> stream4:NodeJS.ReadWriteStream.t_0 -> stream5:'T -> ?callback:(err:NodeJS.ErrnoException.t_0 or_null -> unit) -> unit -> 'T [@@js.global "pipeline"]
      val pipeline: streams:(NodeJS.ReadWriteStream.t_0, NodeJS.ReadableStream.t_0, NodeJS.WritableStream.t_0) union3 list -> ?callback:(err:NodeJS.ErrnoException.t_0 or_null -> unit) -> unit -> NodeJS.WritableStream.t_0 [@@js.global "pipeline"]
      val pipeline: stream1:NodeJS.ReadableStream.t_0 -> stream2:(NodeJS.ReadWriteStream.t_0, NodeJS.WritableStream.t_0) union2 -> streams:((* FIXME: type 'Array<union<?NodeJS.ReadWriteStream | ?NodeJS.WritableStream | (~err:union<?NodeJS.ErrnoException | Null> -> Void)>>' cannot be used for variadic argument *)any list [@js.variadic]) -> NodeJS.WritableStream.t_0 [@@js.global "pipeline"]
      module[@js.scope "pipeline"] Pipeline : sig
        val __promisify__: stream1:NodeJS.ReadableStream.t_0 -> stream2:NodeJS.WritableStream.t_0 -> unit Promise.t_1 [@@js.global "__promisify__"]
        val __promisify__: stream1:NodeJS.ReadableStream.t_0 -> stream2:NodeJS.ReadWriteStream.t_0 -> stream3:NodeJS.WritableStream.t_0 -> unit Promise.t_1 [@@js.global "__promisify__"]
        val __promisify__: stream1:NodeJS.ReadableStream.t_0 -> stream2:NodeJS.ReadWriteStream.t_0 -> stream3:NodeJS.ReadWriteStream.t_0 -> stream4:NodeJS.WritableStream.t_0 -> unit Promise.t_1 [@@js.global "__promisify__"]
        val __promisify__: stream1:NodeJS.ReadableStream.t_0 -> stream2:NodeJS.ReadWriteStream.t_0 -> stream3:NodeJS.ReadWriteStream.t_0 -> stream4:NodeJS.ReadWriteStream.t_0 -> stream5:NodeJS.WritableStream.t_0 -> unit Promise.t_1 [@@js.global "__promisify__"]
        val __promisify__: streams:(NodeJS.ReadWriteStream.t_0, NodeJS.ReadableStream.t_0, NodeJS.WritableStream.t_0) union3 list -> unit Promise.t_1 [@@js.global "__promisify__"]
        val __promisify__: stream1:NodeJS.ReadableStream.t_0 -> stream2:(NodeJS.ReadWriteStream.t_0, NodeJS.WritableStream.t_0) union2 -> streams:((* FIXME: type 'Array<union<?NodeJS.ReadWriteStream | ?NodeJS.WritableStream>>' cannot be used for variadic argument *)any list [@js.variadic]) -> unit Promise.t_1 [@@js.global "__promisify__"]
      end
      module[@js.scope "Pipe"] Pipe : sig
        type t = stream_internal_Pipe
        val t_to_js: t -> Ojs.t
        val t_of_js: Ojs.t -> t
        type t_0 = t
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
        val close: t -> unit [@@js.call "close"]
        val hasRef: t -> bool [@@js.call "hasRef"]
        val ref: t -> unit [@@js.call "ref"]
        val unref: t -> unit [@@js.call "unref"]
      end
    end
    
  end
end
