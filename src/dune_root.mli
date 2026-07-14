(** Find the Dune workspace root using the same rules as Dune

    The input should be a source file (ml, mli, etc.) for which we want
    the workspace root. *)
val find : Path.t -> (Path.t, string) result Promise.t
