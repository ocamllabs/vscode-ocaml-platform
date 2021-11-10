open Import

type t

val make :
     Sandbox.t
  -> (t, [ `Ocamlc_missing | `Ocamlc_version_unexpected ]) result Promise.t

val version_semver : t -> Ocaml_version.t
