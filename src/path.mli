(** Representation of path *)

type t

val ofString : string -> t

val isAbsolute : t -> bool

val v : string -> t

val compare : t -> t -> int

val toString : t -> string

val extname : t -> string

val ( / ) : t -> string -> t

val relative : t -> string -> t

val relative_all : t -> string list -> t

val join : t -> t -> t

val withExt : t -> ext:string -> t

val parent : t -> t option

val isRoot : t -> bool
