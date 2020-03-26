open Bindings
open Utils
module P = Promise
module WorkspaceCfg = Vscode.WorkspaceConfiguration

module Binaries = struct
  let esy = "esy"

  let opam = "opam"
end

(* Terminology:
   - PackageManager: represents supported package managers
     with Global as the fallback
   - projectRoot is different from PackageManager root (Eg. Opam
     (Fpath.ofString "/foo/bar")). Project root
     is the directory where manifest file (opam/esy.json/package.json)
     was found. PackageManager root is the directory that contains the
     manifest file responsible for setting up the toolchain - the two
     are same for Esy and Opam project but different for
     bucklescript. Bucklescript projects have this manifest file
     abstracted away from the user (atleast at the moment)
   - Manifest: abstracts functions handling manifest files
     of the supported package managers *)

module PackageManager : sig
  (** Represents a given package manager that would install the toolchain *)
  type t =
    | Opam of Fpath.t
    | Esy of Fpath.t
    | Global

  val toName : t -> string

  val ofName : root:Fpath.t -> string -> t option

  (** Converts to a readable string representation (useful for loggers etc) *)
  val toString : t -> string

  (** Converts to a valid command name available on the system shell *)
  val toCmdString : t -> string

  (** comparision function to assist set operations *)
  val compare : t -> t -> int

  (** find returns a supported package manager from a given list keeping in my
      Global is a fallback toolchain manager and not exactly a valid package
      manager (hence the exclusion). TODO: rename this to something that make
      this behaviour evident *)
  val findByName : string -> t list -> t option

  val makeEsy : Fpath.t -> t

  val makeOpam : Fpath.t -> t
end = struct
  type t =
    | Opam of Fpath.t
    | Esy of Fpath.t
    | Global

  let toName = function
    | Opam _ -> Binaries.opam
    | Esy _ -> Binaries.esy
    | Global -> "global"

  let ofName ~root = function
    | "opam" -> Some (Opam root)
    | "esy" -> Some (Esy root)
    | "global" -> Some Global
    | _ -> None

  let toString = function
    | Esy root -> Printf.sprintf "esy(%s)" (Fpath.toString root)
    | Opam root -> Printf.sprintf "opam(%s)" (Fpath.toString root)
    | Global -> "global"

  let toCmdString = function
    | Opam _ -> "opam"
    | Esy _ -> "esy"
    | Global -> "bash"

  let compare x y =
    match (x, y) with
    | Esy root1, Esy root2 -> Fpath.compare root1 root2
    | Opam root1, Opam root2 -> Fpath.compare root1 root2
    | Global, Global -> 0
    | Opam _, Esy _ -> -1
    | Esy _, Opam _ -> 1
    | Esy _, Global -> -1
    | Opam _, Global -> -1
    | Global, _ -> 1

  let rec findByName name = function
    | [] -> None
    | x :: xs -> (
      match x with
      | Global -> None
      | Esy root
      | Opam root -> (
        match ofName ~root name with
        | Some y ->
          if compare x y = 0 then
            Some x
          else
            findByName name xs
        | None -> None ) )

  let makeEsy root = Esy root

  let makeOpam root = Opam root
end

module PackageManagerSet : sig
  include Set.S with type elt = PackageManager.t
end =
  Set.Make (PackageManager)

let packageManagerSetOfResultList ~debugMsg lst =
  Js.Console.info debugMsg;
  match lst with
  | Ok lst ->
    List.iter (fun x -> x |> PackageManager.toString |> Js.Console.info) lst;
    lst |> PackageManagerSet.of_list
  | Error msg ->
    Js.Console.error2
      (Printf.sprintf "Error during extracting %s", debugMsg)
      msg;
    PackageManagerSet.empty

type resources =
  { cmd : Cmd.t
  ; kind : PackageManager.t
  ; projectRoot : Fpath.t
  }

let makeResources ~env ~kind ~projectRoot =
  Cmd.make ~env ~cmd:(PackageManager.toCmdString kind)
  |> P.then_ (function
       | Error msg -> Error msg |> P.resolve
       | Ok cmd -> Ok { cmd; kind; projectRoot } |> P.resolve)

let ofPackageManagerName ~env ~name ~projectRoot ~toolchainRoot =
  match PackageManager.ofName ~root:toolchainRoot name with
  | Some kind -> makeResources ~env ~kind ~projectRoot
  | None -> Error ("Invalid package manager name: " ^ name) |> P.resolve

