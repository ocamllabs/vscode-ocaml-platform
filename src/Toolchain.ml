open Bindings
open Utils
module R = Result

type commandAndArgs = string * string array

let promptSetup ~f =
  let open Js.Promise in
  Window.showQuickPick [| "yes"; "no" |]
    (Window.QuickPickOptions.make ~canPickMany:false
       ~placeHolder:{j|Setup this project's toolchain with 'esy'?|j} ())
  |> Js.Promise.then_ (function
       | None -> resolve (Error "Please setup the toolchain")
       | Some choice when choice = "yes" -> f ()
       | Some _ -> resolve (Error "Please setup the toolchain"))

let setupWithProgressIndicator esyCmd ~envWithUnzip:esyEnv folder =
  let open Setup.Bsb in
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
      run esyCmd esyEnv eventEmitter folder
      |> then_ (fun () -> resolve !succeeded))

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
    -> (spec, string) result Js.Promise.t

  val make : env:string Js.Dict.t -> t:t -> (spec, string) result Js.Promise.t

  val setupToolChain : Fpath.t -> spec -> (unit, string) result Js.Promise.t

  val available :
    env:string Js.Dict.t -> root:Fpath.t -> (t list, string) result Js.Promise.t

  val env : spec -> (string Js.Dict.t, string) result Js.Promise.t

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
    ; t : t
    }

  let esy root = Esy root

  let opam root = Opam root

  let make ~env ~t =
    match t with
    | Opam root ->
      Cmd.make ~cmd:"opam" ~env
      |> Js.Promise.then_ (function
           | Error msg -> Js.Promise.resolve (Error msg)
           | Ok cmd -> Ok { cmd; t = Opam root } |> Js.Promise.resolve)
    | Esy root ->
      Cmd.make ~cmd:"esy" ~env
      |> Js.Promise.then_ (function
           | Error msg -> Js.Promise.resolve (Error msg)
           | Ok cmd -> Ok { cmd; t = Esy root } |> Js.Promise.resolve)
    | Global ->
      Cmd.make ~env ~cmd:"bash"
      |> Js.Promise.then_ (function
           | Ok cmd -> Ok { cmd; t = Global } |> Js.Promise.resolve
           | Error msg -> Error msg |> Js.Promise.resolve)

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
    | x when x = Binaries.opam -> make ~env ~t:(opam root)
    | x when x = Binaries.esy -> make ~env ~t:(esy root)
    | x -> "Invalid package manager name: " ^ x |> R.fail |> Js.Promise.resolve

  let available ~env ~root =
    let supportedPackageManagers =
      [ Esy root; Esy Fpath.(root / ".vscode" / "esy"); Opam root ]
    in
    supportedPackageManagers
    |> List.map (fun (pm : t) ->
           let name = toName pm in
           Cmd.make ~env ~cmd:name
           |> Js.Promise.then_ (function
                | Ok _ -> (pm, true) |> Js.Promise.resolve
                | Error _ -> (pm, false) |> Js.Promise.resolve))
    |> Array.of_list |> Js.Promise.all
    |> Js.Promise.then_ (fun r ->
           Js.Array.filter (fun (_pm, available) -> available) r
           |> Array.map (fun (pm, _used) -> pm)
           |> Array.to_list |> R.return |> Js.Promise.resolve)

  let env spec =
    let { cmd; t } = spec in
    match t with
    | Global -> Process.env |> R.return |> Js.Promise.resolve
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
    let { cmd; t } = spec in
    match t with
    | Global -> Ok () |> Js.Promise.resolve
    | Esy root ->
      let rootStr = root |> Fpath.toString in
      Cmd.output cmd ~args:[| "status"; "-P"; rootStr |] ~cwd:rootStr
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
             else if Fpath.compare root workspaceRoot = 0 then (
               Js.log "esy project";
               promptSetup ~f:(fun () ->
                   Window.withProgress
                     [%bs.obj
                       { location = 15; title = "Setting up toolchain..." }]
                     (fun progress ->
                       (progress.report
                          [%bs.obj { increment = int_of_float 1. }] [@bs]);
                       Cmd.output cmd ~cwd:(root |> Fpath.toString) ~args:[||]
                       |> Js.Promise.then_ (fun _ ->
                              (progress.report
                                 [%bs.obj { increment = int_of_float 100. }]
                               [@bs]);
                              Js.Promise.resolve (Ok ()))))
             ) else (
               Js.log "bsb project";
               setupWithProgressIndicator cmd ~envWithUnzip:Process.env
                 (root |> Fpath.toString)
             ))
    | Opam _ -> Js.Promise.resolve (Ok ())

  let lsp spec =
    let { cmd; t } = spec in
    match t with
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
  val lookup : Fpath.t -> (PackageManagerSet.t, string) result Js.Promise.t
end = struct
  let parse projectRoot = function
    | "esy.json" -> Some (PackageManager.esy projectRoot) |> Js.Promise.resolve
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
                 | false -> Some (PackageManager.opam projectRoot) )
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
                   Some (PackageManager.esy projectRoot) |> Js.Promise.resolve
                 else
                   Some
                     (PackageManager.esy
                        Fpath.(projectRoot / ".vscode" / "esy"))
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
                   Some (PackageManager.esy projectRoot) |> Js.Promise.resolve
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
             | _ -> Some (PackageManager.opam projectRoot) |> Js.Promise.resolve)
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
                    |> Array.to_list |> PackageManagerSet.of_list )
                  |> Js.Promise.resolve))
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
    ( PackageManager.available ~root:projectRoot ~env
    , Manifest.lookup projectRoot
      |> okThen (fun pms ->
             if pms = PackageManagerSet.empty then
               Error "TODO: global toolchain"
             else
               Ok pms) )
  |> Js.Promise.then_
       (fun (availablePackageManagers, alreadyUsedPackageManagers) ->
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
           | Ok t -> PackageManager.make ~env ~t
           | Error msg -> Error msg |> Js.Promise.resolve )
         | [ obviousChoice ] ->
           Js.log2 "Toolchain detected" (PackageManager.toString obviousChoice);
           PackageManager.make ~env ~t:obviousChoice
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
             |> Js.Promise.then_ (function
                  | None ->
                    Js.Promise.resolve
                      (Error "showQuickPick() returned undefined")
                  | Some packageManager ->
                    Vscode.WorkspaceConfiguration.update config "packageManager"
                      packageManager 2
                    (* Workspace *)
                    |> Js.Promise.then_ (fun _ ->
                           match
                             PackageManager.find packageManager multipleChoices
                           with
                           | Some pm -> PackageManager.make ~env ~t:pm
                           | None ->
                             Js.Promise.resolve
                               (Error
                                  "Weird invalid state: selected choice was \
                                   not found in the list"))) ))
  |> okThen (fun spec -> Ok { spec; projectRoot })

let setup { spec; projectRoot } =
  PackageManager.setupToolChain projectRoot spec
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
