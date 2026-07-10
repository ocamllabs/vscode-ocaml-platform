(** Locate the dune project root for a given file.

    Walks up the directory tree from [file] looking for a [dune-project]
    file. [Path.realpath] is called first to resolve any symlinks before
    the walk begins.

    Returns [Some root] if a [dune-project] is found, or [None] if the
    walk reaches the filesystem root without finding one. *)
val find : Path.t -> Path.t option Promise.t
