(** A Nodejs event emitter based module that emits progress events as the
   toolchain is setup for a bucklescript project *)
module Bsb : sig
  (** Represents a nodejs event emitter *)
  type t

  (** creates and event emitter *)
  val make : unit -> t

  (** Handles progress event *)
  val onProgress : t -> (float -> unit) -> unit

  (** Handles end event *)
  val onEnd : t -> (unit -> unit) -> unit

  (** Handles error  *)
  val onError : t -> (string -> unit) -> unit

  (** Emits progress event *)
  val reportProgress : t -> float -> unit

  (** Emits end event *)
  val reportEnd : t -> unit

  (** Emits error *)
  val reportError : t -> string -> unit

  (** runs the toolchain setup that keeps the consumer updated with progress
     events *)
  val run : Cmd.t -> string Js.Dict.t -> t -> string -> unit Promise.t
end
