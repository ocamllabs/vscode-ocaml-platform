module Process : sig
  val cwd : unit -> string

  val platform : string

  module Env : sig
    val get : string -> string option

    val set : string -> string -> unit
  end
end

module JsError : sig
  type t = Promise.error

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val ofPromiseError : Promise.error -> string
end

module Buffer : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val to_string : t -> string

  val from : string -> t

  val concat : t array -> t
end

module Stream : sig
  type t

  val t_of_js : Ojs.t -> t

  val t_to_js : t -> Ojs.t

  val on : t -> string -> (Buffer.t -> unit) -> unit

  val write : t -> string -> unit

  val end_ : t -> unit
end

module Fs : sig
  val read_dir : string -> (string list, string) result Promise.t

  val read_file : string -> string Promise.t

  val exists : string -> bool Promise.t
end

module ChildProcess : sig
  module Options : sig
    type t

    val create : ?cwd:string -> ?env:string Interop.Dict.t -> unit -> t
  end

  type return =
    { exitCode : int
    ; stdout : string
    ; stderr : string
    }

  val exec : string -> ?stdin:string -> Options.t -> return Promise.t

  val spawn :
    string -> string array -> ?stdin:string -> Options.t -> return Promise.t
end
