(** A Nodejs event emitter based module that emits progress events as the
   toolchain is setup for a bucklescript project *)
module Bsb : sig
  (** Represents a nodejs event emitter *)
  type t

  val make : unit -> t
  (** creates and event emitter *)

  val onProgress : t -> (float -> unit) -> unit
  (** Handles progress event *)

  val onEnd : t -> (unit -> unit) -> unit
  (** Handles end event *)

  val onError : t -> (string -> unit) -> unit
  (** Handles error  *)

  val reportProgress : t -> float -> unit
  (** Emits progress event *)

  val reportEnd : t -> unit
  (** Emits end event *)

  val reportError : t -> string -> unit
  (** Emits error *)

  val run : Cmd.t -> string Js.Dict.t -> t -> Path.t -> unit Promise.t
  (** runs the toolchain setup that keeps the consumer updated with progress
     events *)
end
