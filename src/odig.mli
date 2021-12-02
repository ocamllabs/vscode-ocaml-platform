type t

val of_opam : Opam.t * Opam.Switch.t -> (t, string) result Promise.t

val odoc_exec : t -> package_name:string -> (string, string) result Promise.t

val cache_dir : t -> Path.t Promise.t

val html_dir : t -> Path.t Promise.t
