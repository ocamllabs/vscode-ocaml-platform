[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Readline : sig
  module Key : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_sequence : t -> string [@@js.get "sequence"]

    val set_sequence : t -> string -> unit [@@js.set "sequence"]

    val get_name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]

    val get_ctrl : t -> bool [@@js.get "ctrl"]

    val set_ctrl : t -> bool -> unit [@@js.set "ctrl"]

    val get_meta : t -> bool [@@js.get "meta"]

    val set_meta : t -> bool -> unit [@@js.set "meta"]

    val get_shift : t -> bool [@@js.get "shift"]

    val set_shift : t -> bool -> unit [@@js.set "shift"]
  end
  [@@js.scope "Key"]

  module Completer_result : sig
    type t = string list * string

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Async_completer : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val apply :
         t
      -> line:string
      -> callback:
           (?err:Error.t or_null -> ?result:Completer_result.t -> unit -> unit)
      -> any
      [@@js.apply]
  end
  [@@js.scope "AsyncCompleter"]

  module Completer : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val apply : t -> line:string -> Completer_result.t [@@js.apply]
  end
  [@@js.scope "Completer"]

  module Read_line_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_input : t -> Readable_stream.t [@@js.get "input"]

    val set_input : t -> Readable_stream.t -> unit [@@js.set "input"]

    val get_output : t -> Writable_stream.t [@@js.get "output"]

    val set_output : t -> Writable_stream.t -> unit [@@js.set "output"]

    val get_completer : t -> (Async_completer.t, Completer.t) union2
      [@@js.get "completer"]

    val set_completer : t -> (Async_completer.t, Completer.t) union2 -> unit
      [@@js.set "completer"]

    val get_terminal : t -> bool [@@js.get "terminal"]

    val set_terminal : t -> bool -> unit [@@js.set "terminal"]

    val get_history_size : t -> int [@@js.get "historySize"]

    val set_history_size : t -> int -> unit [@@js.set "historySize"]

    val get_prompt : t -> string [@@js.get "prompt"]

    val set_prompt : t -> string -> unit [@@js.set "prompt"]

    val get_crlf_delay : t -> int [@@js.get "crlfDelay"]

    val set_crlf_delay : t -> int -> unit [@@js.set "crlfDelay"]

    val get_remove_history_duplicates : t -> bool
      [@@js.get "removeHistoryDuplicates"]

    val set_remove_history_duplicates : t -> bool -> unit
      [@@js.set "removeHistoryDuplicates"]

    val get_escape_code_timeout : t -> int [@@js.get "escapeCodeTimeout"]

    val set_escape_code_timeout : t -> int -> unit
      [@@js.set "escapeCodeTimeout"]

    val get_tab_size : t -> int [@@js.get "tabSize"]

    val set_tab_size : t -> int -> unit [@@js.set "tabSize"]
  end
  [@@js.scope "ReadLineOptions"]

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

  module Cursor_pos : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_rows : t -> int [@@js.get "rows"]

    val set_rows : t -> int -> unit [@@js.set "rows"]

    val get_cols : t -> int [@@js.get "cols"]

    val set_cols : t -> int -> unit [@@js.set "cols"]
  end
  [@@js.scope "CursorPos"]

  module Interface : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_terminal : t -> bool [@@js.get "terminal"]

    val get_line : t -> string [@@js.get "line"]

    val get_cursor : t -> int [@@js.get "cursor"]

    val create :
         input:Readable_stream.t
      -> ?output:Writable_stream.t
      -> ?completer:(Async_completer.t, Completer.t) union2
      -> ?terminal:bool
      -> unit
      -> t
      [@@js.create]

    val create' : options:Read_line_options.t -> t [@@js.create]

    val set_prompt : t -> prompt:string -> unit [@@js.call "setPrompt"]

    val prompt : t -> ?preserve_cursor:bool -> unit -> unit [@@js.call "prompt"]

    val question : t -> query:string -> callback:(answer:string -> unit) -> unit
      [@@js.call "question"]

    val pause : t -> t [@@js.call "pause"]

    val resume : t -> t [@@js.call "resume"]

    val close : t -> unit [@@js.call "close"]

    val write : t -> data:Buffer.t or_string -> ?key:Key.t -> unit -> unit
      [@@js.call "write"]

    val get_cursor_pos : t -> Cursor_pos.t [@@js.call "getCursorPos"]

    val add_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "addListener"]

    val add_listener' :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'' :
      t -> event:([ `line ][@js.enum]) -> listener:(input:string -> unit) -> t
      [@@js.call "addListener"]

    val add_listener''' :
      t -> event:([ `pause ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''' :
      t -> event:([ `resume ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener''''' :
      t -> event:([ `SIGCONT ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener'''''' :
      t -> event:([ `SIGINT ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val add_listener''''''' :
      t -> event:([ `SIGTSTP ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "addListener"]

    val emit :
      t -> event:symbol or_string -> args:(any list[@js.variadic]) -> bool
      [@@js.call "emit"]

    val emit' : t -> event:([ `close ][@js.enum]) -> bool [@@js.call "emit"]

    val emit'' : t -> event:([ `line ][@js.enum]) -> input:string -> bool
      [@@js.call "emit"]

    val emit''' : t -> event:([ `pause ][@js.enum]) -> bool [@@js.call "emit"]

    val emit'''' : t -> event:([ `resume ][@js.enum]) -> bool [@@js.call "emit"]

    val emit''''' : t -> event:([ `SIGCONT ][@js.enum]) -> bool
      [@@js.call "emit"]

    val emit'''''' : t -> event:([ `SIGINT ][@js.enum]) -> bool
      [@@js.call "emit"]

    val emit''''''' : t -> event:([ `SIGTSTP ][@js.enum]) -> bool
      [@@js.call "emit"]

    val on :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "on"]

    val on' : t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on'' :
      t -> event:([ `line ][@js.enum]) -> listener:(input:string -> unit) -> t
      [@@js.call "on"]

    val on''' :
      t -> event:([ `pause ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on'''' :
      t -> event:([ `resume ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on''''' :
      t -> event:([ `SIGCONT ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on'''''' :
      t -> event:([ `SIGINT ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val on''''''' :
      t -> event:([ `SIGTSTP ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "on"]

    val once :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "once"]

    val once' :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once'' :
      t -> event:([ `line ][@js.enum]) -> listener:(input:string -> unit) -> t
      [@@js.call "once"]

    val once''' :
      t -> event:([ `pause ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once'''' :
      t -> event:([ `resume ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once''''' :
      t -> event:([ `SIGCONT ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once'''''' :
      t -> event:([ `SIGINT ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val once''''''' :
      t -> event:([ `SIGTSTP ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "once"]

    val prepend_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener' :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'' :
      t -> event:([ `line ][@js.enum]) -> listener:(input:string -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener''' :
      t -> event:([ `pause ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'''' :
      t -> event:([ `resume ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener''''' :
      t -> event:([ `SIGCONT ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener'''''' :
      t -> event:([ `SIGINT ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_listener''''''' :
      t -> event:([ `SIGTSTP ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependListener"]

    val prepend_once_listener :
      t -> event:string -> listener:(args:(any list[@js.variadic]) -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener' :
      t -> event:([ `close ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'' :
      t -> event:([ `line ][@js.enum]) -> listener:(input:string -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''' :
      t -> event:([ `pause ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''' :
      t -> event:([ `resume ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''''' :
      t -> event:([ `SIGCONT ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener'''''' :
      t -> event:([ `SIGINT ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]

    val prepend_once_listener''''''' :
      t -> event:([ `SIGTSTP ][@js.enum]) -> listener:(unit -> unit) -> t
      [@@js.call "prependOnceListener"]
  end
  [@@js.scope "Interface"]

  module Read_line : sig
    type t = Interface.t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  val create_interface :
       input:Readable_stream.t
    -> ?output:Writable_stream.t
    -> ?completer:(Async_completer.t, Completer.t) union2
    -> ?terminal:bool
    -> unit
    -> Interface.t
    [@@js.global "createInterface"]

  val create_interface : options:Read_line_options.t -> Interface.t
    [@@js.global "createInterface"]

  val emit_keypress_events :
    stream:Readable_stream.t -> ?readline_interface:Interface.t -> unit -> unit
    [@@js.global "emitKeypressEvents"]

  val clear_line :
       stream:Writable_stream.t
    -> dir:Direction.t
    -> ?callback:(unit -> unit)
    -> unit
    -> bool
    [@@js.global "clearLine"]

  val clear_screen_down :
    stream:Writable_stream.t -> ?callback:(unit -> unit) -> unit -> bool
    [@@js.global "clearScreenDown"]

  val cursor_to :
       stream:Writable_stream.t
    -> x:int
    -> ?y:int
    -> ?callback:(unit -> unit)
    -> unit
    -> bool
    [@@js.global "cursorTo"]

  val move_cursor :
       stream:Writable_stream.t
    -> dx:int
    -> dy:int
    -> ?callback:(unit -> unit)
    -> unit
    -> bool
    [@@js.global "moveCursor"]
end
[@@js.scope Import.readline]
