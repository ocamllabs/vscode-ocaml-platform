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

let return = x => Ok(x);
let fail = x => Error(x);
