open Bindings
open Utils
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

  let findByName name xs =
    Utils.List.find_map xs ~f:(function
      | Global -> None
      | s ->
        if toName s = name then
          Some s
        else
          None)

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
  |> Promise.map (function
       | Error msg -> Error msg
       | Ok cmd -> Ok { cmd; kind; projectRoot })

let ofPackageManagerName ~env ~name ~projectRoot ~toolchainRoot =
  match PackageManager.ofName ~root:toolchainRoot name with
  | Some kind -> makeResources ~env ~kind ~projectRoot
  | None -> Error ("Invalid package manager name: " ^ name) |> Promise.resolve

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
  |> Js.Dict.fromArray |> Result.return |> Promise.resolve

let env ~cmd ~kind =
  match kind with
  | PackageManager.Global -> Ok Process.env |> Promise.resolve
  | Esy root ->
    Cmd.output cmd
      ~args:[| "command-env"; "--json"; "-P"; Fpath.toString root |]
      ~cwd:(Fpath.toString root)
    |> Promise.Result.bind (fun stdout ->
           match Json.parse stdout with
           | Some json ->
             json
             |> Json.Decode.dict Json.Decode.string
             |> Result.return |> Promise.resolve
           | None ->
             Error ("'esy command-env' returned non-json output: " ^ stdout)
             |> Promise.resolve)
  | Opam root ->
    Cmd.output cmd ~args:[| "exec"; "env" |] ~cwd:(Fpath.toString root)
    |> Promise.Result.bind parseOpamEnvOutput

let supportedPackageManagers ~env ~root =
  let supportedPackageManagers =
    [ PackageManager.Esy root; Esy (hiddenEsyDir root); Opam root ]
  in
  supportedPackageManagers
  |> List.map (fun packageManager ->
         Cmd.make ~env ~cmd:(PackageManager.toName packageManager)
         |> Promise.map (function
              | Error _ -> None
              | Ok _ -> Some packageManager))
  |> Array.of_list |> Promise.all
  |> Promise.map (fun results ->
         results
         |. Belt.Array.keepMap (fun pm -> pm)
         |> Array.to_list |> Result.return)

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
  |> Promise.then_ (function
       | None -> Error "showQuickPick() returned undefined" |> Promise.resolve
       | Some packageManagerName ->
         WorkspaceCfg.update config "packageManager" packageManagerName
           (WorkspaceCfg.configurationTargetToJs Workspace)
         |> Promise.map (fun _ ->
                match PackageManager.findByName packageManagerName choices with
                | None -> Error "Selected choice was not found in the list"
                | Some pm -> Ok pm))

let init ~env ~folder =
  let projectRoot = Fpath.ofString folder in
  Promise.all2
    ( supportedPackageManagers ~root:projectRoot ~env
    , Manifest.lookup projectRoot
      |> Promise.Result.bind (fun r ->
             packageManagersListOfLookup r |> Promise.resolve) )
  |> Promise.then_ (fun (supportedPackageManagers, detectedPackageManagers) ->
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
             |> Promise.resolve )
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
             |> Promise.then_ (function
                  | Error e -> Error e |> Promise.resolve
                  | Ok pm -> makeResources ~env ~kind:pm ~projectRoot) ))

let promptSetup fn =
  Window.showQuickPick [| "yes"; "no" |]
    (Window.QuickPickOptions.make ~canPickMany:false
       ~placeHolder:{j|Setup this project's toolchain with 'esy'?|j} ())
  |> Promise.then_ (function
       | Some choice when choice = "yes" -> fn ()
       | Some _
       | None ->
         Error "Please setup the toolchain" |> Promise.resolve)

let setupWithProgressIndicator fn =
  Window.withProgress
    [%bs.obj
      { location = Window.locationToJs Window.Notification
      ; title = "Setting up toolchain..."
      }]
    fn

let setupEsy ~cmd ~root =
  setupWithProgressIndicator (fun progress ->
      progress.report [%bs.obj { increment = int_of_float 1. }];
      Cmd.output cmd ~cwd:(root |> Fpath.toString) ~args:[||]
      |> Promise.map (fun _ ->
             progress.report [%bs.obj { increment = int_of_float 100. }];
             Ok ()))

let setupBsb ~cmd ~envWithUnzip:esyEnv folder =
  setupWithProgressIndicator (fun progress ->
      let succeeded = ref (Ok ()) in
      let eventEmitter = Setup.Bsb.make () in
      Setup.Bsb.onProgress eventEmitter (fun percent ->
          Js.Console.info2 "Percentage:" percent;
          progress.report
            [%bs.obj { increment = int_of_float (percent *. 100.) }]);
      Setup.Bsb.onEnd eventEmitter (fun () ->
          progress.report [%bs.obj { increment = 100 }]);
      Setup.Bsb.onError eventEmitter (fun errorMsg ->
          succeeded := Error errorMsg);
      Setup.Bsb.run cmd esyEnv eventEmitter folder
      |> Promise.map (fun () -> !succeeded))

type esyProjectState =
  | Ready
  | PendingEsy
  | PendingBsb

let esyProjectState ~cmd ~root ~projectRoot =
  let rootStr = Fpath.toString root in
  Cmd.output cmd ~args:[| "status"; "-P"; rootStr |] ~cwd:rootStr
  |> Promise.map (function
       | Error _ -> Ok false
       | Ok esyOutput -> (
         match Json.parse esyOutput with
         | None -> Ok false
         | Some esyResponse ->
           esyResponse
           |> Json.Decode.field "isProjectReadyForDev" Json.Decode.bool
           |> Result.return ))
  |> Promise.Result.map (fun isProjectReadyForDev ->
         if isProjectReadyForDev then
           Ready
         else if Fpath.compare root projectRoot = 0 then
           PendingEsy
         else
           PendingBsb)

let setupToolChain { cmd; kind; projectRoot } =
  match kind with
  | Global -> Ok () |> Promise.resolve
  | Opam _ -> Ok () |> Promise.resolve
  | Esy root ->
    esyProjectState ~cmd ~root ~projectRoot
    |> Promise.then_ (function
         | Error e -> Error e |> Promise.resolve
         | Ok Ready -> Ok () |> Promise.resolve
         | Ok PendingEsy -> promptSetup (fun () -> setupEsy ~cmd ~root)
         | Ok PendingBsb ->
           setupBsb ~cmd ~envWithUnzip:Process.env (Fpath.toString root))

let runSetup ({ cmd; kind; _ } as resources) =
  setupToolChain resources
  |> Promise.Result.bind (fun () -> env ~cmd ~kind)
  |> Promise.Result.bind (fun env ->
         (* This function/callback here is a temporary way to check ocamllsp if
            installed after setupToolChain completes. TODO: move it inside
            setupToolChain itself *)
         Cmd.make ~cmd:"ocamllsp" ~env)
  |> Promise.map (function
       | Ok _ -> Ok ()
       | Error msg -> Error {j| Toolchain initialisation failed: $msg |j})

let getLspCommand { kind; cmd; _ } =
  match kind with
  | Opam _ -> (Cmd.binPath cmd, [| "exec"; "ocamllsp" |])
  | Esy root -> (Cmd.binPath cmd, [| "-P"; Fpath.toString root; "ocamllsp" |])
  | Global -> ("ocamllsp", [||])
