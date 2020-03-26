type lookup =
  | Esy of Fpath.t
  | Opam of Fpath.t

val lookup : Fpath.t -> (lookup list, string) Belt.Result.t Promise.t
