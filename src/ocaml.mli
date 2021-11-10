open Import

type t

val make :
     Sandbox.t
  -> (t, [ `Ocamlc_missing | `Unable_to_parse_version of string ]) result
     Promise.t

val version : t -> Ocaml_version.t
