module Caml = struct
  module Array = Array
end

module R = Result
open Bindings
open Utils

let pathMissingFromEnv = "'PATH' variable not found in the environment"

let noPackageManagerFound =
  {j| No package manager found. We support opam (https://opam.ocaml.org/) and esy (https://esy.sh/) |j}

type commandAndArgs = string * string array

let promptSetup packageManager ~f =
  let open Js.Promise in
  (Window.showQuickPick [| "yes"; "no" |]
     (Window.QuickPickOptions.make ~canPickMany:false
        ~placeHolder:{j|Setup this project's toolchain with $packageManager?|j}
        ()) [@bs])
  |> Js.Promise.then_ (fun choice ->
         match Js.Nullable.toOption choice with
         | None -> resolve (Error "Please setup the toolchain")
         | Some choice ->
           if choice = "yes" then
             f ()
           else
             resolve (Error "Please setup the toolchain"))

let setupWithProgressIndicator m folder =
  let module M = (val m : Setup.T) in
  let open M in
  Window.withProgress
    [%bs.obj { location = 15; title = "Setting up toolchain..." }]
    (fun progress ->
      let succeeded = ref (Ok ()) in
      let eventEmitter = make () in
      onProgress eventEmitter (fun percent ->
          Js.log2 "Percentage:" percent;
          (progress.report
             [%bs.obj { increment = int_of_float (percent *. 100.) }] [@bs]));
      onEnd eventEmitter (fun () ->
          (progress.report [%bs.obj { increment = 100 }] [@bs]));
      onError eventEmitter (fun errorMsg -> succeeded := Error errorMsg);
      let open Js.Promise in
      run eventEmitter folder |> then_ (fun () -> resolve !succeeded))

module Cmd : sig
  type t

  val make :
    env:string Js.Dict.t -> cmd:string -> (t, string) result Js.Promise.t

  type stdout = string

  val output :
       args:string Js.Array.t
    -> cwd:string
    -> t
    -> (stdout, string) result Js.Promise.t

  val binPath : t -> string
end = struct
  type t =
    { cmd : string
    ; env : string Js.Dict.t
    }

  type stdout = string

  let binPath c = c.cmd

  let make ~env ~cmd =
    match Js.Dict.get env "PATH" with
    | None -> Error pathMissingFromEnv |> Js.Promise.resolve
    | Some path ->
      let cmds =
        match Sys.unix with
        | true -> [| cmd |]
        | false -> [| cmd ^ ".exe"; cmd ^ ".cmd" |]
      in
      cmds
      |> Array.map (fun cmd ->
             Js.String.split env_sep path
             |> Js.Array.map (fun p -> Filename.concat p cmd))
      |> Js.Array.reduce Js.Array.concat [||]
      |> Js.Array.map (fun p ->
             Fs.exists p
             |> Js.Promise.then_ (fun exists -> Js.Promise.resolve (p, exists)))
      |> Js.Promise.all
      |> Js.Promise.then_ (fun r ->
             Js.Promise.resolve (Js.Array.filter (fun (_p, exists) -> exists) r))
      |> Js.Promise.then_ (fun r ->
             let r = Array.to_list r in
             let r =
               match r with
               | [] -> Error {j| Command "$cmd" not found |j}
               | (cmd, _exists) :: _rest -> Ok { cmd; env }
             in
             Js.Promise.resolve r)

  let output ~args ~cwd { cmd; env } =
    let shellString = Js.Array.concat args [| cmd |] |> Js.Array.joinWith " " in
    Js.log shellString;
    ChildProcess.exec shellString (ChildProcess.Options.make ~cwd ~env ())
    |> Js.Promise.then_ (fun r ->
           let r =
             match r with
             | Error e -> e |> ChildProcess.E.toString |> R.fail
             | Ok (exitCode, stdout, stderr) ->
               if exitCode = 0 then
                 Ok stdout
               else
                 Error
                   {j| Command $cmd failed:
exitCode: $exitCode
stderr: $stderr
|j}
           in
           Js.Promise.resolve r)
end

module PackageManager : sig
  type t

  type a = t

  type spec

  module type T = sig
    val name : string

    val lockFile : Fpath.t

    val make :
         env:string Js.Dict.t
      -> root:Fpath.t
      -> discoveredManifestPath:Fpath.t
      -> (spec, string) result Js.Promise.t
  end

  module Esy : T

  module Opam : T

  val ofName : string -> (t, string) result

  val toName : t -> string

  val specOfName :
       env:string Js.Dict.t
    -> name:string
    -> root:Fpath.t
    -> discoveredManifestPath:Fpath.t
    -> (spec, string) result Js.Promise.t

  val make :
       env:string Js.Dict.t
    -> root:Fpath.t
    -> discoveredManifestPath:Fpath.t
    -> t:t
    -> (spec, string) result Js.Promise.t

  val setupToolChain : spec -> (unit, string) result Js.Promise.t

  module PackageManagerSpecTuple : sig
    type t = a * Fpath.t
  end

  module PackageManagerSpecTupleSet : sig
    include Set.S with type elt = PackageManagerSpecTuple.t
  end

  val alreadyUsed : Fpath.t -> (t list, string) result Js.Promise.t

  val available : env:string Js.Dict.t -> (t list, string) result Js.Promise.t

  val env : spec -> (string Js.Dict.t, string) result Js.Promise.t

  val lsp : spec -> commandAndArgs

  module Manifest : sig
    val lookup :
      Fpath.t -> (PackageManagerSpecTupleSet.t, string) result Js.Promise.t
  end
end = struct
  type t =
    | Opam
    | Esy

  type a = t

  type spec =
    { cmd : Cmd.t
    ; lsp : unit -> commandAndArgs
    ; env : unit -> (string Js.Dict.t, string) result Js.Promise.t
    ; setup : unit -> (unit, string) result Js.Promise.t
    }

  let supportedPackageManagers = [ Esy; Opam ]

  module type T = sig
    val name : string

    val lockFile : Fpath.t

    val make :
         env:string Js.Dict.t
      -> root:Fpath.t
      -> discoveredManifestPath:Fpath.t
      -> (spec, string) result Js.Promise.t
  end

  module Esy : T = struct
    let name = "esy"

    let lockFile =
      let open Fpath in
      v "esy.lock" / "index.json"

    let make ~env ~root ~discoveredManifestPath =
      Cmd.make ~cmd:"esy" ~env
      |> okThen (fun cmd ->
             { cmd
             ; setup =
                 (fun () ->
                   let rootStr = root |> Fpath.toString in
                   Cmd.output cmd
                     ~args:[| "status"; "-P"; rootStr |]
                     ~cwd:rootStr
                   |> Js.Promise.then_ (fun r ->
                          let r =
                            match r with
                            | Error _ -> R.return false
                            | Ok stdout -> (
                              match Json.parse stdout with
                              | None -> R.return false
                              | Some json ->
                                json
                                |> (let open Json.Decode in
                                   field "isProjectReadyForDev" bool)
                                |> R.return )
                          in
                          Js.Promise.resolve r)
                   |> Js.Promise.then_ (function
                        | Error e -> e |> R.fail |> Js.Promise.resolve
                        | Ok isProjectReadyForDev ->
                          if isProjectReadyForDev then
                            () |> R.return |> Js.Promise.resolve
                          else if root = discoveredManifestPath then
                            promptSetup "esy" ~f:(fun () ->
                                setupWithProgressIndicator
                                  (module Setup.Esy)
                                  rootStr)
                          else
                            promptSetup "esy" ~f:(fun () ->
                                setupWithProgressIndicator
                                  (module Setup.Bsb)
                                  (discoveredManifestPath |> Fpath.toString))))
             ; env =
                 (fun () ->
                   Cmd.output cmd
                     ~args:
                       [| "command-env"; "--json"; "-P"; Fpath.toString root |]
                     ~cwd:(Fpath.toString root)
                   |> okThen (fun stdout ->
                          match Json.parse stdout with
                          | Some json ->
                            json
                            |> Json.Decode.dict Json.Decode.string
                            |> R.return
                          | None ->
                            Error
                              ( "'esy command-env' returned non-json output: "
                              ^ stdout )))
             ; lsp =
                 (fun () ->
                   (Cmd.binPath cmd, [| "-P"; Fpath.toString root; "ocamllsp" |]))
             }
             |> R.return)
  end

  module Opam : T = struct
    let name = "opam"

    let lockFile = Fpath.v "opam.lock"

    let make ~env ~root ~discoveredManifestPath:_ =
      let rootStr = root |> Fpath.toString in
      Cmd.make ~cmd:"opam" ~env
      |> okThen (fun cmd ->
             { cmd
             ; setup =
                 (fun () ->
                   setupWithProgressIndicator (module Setup.Opam) rootStr)
             ; env =
                 (fun () ->
                   Cmd.output cmd ~args:[| "exec"; "env" |]
                     ~cwd:(Fpath.toString root)
                   |> okThen (fun stdout ->
                          stdout |> Js.String.split "\n"
                          |> Js.Array.map (fun x -> Js.String.split "=" x)
                          |> Js.Array.map (fun r ->
                                 match Array.to_list r with
                                 | [] ->
                                   (* TODO Environment entries are not
                                      necessarily key value pairs *)
                                   Error "Splitting on '=' in env output failed"
                                 | [ k; v ] -> Ok (k, v)
                                 | l ->
                                   Js.log l;
                                   Error
                                     "Splitting on '=' in env output returned \
                                      more than two items")
                          |> Js.Array.reduce
                               (fun acc kv ->
                                 match kv with
                                 | Ok kv -> kv :: acc
                                 | Error msg ->
                                   Js.log msg;
                                   acc)
                               []
                          |> Js.Dict.fromList |> R.return))
             ; lsp = (fun () -> (name, [| "exec"; "ocamllsp" |]))
             }
             |> R.return)
  end

  let make ~env ~root ~discoveredManifestPath ~t =
    match t with
    | Opam -> Opam.make ~env ~root ~discoveredManifestPath
    | Esy -> Esy.make ~env ~root ~discoveredManifestPath

  let toName = function
    | Opam -> "opam"
    | Esy -> "esy"

  let ofName = function
    | "opam" -> Ok Opam
    | "esy" -> Ok Esy
    | n -> Error {j|Invalid name $n was provided|j}

  let specOfName ~env ~name ~root ~discoveredManifestPath =
    match name with
    | x when x = Opam.name -> Opam.make ~env ~root ~discoveredManifestPath
    | x when x = Esy.name -> Esy.make ~env ~root ~discoveredManifestPath
    | _ -> "Invalid package manager name" |> R.fail |> Js.Promise.resolve

  module PackageManagerSpecTuple = struct
    type t = a * Fpath.t

    let compare x y =
      let xa, xb = x in
      let ya, yb = y in
      if xa = ya && xb = yb then
        0
      else
        1
  end

  module PackageManagerSpecTupleSet = Set.Make (PackageManagerSpecTuple)

  let alreadyUsed folder =
    [ Esy; Opam ] |> Array.of_list
    |> Array.map (fun pm ->
           let lockFileFpath =
             match pm with
             | Opam ->
               let open Fpath in
               join folder Opam.lockFile
             | Esy ->
               let open Fpath in
               join folder Esy.lockFile
           in
           Fs.exists (Fpath.show lockFileFpath)
           |> Js.Promise.then_ (fun exists -> Js.Promise.resolve (pm, exists)))
    |> Js.Promise.all
    |> Js.Promise.then_ (fun l ->
           l
           |> Js.Array.filter (fun (_pm, used) -> used)
           |> Array.map (fun t ->
                  let pm, _used = t in
                  pm)
           |> Array.to_list |> R.return |> Js.Promise.resolve)

  let available ~env =
    supportedPackageManagers
    |> List.map (fun (pm : t) ->
           let name =
             match pm with
             | Opam -> Opam.name
             | Esy -> Esy.name
           in
           Cmd.make ~env ~cmd:name
           |> Js.Promise.then_ (fun r ->
                  let r =
                    match r with
                    | Ok _ -> (pm, true)
                    | Error _e -> (pm, false)
                  in
                  Js.Promise.resolve r))
    |> Array.of_list |> Js.Promise.all
    |> Js.Promise.then_ (fun r ->
           Js.Array.filter (fun (_pm, available) -> available) r
           |> Array.map (fun (pm, _used) -> pm)
           |> Array.to_list |> R.return |> Js.Promise.resolve)

  let setupToolChain spec = spec.setup ()

  let lsp spec = spec.lsp ()

  let env spec = spec.env ()

  module Manifest : sig
    val lookup :
      Fpath.t -> (PackageManagerSpecTupleSet.t, string) result Js.Promise.t
  end = struct
    let parse projectRoot = function
      | "esy.json" -> Some (Esy, projectRoot) |> Js.Promise.resolve
      | "opam" ->
        Fs.stat
          (let open Fpath in
          projectRoot / "opam" |> toString)
        |> Js.Promise.then_ (fun r ->
               let r =
                 match r with
                 | Error _ -> None
                 | Ok stats -> (
                   match Fs.Stat.isDirectory stats with
                   | true -> None
                   | false -> Some (Opam, projectRoot) )
               in
               Js.Promise.resolve r)
      | "package.json" ->
        let manifestFile =
          (let open Fpath in
          projectRoot / "package.json")
          |> Fpath.show
        in
        Fs.readFile manifestFile
        |> Js.Promise.then_ (fun manifest ->
               match Json.parse manifest with
               | None -> None |> Js.Promise.resolve
               | Some json ->
                 if
                   Utils.propertyExists json "dependencies"
                   || Utils.propertyExists json "devDependencies"
                 then
                   if Utils.propertyExists json "esy" then
                     Some (Esy, projectRoot) |> Js.Promise.resolve
                   else
                     Some
                       ( Esy
                       , let open Fpath in
                         projectRoot / ".vscode" / "esy" )
                     |> Js.Promise.resolve
                 else
                   None |> Js.Promise.resolve)
      | file -> (
        let manifestFile =
          (let open Fpath in
          projectRoot / file)
          |> Fpath.show
        in
        match Path.extname file with
        | ".json" ->
          Fs.readFile manifestFile
          |> Js.Promise.then_ (fun manifest ->
                 match Json.parse manifest with
                 | Some json ->
                   if
                     Utils.propertyExists json "dependencies"
                     || Utils.propertyExists json "devDependencies"
                   then
                     Some (Esy, projectRoot) |> Js.Promise.resolve
                   else
                     None |> Js.Promise.resolve
                 | None ->
                   Js.log3 "Invalid JSON file found. Ignoring..." manifest
                     manifestFile;
                   None |> Js.Promise.resolve)
        | ".opam" ->
          Fs.readFile manifestFile
          |> Js.Promise.then_ (function
               | "" -> None |> Js.Promise.resolve
               | _ -> Some (Opam, projectRoot) |> Js.Promise.resolve)
        | _ -> None |> Js.Promise.resolve )

    let lookup projectRoot =
      Fs.readDir (Fpath.toString projectRoot)
      |> Js.Promise.then_ (function
           | Error msg -> Js.Promise.resolve (Error msg)
           | Ok files ->
             files
             |> Js.Array.map (parse projectRoot)
             |> Js.Promise.all
             |> Js.Promise.then_ (fun l ->
                    Ok
                      ( Js.Array.reduce
                          (fun acc x ->
                            Js.Array.concat acc
                              ( match x with
                              | Some x -> Array.of_list [ x ]
                              | None -> [||] ))
                          [||] l
                      |> Array.to_list |> PackageManagerSpecTupleSet.of_list )
                    |> Js.Promise.resolve))
  end
end

type t =
  { spec : PackageManager.spec
  ; projectRoot : Fpath.t
  }

type resources =
  { spec : PackageManager.spec
  ; projectRoot : Fpath.t
  }

let init ~env ~folder =
  let projectRoot = Fpath.ofString folder in
  Js.Promise.all2
    ( PackageManager.available ~env
    , PackageManager.alreadyUsed projectRoot
      |> Js.Promise.then_ (function
           | Ok [] ->
             PackageManager.Manifest.lookup projectRoot
             |> okThen (fun x ->
                    x |> PackageManager.PackageManagerSpecTupleSet.elements
                    |> function
                    | [] -> Error "TODO: global toolchain"
                    | packageManagersInUse -> packageManagersInUse |> R.return)
           | Ok packageManagersInUse ->
             packageManagersInUse
             |> List.map (fun x -> (x, projectRoot))
             |> R.return |> Js.Promise.resolve
           | Error msg -> Error msg |> Js.Promise.resolve) )
  |> Js.Promise.then_
       (fun (availablePackageManagers, alreadyUsedPackageManagers) ->
         let availablePackageManagers =
           match availablePackageManagers with
           | Ok x -> x
           | Error msg ->
             Js.log2 "Error during availablePackageManagers()" msg;
             []
         in
         let alreadyUsedPackageManagers =
           match alreadyUsedPackageManagers with
           | Ok x -> x
           | Error msg ->
             Js.log2 "Error during alreadyUsedPackageManagers()" msg;
             []
         in
         match
           List.filter
             (fun (x, _) ->
               match
                 List.find_opt (fun y -> y = x) availablePackageManagers
               with
               | Some _ -> true
               | None -> false)
             alreadyUsedPackageManagers
         with
         | [] -> Error noPackageManagerFound |> Js.Promise.resolve
         | [ (obviousChoice, toolChainRoot) ] ->
           PackageManager.make ~env ~root:toolChainRoot ~t:obviousChoice
             ~discoveredManifestPath:projectRoot
         | multipleChoices -> (
           let config = Vscode.Workspace.getConfiguration "ocaml" in
           match
             ( config
               |. Vscode.WorkspaceConfiguration.get "packageManager"
               |> Js.Nullable.toOption
             , config
               |. Vscode.WorkspaceConfiguration.get "toolChainRoot"
               |> Js.Nullable.toOption )
           with
           | Some name, Some root ->
             PackageManager.specOfName ~env ~name ~root:(Fpath.ofString root)
               ~discoveredManifestPath:projectRoot
           | Some name, None ->
             PackageManager.specOfName ~env ~name ~root:projectRoot
               ~discoveredManifestPath:projectRoot
           | _ ->
             Js.log multipleChoices;
             (Window.showQuickPick
                ( multipleChoices
                |> List.map (fun (pm, _) -> PackageManager.toName pm)
                |> Array.of_list )
                (Window.QuickPickOptions.make ~canPickMany:false
                   ~placeHolder:
                     "Which package manager would you like to manage the \
                      toolchain?"
                   ()) [@bs])
             |> Js.Promise.then_ (fun packageManager ->
                    match Js.Nullable.toOption packageManager with
                    | None ->
                      Js.Promise.resolve
                        (Error "showQuickPick() returned undefined")
                    | Some packageManager ->
                      Vscode.WorkspaceConfiguration.update config
                        "packageManager" packageManager 2
                      (* Workspace *)
                      |> Js.Promise.then_ (fun _ ->
                             let pm = PackageManager.ofName packageManager in
                             match pm with
                             | Ok pmx -> (
                               match
                                 List.find_opt
                                   (fun (pmy, _toolChainRoot) -> pmy = pmx)
                                   multipleChoices
                               with
                               | None ->
                                 Js.Promise.resolve
                                   (Error
                                      "Weird invalid state: selected choice \
                                       was not found in the list")
                               | Some (pm, toolChainRoot) ->
                                 PackageManager.make ~env ~t:pm
                                   ~root:toolChainRoot
                                   ~discoveredManifestPath:projectRoot )
                             | Error msg -> Js.Promise.resolve (Error msg))) ))
  |> okThen (fun spec -> Ok { spec; projectRoot })

let setup { spec; projectRoot } =
  PackageManager.setupToolChain spec
  |> Js.Promise.then_ (function
       | Error msg -> Error msg |> Js.Promise.resolve
       | Ok () -> PackageManager.env spec)
  |> Js.Promise.then_ (function
       | Ok env -> Cmd.make ~cmd:"ocamllsp" ~env
       | Error e -> e |> R.fail |> Js.Promise.resolve)
  |> Js.Promise.then_ (fun r ->
         let r =
           match r with
           | Ok _ -> Ok ({ spec; projectRoot } : t)
           | Error msg -> Error {j| Toolchain initialisation failed: $msg |j}
         in
         Js.Promise.resolve r)

let lsp (t : t) = PackageManager.lsp t.spec
