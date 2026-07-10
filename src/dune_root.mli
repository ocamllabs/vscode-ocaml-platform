(** Find the nearest [dune-project] ancestor directory of [file].

    Walks up the directory tree from [file], resolving symlinks first via
    [Path.realpath], and returns the first directory that contains a
    [dune-project] file.

    Note: this is not the same as the true Dune workspace root, which may
    be a higher-level directory containing a [dune-workspace] file or
    another [dune-project]. The full algorithm is implemented in
    {{:https://github.com/ocaml/dune/blob/main/bin/workspace_root.ml}
    dune/bin/workspace_root.ml} and is not trivially replicable here.
    For the purposes of ocamlgrep (scanning a single project), the nearest
    [dune-project] is a good enough approximation.

    Returns [Some root] if found, or [None] if no [dune-project] exists on
    the path to the filesystem root. *)
val find_nearest_dune_project : Path.t -> Path.t option Promise.t
