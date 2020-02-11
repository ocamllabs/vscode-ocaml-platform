open Belt.Result;

let (>>=) = flatMap;
let (>>|) = map;

let (|!) = (o, f) =>
  switch (o) {
  | None => f()
  | _ => ()
  };

let toResult = msg =>
  fun
  | Some(x) => Ok(x)
  | None => Error(msg);
