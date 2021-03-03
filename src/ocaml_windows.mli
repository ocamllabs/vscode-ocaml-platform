(* Whether to use ocaml-env for opam on Windows *)
val use_ocaml_env : unit -> bool

(* Spawn command from OCaml for Windows using ocaml-env *)
val spawn_ocaml_env : string list -> Cmd.spawn

(* Path to home directory from OCaml for Windows *)
val cygwin_home : unit -> (string, string) result Promise.t
