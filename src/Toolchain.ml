open Bindings
open Utils
module P = Js.Promise
module WorkspaceCfg = Vscode.WorkspaceConfiguration

module Binaries = struct
  let esy = "esy"

  let opam = "opam"
end

module PackageManager = struct
  type t =
    | Opam of Fpath.t
    | Esy of Fpath.t
    | Global

  let toName = function
    | Opam _ -> Binaries.opam
    | Esy _ -> Binaries.esy
    | Global -> "global"

  let ofName root = function
    | "opam" -> Ok (Opam root)
    | "esy" -> Ok (Esy root)
    | "global" -> Ok Global
    | n -> Error {j|Invalid name $n was provided|j}

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

  let rec find name = function
  | [] -> None
  | x :: xs -> (
    match x with
    | Global -> None
    | Esy root
    | Opam root -> (
      match ofName root name with
      | Ok y ->
        if compare x y = 0 then
          Some x
        else
          find name xs
      | Error _ -> None ) )

  let makeEsy root = Esy root

  let makeOpam root = Opam root
end

module PackageManagerSet : sig
  include Set.S with type elt = PackageManager.t
end =
  Set.Make (PackageManager)

type spec =
  { cmd : Cmd.t
  ; kind : PackageManager.t
  }

let promptSetup ~f =
  Window.showQuickPick [| "yes"; "no" |]
    (Window.QuickPickOptions.make ~canPickMany:false
       ~placeHolder:{j|Setup this project's toolchain with 'esy'?|j} ())
  |> P.then_ (function
       | None -> P.resolve (Error "Please setup the toolchain")
       | Some choice when choice = "yes" -> f ()
       | Some _ -> P.resolve (Error "Please setup the toolchain"))

let setupWithProgressIndicator esyCmd ~envWithUnzip:esyEnv folder =
  let open Setup.Bsb in
  Window.withProgress
    [%bs.obj
      { location = Window.locationToJs Window.Notification
      ; title = "Setting up toolchain..."
      }]
    (fun progress ->
      let succeeded = ref (Ok ()) in
      let eventEmitter = make () in
      onProgress eventEmitter (fun percent ->
          Js.Console.info2 "Percentage:" percent;
          (progress.report
             [%bs.obj { increment = int_of_float (percent *. 100.) }] [@bs]));
      onEnd eventEmitter (fun () ->
          (progress.report [%bs.obj { increment = 100 }] [@bs]));
      onError eventEmitter (fun errorMsg -> succeeded := Error errorMsg);
      run esyCmd esyEnv eventEmitter folder
      |> P.then_ (fun () -> P.resolve !succeeded))

let makeSpec ~env ~kind =
  Cmd.make ~env ~cmd:(PackageManager.toCmdString kind)
  |> P.then_ (function
       | Error msg -> P.resolve (Error msg)
       | Ok cmd -> P.resolve (Ok { cmd; kind }))

let specOfName ~env ~name ~root =
  match name with
  | x when x = Binaries.opam -> makeSpec ~env ~kind:(PackageManager.makeOpam root)
  | x when x = Binaries.esy -> makeSpec ~env ~kind:(PackageManager.makeEsy root)
  | x -> Error ("Invalid package manager name: " ^ x) |> P.resolve

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
  |> Js.Dict.fromArray |> Result.return

let env spec =
  let { cmd; kind } = spec in
  match kind with
  | Global -> Ok Process.env |> P.resolve
  | Esy root ->
    Cmd.output cmd
      ~args:[| "command-env"; "--json"; "-P"; Fpath.toString root |]
      ~cwd:(Fpath.toString root)
    |> okThen (fun stdout ->
           match Json.parse stdout with
           | Some json ->
             json |> Json.Decode.dict Json.Decode.string |> Result.return
           | None ->
             Error ("'esy command-env' returned non-json output: " ^ stdout))
  | Opam root ->
    Cmd.output cmd ~args:[| "exec"; "env" |] ~cwd:(Fpath.toString root)
    |> okThen parseOpamEnvOutput

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

let makeSet ~debugMsg lst =
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
  { spec : spec
  ; projectRoot : Fpath.t
  }

let packageManagersListOfLookup = function
  | [] -> Error "TODO: global toolchain"
  | pms ->
    Ok
      (List.map
         (function
           | `Opam root -> PackageManager.makeOpam root
           | `Esy root -> PackageManager.makeEsy root)
         pms)

let selectPackageManager ~config choices =
  let placeHolder =
    "Which package manager would you like to manage the toolchain?"
  in
  Window.QuickPickOptions.make ~canPickMany:false ~placeHolder ()
  |> Window.showQuickPick
       (choices |> List.map PackageManager.toName |> Array.of_list)
  |> P.then_ (function
       | None -> P.resolve (Error "showQuickPick() returned undefined")
       | Some packageManager ->
         WorkspaceCfg.update config "packageManager" packageManager
           (WorkspaceCfg.configurationTargetToJs Workspace)
         |> P.then_ (fun _ ->
                match PackageManager.find packageManager choices with
                | None ->
                  Error "Selected choice was not found in the list" |> P.resolve
                | Some pm -> Ok pm |> P.resolve))

let init ~env ~folder =
  let projectRoot = Fpath.ofString folder in
  let usedPMs =
    Manifest.lookup projectRoot |> okThen packageManagersListOfLookup
  in
  P.all2 (supportedPackageManagers ~root:projectRoot ~env, usedPMs)
  |> P.then_ (fun (supportedPMs, usedPMs) ->
         let supportedPMs =
           makeSet ~debugMsg:"supported package managers" supportedPMs
         in
         let usedPMs =
           makeSet ~debugMsg:"possibly used package managers" usedPMs
         in
         match
           PackageManagerSet.inter supportedPMs usedPMs
           |> PackageManagerSet.elements
         with
         | [] -> (
           Js.Console.info "Will lookup toolchain from global env";
           match PackageManager.ofName projectRoot "<global>" with
           | Ok kind -> makeSpec ~env ~kind
           | Error msg -> Error msg |> P.resolve )
         | [ obviousChoice ] ->
           Js.Console.info2 "Toolchain detected"
             (PackageManager.toString obviousChoice);
           makeSpec ~env ~kind:obviousChoice
         | multipleChoices -> (
           let config = Vscode.Workspace.getConfiguration "ocaml" in
           match
             ( config |. Vscode.WorkspaceConfiguration.get "packageManager"
             , config |. Vscode.WorkspaceConfiguration.get "toolChainRoot" )
           with
           | Some name, Some root ->
             specOfName ~env ~name ~root:(Fpath.ofString root)
           | Some name, None -> specOfName ~env ~name ~root:projectRoot
           | None, Some _
           | None, None ->
             selectPackageManager ~config multipleChoices
             |> P.then_ (function
                  | Error e -> Error e |> P.resolve
                  | Ok pm -> makeSpec ~env ~kind:pm) ))
  |> okThen (fun spec -> Ok { spec; projectRoot })

let setupBsbWithPrompt ~cmd ~root =
  promptSetup ~f:(fun () ->
      Window.withProgress
        [%bs.obj
          { location = Window.locationToJs Window.Notification
          ; title = "Setting up toolchain..."
          }]
        (fun progress ->
          (progress.report [%bs.obj { increment = int_of_float 1. }] [@bs]);
          Cmd.output cmd ~cwd:(root |> Fpath.toString) ~args:[||]
          |> P.then_ (fun _ ->
                 (progress.report
                    [%bs.obj { increment = int_of_float 100. }] [@bs]);
                 P.resolve (Ok ()))))

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
             `Ready
           else if Fpath.compare root projectRoot <> 0 then
             `PendingEsy
           else
             `PendingBsb
         in
         Ok state |> P.resolve)

let setupToolChain projectRoot spec =
  let { cmd; kind } = spec in
  match kind with
  | Global -> Ok () |> P.resolve
  | Opam _ -> Ok () |> P.resolve
  | Esy root ->
    esyProjectState ~cmd ~root ~projectRoot
    |> P.then_ (function
         | Error e -> Error e |> P.resolve
         | Ok `Ready -> Ok () |> P.resolve
         | Ok `PendingEsy ->
           setupWithProgressIndicator cmd ~envWithUnzip:Process.env
             (Fpath.toString root)
         | Ok `PendingBsb -> setupBsbWithPrompt ~cmd ~root)

let setup { spec; projectRoot } =
  setupToolChain projectRoot spec
  |> P.then_ (function
       | Error msg -> Error msg |> P.resolve
       | Ok () -> env spec)
  |> P.then_ (function
       | Error e -> Error e |> P.resolve
       | Ok env -> Cmd.make ~cmd:"ocamllsp" ~env)
  |> P.then_ (fun r ->
         let r =
           match r with
           | Ok _ -> Ok ({ spec; projectRoot } : resources)
           | Error msg -> Error {j| Toolchain initialisation failed: $msg |j}
         in
         P.resolve r)

let getLspCommand { spec = { kind; cmd } } =
  match kind with
  | Opam _ -> (Cmd.binPath cmd, [| "exec"; "ocamllsp" |])
  | Esy root -> (Cmd.binPath cmd, [| "-P"; Fpath.toString root; "ocamllsp" |])
  | Global -> ("ocamllsp", [||])
