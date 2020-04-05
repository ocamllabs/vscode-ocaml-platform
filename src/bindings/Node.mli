module Process : sig
  type t

  val platform : string

  val env : string Js.Dict.t
end

module JsError : sig
  type t

  val ofPromiseError : _ -> t
end

module ChildProcess : sig
  module Options : sig
    type t

    val make : ?cwd:string -> ?env:string Js.Dict.t -> unit -> t
  end

  type t

  val exec :
    string -> Options.t -> (int * string * string, string) result Promise.t
end

module Path : sig
  val extname : string -> string

  val join : string array -> string
end

module Stream : sig
  type t
end

module Fs : sig
  module Stat : sig
    type t

    val isDirectory : t -> bool
  end

  val exists : string -> bool Promise.t

  val stat : string -> (Stat.t, string) result Promise.t

  val readFile : string -> string Promise.t

  val writeFile : string -> string -> unit Promise.t

  val readDir : string -> (string array, string) result Promise.t

  val createWriteStream : string -> Stream.t

  module E : sig
    type t = PathNotFound
  end

  val mkdir : ?p:bool -> string -> (unit, E.t) result Promise.t
end

module Buffer : sig
  type t
end

module Request : sig
  val request : string -> Stream.t
end

module RequestProgress : sig
  type t

  val requestProgress : Stream.t -> t

  type state =
    < percent : float
    ; speed : int
    ; size : < total : int ; transferred : int > Js.t
    ; time : < elapsed : float ; remaining : float > Js.t >
    Js.t

  val pipe : t -> Stream.t -> unit

  val onError : t -> (JsError.t -> unit) -> unit

  val onData : t -> (Buffer.t -> unit) -> unit

  val onEnd : t -> (unit -> unit) -> unit

  val onProgress : t -> (state -> unit) -> unit
end

module Response : sig end

module Https : sig
  module E : sig
    type t = Failure of string
  end

  val getCompleteResponse : string -> (string, E.t) result Promise.t
end

module Os : sig
  val tmpdir : unit -> string
end

val thisProjectsEsyJson : string
