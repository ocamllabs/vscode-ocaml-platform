open Interop

val __filename : unit -> string

val __dirname : unit -> string

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
  include Js.T

  val toString : t -> string

  val from : string -> t

  val concat : t array -> t
end

module Stream : sig
  include Js.T

  val on : t -> string -> (Buffer.t -> unit) -> unit

  val write : t -> string -> unit

  val end_ : t -> unit
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
