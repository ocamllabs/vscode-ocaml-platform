[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Anonymous_interface0 : sig
  type t

  val t_to_js : t -> Ojs.t

  val t_of_js : Ojs.t -> t
end

module Tty : sig
  open Node_net

  val isatty : fd:int -> bool [@@js.global "isatty"]

  module Read_stream : sig
    include module type of struct
      include Net.Socket
    end

    val create : fd:int -> ?options:Net.Socket_constructor_opts.t -> unit -> t
      [@@js.create]

    val get_is_raw : t -> bool [@@js.get "isRaw"]

    val set_is_raw : t -> bool -> unit [@@js.set "isRaw"]

    val set_raw_mode : t -> mode:bool -> t [@@js.call "setRawMode"]

    val get_is_tty : t -> bool [@@js.get "isTTY"]

    val set_is_tty : t -> bool -> unit [@@js.set "isTTY"]
  end
  [@@js.scope "ReadStream"]

  module Direction : sig
    type t =
      ([ `L_n_minus1 [@js -1]
       | `L_n_0 [@js 0]
       | `L_n_1 [@js 1]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Write_stream : sig
    include module type of struct
      include Net.Socket
    end

    val create : fd:int -> t [@@js.create]

    val add_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "addListener"]

    val add_listener' :
      t -> event:([ `resize ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val emit :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val emit' : t -> event:([ `resize ][@js.enum]) -> bool [@@js.call "emit"]

    val on :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "on"]

    val on' : t -> event:([ `resize ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val once :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "once"]

    val once' :
      t -> event:([ `resize ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val prepend_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener' :
      t -> event:([ `resize ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_once_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener' :
      t -> event:([ `resize ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val clear_line :
      t -> dir:Direction.t -> ?callback:(unit -> unit) -> unit -> bool
      [@@js.call "clearLine"]

    val clear_screen_down : t -> ?callback:(unit -> unit) -> unit -> bool
      [@@js.call "clearScreenDown"]

    val cursor_to :
      t -> x:int -> ?y:int -> ?callback:(unit -> unit) -> unit -> bool
      [@@js.call "cursorTo"]

    val cursor_to' : t -> x:int -> callback:(unit -> unit) -> bool
      [@@js.call "cursorTo"]

    val move_cursor :
      t -> dx:int -> dy:int -> ?callback:(unit -> unit) -> unit -> bool
      [@@js.call "moveCursor"]

    val get_color_depth : t -> ?env:Anonymous_interface0.t -> unit -> int
      [@@js.call "getColorDepth"]

    val has_colors : t -> ?depth:int -> unit -> bool [@@js.call "hasColors"]

    val has_colors' : t -> ?env:Anonymous_interface0.t -> unit -> bool
      [@@js.call "hasColors"]

    val has_colors'' :
      t -> depth:int -> ?env:Anonymous_interface0.t -> unit -> bool
      [@@js.call "hasColors"]

    val get_window_size : t -> int * int [@@js.call "getWindowSize"]

    val get_columns : t -> int [@@js.get "columns"]

    val set_columns : t -> int -> unit [@@js.set "columns"]

    val get_rows : t -> int [@@js.get "rows"]

    val set_rows : t -> int -> unit [@@js.set "rows"]

    val get_is_tty : t -> bool [@@js.get "isTTY"]

    val set_is_tty : t -> bool -> unit [@@js.set "isTTY"]
  end
  [@@js.scope "WriteStream"]
end
[@@js.scope Import.tty]