let parseOpamEnvOutput opamEnvOutput =
  opamEnvOutput |> Js.String.split "\n"
  |. Belt.Array.keepMap (fun r ->
         match r |> Js.String.split "=" |> Array.to_list with
         | [ k; v ] -> Some (k, v)
         | [] ->
           (* TODO Environment entries are not necessarily key value pairs *)
           Js.Console.info "Splitting on '=' in env output failed";
           None
         | l ->
           Js.Console.info2
             "Splitting on '=' in env output returned more than two items: "
             (l |> Array.of_list |> Js.Array.joinWith ",");
           None)
  |> Js.Dict.fromArray |> Result.return |> P.resolve

let env ~cmd ~kind =
  match kind with
  | PackageManager.Global -> Ok Process.env |> P.resolve
  | Esy root ->
    Cmd.output cmd
      ~args:[| "command-env"; "--json"; "-P"; Fpath.toString root |]
      ~cwd:(Fpath.toString root)
    |> P.mapOk (fun stdout ->
           match Json.parse stdout with
           | Some json ->
             json
             |> Json.Decode.dict Json.Decode.string
             |> Result.return |> P.resolve
           | None ->
             Error ("'esy command-env' returned non-json output: " ^ stdout)
             |> P.resolve)
  | Opam root ->
    Cmd.output cmd ~args:[| "exec"; "env" |] ~cwd:(Fpath.toString root)
    |> P.mapOk parseOpamEnvOutput

let supportedPackageManagers ~env ~root =
  let supportedPackageManagers =
    [ PackageManager.Esy root; Esy Fpath.(root / ".vscode" / "esy"); Opam root ]
  in
  supportedPackageManagers
  |> List.map (fun packageManager ->
         Cmd.make ~env ~cmd:(PackageManager.toName packageManager)
         |> P.then_ (function
              | Error _ -> None |> P.resolve
              | Ok _ -> Some packageManager |> P.resolve))
  |> Array.of_list |> P.all
  |> P.then_ (fun results ->
         results
         |. Belt.Array.keepMap (fun pm -> pm)
         |> Array.to_list |> Result.return |> P.resolve)

let packageManagersListOfLookup = function
  | [] -> Error "TODO: global toolchain"
  | pms ->
    Ok
      (List.map
         (function
           | Manifest.Opam root -> PackageManager.makeOpam root
           | Esy root -> PackageManager.makeEsy root)
         pms)

let selectPackageManager ~config choices =
  let placeHolder =
    "Which package manager would you like to manage the toolchain?"
  in
  Window.QuickPickOptions.make ~canPickMany:false ~placeHolder ()
  |> Window.showQuickPick
       (choices |> List.map PackageManager.toName |> Array.of_list)
  |> P.then_ (function
       | None -> Error "showQuickPick() returned undefined" |> P.resolve
       | Some packageManagerName ->
         WorkspaceCfg.update config "packageManager" packageManagerName
           (WorkspaceCfg.configurationTargetToJs Workspace)
         |> P.then_ (fun _ ->
                match PackageManager.findByName packageManagerName choices with
                | None ->
                  Error "Selected choice was not found in the list" |> P.resolve
                | Some pm -> Ok pm |> P.resolve))

let init ~env ~folder =
  let projectRoot = Fpath.ofString folder in
  P.all2
    ( supportedPackageManagers ~root:projectRoot ~env
    , Manifest.lookup projectRoot
      |> P.mapOk (fun r -> packageManagersListOfLookup r |> P.resolve) )
  |> P.then_ (fun (supportedPackageManagers, detectedPackageManagers) ->
         let supportedPackageManagers =
           packageManagerSetOfResultList ~debugMsg:"supported package managers"
             supportedPackageManagers
         in
         let detectedPackageManagers =
           packageManagerSetOfResultList
             ~debugMsg:"possibly used package managers" detectedPackageManagers
         in
         match
           PackageManagerSet.inter supportedPackageManagers
             detectedPackageManagers
           |> PackageManagerSet.elements
         with
         | [] -> (
           Js.Console.info "Will lookup toolchain from global env";
           let global = "global" in
           match PackageManager.ofName ~root:projectRoot global with
           | Some kind -> makeResources ~env ~kind ~projectRoot
           | None ->
             Error
               {j| Unexplained exception: PackageManager.ofName returned None for a valid name $global |j}
             |> P.resolve )
         | [ packageManager ] ->
           Js.Console.info2 "Toolchain detected"
             (PackageManager.toString packageManager);
           makeResources ~env ~kind:packageManager ~projectRoot
         | packageManagers -> (
           let config = Vscode.Workspace.getConfiguration "ocaml" in
           match
             ( Vscode.WorkspaceConfiguration.get config "packageManager"
             , Vscode.WorkspaceConfiguration.get config "toolChainRoot" )
           with
           | Some name, Some root ->
             ofPackageManagerName ~env ~name ~projectRoot
               ~toolchainRoot:(Fpath.ofString root)
           | Some name, None ->
             ofPackageManagerName ~env ~name ~toolchainRoot:projectRoot
               ~projectRoot
           | None, Some _
           | None, None ->
             selectPackageManager ~config packageManagers
             |> P.then_ (function
                  | Error e -> Error e |> P.resolve
                  | Ok pm -> makeResources ~env ~kind:pm ~projectRoot) ))

