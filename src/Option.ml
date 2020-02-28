open Belt.Option
let (>>=) = flatMap
let (>>|) = map
let (|!) o f = match o with | None -> f () | _ -> ()
let toResult e =
  function
  | ((Some (x))[@explicit_arity ]) -> ((Ok (x))[@explicit_arity ])
  | None -> ((Error (e))[@explicit_arity ])
let toPromise e =
  function
  | ((Some (x))[@explicit_arity ]) -> x
  | None -> Js.Promise.resolve ((Error (e))[@explicit_arity ])