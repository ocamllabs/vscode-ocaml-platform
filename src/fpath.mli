type t

val ofString : string -> t

val v : string -> t

val compare : t -> t -> int

val toString : t -> string

val show : t -> string

val ( / ) : t -> string -> t

val join : t -> t -> t
