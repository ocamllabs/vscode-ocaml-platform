open Belt.Result
let (>>=) = flatMap
let (>>|) = map
let (|!) o f = match o with | None -> f () | _ -> ()
let toResult msg =
  function
  | ((Some (x))[@explicit_arity ]) -> ((Ok (x))[@explicit_arity ])
  | None -> ((Error (msg))[@explicit_arity ])
let return x = ((Ok (x))[@explicit_arity ])
let fail x = ((Error (x))[@explicit_arity ])