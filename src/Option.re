open Belt.Option;

let (>>=) = flatMap;
let (>>|) = map;

let (|!) = (o, f) =>
  switch (o) {
  | None => f()
  | _ => ()
  };

let toResult = e =>
  fun
  | Some(x) => Ok(x)
  | None => Error(e);

let toPromise = e =>
  fun
  | Some(x) => x
  | None => Js.Promise.resolve(Error(e));
