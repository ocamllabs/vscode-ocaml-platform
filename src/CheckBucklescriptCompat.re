/* This had to be moved to it's own separate module so that it could be test */
open Utils;

module E = {
  type t =
    | NoBsPlatform
    | IncompatibleBucklescript
    | NoDepsOrDevDeps;
  let toString =
    fun
    | NoBsPlatform => "'bs-platform' was expected in the 'dependencies' section of the manifest file, but was not found!"
    | IncompatibleBucklescript => "Bucklescript <6 not supported"
    | NoDepsOrDevDeps => "The manifest file doesn't seem to contain `dependencies` or `devDependencies` property";
};

let processDeps = dependencies => {
  switch (Js.Dict.get(dependencies, "bs-platform")) {
  | Some(bsPlatformVersion) =>
    if (bsPlatformVersion->Semver.minVersion->Semver.satisfies(">=6.0.0")) {
      Ok();
    } else {
      Error(E.IncompatibleBucklescript);
    }
  | None => Error(E.NoBsPlatform)
  };
};

let run = manifestJson => {
  Json.Decode.(
    switch (
      manifestJson |> (field("dependencies", dict(string)) |> optional),
      manifestJson |> (field("devDependencies", dict(string)) |> optional),
    ) {
    | (Some(dependenciesJson), None)
    | (None, Some(dependenciesJson)) => processDeps(dependenciesJson)
    | (Some(dependenciesJson), Some(devDependenciesJson)) =>
      processDeps(mergeDicts(dependenciesJson, devDependenciesJson))
    | (None, None) => Error(E.NoDepsOrDevDeps)
    }
  );
};
