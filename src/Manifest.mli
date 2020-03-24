val lookup :
     Fpath.t
  -> ([> `Esy of Fpath.t | `Opam of Fpath.t ] list, string) Belt.Result.t
     Js.Promise.t
