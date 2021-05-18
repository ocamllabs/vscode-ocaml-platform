[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_chunk : t -> any [@@js.get "chunk"]

  val set_chunk : t -> any -> unit [@@js.set "chunk"]

  val get_encoding : t -> Buffer_encoding.t [@@js.get "encoding"]

  val set_encoding : t -> Buffer_encoding.t -> unit [@@js.set "encoding"]
end

module Anonymous_interface1 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t

  val get_end : t -> bool [@@js.get "end"]

  val set_end : t -> bool -> unit [@@js.set "end"]
end

module Stream : sig
  module Internal : sig
    module Base : sig
      type t = stream

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val pipe : t -> 'T -> ?options:Anonymous_interface1.t -> unit -> 'T
        [@@js.call "pipe"]
    end

    module Readable_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val get_high_water_mark : t -> int [@@js.get "highWaterMark"]

      val set_high_water_mark : t -> int -> unit [@@js.set "highWaterMark"]

      val get_encoding : t -> Buffer_encoding.t [@@js.get "encoding"]

      val set_encoding : t -> Buffer_encoding.t -> unit [@@js.set "encoding"]

      val get_object_mode : t -> bool [@@js.get "objectMode"]

      val set_object_mode : t -> bool -> unit [@@js.set "objectMode"]

      val read : t -> this:stream -> size:int -> unit [@@js.call "read"]

      val destroy :
           t
        -> this:stream
        -> error:Error.t or_null
        -> callback:(error:Error.t or_null -> unit)
        -> unit
        [@@js.call "destroy"]

      val get_auto_destroy : t -> bool [@@js.get "autoDestroy"]

      val set_auto_destroy : t -> bool -> unit [@@js.set "autoDestroy"]
    end
    [@@js.scope "ReadableOptions"]

    module Stream : sig
      include module type of struct
        include Base
      end

      val create : ?opts:Readable_options.t -> unit -> t [@@js.create]
    end
    [@@js.scope "Stream"]

    module Readable : sig
      include module type of struct
        include Stream
      end

      val from :
           iterable:(any Async_iterable.t, any Iterable.t) union2
        -> ?options:Readable_options.t
        -> unit
        -> t
        [@@js.global "from"]

      val get_readable : t -> bool [@@js.get "readable"]

      val set_readable : t -> bool -> unit [@@js.set "readable"]

      val get_readable_encoding : t -> Buffer_encoding.t or_null
        [@@js.get "readableEncoding"]

      val get_readable_ended : t -> bool [@@js.get "readableEnded"]

      val get_readable_flowing : t -> bool or_null [@@js.get "readableFlowing"]

      val get_readable_high_water_mark : t -> int
        [@@js.get "readableHighWaterMark"]

      val get_readable_length : t -> int [@@js.get "readableLength"]

      val get_readable_object_mode : t -> bool [@@js.get "readableObjectMode"]

      val get_destroyed : t -> bool [@@js.get "destroyed"]

      val set_destroyed : t -> bool -> unit [@@js.set "destroyed"]

      val create : ?opts:Readable_options.t -> unit -> t [@@js.create]

      val _read : t -> size:int -> unit [@@js.call "_read"]

      val read : t -> ?size:int -> unit -> any [@@js.call "read"]

      val set_encoding : t -> encoding:Buffer_encoding.t -> t
        [@@js.call "setEncoding"]

      val pause : t -> t [@@js.call "pause"]

      val resume : t -> t [@@js.call "resume"]

      val is_paused : t -> bool [@@js.call "isPaused"]

      val unpipe : t -> ?destination:Writable_stream.t -> unit -> t
        [@@js.call "unpipe"]

      val unshift :
        t -> chunk:string -> ?encoding:Buffer_encoding.t -> unit -> unit
        [@@js.call "unshift"]

      val wrap : t -> old_stream:Readable_stream.t -> t [@@js.call "wrap"]

      val push :
        t -> chunk:string -> ?encoding:Buffer_encoding.t -> unit -> bool
        [@@js.call "push"]

      val _destroy :
           t
        -> error:Error.t or_null
        -> callback:(?error:Error.t or_null -> unit -> unit)
        -> unit
        [@@js.call "_destroy"]

      val destroy : t -> ?error:Error.t -> unit -> unit [@@js.call "destroy"]

      module Close_listener : sig
        type t = unit -> unit

        val t_to_js : t -> Ojs.t

        val t_of_js : Ojs.t -> t
      end

      module Data_listener : sig
        type chunk =
          ([ `String of string
           | `Buffer of Buffer.t
           ]
          [@js.union])

        [@@@js.implem
        let chunk_of_js js_val =
          match Ojs.type_of js_val with
          | "string" -> `String ([%js.to: string] js_val)
          | _ -> `Buffer ([%js.to: Buffer.t] js_val)]

        type t = chunk:chunk -> unit

        val t_to_js : t -> Ojs.t

        val t_of_js : Ojs.t -> t
      end

      module End_listener : sig
        type t = unit -> unit

        val t_to_js : t -> Ojs.t

        val t_of_js : Ojs.t -> t
      end

      module Error_listener : sig
        type t = err:Error.t -> unit

        val t_to_js : t -> Ojs.t

        val t_of_js : Ojs.t -> t
      end

      module Pause_listener : sig
        type t = unit -> unit

        val t_to_js : t -> Ojs.t

        val t_of_js : Ojs.t -> t
      end

      module Readable_listener : sig
        type t = unit -> unit

        val t_to_js : t -> Ojs.t

        val t_of_js : Ojs.t -> t
      end

      module Resume_listener : sig
        type t = unit -> unit

        val t_to_js : t -> Ojs.t

        val t_of_js : Ojs.t -> t
      end

      type listener =
        ([ `Close of Close_listener.t
         | `Data of Data_listener.t
         | `End of End_listener.t
         | `Error of Error_listener.t
         | `Pause of Pause_listener.t
         | `Readable of Readable_listener.t
         | `Resume of Resume_listener.t
         ]
        [@js.union])

      [@@@js.stop]

      val on : t -> listener -> unit

      val add_listener : t -> listener -> unit

      val once : t -> listener -> unit

      val prepend_listener : t -> listener -> unit

      val prepend_once_listener : t -> listener -> unit

      [@@@js.start]

      [@@@js.implem
      val on : t -> string -> Ojs.t -> unit [@@js.call "on"]

      val add_listener : t -> string -> Ojs.t -> unit [@@js.call "addListener"]

      val once : t -> string -> Ojs.t -> unit [@@js.call "once"]

      val prepend_listener : t -> string -> Ojs.t -> unit
        [@@js.call "prependListener"]

      val prepend_once_listener : t -> string -> Ojs.t -> unit
        [@@js.call "prependOnceListener"]

      val remove_listener : t -> string -> Ojs.t -> unit
        [@@js.call "removeListener"]

      let with_listener_fn fn t = function
        | `Close f -> fn t "close" @@ [%js.of: Close_listener.t] f
        | `Data f -> fn t "data" @@ [%js.of: Data_listener.t] f
        | `End f -> fn t "end" @@ [%js.of: End_listener.t] f
        | `Error f -> fn t "error" @@ [%js.of: Error_listener.t] f
        | `Pause f -> fn t "pause" @@ [%js.of: Pause_listener.t] f
        | `Readable f -> fn t "readable" @@ [%js.of: Readable_listener.t] f
        | `Resume f -> fn t "resume" @@ [%js.of: Resume_listener.t] f

      let on = with_listener_fn on

      let add_listener = with_listener_fn add_listener

      let once = with_listener_fn once

      let prepend_listener = with_listener_fn prepend_listener

      let prepend_once_listener = with_listener_fn prepend_once_listener

      let remove_listener = with_listener_fn remove_listener]

      val cast' : t -> Readable_stream.t [@@js.cast]
    end
    [@@js.scope "Readable"]

    module Writable_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val get_high_water_mark : t -> int [@@js.get "highWaterMark"]

      val set_high_water_mark : t -> int -> unit [@@js.set "highWaterMark"]

      val get_decode_strings : t -> bool [@@js.get "decodeStrings"]

      val set_decode_strings : t -> bool -> unit [@@js.set "decodeStrings"]

      val get_default_encoding : t -> Buffer_encoding.t
        [@@js.get "defaultEncoding"]

      val set_default_encoding : t -> Buffer_encoding.t -> unit
        [@@js.set "defaultEncoding"]

      val get_object_mode : t -> bool [@@js.get "objectMode"]

      val set_object_mode : t -> bool -> unit [@@js.set "objectMode"]

      val get_emit_close : t -> bool [@@js.get "emitClose"]

      val set_emit_close : t -> bool -> unit [@@js.set "emitClose"]

      val write :
           t
        -> this:stream
        -> chunk:string
        -> encoding:Buffer_encoding.t
        -> callback:(?error:Error.t or_null -> unit -> unit)
        -> unit
        [@@js.call "write"]

      val writev :
           t
        -> this:stream
        -> chunks:Anonymous_interface0.t list
        -> callback:(?error:Error.t or_null -> unit -> unit)
        -> unit
        [@@js.call "writev"]

      val destroy :
           t
        -> this:stream
        -> error:Error.t or_null
        -> callback:(error:Error.t or_null -> unit)
        -> unit
        [@@js.call "destroy"]

      val final :
           t
        -> this:stream
        -> callback:(?error:Error.t or_null -> unit -> unit)
        -> unit
        [@@js.call "final"]

      val get_auto_destroy : t -> bool [@@js.get "autoDestroy"]

      val set_auto_destroy : t -> bool -> unit [@@js.set "autoDestroy"]
    end
    [@@js.scope "WritableOptions"]

    module Writable : sig
      include module type of struct
        include Stream
      end

      val get_writable : t -> bool [@@js.get "writable"]

      val get_writable_ended : t -> bool [@@js.get "writableEnded"]

      val get_writable_finished : t -> bool [@@js.get "writableFinished"]

      val get_writable_high_water_mark : t -> int
        [@@js.get "writableHighWaterMark"]

      val get_writable_length : t -> int [@@js.get "writableLength"]

      val get_writable_object_mode : t -> bool [@@js.get "writableObjectMode"]

      val get_writable_corked : t -> int [@@js.get "writableCorked"]

      val get_destroyed : t -> bool [@@js.get "destroyed"]

      val set_destroyed : t -> bool -> unit [@@js.set "destroyed"]

      val create : ?opts:Writable_options.t -> unit -> t [@@js.create]

      val _write :
           t
        -> chunk:string
        -> encoding:Buffer_encoding.t
        -> callback:(?error:Error.t or_null -> unit -> unit)
        -> unit
        [@@js.call "_write"]

      val _writev :
           t
        -> chunks:Anonymous_interface0.t list
        -> callback:(?error:Error.t or_null -> unit -> unit)
        -> unit
        [@@js.call "_writev"]

      val _destroy :
           t
        -> error:Error.t or_null
        -> callback:(?error:Error.t or_null -> unit -> unit)
        -> unit
        [@@js.call "_destroy"]

      val _final :
        t -> callback:(?error:Error.t or_null -> unit -> unit) -> unit
        [@@js.call "_final"]

      val write :
           t
        -> chunk:string
        -> ?cb:(error:Error.t or_null_or_undefined -> unit)
        -> unit
        -> bool
        [@@js.call "write"]

      val write' :
           t
        -> chunk:string
        -> encoding:Buffer_encoding.t
        -> ?cb:(error:Error.t or_null_or_undefined -> unit)
        -> unit
        -> bool
        [@@js.call "write"]

      val set_default_encoding : t -> encoding:Buffer_encoding.t -> t
        [@@js.call "setDefaultEncoding"]

      val end_ : t -> ?cb:(unit -> unit) -> unit -> unit [@@js.call "end"]

      val end_' : t -> chunk:string -> ?cb:(unit -> unit) -> unit -> unit
        [@@js.call "end"]

      val end_'' :
           t
        -> chunk:string
        -> encoding:Buffer_encoding.t
        -> ?cb:(unit -> unit)
        -> unit
        -> unit
        [@@js.call "end"]

      val cork : t -> unit [@@js.call "cork"]

      val uncork : t -> unit [@@js.call "uncork"]

      val destroy : t -> ?error:Error.t -> unit -> unit [@@js.call "destroy"]

      val add_listener :
        t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
        [@@js.call "addListener"]

      val add_listener' :
        t -> event:([ `drain ][@js.enum]) -> listener:(unit -> unit) -> t
        [@@js.call "addListener"]

      val add_listener'' :
        t -> event:([ `error ][@js.enum]) -> listener:(err:Error.t -> unit) -> t
        [@@js.call "addListener"]

      val add_listener''' :
        t -> event:([ `finish ][@js.enum]) -> listener:(unit -> unit) -> t
        [@@js.call "addListener"]

      val add_listener'''' :
           t
        -> event:([ `pipe ][@js.enum])
        -> listener:(src:Readable.t -> unit)
        -> t
        [@@js.call "addListener"]

      val add_listener''''' :
           t
        -> event:([ `unpipe ][@js.enum])
        -> listener:(src:Readable.t -> unit)
        -> t
        [@@js.call "addListener"]

      val add_listener'''''' :
           t
        -> event:symbol or_string
        -> listener:(args:(any list[@js.variadic]) -> unit)
        -> t
        [@@js.call "addListener"]

      val emit : t -> event:([ `close ][@js.enum]) -> bool [@@js.call "emit"]

      val emit' : t -> event:([ `drain ][@js.enum]) -> bool [@@js.call "emit"]

      val emit'' : t -> event:([ `error ][@js.enum]) -> err:Error.t -> bool
        [@@js.call "emit"]

      val emit''' : t -> event:([ `finish ][@js.enum]) -> bool
        [@@js.call "emit"]

      val emit'''' : t -> event:([ `pipe ][@js.enum]) -> src:Readable.t -> bool
        [@@js.call "emit"]

      val emit''''' :
        t -> event:([ `unpipe ][@js.enum]) -> src:Readable.t -> bool
        [@@js.call "emit"]

      val emit'''''' :
        t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
        [@@js.call "emit"]

      module Close_listener : sig
        type t = unit -> unit

        val t_to_js : t -> Ojs.t

        val t_of_js : Ojs.t -> t
      end

      module Drain_listener : sig
        type t = unit -> unit

        val t_to_js : t -> Ojs.t

        val t_of_js : Ojs.t -> t
      end

      module Error_listener : sig
        type t = err:Error.t -> unit

        val t_to_js : t -> Ojs.t

        val t_of_js : Ojs.t -> t
      end

      module Finish_listener : sig
        type t = unit -> unit

        val t_to_js : t -> Ojs.t

        val t_of_js : Ojs.t -> t
      end

      module Pipe_listener : sig
        type t = src:Readable.t -> unit

        val t_to_js : t -> Ojs.t

        val t_of_js : Ojs.t -> t
      end

      module Unpipe_listener : sig
        type t = src:Readable.t -> unit

        val t_to_js : t -> Ojs.t

        val t_of_js : Ojs.t -> t
      end

      type listener =
        ([ `Close of Close_listener.t
         | `Drain of Drain_listener.t
         | `Error of Error_listener.t
         | `Finish of Finish_listener.t
         | `Pipe of Pipe_listener.t
         | `Unpipe of Unpipe_listener.t
         ]
        [@js.union])

      [@@@js.stop]

      val on : t -> listener -> unit

      val add_listener : t -> listener -> unit

      val once : t -> listener -> unit

      val prepend_listener : t -> listener -> unit

      val prepend_once_listener : t -> listener -> unit

      [@@@js.start]

      [@@@js.implem
      val on : t -> string -> Ojs.t -> unit [@@js.call "on"]

      val add_listener : t -> string -> Ojs.t -> unit [@@js.call "addListener"]

      val once : t -> string -> Ojs.t -> unit [@@js.call "once"]

      val prepend_listener : t -> string -> Ojs.t -> unit
        [@@js.call "prependListener"]

      val prepend_once_listener : t -> string -> Ojs.t -> unit
        [@@js.call "prependOnceListener"]

      val remove_listener : t -> string -> Ojs.t -> unit
        [@@js.call "removeListener"]

      let with_listener_fn fn t = function
        | `Close f -> fn t "close" @@ [%js.of: Close_listener.t] f
        | `Drain f -> fn t "drain" @@ [%js.of: Drain_listener.t] f
        | `Error f -> fn t "error" @@ [%js.of: Error_listener.t] f
        | `Finish f -> fn t "finish" @@ [%js.of: Finish_listener.t] f
        | `Pipe f -> fn t "pipe" @@ [%js.of: Pipe_listener.t] f
        | `Unpipe f -> fn t "unpipe" @@ [%js.of: Unpipe_listener.t] f

      let on = with_listener_fn on

      let add_listener = with_listener_fn add_listener

      let once = with_listener_fn once

      let prepend_listener = with_listener_fn prepend_listener

      let prepend_once_listener = with_listener_fn prepend_once_listener

      let remove_listener = with_listener_fn remove_listener]

      val cast' : t -> Writable_stream.t [@@js.cast]
    end
    [@@js.scope "Writable"]

    module Duplex_options : sig
      include module type of struct
        include Readable_options
      end

      val get_allow_half_open : t -> bool [@@js.get "allowHalfOpen"]

      val set_allow_half_open : t -> bool -> unit [@@js.set "allowHalfOpen"]

      val get_readable_object_mode : t -> bool [@@js.get "readableObjectMode"]

      val set_readable_object_mode : t -> bool -> unit
        [@@js.set "readableObjectMode"]

      val get_writable_object_mode : t -> bool [@@js.get "writableObjectMode"]

      val set_writable_object_mode : t -> bool -> unit
        [@@js.set "writableObjectMode"]

      val get_readable_high_water_mark : t -> int
        [@@js.get "readableHighWaterMark"]

      val set_readable_high_water_mark : t -> int -> unit
        [@@js.set "readableHighWaterMark"]

      val get_writable_high_water_mark : t -> int
        [@@js.get "writableHighWaterMark"]

      val set_writable_high_water_mark : t -> int -> unit
        [@@js.set "writableHighWaterMark"]

      val get_writable_corked : t -> int [@@js.get "writableCorked"]

      val set_writable_corked : t -> int -> unit [@@js.set "writableCorked"]

      val read : t -> this:stream -> size:int -> unit [@@js.call "read"]

      val write :
           t
        -> this:stream
        -> chunk:string
        -> encoding:Buffer_encoding.t
        -> callback:(?error:Error.t or_null -> unit -> unit)
        -> unit
        [@@js.call "write"]

      val writev :
           t
        -> this:stream
        -> chunks:Anonymous_interface0.t list
        -> callback:(?error:Error.t or_null -> unit -> unit)
        -> unit
        [@@js.call "writev"]

      val final :
           t
        -> this:stream
        -> callback:(?error:Error.t or_null -> unit -> unit)
        -> unit
        [@@js.call "final"]

      val destroy :
           t
        -> this:stream
        -> error:Error.t or_null
        -> callback:(error:Error.t or_null -> unit)
        -> unit
        [@@js.call "destroy"]

      val cast' : t -> Writable_options.t [@@js.cast]
    end
    [@@js.scope "DuplexOptions"]

    module Duplex : sig
      include module type of struct
        include Stream
      end

      val get_writable : t -> bool [@@js.get "writable"]

      val get_writable_ended : t -> bool [@@js.get "writableEnded"]

      val get_writable_finished : t -> bool [@@js.get "writableFinished"]

      val get_writable_high_water_mark : t -> int
        [@@js.get "writableHighWaterMark"]

      val get_writable_length : t -> int [@@js.get "writableLength"]

      val get_writable_object_mode : t -> bool [@@js.get "writableObjectMode"]

      val get_writable_corked : t -> int [@@js.get "writableCorked"]

      val create : ?opts:Duplex_options.t -> unit -> t [@@js.create]

      val _write :
           t
        -> chunk:string
        -> encoding:Buffer_encoding.t
        -> callback:(?error:Error.t or_null -> unit -> unit)
        -> unit
        [@@js.call "_write"]

      val _writev :
           t
        -> chunks:Anonymous_interface0.t list
        -> callback:(?error:Error.t or_null -> unit -> unit)
        -> unit
        [@@js.call "_writev"]

      val _destroy :
           t
        -> error:Error.t or_null
        -> callback:(error:Error.t or_null -> unit)
        -> unit
        [@@js.call "_destroy"]

      val _final :
        t -> callback:(?error:Error.t or_null -> unit -> unit) -> unit
        [@@js.call "_final"]

      val write :
           t
        -> chunk:string
        -> ?encoding:Buffer_encoding.t
        -> ?cb:(error:Error.t or_null_or_undefined -> unit)
        -> unit
        -> bool
        [@@js.call "write"]

      val write' :
           t
        -> chunk:string
        -> ?cb:(error:Error.t or_null_or_undefined -> unit)
        -> unit
        -> bool
        [@@js.call "write"]

      val set_default_encoding : t -> encoding:Buffer_encoding.t -> t
        [@@js.call "setDefaultEncoding"]

      val end_ : t -> ?cb:(unit -> unit) -> unit -> unit [@@js.call "end"]

      val end_' : t -> chunk:string -> ?cb:(unit -> unit) -> unit -> unit
        [@@js.call "end"]

      val end_'' :
           t
        -> chunk:string
        -> ?encoding:Buffer_encoding.t
        -> ?cb:(unit -> unit)
        -> unit
        -> unit
        [@@js.call "end"]

      val cork : t -> unit [@@js.call "cork"]

      val uncork : t -> unit [@@js.call "uncork"]

      val cast' : t -> Writable.t [@@js.cast]
    end
    [@@js.scope "Duplex"]

    module Transform_callback : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val apply : t -> ?error:Error.t or_null -> ?data:any -> unit -> unit
        [@@js.apply]
    end
    [@@js.scope "TransformCallback"]

    module Transform_options : sig
      include module type of struct
        include Duplex_options
      end

      val read : t -> this:stream -> size:int -> unit [@@js.call "read"]

      val write :
           t
        -> this:stream
        -> chunk:string
        -> encoding:Buffer_encoding.t
        -> callback:(?error:Error.t or_null -> unit -> unit)
        -> unit
        [@@js.call "write"]

      val writev :
           t
        -> this:stream
        -> chunks:Anonymous_interface0.t list
        -> callback:(?error:Error.t or_null -> unit -> unit)
        -> unit
        [@@js.call "writev"]

      val final :
           t
        -> this:stream
        -> callback:(?error:Error.t or_null -> unit -> unit)
        -> unit
        [@@js.call "final"]

      val destroy :
           t
        -> this:stream
        -> error:Error.t or_null
        -> callback:(error:Error.t or_null -> unit)
        -> unit
        [@@js.call "destroy"]

      val transform :
           t
        -> this:stream
        -> chunk:string
        -> encoding:Buffer_encoding.t
        -> callback:Transform_callback.t
        -> unit
        [@@js.call "transform"]

      val flush : t -> this:stream -> callback:Transform_callback.t -> unit
        [@@js.call "flush"]
    end
    [@@js.scope "TransformOptions"]

    module Transform : sig
      include module type of struct
        include Duplex
      end

      val create : ?opts:Transform_options.t -> unit -> t [@@js.create]

      val _transform :
           t
        -> chunk:string
        -> encoding:Buffer_encoding.t
        -> callback:Transform_callback.t
        -> unit
        [@@js.call "_transform"]

      val _flush : t -> callback:Transform_callback.t -> unit
        [@@js.call "_flush"]
    end
    [@@js.scope "Transform"]

    module Pass_through : sig
      include module type of struct
        include Transform
      end
    end

    module Finished_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val get_error : t -> bool [@@js.get "error"]

      val set_error : t -> bool -> unit [@@js.set "error"]

      val get_readable : t -> bool [@@js.get "readable"]

      val set_readable : t -> bool -> unit [@@js.set "readable"]

      val get_writable : t -> bool [@@js.get "writable"]

      val set_writable : t -> bool -> unit [@@js.set "writable"]
    end
    [@@js.scope "FinishedOptions"]

    val finished :
         stream:
           (Read_write_stream.t, Readable_stream.t, Writable_stream.t) union3
      -> options:Finished_options.t
      -> callback:(?err:Errno_exception.t or_null -> unit -> unit)
      -> (unit -> unit[@js.dummy])
      [@@js.global "finished"]

    val finished :
         stream:
           (Read_write_stream.t, Readable_stream.t, Writable_stream.t) union3
      -> callback:(?err:Errno_exception.t or_null -> unit -> unit)
      -> (unit -> unit[@js.dummy])
      [@@js.global "finished"]

    module Finished : sig
      val __promisify__ :
           stream:
             (Read_write_stream.t, Readable_stream.t, Writable_stream.t) union3
        -> ?options:Finished_options.t
        -> unit
        -> unit Promise.t
        [@@js.global "__promisify__"]
    end
    [@@js.scope "finished"]

    val pipeline :
         stream1:Readable_stream.t
      -> stream2:'T
      -> ?callback:(err:Errno_exception.t or_null -> unit)
      -> unit
      -> 'T
      [@@js.global "pipeline"]

    val pipeline :
         stream1:Readable_stream.t
      -> stream2:Read_write_stream.t
      -> stream3:'T
      -> ?callback:(err:Errno_exception.t or_null -> unit)
      -> unit
      -> 'T
      [@@js.global "pipeline"]

    val pipeline :
         stream1:Readable_stream.t
      -> stream2:Read_write_stream.t
      -> stream3:Read_write_stream.t
      -> stream4:'T
      -> ?callback:(err:Errno_exception.t or_null -> unit)
      -> unit
      -> 'T
      [@@js.global "pipeline"]

    val pipeline :
         stream1:Readable_stream.t
      -> stream2:Read_write_stream.t
      -> stream3:Read_write_stream.t
      -> stream4:Read_write_stream.t
      -> stream5:'T
      -> ?callback:(err:Errno_exception.t or_null -> unit)
      -> unit
      -> 'T
      [@@js.global "pipeline"]

    val pipeline :
         streams:
           (Read_write_stream.t, Readable_stream.t, Writable_stream.t) union3
           list
      -> ?callback:(err:Errno_exception.t or_null -> unit)
      -> unit
      -> Writable_stream.t
      [@@js.global "pipeline"]

    val pipeline :
         stream1:Readable_stream.t
      -> stream2:(Read_write_stream.t, Writable_stream.t) union2
      -> streams:
           (* FIXME: type 'Array<union<?ReadWriteStream | ?WritableStream |
              (~err:union<?ErrnoException | Null> -> Void)>>' cannot be used for
              variadic argument *)
           (any list[@js.variadic])
      -> Writable_stream.t
      [@@js.global "pipeline"]

    module Pipeline : sig
      val __promisify__ :
        stream1:Readable_stream.t -> stream2:Writable_stream.t -> unit Promise.t
        [@@js.global "__promisify__"]

      val __promisify__ :
           stream1:Readable_stream.t
        -> stream2:Read_write_stream.t
        -> stream3:Writable_stream.t
        -> unit Promise.t
        [@@js.global "__promisify__"]

      val __promisify__ :
           stream1:Readable_stream.t
        -> stream2:Read_write_stream.t
        -> stream3:Read_write_stream.t
        -> stream4:Writable_stream.t
        -> unit Promise.t
        [@@js.global "__promisify__"]

      val __promisify__ :
           stream1:Readable_stream.t
        -> stream2:Read_write_stream.t
        -> stream3:Read_write_stream.t
        -> stream4:Read_write_stream.t
        -> stream5:Writable_stream.t
        -> unit Promise.t
        [@@js.global "__promisify__"]

      val __promisify__ :
           streams:
             (Read_write_stream.t, Readable_stream.t, Writable_stream.t) union3
             list
        -> unit Promise.t
        [@@js.global "__promisify__"]

      val __promisify__ :
           stream1:Readable_stream.t
        -> stream2:(Read_write_stream.t, Writable_stream.t) union2
        -> streams:
             (* FIXME: type 'Array<union<?ReadWriteStream | ?WritableStream>>'
                cannot be used for variadic argument *)
             (any list[@js.variadic])
        -> unit Promise.t
        [@@js.global "__promisify__"]
    end
    [@@js.scope "pipeline"]

    module Pipe : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val close : t -> unit [@@js.call "close"]

      val has_ref : t -> bool [@@js.call "hasRef"]

      val ref : t -> unit [@@js.call "ref"]

      val unref : t -> unit [@@js.call "unref"]
    end
    [@@js.scope "Pipe"]
  end
  [@@js.scope "internal"]
  (* export = internal *)

  include module type of struct
    include Internal
  end
end
[@@js.scope Import.stream]
