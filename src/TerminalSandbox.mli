type t

val dispose : t -> unit

val create : Toolchain.resources -> t

val openTerminal : t -> unit option
