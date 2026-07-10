(** ocamlgrep: project-wide search for OCaml expression patterns.

   The user enters a pattern (an OCaml expression with [__] wildcards and
   optional type constraints) via an InputBox.

   Results are shown in VS Code's built-in References panel.
*)
val callback : Extension_instance.t -> unit -> unit
