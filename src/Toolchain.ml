open Bindings
open Utils
module R = Result
module P = Js.Promise

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
  type t

  type spec

  val ofName : Fpath.t -> string -> (t, string) result

  val toName : t -> string

  val toString : t -> string

  val specOfName :
       env:string Js.Dict.t
    -> name:string
    -> root:Fpath.t
    -> (spec, string) result P.t

  val makeSpec : env:string Js.Dict.t -> kind:t -> (spec, string) result P.t

  val setupToolChain : Fpath.t -> spec -> (unit, string) result P.t

  val available :
    env:string Js.Dict.t -> root:Fpath.t -> (t list, string) result P.t

  val env : spec -> (string Js.Dict.t, string) result P.t

  val lsp : spec -> commandAndArgs

  val compare : t -> t -> int

  val find : string -> t list -> t option

  val esy : Fpath.t -> t

  val opam : Fpath.t -> t
end = struct
  type t =
    | Opam of Fpath.t
    | Esy of Fpath.t
    | Global

  type spec =
    { cmd : Cmd.t
    ; kind : t
    }

  let esy root = Esy root

  let opam root = Opam root

  let makeSpec ~env ~kind =
    match kind with
    | Opam root ->
      Cmd.make ~cmd:"opam" ~env
      |> P.then_ (function
           | Error msg -> P.resolve (Error msg)
           | Ok cmd -> Ok { cmd; kind = Opam root } |> P.resolve)
    | Esy root ->
      Cmd.make ~cmd:"esy" ~env
      |> P.then_ (function
           | Error msg -> P.resolve (Error msg)
           | Ok cmd -> Ok { cmd; kind = Esy root } |> P.resolve)
    | Global ->
      Cmd.make ~env ~cmd:"bash"
      |> P.then_ (function
           | Ok cmd -> Ok { cmd; kind = Global } |> P.resolve
           | Error msg -> Error msg |> P.resolve)

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

  let specOfName ~env ~name ~root =
    match name with
    | x when x = Binaries.opam -> makeSpec ~env ~kind:(opam root)
    | x when x = Binaries.esy -> makeSpec ~env ~kind:(esy root)
    | x -> "Invalid package manager name: " ^ x |> R.fail |> P.resolve

  let available ~env ~root =
    let supportedPackageManagers =
      [ Esy root; Esy Fpath.(root / ".vscode" / "esy"); Opam root ]
    in
    supportedPackageManagers
    |> List.map (fun (pm : t) ->
           let name = toName pm in
           Cmd.make ~env ~cmd:name
           |> P.then_ (function
                | Ok _ -> (pm, true) |> P.resolve
                | Error _ -> (pm, false) |> P.resolve))
    |> Array.of_list |> P.all
    |> P.then_ (fun r ->
           Js.Array.filter (fun (_pm, available) -> available) r
           |> Array.map (fun (pm, _used) -> pm)
           |> Array.to_list |> R.return |> P.resolve)

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

  let lsp spec =
    let { cmd; kind } = spec in
    match kind with
    | Opam _ -> (Cmd.binPath cmd, [| "exec"; "ocamllsp" |])
    | Esy root -> (Cmd.binPath cmd, [| "-P"; Fpath.toString root; "ocamllsp" |])
    | Global -> ("ocamllsp", [||])

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
      | Esy root -> (
        match ofName root name with
        | Ok y ->
          if compare x y = 0 then
            Some x
          else
            find name xs
        | Error _ -> None )
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
  include Set.S with type elt = PackageManager.t
end =
  Set.Make (PackageManager)

module Manifest : sig
  val lookup : Fpath.t -> (PackageManagerSet.t, string) result P.t