let promptSetup fn =
  Window.showQuickPick [| "yes"; "no" |]
    (Window.QuickPickOptions.make ~canPickMany:false
       ~placeHolder:{j|Setup this project's toolchain with 'esy'?|j} ())
  |> P.then_ (function
       | Some choice when choice = "yes" -> fn ()
       | Some _
       | None ->
         Error "Please setup the toolchain" |> P.resolve)

let setupWithProgressIndicator fn =
  Window.withProgress
    [%bs.obj
      { location = Window.locationToJs Window.Notification
      ; title = "Setting up toolchain..."
      }]
    fn

let setupEsy ~cmd ~root =
  setupWithProgressIndicator (fun progress ->
      (progress.report [%bs.obj { increment = int_of_float 1. }] [@bs]);
      Cmd.output cmd ~cwd:(root |> Fpath.toString) ~args:[||]
      |> P.then_ (fun _ ->
             (progress.report [%bs.obj { increment = int_of_float 100. }] [@bs]);
             Ok () |> P.resolve))

let setupBsb ~cmd ~envWithUnzip:esyEnv folder =
  setupWithProgressIndicator (fun progress ->
      let succeeded = ref (Ok ()) in
      let eventEmitter = Setup.Bsb.make () in
      Setup.Bsb.onProgress eventEmitter (fun percent ->
          Js.Console.info2 "Percentage:" percent;
          (progress.report
             [%bs.obj { increment = int_of_float (percent *. 100.) }] [@bs]));
      Setup.Bsb.onEnd eventEmitter (fun () ->
          (progress.report [%bs.obj { increment = 100 }] [@bs]));
      Setup.Bsb.onError eventEmitter (fun errorMsg ->
          succeeded := Error errorMsg);
      Setup.Bsb.run cmd esyEnv eventEmitter folder
      |> P.then_ (fun () -> P.resolve !succeeded))

type esyProjectState =
  | Ready
  | PendingEsy
  | PendingBsb

let esyProjectState ~cmd ~root ~projectRoot =
  let rootStr = Fpath.toString root in
  Cmd.output cmd ~args:[| "status"; "-P"; rootStr |] ~cwd:rootStr
  |> P.then_ (function
       | Error _ -> Ok false |> P.resolve
       | Ok esyOutput -> (
         match Json.parse esyOutput with
         | None -> Ok false |> P.resolve
         | Some esyResponse ->
           esyResponse
           |> Json.Decode.field "isProjectReadyForDev" Json.Decode.bool
           |> Result.return |> P.resolve ))
  |> P.then_ (function
       | Error e -> Error e |> P.resolve
       | Ok isProjectReadyForDev ->
         let state =
           if isProjectReadyForDev then
             Ready
           else if Fpath.compare root projectRoot = 0 then
             PendingEsy
           else
             PendingBsb
         in
         Ok state |> P.resolve)

let setupToolChain { cmd; kind; projectRoot } =
  match kind with
  | Global -> Ok () |> P.resolve
  | Opam _ -> Ok () |> P.resolve
  | Esy root ->
    esyProjectState ~cmd ~root ~projectRoot
    |> P.then_ (function
         | Error e -> Error e |> P.resolve
         | Ok Ready -> Ok () |> P.resolve
         | Ok PendingEsy -> promptSetup (fun () -> setupEsy ~cmd ~root)
         | Ok PendingBsb ->
           setupBsb ~cmd ~envWithUnzip:Process.env (Fpath.toString root))

let runSetup ({ cmd; kind; _ } as resources) =
  setupToolChain resources
  |> P.then_ (function
       | Error msg -> Error msg |> P.resolve
       | Ok () -> env ~cmd ~kind)
  |> P.then_ (function
       (* This function/callback here is a temporary way to check ocamllsp if
          installed after setupToolChain completes. TODO: move it inside
          setupToolChain itself *)
       | Error e -> Error e |> P.resolve
       | Ok env -> Cmd.make ~cmd:"ocamllsp" ~env)
  |> P.then_ (fun r ->
         let r =
           match r with
           | Ok _ -> Ok ()
           | Error msg -> Error {j| Toolchain initialisation failed: $msg |j}
         in
         P.resolve r)

let getLspCommand { kind; cmd; _ } =
  match kind with
  | Opam _ -> (Cmd.binPath cmd, [| "exec"; "ocamllsp" |])
  | Esy root -> (Cmd.binPath cmd, [| "-P"; Fpath.toString root; "ocamllsp" |])
  | Global -> ("ocamllsp", [||])
