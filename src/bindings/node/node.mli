open Interop

val __filename : unit -> string

val __dirname : unit -> string

module Timeout : sig
  include Js.T

  val hasRef : t -> bool

  val ref : t -> t

  val refresh : t -> t

  val unref : t -> t
end

val setInterval : (unit -> unit) -> int -> Timeout.t

val setTimeout : (unit -> unit) -> int -> Timeout.t

module Process : sig
  val cwd : unit -> string

  val platform : string

  val arch : string

  module Env : sig
    val get : string -> string option

    val set : string -> string -> unit

    val env : string Interop.Dict.t
  end
end

module JsError : sig
  include Js.T with type t = Promise.error

  val message : t -> string
end

module Buffer : sig
  include Js.T

  val toString : t -> string

  val from : string -> t

  val concat : t list -> t

  val append : t ref -> t -> unit

  val write :
       t
    -> string:string
    -> ?offset:int
    -> ?length:int
    -> ?encoding:string
    -> unit
    -> unit
end

module Stream : sig
  module Readable : sig
    include Js.T

    type chunk =
      [ `String of string
      | `Buffer of Buffer.t
      ]

    val on :
         t
      -> [ `Close of unit -> unit
         | `Data of chunk:chunk -> unit
         | `End of unit -> 'c
         | `Error of err:JsError.t -> unit
         | `Pause of unit -> unit
         | `Readable of unit -> unit
         | `Resume of unit -> unit
         ]
      -> unit
  end

  module Writable : sig
    include Js.T

    val on :
         t
      -> [ `Close of unit -> unit
         | `Drain of unit -> unit
         | `Error of err:JsError.t -> unit
         | `Finish of unit -> unit
         | `Pipe of src:t -> unit
         | `Unpipe of src:t -> unit
         ]
      -> unit

    val write : t -> string -> unit

    val end_ : t -> unit
  end
end

module Path : sig
  val delimiter : char

  val basename : string -> string

  val dirname : string -> string

  val extname : string -> string

  val isAbsolute : string -> bool

  val join : string list -> string
end

module Os : sig
  val homedir : unit -> string
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

  type event =
    | Spawned
    | Stdout of string
    | Stderr of string
    | Closed

  val exec :
       ?logger:(event -> unit)
    -> ?stdin:string
    -> ?options:Options.t
    -> string
    -> return Promise.t

  val spawn :
       ?logger:(event -> unit)
    -> ?stdin:string
    -> ?options:Options.t
    -> string
    -> string array
    -> return Promise.t
end
