open Interop

module Server : sig
  type t

  val close : t -> t

  val on :
       t
    -> [ `Close of unit -> unit | `Error of err:Node.JsError.t -> unit ]
    -> unit
end

type polka

module Middleware : sig
  module Request : sig
    include Js.T
  end

  module Response : sig
    include Js.T
  end

  type t =
    request:Request.t -> response:Response.t -> next:(unit -> polka) -> polka
end

val create : unit -> polka

val listen : int -> ?callback:(unit -> unit) -> polka -> unit -> polka

val get : string -> (unit -> unit) -> polka -> polka

val use : Middleware.t list -> polka -> polka

val server : polka -> Server.t

module Sirv : sig
  val serve : string -> Middleware.t
end
