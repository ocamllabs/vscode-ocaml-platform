type t

val create : Toolchain.t -> t option

val dispose : t -> unit

val show : t -> unit
