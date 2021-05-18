[@@@ocaml.warning "-7-11-32-33-39"]
[@@@js.implem 
  [@@@ocaml.warning "-7-11-32-33-39"]
]
open Ts2ocaml_baselib
(* 
  unknown identifiers:
  - net.Socket
  - net.SocketConstructorOpts
 *)
[@@@js.stop]
module type Missing = sig
  module net : sig
    module Socket : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module SocketConstructorOpts : sig
      type t_0
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
  end
end
[@@@js.start]
[@@@js.implem 
  module type Missing = sig
    module net : sig
      module Socket : sig
        type t_0
        val t_0_to_js: t_0 -> Ojs.t
        val t_0_of_js: Ojs.t -> t_0
      end
      module SocketConstructorOpts : sig
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
    end
    module Types : sig
      open AnonymousInterfaces
      type tty_Direction = ([`L_n_minus1[@js -1] | `L_n_0[@js 0] | `L_n_1[@js 1]] [@js.enum])
      and tty_ReadStream = [`Tty_ReadStream] intf
      [@@js.custom { of_js=Obj.magic; to_js=Obj.magic }]
      and tty_WriteStream = [`Tty_WriteStream] intf
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
  end
  module[@js.scope "node:tty"] Node_tty : sig
    (* export * from 'tty'; *)
  end
  module[@js.scope "tty"] Tty : sig
    (* import * as net from 'node:net'; *)
    val isatty: fd:float -> bool [@@js.global "isatty"]
    module[@js.scope "ReadStream"] ReadStream : sig
      type t = tty_ReadStream
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: fd:float -> ?options:Net.SocketConstructorOpts.t_0 -> unit -> t [@@js.create]
      val get_isRaw: t -> bool [@@js.get "isRaw"]
      val set_isRaw: t -> bool -> unit [@@js.set "isRaw"]
      val setRawMode: t -> mode:bool -> t [@@js.call "setRawMode"]
      val get_isTTY: t -> bool [@@js.get "isTTY"]
      val set_isTTY: t -> bool -> unit [@@js.set "isTTY"]
      val cast: t -> Net.Socket.t_0 [@@js.cast]
    end
    module Direction : sig
      type t = tty_Direction
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
    end
    module[@js.scope "WriteStream"] WriteStream : sig
      type t = tty_WriteStream
      val t_to_js: t -> Ojs.t
      val t_of_js: Ojs.t -> t
      type t_0 = t
      val t_0_to_js: t_0 -> Ojs.t
      val t_0_of_js: Ojs.t -> t_0
      val create: fd:float -> t [@@js.create]
      val addListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "addListener"]
      val addListener': t -> event:([`L_s0_resize] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "addListener"]
      val emit: t -> event:symbol or_string -> args:(any list [@js.variadic]) -> bool [@@js.call "emit"]
      val emit': t -> event:([`L_s0_resize] [@js.enum]) -> bool [@@js.call "emit"]
      val on: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "on"]
      val on': t -> event:([`L_s0_resize] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "on"]
      val once: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "once"]
      val once': t -> event:([`L_s0_resize] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "once"]
      val prependListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependListener"]
      val prependListener': t -> event:([`L_s0_resize] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependListener"]
      val prependOnceListener: t -> event:string -> listener:(args:(any list [@js.variadic]) -> unit) -> t [@@js.call "prependOnceListener"]
      val prependOnceListener': t -> event:([`L_s0_resize] [@js.enum]) -> listener:(unit -> unit) -> t [@@js.call "prependOnceListener"]
      val clearLine: t -> dir:tty_Direction -> ?callback:(unit -> unit) -> unit -> bool [@@js.call "clearLine"]
      val clearScreenDown: t -> ?callback:(unit -> unit) -> unit -> bool [@@js.call "clearScreenDown"]
      val cursorTo: t -> x:float -> ?y:float -> ?callback:(unit -> unit) -> unit -> bool [@@js.call "cursorTo"]
      val cursorTo': t -> x:float -> callback:(unit -> unit) -> bool [@@js.call "cursorTo"]
      val moveCursor: t -> dx:float -> dy:float -> ?callback:(unit -> unit) -> unit -> bool [@@js.call "moveCursor"]
      val getColorDepth: t -> ?env:anonymous_interface_0 -> unit -> float [@@js.call "getColorDepth"]
      val hasColors: t -> ?depth:float -> unit -> bool [@@js.call "hasColors"]
      val hasColors': t -> ?env:anonymous_interface_0 -> unit -> bool [@@js.call "hasColors"]
      val hasColors'': t -> depth:float -> ?env:anonymous_interface_0 -> unit -> bool [@@js.call "hasColors"]
      val getWindowSize: t -> (float * float) [@@js.call "getWindowSize"]
      val get_columns: t -> float [@@js.get "columns"]
      val set_columns: t -> float -> unit [@@js.set "columns"]
      val get_rows: t -> float [@@js.get "rows"]
      val set_rows: t -> float -> unit [@@js.set "rows"]
      val get_isTTY: t -> bool [@@js.get "isTTY"]
      val set_isTTY: t -> bool -> unit [@@js.set "isTTY"]
      val cast: t -> Net.Socket.t_0 [@@js.cast]
    end
  end
end
