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
  Js.Promise.(Result.(r >>| f |> resolve));

let bindResultAndResolvePromise = (f, r) =>
  Js.Promise.(Result.(r >>= f |> resolve));

let getSubDict = (dict, key) =>
  dict->Js.Dict.get(key)->Belt.Option.flatMap(Js.Json.decodeObject);

let mergeDicts = (dict1, dict2) =>
  Js.Dict.fromArray(
    Js.Array.concat(Js.Dict.entries(dict1), Js.Dict.entries(dict2)),
  );

let (<<) = (f, g, x) => f(g(x));
