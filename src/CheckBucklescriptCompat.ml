open Utils
module E =
  struct
    type t =
      | NoBsPlatform 
      | IncompatibleBucklescript 
      | NoDepsOrDevDeps 
    let toString =
      function
      | NoBsPlatform ->
          "'bs-platform' was expected in the 'dependencies' section of the manifest file, but was not found!"
      | IncompatibleBucklescript -> "Bucklescript <6 not supported"
      | NoDepsOrDevDeps ->
          "The manifest file doesn't seem to contain `dependencies` or `devDependencies` property"
  end
let processDeps dependencies =
  match Js.Dict.get dependencies "bs-platform" with
  | ((Some (bsPlatformVersion))[@explicit_arity ]) ->
      if
        ((bsPlatformVersion |. Semver.minVersion) |. Semver.satisfies)
          ">=6.0.0"
      then ((Ok (()))[@explicit_arity ])
      else ((Error (E.IncompatibleBucklescript))[@explicit_arity ])
  | None -> ((Error (E.NoBsPlatform))[@explicit_arity ])
let run manifestJson =
  let open Json.Decode in
    match ((manifestJson |>
              ((field "dependencies" (dict string)) |> optional)),
            (manifestJson |>
               ((field "devDependencies" (dict string)) |> optional)))
    with
    | (((Some (dependenciesJson))[@explicit_arity ]), None)
      |(None, ((Some (dependenciesJson))[@explicit_arity ])) ->
        processDeps dependenciesJson
    | (((Some (dependenciesJson))[@explicit_arity ]), ((Some
       (devDependenciesJson))[@explicit_arity ])) ->
        processDeps (mergeDicts dependenciesJson devDependenciesJson)
    | (None, None) -> ((Error (E.NoDepsOrDevDeps))[@explicit_arity ])