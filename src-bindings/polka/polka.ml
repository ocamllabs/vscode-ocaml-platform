open Interop

module Server = struct
  include Interface.Make ()

  module Address = struct
    include Interface.Make ()

    include [%js: val port : t -> int [@@js.get]]
  end

  include
    [%js:
    val close : t -> t [@@js.call]

    val address : t -> Address.t [@@js.call]

    val on : t -> string -> Ojs.t -> unit [@@js.call]]

  let on t = function
    | `Close f -> on t "close" @@ [%js.of: unit -> unit] f
    | `Error f -> on t "error" @@ [%js.of: err:Node.JsError.t -> unit] f
end

type polka = Ojs.t

let polka_of_js = Ojs.t_of_js

let polka_to_js = Ojs.t_to_js

module Middleware = struct
  module Request = struct
    include Interface.Make ()
  end

  module Response = struct
    include Interface.Make ()
  end

  type t =
    request:Request.t -> response:Response.t -> next:(unit -> polka) -> polka
  [@@js]
end

include
  [%js:
  val create : unit -> polka [@@js.global "polka"]

  val listen_ : polka -> int -> ?callback:(unit -> unit) -> unit -> polka
    [@@js.call "listen"]

  val get_ : polka -> string -> (unit -> unit) -> polka [@@js.call "get"]

  val use_ : polka -> (Middleware.t list[@js.variadic]) -> polka
    [@@js.call "use"]

  val server : polka -> Server.t [@@js.get]]

let get path callback t = get_ t path callback

let listen port ?callback t = listen_ t port ?callback

let use middlewares t = use_ t middlewares

module Sirv = struct
  include
    [%js:
    val serve : string -> (Middleware.t[@js.dummy]) [@@js.global "sirv"]]
end
