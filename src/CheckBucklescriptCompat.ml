let mergeDicts dict1 dict2 =
  Js.Dict.fromArray
    (Js.Array.concat (Js.Dict.entries dict1) (Js.Dict.entries dict2))

let processDeps dependencies =
  match Js.Dict.get dependencies "bs-platform" with
  | Some bsPlatformVersion ->
    if (bsPlatformVersion |. Semver.minVersion |. Semver.satisfies) ">=6.0.0"
    then
      Ok ()
    else
      Error "Bucklescript <6 not supported"
  | None ->
    Error
      "'bs-platform' was expected in the 'dependencies' section of the \
       manifest file, but was not found!"

let run manifestJson =
  let open Json.Decode in
  match
    ( manifestJson |> (field "dependencies" (dict string) |> optional)
    , manifestJson |> (field "devDependencies" (dict string) |> optional) )
  with
  | Some dependenciesJson, None
  | None, Some dependenciesJson ->
    processDeps dependenciesJson
  | Some dependenciesJson, Some devDependenciesJson ->
    processDeps (mergeDicts dependenciesJson devDependenciesJson)
  | None, None ->
    Error
      "The manifest file doesn't seem to contain `dependencies` or \
       `devDependencies` property"
