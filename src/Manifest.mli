(** Responsible for looking up manifest files of supported package managers *)

type lookup =
  | Esy of Path.t
  | Opam of Path.t

(** Returns a list of the package managers found in the given directory *)
val lookup : Path.t -> (lookup list, string) result Promise.t
