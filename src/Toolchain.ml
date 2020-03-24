open Bindings
open Utils
module R = Result
module P = Js.Promise
module WorkspaceCfg = Vscode.WorkspaceConfiguration

type packageManager =
  | Opam of Fpath.t
  | Esy of Fpath.t
  | Global

type spec =
  { cmd : Cmd.t
  ; kind : packageManager
  }

type commandAndArgs = string * string array

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
          Js.log2 "Percentage:" percent;
          (progress.report
             [%bs.obj { increment = int_of_float (percent *. 100.) }] [@bs]));
      onEnd eventEmitter (fun () ->
          (progress.report [%bs.obj { increment = 100 }] [@bs]));
      onError eventEmitter (fun errorMsg -> succeeded := Error errorMsg);
      run esyCmd esyEnv eventEmitter folder
      |> P.then_ (fun () -> P.resolve !succeeded))

module Binaries = struct
  let esy = "esy"

  let opam = "opam"
end

module PackageManager : sig
  val ofName : Fpath.t -> string -> (packageManager, string) result

  val toName : packageManager -> string

  val toString : packageManager -> string

  val specOfName :
       env:string Js.Dict.t
    -> name:string
    -> root:Fpath.t
    -> (spec, string) result P.t

  val makeSpec :
    env:string Js.Dict.t -> kind:packageManager -> (spec, string) result P.t

  val setupToolChain : Fpath.t -> spec -> (unit, string) result P.t

  val env : spec -> (string Js.Dict.t, string) result P.t

  val find : string -> packageManager list -> packageManager option

  val esy : Fpath.t -> packageManager

  val opam : Fpath.t -> packageManager
end = struct
  let esy root = Esy root

  let opam root = Opam root

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

  let makeSpec ~env ~kind =
    Cmd.make ~env ~cmd:(toCmdString kind)
    |> P.then_ (function
         | Error msg -> P.resolve (Error msg)
         | Ok cmd -> P.resolve (Ok { cmd; kind }))

  let specOfName ~env ~name ~root =
    match name with
    | x when x = Binaries.opam -> makeSpec ~env ~kind:(opam root)
    | x when x = Binaries.esy -> makeSpec ~env ~kind:(esy root)
    | x -> "Invalid package manager name: " ^ x |> R.fail |> P.resolve

  let env spec =
    let { cmd; kind } = spec in
    match kind with
    | Global -> Process.env |> R.return |> P.resolve
    | Esy root ->
      Cmd.output cmd
        ~args:[| "command-env"; "--json"; "-P"; Fpath.toString root |]
        ~cwd:(Fpath.toString root)
      |> okThen (fun stdout ->
             match Json.parse stdout with
             | Some json ->
               json |> Json.Decode.dict Json.Decode.string |> R.return
             | None ->
               Error ("'esy command-env' returned non-json output: " ^ stdout))
    | Opam root ->
      Cmd.output cmd ~args:[| "exec"; "env" |] ~cwd:(Fpath.toString root)
      |> okThen (fun stdout ->
             stdout |> Js.String.split "\n"
             |> Js.Array.map (fun x -> Js.String.split "=" x)
             |> Js.Array.map (fun r ->
                    match Array.to_list r with
                    | [] ->
                      (* TODO Environment entries are not necessarily key value
                         pairs *)
                      Error "Splitting on '=' in env output failed"
                    | [ k; v ] -> Ok (k, v)
                    | l ->
                      Js.log l;
                      Error
                        "Splitting on '=' in env output returned more than two \
                         items")
             |> Js.Array.reduce
                  (fun acc kv ->
                    match kv with
                    | Ok kv -> kv :: acc
                    | Error msg ->
                      Js.log msg;
                      acc)
                  []
             |> Js.Dict.fromList |> R.return)

  let setupToolChain workspaceRoot spec =
    let { cmd; kind } = spec in
    match kind with
    | Global -> Ok () |> P.resolve
    | Esy root ->
      let rootStr = root |> Fpath.toString in
      Cmd.output cmd ~args:[| "status"; "-P"; rootStr |] ~cwd:rootStr
      |> P.then_ (fun r ->
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
             P.resolve r)
      |> P.then_ (function
           | Error e -> e |> R.fail |> P.resolve
           | Ok isProjectReadyForDev ->
             if isProjectReadyForDev then
               () |> R.return |> P.resolve
             else if Fpath.compare root workspaceRoot = 0 then (
               Js.log "esy project";
               promptSetup ~f:(fun () ->
                   Window.withProgress
                     [%bs.obj
                       { location = Window.locationToJs Window.Notification
                       ; title = "Setting up toolchain..."
                       }]
                     (fun progress ->
                       (progress.report
                          [%bs.obj { increment = int_of_float 1. }] [@bs]);
                       Cmd.output cmd ~cwd:(root |> Fpath.toString) ~args:[||]
                       |> P.then_ (fun _ ->
                              (progress.report
                                 [%bs.obj { increment = int_of_float 100. }]
                               [@bs]);
                              P.resolve (Ok ()))))
             ) else (
               Js.log "bsb project";
               setupWithProgressIndicator cmd ~envWithUnzip:Process.env
                 (root |> Fpath.toString)
             ))
    | Opam _ -> P.resolve (Ok ())

  (* TODO: relies on compare *)
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
end

module PackageManagerSet : sig
  include Set.S with type elt = packageManager
end = Set.Make (struct
  type t = packageManager

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
end)

let supportedPackageManagers ~env ~root =
  let supportedPackageManagers =
    [ Esy root; Esy Fpath.(root / ".vscode" / "esy"); Opam root ]
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
         |> Array.to_list |> R.return |> P.resolve)

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
           | `Opam root -> PackageManager.opam root
           | `Esy root -> PackageManager.esy root)
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
           | Ok kind -> PackageManager.makeSpec ~env ~kind
           | Error msg -> Error msg |> P.resolve )
         | [ obviousChoice ] ->
           Js.Console.info2 "Toolchain detected"
             (PackageManager.toString obviousChoice);
           PackageManager.makeSpec ~env ~kind:obviousChoice
         | multipleChoices -> (
           let config = Vscode.Workspace.getConfiguration "ocaml" in
           match
             ( config |. Vscode.WorkspaceConfiguration.get "packageManager"
             , config |. Vscode.WorkspaceConfiguration.get "toolChainRoot" )
           with
           | Some name, Some root ->
             PackageManager.specOfName ~env ~name ~root:(Fpath.ofString root)
           | Some name, None ->
             PackageManager.specOfName ~env ~name ~root:projectRoot
           | None, Some _
           | None, None ->
             selectPackageManager ~config multipleChoices
             |> P.then_ (function
                  | Error e -> Error e |> P.resolve
                  | Ok pm -> PackageManager.makeSpec ~env ~kind:pm) ))
  |> okThen (fun spec -> Ok { spec; projectRoot })

let setup { spec; projectRoot } =
  PackageManager.setupToolChain projectRoot spec
  |> P.then_ (function
       | Error msg -> Error msg |> P.resolve
       | Ok () -> PackageManager.env spec)
  |> P.then_ (function
       | Ok env -> Cmd.make ~cmd:"ocamllsp" ~env
       | Error e -> e |> R.fail |> P.resolve)
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
