[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Console : sig
  module Console : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val assert_ :
         t
      -> value:any
      -> ?message:string
      -> params:(any list[@js.variadic])
      -> unit
      -> unit
      [@@js.call "assert"]

    val clear : t -> unit [@@js.call "clear"]

    val count : t -> ?label:string -> unit -> unit [@@js.call "count"]

    val count_reset : t -> ?label:string -> unit -> unit
      [@@js.call "countReset"]

    val debug :
      t -> ?message:any -> params:(any list[@js.variadic]) -> unit -> unit
      [@@js.call "debug"]

    val dir :
      t -> obj:any -> ?options:Node_util.Util.Inspect_options.t -> unit -> unit
      [@@js.call "dir"]

    val dirxml : t -> data:(any list[@js.variadic]) -> unit [@@js.call "dirxml"]

    val error :
      t -> ?message:any -> params:(any list[@js.variadic]) -> unit -> unit
      [@@js.call "error"]

    val group : t -> label:(any list[@js.variadic]) -> unit [@@js.call "group"]

    val group_collapsed : t -> label:(any list[@js.variadic]) -> unit
      [@@js.call "groupCollapsed"]

    val group_end : t -> unit [@@js.call "groupEnd"]

    val info :
      t -> ?message:any -> params:(any list[@js.variadic]) -> unit -> unit
      [@@js.call "info"]

    val log :
      t -> ?message:any -> params:(any list[@js.variadic]) -> unit -> unit
      [@@js.call "log"]

    val table : t -> tabular_data:any -> ?properties:string list -> unit -> unit
      [@@js.call "table"]

    val time : t -> ?label:string -> unit -> unit [@@js.call "time"]

    val time_end : t -> ?label:string -> unit -> unit [@@js.call "timeEnd"]

    val time_log :
      t -> ?label:string -> data:(any list[@js.variadic]) -> unit -> unit
      [@@js.call "timeLog"]

    val trace :
      t -> ?message:any -> params:(any list[@js.variadic]) -> unit -> unit
      [@@js.call "trace"]

    val warn :
      t -> ?message:any -> params:(any list[@js.variadic]) -> unit -> unit
      [@@js.call "warn"]

    val profile : t -> ?label:string -> unit -> unit [@@js.call "profile"]

    val profile_end : t -> ?label:string -> unit -> unit
      [@@js.call "profileEnd"]

    val time_stamp : t -> ?label:string -> unit -> unit [@@js.call "timeStamp"]

    module Console_constructor_options : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val get_stdout : t -> Writable_stream.t [@@js.get "stdout"]

      val set_stdout : t -> Writable_stream.t -> unit [@@js.set "stdout"]

      val get_stderr : t -> Writable_stream.t [@@js.get "stderr"]

      val set_stderr : t -> Writable_stream.t -> unit [@@js.set "stderr"]

      val get_ignore_errors : t -> bool [@@js.get "ignoreErrors"]

      val set_ignore_errors : t -> bool -> unit [@@js.set "ignoreErrors"]

      val get_color_mode : t -> ([ `auto [@js "auto"] ][@js.enum]) or_boolean
        [@@js.get "colorMode"]

      val set_color_mode : t -> ([ `auto ][@js.enum]) or_boolean -> unit
        [@@js.set "colorMode"]

      val get_inspect_options : t -> Node_util.Util.Inspect_options.t
        [@@js.get "inspectOptions"]

      val set_inspect_options : t -> Node_util.Util.Inspect_options.t -> unit
        [@@js.set "inspectOptions"]
    end
    [@@js.scope "ConsoleConstructorOptions"]

    module Console_constructor : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val get_prototype : t -> t [@@js.get "prototype"]

      val set_prototype : t -> t -> unit [@@js.set "prototype"]

      val create :
           t
        -> stdout:Writable_stream.t
        -> ?stderr:Writable_stream.t
        -> ?ignore_errors:bool
        -> unit
        -> t
        [@@js.apply_newable]

      val create' : t -> options:Console_constructor_options.t -> t
        [@@js.apply_newable]
    end
    [@@js.scope "ConsoleConstructor"]

    val get_console : t -> Console_constructor.t [@@js.get "Console"]

    val set_console : t -> Console_constructor.t -> unit [@@js.set "Console"]
  end
  [@@js.scope "Console"]

  val assert_ :
    bool -> ?message:string -> params:(any list[@js.variadic]) -> unit -> unit
    [@@js.global "assert"]

  val clear : unit [@@js.global "clear"]

  val count : ?label:string -> unit -> unit [@@js.global "count"]

  val count_reset : ?label:string -> unit -> unit [@@js.global "countReset"]

  val debug : string -> params:(any list[@js.variadic]) -> unit -> unit
    [@@js.global "debug"]

  val dir : any -> ?options:Node_util.Util.Inspect_options.t -> unit -> unit
    [@@js.global "dir"]

  val dirxml : (any list[@js.variadic]) -> unit [@@js.global "dirxml"]

  val error : string -> params:(any list[@js.variadic]) -> unit -> unit
    [@@js.global "error"]

  val group : (any list[@js.variadic]) -> unit [@@js.global "group"]

  val group_collapsed : (any list[@js.variadic]) -> unit
    [@@js.global "groupCollapsed"]

  val group_end : unit [@@js.global "groupEnd"]

  val info : string -> params:(any list[@js.variadic]) -> unit
    [@@js.global "info"]

  val log : string -> params:(any list[@js.variadic]) -> unit -> unit
    [@@js.global "log"]

  val table : tabular_data:any -> ?properties:string list -> unit -> unit
    [@@js.global "table"]

  val time : ?label:string -> unit -> unit [@@js.global "time"]

  val time_end : ?label:string -> unit -> unit [@@js.global "timeEnd"]

  val time_log : ?label:string -> data:(any list[@js.variadic]) -> unit -> unit
    [@@js.global "timeLog"]

  val trace : string -> params:(any list[@js.variadic]) -> unit -> unit
    [@@js.global "trace"]

  val warn : string -> params:(any list[@js.variadic]) -> unit -> unit
    [@@js.global "warn"]

  val profile : ?label:string -> unit -> unit [@@js.global "profile"]

  val profile_end : ?label:string -> unit -> unit [@@js.global "profileEnd"]

  val time_stamp : ?label:string -> unit -> unit [@@js.global "timeStamp"]
end
[@@js.scope Import.console]
