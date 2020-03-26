(** Responsible for looking up manifest files of supported package managers *)

type lookup =
  | Esy of Fpath.t
  | Opam of Fpath.t

(** Returns a list of the package managers found in the given directory *)
val lookup : Fpath.t -> (lookup list, string) result Promise.t
