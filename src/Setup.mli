(* A Nodejs event emitter based module that emits progress events as the
   toolchain is setup for a bucklescript project *)
module Bsb : sig
  type t (* event emitter *)

  val make : unit -> t (* creates and event emitter *)

  (* event handlers *)
  val onProgress : t -> (float -> unit) -> unit

  val onEnd : t -> (unit -> unit) -> unit

  val onError : t -> (string -> unit) -> unit

  (* event emitters *)
  val reportProgress : t -> float -> unit

  val reportEnd : t -> unit

  val reportError : t -> string -> unit

  (* runs the toolchain setup that keeps the consumer updated with progress
     events *)
  val run : Cmd.t -> string Js.Dict.t -> t -> string -> unit Js.Promise.t
end
