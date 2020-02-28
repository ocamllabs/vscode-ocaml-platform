module R = Result;

let env_sep = Sys.unix ? ":" : ";";
let propertyExists = (json, property) => {
  Js.Json.(
    switch (classify(json)) {
    | JSONObject(json) =>
      switch (Js.Dict.get(json, property)) {
      | Some(j) =>
        switch (classify(j)) {
        | JSONNull => false
        | _ => true
        }
      | None => false
      }
    | _ => false
    }
  );
};

let mapResultAndResolvePromise = (f, r) =>
  Js.Promise.(R.(r >>| f |> resolve));

let bindResultAndResolvePromise = (f, r) =>
  Js.Promise.(R.(r >>= f |> resolve));

let getSubDict = (dict, key) =>
  dict->Js.Dict.get(key)->Belt.Option.flatMap(Js.Json.decodeObject);

let mergeDicts = (dict1, dict2) =>
  Js.Dict.fromArray(
    Js.Array.concat(Js.Dict.entries(dict1), Js.Dict.entries(dict2)),
  );

let (<<) = (f, g, x) => f(g(x));

module Fpath: {
  type t;
  let ofString: string => t;
  let v: string => t;
  let toString: t => string;
  let show: t => string;
  let (/): (t, string) => t;
  let join: (t, t) => t;
} = {
  let sep = Sys.unix ? "/" : "\\\\";
  type t = list(string);
  let ofString = Array.to_list << Js.String.split(sep);
  let v = ofString;
  let toString = Js.Array.joinWith(sep) << Array.of_list;
  let show = toString;
  let (/) = (p, x) => p @ [x];
  let join = (x, y) => x @ y;
};

let okThen = f =>
  Js.Promise.(
    then_(
      resolve
      << (
        fun
        | Ok(x) => f(x)
        | Error(e) => Error(e)
      ),
    )
  );
