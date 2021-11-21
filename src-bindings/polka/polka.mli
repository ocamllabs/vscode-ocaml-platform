open Interop

module Middleware : sig
  include Js.T
end

module Sirv : sig
  type t = Middleware.t

  val serve : string -> t
end

module Server : sig
  type t

  val close : t -> t
end

type t

val create : unit -> t

val listen : int -> ?callback:(unit -> unit) -> t -> unit -> t

val get : string -> (unit -> unit) -> t -> t

val use : (Middleware.t list[@js.variadic]) -> t -> t

val server : t -> Server.t
