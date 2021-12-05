open Interop

module Middleware = struct
  include Interface.Make ()
end

module Server = struct
  include Interface.Make ()

  include
    [%js:
    val close : t -> t [@@js.call]

    val on : t -> string -> Ojs.t -> unit [@@js.call]]

  let on t = function
    | `Close f -> on t "close" @@ [%js.of: unit -> unit] f
    | `Error f -> on t "error" @@ [%js.of: err:Node.JsError.t -> unit] f
end

module Sirv = struct
  include
    [%js:
    type t = Middleware.t

    val serve : string -> t [@@js.global "sirv"]]
end

include
  [%js:
  type t

  val create : unit -> t [@@js.global "polka"]

  val listen_ : t -> int -> ?callback:(unit -> unit) -> unit -> t
    [@@js.call "listen"]

  val get_ : t -> string -> (unit -> unit) -> t [@@js.call "get"]

  val use_ : t -> (Middleware.t list[@js.variadic]) -> t [@@js.call "use"]

  val server : t -> Server.t [@@js.get]]

let get path callback t = get_ t path callback

let listen port ?callback t = listen_ t port ?callback

let use middlewares t = use_ t middlewares
