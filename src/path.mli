(** Representation of path *)

type t

val equal : t -> t -> bool

(** [iequal p0 p1] is [true] if and only if [p1] and [p2] are equal but case
    insensitive to any ASCII-uppercase/-lowercase differences. *)
val iequal : t -> t -> bool

val of_string : string -> t

val to_string : t -> string

val delimiter : char

val sep : char

val is_absolute : t -> bool

val compare : t -> t -> int

val dirname : t -> string

val extname : t -> string

val basename : t -> string

val join : t -> t -> t

val ( / ) : t -> string -> t

val relative : t -> string -> t

val relative_all : t -> string list -> t

val with_ext : t -> ext:string -> t

val parent : t -> t option

val is_root : t -> bool

val asset : string -> t
