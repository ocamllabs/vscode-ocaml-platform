open Interop

module Server : sig
  module Address : sig
    include Ojs.T

    val port : t -> int
    val address : t -> string
  end

  include Ojs.T

  val close : t -> ?callback:(Node.JsError.t or_undefined -> unit) -> unit -> t
  val address : t -> Address.t or_undefined
  (* TODO: the return type can also be a string in case the server uses a pipe
     or Unix Domain Socket, but we don't handle that case *)

  val on : t -> [ `Close of unit -> unit | `Error of err:Node.JsError.t -> unit ] -> unit
end

type polka

module Middleware : sig
  module Request : sig
    include Ojs.T
  end

  module Response : sig
    include Ojs.T
  end

  type t = request:Request.t -> response:Response.t -> next:(unit -> polka) -> polka

  include Ojs.T with type t := t
end

val create : unit -> polka
val listen : int -> ?hostname:string -> ?callback:(unit -> unit) -> polka -> unit -> polka
val get : string -> (unit -> unit) -> polka -> polka
val use : Middleware.t list -> polka -> polka
val server : polka -> Server.t

module Sirv : sig
  module Options : sig
    include Ojs.T

    val create : dev:bool -> t
  end

  val serve : string -> ?options:Options.t -> unit -> Middleware.t
end