end = struct
  let parse projectRoot = function
    | "esy.json" -> Some (PackageManager.esy projectRoot) |> P.resolve
    | "opam" ->
      Fs.stat
        (let open Fpath in
        projectRoot / "opam" |> toString)
      |> P.then_ (fun r ->
             let r =
               match r with
               | Error _ -> None
               | Ok stats -> (
                 match Fs.Stat.isDirectory stats with
                 | true -> None
                 | false -> Some (PackageManager.opam projectRoot) )
             in
             P.resolve r)
    | "package.json" ->
      let manifestFile =
        (let open Fpath in
        projectRoot / "package.json")
        |> Fpath.show
      in
      Fs.readFile manifestFile
      |> P.then_ (fun manifest ->
             match Json.parse manifest with
             | None -> None |> P.resolve
             | Some json ->
               if
                 Utils.propertyExists json "dependencies"
                 || Utils.propertyExists json "devDependencies"
               then
                 if Utils.propertyExists json "esy" then
                   Some (PackageManager.esy projectRoot) |> P.resolve
                 else
                   Some
                     (PackageManager.esy
                        Fpath.(projectRoot / ".vscode" / "esy"))
                   |> P.resolve
               else
                 None |> P.resolve)
    | file -> (
      let manifestFile =
        (let open Fpath in
        projectRoot / file)
        |> Fpath.show
      in
      match Path.extname file with
      | ".json" ->
        Fs.readFile manifestFile
        |> P.then_ (fun manifest ->
               match Json.parse manifest with
               | Some json ->
                 if
                   Utils.propertyExists json "dependencies"
                   || Utils.propertyExists json "devDependencies"
                 then
                   Some (PackageManager.esy projectRoot) |> P.resolve
                 else
                   None |> P.resolve
               | None ->
                 Js.log3 "Invalid JSON file found. Ignoring..." manifest
                   manifestFile;
                 None |> P.resolve)
      | ".opam" ->
        Fs.readFile manifestFile
        |> P.then_ (function
             | "" -> None |> P.resolve
             | _ -> Some (PackageManager.opam projectRoot) |> P.resolve)
      | _ -> None |> P.resolve )

  let lookup projectRoot =
    Fs.readDir (Fpath.toString projectRoot)
    |> P.then_ (function
         | Error msg -> P.resolve (Error msg)
         | Ok files ->
           files
           |> Js.Array.map (parse projectRoot)
           |> P.all
           |> P.then_ (fun l ->
                  Ok
                    ( Js.Array.reduce
                        (fun acc x ->
                          Js.Array.concat acc
                            ( match x with
                            | Some x -> Array.of_list [ x ]
                            | None -> [||] ))
                        [||] l
                    |> Array.to_list |> PackageManagerSet.of_list )
                  |> P.resolve))
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
  P.all2
    ( PackageManager.available ~root:projectRoot ~env
    , Manifest.lookup projectRoot
      |> okThen (fun pms ->
             if pms = PackageManagerSet.empty then
               Error "TODO: global toolchain"
             else
               Ok pms) )
  |> P.then_ (fun (availablePackageManagers, alreadyUsedPackageManagers) ->
         let availablePackageManagers =
           match availablePackageManagers with
           | Ok x -> x |> PackageManagerSet.of_list
           | Error msg ->
             Js.log2 "Error during availablePackageManagers()" msg;
             PackageManagerSet.empty
         in
         let alreadyUsedPackageManagers =
           match alreadyUsedPackageManagers with
           | Ok x -> x
           | Error msg ->
             Js.log2 "Error during alreadyUsedPackageManagers()" msg;
             PackageManagerSet.empty
         in
         Js.log "availablePackageManagers";
         PackageManagerSet.iter
           (fun x -> x |> PackageManager.toString |> Js.log)
           availablePackageManagers;
         Js.log "possiblyUsed";
         PackageManagerSet.iter
           (fun x -> x |> PackageManager.toString |> Js.log)
           alreadyUsedPackageManagers;
         match
           PackageManagerSet.inter availablePackageManagers
             alreadyUsedPackageManagers
           |> PackageManagerSet.elements
         with
         | [] -> (
           Js.log "Will lookup toolchain from global env";
           match PackageManager.ofName projectRoot "<global>" with
           | Ok kind -> PackageManager.makeSpec ~env ~kind
           | Error msg -> Error msg |> P.resolve )
         | [ obviousChoice ] ->
           Js.log2 "Toolchain detected" (PackageManager.toString obviousChoice);
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
           | _ ->
             Window.showQuickPick
               ( multipleChoices
               |> List.map (fun pm -> PackageManager.toName pm)
               |> Array.of_list )
               (Window.QuickPickOptions.make ~canPickMany:false
                  ~placeHolder:
                    "Which package manager would you like to manage the \
                     toolchain?"
                  ())
             |> P.then_ (function
                  | None ->
                    P.resolve (Error "showQuickPick() returned undefined")
                  | Some packageManager ->
                    let open Vscode.WorkspaceConfiguration in
                    update config "packageManager" packageManager
                      (configurationTargetToJs Workspace)
                    (* Workspace *)
                    |> P.then_ (fun _ ->
                           match
                             PackageManager.find packageManager multipleChoices
                           with
                           | Some pm -> PackageManager.makeSpec ~env ~kind:pm
                           | None ->
                             P.resolve
                               (Error
                                  "Weird invalid state: selected choice was \
                                   not found in the list"))) ))
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
           | Ok _ -> Ok ({ spec; projectRoot } : t)
           | Error msg -> Error {j| Toolchain initialisation failed: $msg |j}
         in
         P.resolve r)

let lsp (t : t) = PackageManager.lsp t.spec
