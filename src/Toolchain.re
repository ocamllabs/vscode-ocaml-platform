module Caml = {
  module Array = Array;
};
module R = Result;
open Bindings;
open Utils;

let pathMissingFromEnv = "'PATH' variable not found in the environment";
let noPackageManagerFound = {j| No package manager found. We support opam (https://opam.ocaml.org/) and esy (https://esy.sh/) |j};

type commandAndArgs = (string, array(string));

let setupWithProgressIndicator = (m, folder) => {
  module M = (val m: Setup.T);
  M.(
    Window.withProgress(
      {
        "location": 15, /* Window.(locationToJs(Notification)) */
        "title": "Setting up toolchain...",
      },
      progress => {
        let succeeded = ref(Ok());
        let eventEmitter = make();
        onProgress(
          eventEmitter,
          percent => {
            Js.log2("Percentage:", percent);
            progress.report(. {"increment": int_of_float(percent *. 100.)});
          },
        );
        onEnd(eventEmitter, () => {progress.report(. {"increment": 100})});
        onError(eventEmitter, errorMsg => {succeeded := Error(errorMsg)});
        Js.Promise.(
          run(eventEmitter, folder) |> then_(() => resolve(succeeded^))
        );
      },
    )
  );
};

module Cmd: {
  type t;
  let make:
    (~env: Js.Dict.t(string), ~cmd: string) =>
    Js.Promise.t(result(t, string));
  type stdout = string;
  let output:
    (~args: Js.Array.t(string), ~cwd: string, t) =>
    Js.Promise.t(result(stdout, string));
  let binPath: t => string;
} = {
  type t = {
    cmd: string,
    env: Js.Dict.t(string),
  };
  type stdout = string;
  let binPath = c => c.cmd;
  let make = (~env, ~cmd) => {
    switch (Js.Dict.get(env, "PATH")) {
    | None => Error(pathMissingFromEnv) |> Js.Promise.resolve
    | Some(path) =>
      let cmds = Sys.unix ? [|cmd|] : [|cmd ++ ".exe", cmd ++ ".cmd"|];
      cmds
      |> Array.map(cmd => {
           Js.String.split(env_sep, path)
           |> Js.Array.map(p => Filename.concat(p, cmd))
         })
      |> Js.Array.reduce(Js.Array.concat, [||])
      |> Js.Array.map(p => {
           Fs.exists(p)
           |> Js.Promise.then_(exists => Js.Promise.resolve((p, exists)))
         })
      |> Js.Promise.all
      |> Js.Promise.then_(
           Js.Promise.resolve << Js.Array.filter(((p, exists)) => exists),
         )
      |> Js.Promise.then_(
           Js.Promise.resolve
           << (
             fun
             | [] => Error({j| Command "$cmd" not found |j})
             | [(cmd, exists), ..._rest] => Ok({cmd, env})
           )
           << Array.to_list,
         );
    };
  };
  let output = (~args, ~cwd, {cmd, env}) => {
    let shellString =
      Js.Array.concat(args, [|cmd|]) |> Js.Array.joinWith(" ");
    Js.log(shellString);
    ChildProcess.exec(shellString, ChildProcess.Options.make(~cwd, ~env, ()))
    |> Js.Promise.then_(
         Js.Promise.resolve
         << (
           fun
           | Error(e) => e |> ChildProcess.E.toString |> R.fail
           | Ok((exitCode, stdout, stderr)) =>
             if (exitCode == 0) {
               Ok(stdout);
             } else {
               Error(
                 {j| Command $cmd failed:
exitCode: $exitCode
stderr: $stderr
|j},
               );
             }
         ),
       );
  };
};

/* Package managers that can install native Reason/
   OCaml packages for us */
module PackageManager: {
  type t;
  type a = t;
  type spec;
  module type T = {
    let name: string;
    let lockFile: Fpath.t;
    let make:
      (
        ~env: Js.Dict.t(string),
        ~root: Fpath.t,
        ~discoveredManifestPath: Fpath.t
      ) =>
      Js.Promise.t(result(spec, string));
  };
  module Esy: T;
  module Opam: T;
  let ofName: string => result(t, string);
  let toName: t => string;
  let specOfName:
    (
      ~env: Js.Dict.t(string),
      ~name: string,
      ~root: Fpath.t,
      ~discoveredManifestPath: Fpath.t
    ) =>
    Js.Promise.t(result(spec, string));
  let make:
    (
      ~env: Js.Dict.t(string),
      ~root: Fpath.t,
      ~discoveredManifestPath: Fpath.t,
      ~t: t
    ) =>
    Js.Promise.t(result(spec, string));
  let setupToolChain: spec => Js.Promise.t(result(unit, string));

  module PackageManagerSpecTuple: {
    type t = (a, Utils.Fpath.t);
    let compare: (('a, 'b), ('a, 'b)) => int;
  };
  module PackageManagerSpecTupleSet: {
    type elt = PackageManagerSpecTuple.t;
    type t = Set.Make(PackageManagerSpecTuple).t;
    let empty: t;
    let is_empty: t => bool;
    let mem: (elt, t) => bool;
    let add: (elt, t) => t;
    let singleton: elt => t;
    let remove: (elt, t) => t;
    let union: (t, t) => t;
    let inter: (t, t) => t;
    let diff: (t, t) => t;
    let compare: (t, t) => int;
    let equal: (t, t) => bool;
    let subset: (t, t) => bool;
    let iter: (elt => unit, t) => unit;
    let map: (elt => elt, t) => t;
    let fold: ((elt, 'a) => 'a, t, 'a) => 'a;
    let for_all: (elt => bool, t) => bool;
    let exists: (elt => bool, t) => bool;
    let filter: (elt => bool, t) => t;
    let partition: (elt => bool, t) => (t, t);
    let cardinal: t => int;
    let elements: t => list(elt);
    let min_elt: t => elt;
    let min_elt_opt: t => option(elt);
    let max_elt: t => elt;
    let max_elt_opt: t => option(elt);
    let choose: t => elt;
    let choose_opt: t => option(elt);
    let split: (elt, t) => (t, bool, t);
    let find: (elt, t) => elt;
    let find_opt: (elt, t) => option(elt);
    let find_first: (elt => bool, t) => elt;
    let find_first_opt: (elt => bool, t) => option(elt);
    let find_last: (elt => bool, t) => elt;
    let find_last_opt: (elt => bool, t) => option(elt);
    let of_list: list(elt) => t;
  };

  let alreadyUsed: Fpath.t => Js.Promise.t(result(list(t), string));
  let available:
    (~env: Js.Dict.t(string)) => Js.Promise.t(result(list(t), string));
  let env: spec => Js.Promise.t(result(Js.Dict.t(string), string));
  let lsp: spec => commandAndArgs;
  module Manifest: {
    let lookup:
      Fpath.t => Js.Promise.t(result(PackageManagerSpecTupleSet.t, string));
  };
} = {
  type t =
    | Opam
    | Esy;

  type a = t;

  type spec = {
    cmd: Cmd.t,
    lsp: unit => commandAndArgs,
    env: unit => Js.Promise.t(result(Js.Dict.t(string), string)),
    setup: unit => Js.Promise.t(result(unit, string)),
  };

  let supportedPackageManagers = [Esy, Opam];
  module type T = {
    let name: string;
    let lockFile: Fpath.t;
    let make:
      (
        ~env: Js.Dict.t(string),
        ~root: Fpath.t,
        ~discoveredManifestPath: Fpath.t
      ) =>
      Js.Promise.t(result(spec, string));
  };

  module Esy: T = {
    let name = "esy";
    let lockFile = Fpath.(v("esy.lock") / "index.json");
    let make = (~env, ~root, ~discoveredManifestPath) =>
      Cmd.make(~cmd="esy", ~env)
      |> okThen(cmd => {
           {
             cmd,
             setup: () => {
               let rootStr = root |> Fpath.toString;
               Cmd.output(
                 cmd,
                 ~args=[|"status", "-P", rootStr|],
                 ~cwd=rootStr,
               )
               |> Js.Promise.then_(
                    Js.Promise.resolve
                    << (
                      fun
                      | Error(_) => R.return(false)
                      | Ok(stdout) => {
                          switch (Json.parse(stdout)) {
                          | None => R.return(false)
                          | Some(json) =>
                            json
                            |> Json.Decode.(
                                 field("isProjectReadyForDev", bool)
                               )
                            |> R.return
                          };
                        }
                    ),
                  )
               |> Js.Promise.then_(
                    fun
                    | Error(e) => e |> R.fail |> Js.Promise.resolve
                    | Ok(isProjectReadyForDev) =>
                      if (isProjectReadyForDev) {
                        () |> R.return |> Js.Promise.resolve;
                      } else if (root == discoveredManifestPath) {
                        setupWithProgressIndicator(
                          (module Setup.Esy),
                          rootStr,
                        );
                      } else {
                        setupWithProgressIndicator(
                          (module Setup.Bsb),
                          discoveredManifestPath |> Fpath.toString,
                        );
                      },
                  );
             },
             env: () =>
               Cmd.output(
                 cmd,
                 ~args=[|
                   "command-env",
                   "--json",
                   "-P",
                   Fpath.toString(root),
                 |],
                 ~cwd=Fpath.toString(root),
               )
               |> okThen(stdout => {
                    switch (Json.parse(stdout)) {
                    | Some(json) =>
                      json |> Json.Decode.dict(Json.Decode.string) |> R.return
                    | None =>
                      Error(
                        "'esy command-env' returned non-json output: "
                        ++ stdout,
                      )
                    }
                  }),
             lsp: () => (
               Cmd.binPath(cmd),
               [|"-P", Fpath.toString(root), "ocamllsp"|],
             ),
           }
           |> R.return
         });
  };

  module Opam: T = {
    let name = "opam";
    let lockFile = Fpath.v("opam.lock");
    let make = (~env, ~root, ~discoveredManifestPath as _) => {
      let rootStr = root |> Fpath.toString;
      Cmd.make(~cmd="opam", ~env)
      |> okThen(cmd => {
           {
             cmd,
             setup: () => {
               /* TODO: check if tools needed are available in the opam switch */
               setupWithProgressIndicator(
                 (module Setup.Opam),
                 rootStr,
               );
             },

             env: () =>
               Cmd.output(
                 cmd,
                 ~args=[|"exec", "env"|], /* TODO: Windows? */
                 ~cwd=Fpath.toString(root),
               )
               |> okThen(stdout => {
                    stdout
                    |> Js.String.split("\n")
                    |> Js.Array.map(x => Js.String.split("=", x))
                    |> Js.Array.map(
                         (
                           fun
                           | [] =>
                             Error("Splitting on '=' in env output failed")
                           | [k, v] => Ok((k, v))
                           | l => {
                               Js.log(l);
                               Error(
                                 "Splitting on '=' in env output returned more than two items",
                               );
                             }
                         )
                         << Array.to_list,
                       )
                    |> Js.Array.reduce(
                         (acc, kv) => {
                           switch (kv) {
                           | Ok(kv) => [kv, ...acc]
                           | Error(msg) =>
                             Js.log(msg);
                             acc;
                           }
                         },
                         [],
                       )
                    |> Js.Dict.fromList
                    |> R.return
                  }),
             lsp: () => (name, [|"exec", "ocamllsp"|]),
           }
           |> R.return
         });
    };
  };

  let make = (~env, ~root, ~discoveredManifestPath, ~t) =>
    switch (t) {
    | Opam => Opam.make(~env, ~root, ~discoveredManifestPath)
    | Esy => Esy.make(~env, ~root, ~discoveredManifestPath)
    };

  let toName =
    fun
    | Opam => "opam"
    | Esy => "esy";

  let ofName =
    fun
    | "opam" => Ok(Opam)
    | "esy" => Ok(Esy)
    | n => Error({j|Invalid name $n was provided|j});

  let specOfName = (~env, ~name, ~root, ~discoveredManifestPath) =>
    switch (name) {
    | x when x == Opam.name => Opam.make(~env, ~root, ~discoveredManifestPath)
    | x when x == Esy.name => Esy.make(~env, ~root, ~discoveredManifestPath)
    | _ => "Invalid package manager name" |> R.fail |> Js.Promise.resolve
    };

  module PackageManagerSpecTuple = {
    type t = (a, Fpath.t);
    let compare = (x, y) => {
      let (xa, xb) = x;
      let (ya, yb) = y;
      if (xa == ya && xb == yb) {
        0;
      } else {
        1;
      };
    };
  };

  module PackageManagerSpecTupleSet = Set.Make(PackageManagerSpecTuple);

  let alreadyUsed = folder => {
    [Esy, Opam]
    |> Array.of_list
    |> Array.map(pm => {
         let lockFileFpath =
           switch (pm) {
           | Opam => Fpath.(join(folder, Opam.lockFile))
           | Esy => Fpath.(join(folder, Esy.lockFile))
           };
         Fs.exists(Fpath.show(lockFileFpath))
         |> Js.Promise.then_(Js.Promise.resolve << (exists => (pm, exists)));
       })
    |> Js.Promise.all
    |> Js.Promise.then_(l =>
         l
         |> Js.Array.filter(((_pm, used)) => used)
         |> Array.map(t => {
              let (pm, _used) = t;
              pm;
            })
         |> Array.to_list
         |> R.return
         |> Js.Promise.resolve
       );
  };
  let available = (~env) => {
    supportedPackageManagers
    |> List.map((pm: t) => {
         let name =
           switch (pm) {
           | Opam => Opam.name
           | Esy => Esy.name
           };
         Cmd.make(~env, ~cmd=name)
         |> Js.Promise.then_(
              Js.Promise.resolve
              << (
                fun
                | Ok(_) => {
                    (pm, true);
                  }
                | Error(e) => {
                    (pm, false);
                  }
              ),
            );
       })
    |> Array.of_list
    |> Js.Promise.all
    |> Js.Promise.then_(
         Js.Promise.resolve
         << R.return
         << Array.to_list
         << Array.map(t => {
              let (pm, _used) = t;
              pm;
            })
         << Js.Array.filter(((_pm, available)) => available),
       );
  };

  let setupToolChain = spec => spec.setup();
  let lsp = spec => spec.lsp();
  let env = spec => spec.env();

  module Manifest: {
    let lookup:
      Fpath.t => Js.Promise.t(result(PackageManagerSpecTupleSet.t, string));
  } = {
    /* TODO: Constructors Esy and Opam simply take Fpath.t - no way of telling if that is a directory or actual filename */
    let parse = projectRoot =>
      fun
      | "esy.json" => Some((Esy, projectRoot)) |> Js.Promise.resolve
      | "opam" => {
          Fs.stat(Fpath.(projectRoot / "opam" |> toString))
          |> Js.Promise.then_(
               Js.Promise.resolve
               << (
                 fun
                 | Ok(stats) =>
                   Fs.Stat.isDirectory(stats)
                     ? None : Some((Opam, projectRoot))
                 | Error(_) => None
               ),
             );
        }
      | "package.json" => {
          let manifestFile =
            Fpath.(projectRoot / "package.json") |> Fpath.show;
          Fs.readFile(manifestFile)
          |> Js.Promise.then_(manifest => {
               switch (Json.parse(manifest)) {
               | None => None |> Js.Promise.resolve
               | Some(json) =>
                 if (Utils.propertyExists(json, "dependencies")
                     || Utils.propertyExists(json, "devDependencies")) {
                   if (Utils.propertyExists(json, "esy")) {
                     Some((Esy, projectRoot)) |> Js.Promise.resolve;
                   } else {
                     Some((Esy, Fpath.(projectRoot / ".vscode" / "esy")))
                     |> Js.Promise.resolve;
                   };
                 } else {
                   None |> Js.Promise.resolve;
                 }
               }
             });
        }
      | file => {
          let manifestFile = Fpath.(projectRoot / file) |> Fpath.show;
          switch (Path.extname(file)) {
          | ".json" =>
            Fs.readFile(manifestFile)
            |> Js.Promise.then_(manifest => {
                 switch (Json.parse(manifest)) {
                 | Some(json) =>
                   if (Utils.propertyExists(json, "dependencies")
                       || Utils.propertyExists(json, "devDependencies")) {
                     Some((Esy, projectRoot)) |> Js.Promise.resolve;
                   } else {
                     None |> Js.Promise.resolve;
                   }

                 | None =>
                   Js.log3(
                     "Invalid JSON file found. Ignoring...",
                     manifest,
                     manifestFile,
                   );
                   None |> Js.Promise.resolve;
                 }
               })
          | ".opam" =>
            Fs.readFile(manifestFile)
            |> Js.Promise.then_(
                 fun
                 | "" => None |> Js.Promise.resolve
                 | _ => Some((Opam, projectRoot)) |> Js.Promise.resolve,
               )

          | _ => None |> Js.Promise.resolve
          };
        };

    let lookup = projectRoot => {
      Fs.readDir(Fpath.toString(projectRoot))
      |> Js.Promise.then_(
           fun
           | Error(msg) => Js.Promise.resolve(Error(msg))
           | Ok(files) => {
               files
               |> Js.Array.map(parse(projectRoot))
               |> Js.Promise.all
               |> Js.Promise.then_(l =>
                    Ok(
                      Js.Array.reduce(
                        (acc, x) =>
                          Js.Array.concat(
                            acc,
                            switch (x) {
                            | Some(x) => Array.of_list([x])
                            | None => [||]
                            },
                          ),
                        [||],
                        l,
                      )
                      |> Array.to_list
                      |> PackageManagerSpecTupleSet.of_list,
                    )
                    |> Js.Promise.resolve
                  );
             },
         );
    };
  };
};

/* We declare two types with identical structure to differentiate state: t is the toolchain ready for consumption. resources is the toolchain that could need setup (and may fail) */

type t = {
  spec: PackageManager.spec,
  projectRoot: Fpath.t,
};

type resources = {
  spec: PackageManager.spec,
  projectRoot: Fpath.t,
};

let init = (~env, ~folder) => {
  let projectRoot = Fpath.ofString(folder);

  Js.Promise.all2((
    PackageManager.available(~env),
    PackageManager.alreadyUsed(projectRoot)
    |> Js.Promise.then_(
         fun
         | Ok([]) =>
           PackageManager.Manifest.lookup(projectRoot)
           |> okThen(x =>
                x
                |> PackageManager.PackageManagerSpecTupleSet.elements
                |> (
                  fun
                  | [] => Error("TODO: global toolchain")
                  | packageManagersInUse => packageManagersInUse |> R.return
                )
              )
         | Ok(packageManagersInUse) =>
           packageManagersInUse
           |> List.map(x => (x, projectRoot))
           |> R.return
           |> Js.Promise.resolve
         | Error(msg) => Error(msg) |> Js.Promise.resolve,
       ),
  ))
  |> Js.Promise.then_(
       ((availablePackageManagers, alreadyUsedPackageManagers)) => {
       let availablePackageManagers =
         switch (availablePackageManagers) {
         | Ok(x) => x
         | Error(msg) =>
           Js.log2("Error during availablePackageManagers()", msg);
           [];
         };
       let alreadyUsedPackageManagers =
         switch (alreadyUsedPackageManagers) {
         | Ok(x) => x
         | Error(msg) =>
           Js.log2("Error during alreadyUsedPackageManagers()", msg);
           [];
         };

       switch (
         List.filter(
           ((x, _)) =>
             switch (List.find_opt(y => y == x, availablePackageManagers)) {
             | Some(_) => true
             | None => false
             },
           alreadyUsedPackageManagers,
         )
       ) {
       | [] => Error(noPackageManagerFound) |> Js.Promise.resolve
       | [(obviousChoice, toolChainRoot)] =>
         PackageManager.make(
           ~env,
           ~root=toolChainRoot,
           ~t=obviousChoice,
           ~discoveredManifestPath=projectRoot,
         )
       | multipleChoices =>
         let config = Vscode.Workspace.getConfiguration("ocaml");
         switch (
           Js.Nullable.toOption(config##packageManager),
           Js.Nullable.toOption(config##toolChainRoot),
         ) {
         /* TODO: unsafe type config. It's just 'a */
         | (Some(name), Some(root)) =>
           PackageManager.specOfName(
             ~env,
             ~name,
             ~root,
             ~discoveredManifestPath=projectRoot,
           )
         | (Some(name), None) =>
           PackageManager.specOfName(
             ~env,
             ~name,
             ~root=projectRoot,
             ~discoveredManifestPath=projectRoot,
           )
         | _ =>
           Js.log(multipleChoices);
           Window.showQuickPick(.
             multipleChoices
             |> List.map(((pm, _)) => PackageManager.toName(pm))
             |> Array.of_list,
             Window.QuickPickOptions.make(~canPickMany=false, ()),
           )
           |> Js.Promise.then_(packageManager => {
                switch (Js.Nullable.toOption(packageManager)) {
                | None =>
                  Js.Promise.resolve(
                    Error("showQuickPick() returned undefined"),
                  )
                | Some(packageManager) =>
                  let pm = PackageManager.ofName(packageManager);
                  switch (pm) {
                  | Ok(pmx) =>
                    switch (
                      List.find_opt(
                        ((pmy, _toolChainRoot)) => pmy == pmx,
                        multipleChoices,
                      )
                    ) {
                    | None =>
                      Js.Promise.resolve(
                        Error(
                          "Weird invalid state: selected choice was not found in the list",
                        ),
                      )
                    | Some((pm, toolChainRoot)) =>
                      PackageManager.make(
                        ~env,
                        ~t=pm,
                        ~root=toolChainRoot,
                        ~discoveredManifestPath=projectRoot,
                      )
                    }
                  | Error(msg) => Js.Promise.resolve(Error(msg))
                  };
                }
              });
         };
       };
     })
  |> okThen(spec => Ok({spec, projectRoot}));
};

let setup = ({spec, projectRoot}) => {
  PackageManager.setupToolChain(spec)
  |> Js.Promise.then_(
       fun
       | Error(msg) => Error(msg) |> Js.Promise.resolve
       | Ok () => PackageManager.env(spec),
     )
  |> Js.Promise.then_(
       fun
       | Ok(env) => Cmd.make(~cmd="ocamllsp", ~env)
       | Error(e) => e |> R.fail |> Js.Promise.resolve,
     )
  |> Js.Promise.then_(
       Js.Promise.resolve
       << (
         fun
         | Ok(_) => Ok({spec, projectRoot}: t)
         | Error(msg) => Error({j| Toolchain initialisation failed: $msg |j})
       ),
     );
};

let lsp = (t: t) => PackageManager.lsp(t.spec);
