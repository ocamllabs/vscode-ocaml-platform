type t

val create : Toolchain.resources -> t option

val dispose : t -> unit

val show : t -> unit
