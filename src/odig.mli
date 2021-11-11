type t

type of_opam_error = Odig_not_installed

val of_opam : Opam.t * Opam.Switch.t -> (t, of_opam_error) result Promise.t

val odoc_exec : t -> string -> (string, string) result Promise.t

val cache_dir : t -> Path.t Promise.t

val html_dir : t -> Path.t Promise.t
