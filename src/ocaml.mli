open Import

(** Returns the version returned by [ocamlc --version]. On every call, runs this
    command, so try to cache the result if you need the version several times. *)
val version : Sandbox.t -> (string, string) result Promise.t
