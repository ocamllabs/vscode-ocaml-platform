module Process : sig
  val cwd : unit -> string

  val platform : string

  module Env : sig
    val get : string -> string option

    val set : string -> string -> unit
  end
end

module JsError : sig
  val message : Promise.error -> string
end

module Buffer : sig
  type t

  val toString : t -> string

  val from : string -> t

  val concat : t array -> t

  (** {4 Converters} *)

  (** Get a [Buffer.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [Buffer.t]. *)
  val t_to_js : t -> Ojs.t
end

module Stream : sig
  type t

  val on : t -> string -> (Buffer.t -> unit) -> unit

  val write : t -> string -> unit

  val end_ : t -> unit

  (** {4 Converters} *)

  (** Get a [Stream.t] from a JavaScript object. *)
  val t_of_js : Ojs.t -> t

  (** Get a JavaScript object from a [Stream.t]. *)
  val t_to_js : t -> Ojs.t
end

module Path : sig
  val delimiter : char

  val basename : string -> string

  val dirname : string -> string

  val extname : string -> string

  val isAbsolute : string -> bool

  val join : string list -> string
end

module Fs : sig
  val readDir : string -> (string list, string) result Promise.t

  val readFile : string -> string Promise.t

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
