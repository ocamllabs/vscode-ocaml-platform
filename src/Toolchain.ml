open Import

(* Terminology:
   - PackageManager: represents supported package managers
     with Global as the fallback
   - projectRoot is different from PackageManager root (Eg. Opam
     (Path.ofString "/foo/bar")). Project root
     is the directory where manifest file (opam/esy.json/package.json)
     was found. PackageManager root is the directory that contains the
     manifest file responsible for setting up the toolchain - the two
     are same for Esy and Opam project but different for
     bucklescript. Bucklescript projects have this manifest file
     abstracted away from the user (atleast at the moment)
   - Manifest: abstracts functions handling manifest files
     of the supported package managers *)

module PackageManager = struct
  module Kind = struct
    type t =
      | Opam
      | Esy
      | Global

    module Hmap = struct
      type ('opam, 'esy, 'global) t =
        { opam : 'opam
        ; esy : 'esy
        ; global : 'global
        }
    end

    let of_string = function
      | "opam" -> Some Opam
      | "esy" -> Some Esy
      | "global" -> Some Global
      | _ -> None

    let to_string = function
      | Opam -> "opam"
      | Esy -> "esy"
      | Global -> "global"

    let setting =
      let of_string s =
        match of_string s with
        | None -> failwith ("Invalid kind: " ^ s)
        | Some s -> s
      in
      Settings.create ~scope:Workspace ~key:"packageManager" ~of_string
        ~to_string
  end

  type t =
    | Opam of Opam.t * Opam.Switch.t
    | Esy of Cmd.t * Path.t
    | Global

  let kind = function
    | Opam _ -> Kind.Opam
    | Esy _ -> Esy
    | Global -> Global

  let toString = function
    | Esy (_, root) -> Printf.sprintf "esy(%s)" (Path.toString root)
    | Opam (_, switch) ->
      Printf.sprintf "opam(%s)" (Opam.Switch.toString switch)
    | Global -> "global"
end

type resources =
  { kind : PackageManager.t
  ; projectRoot : Path.t
  }

let toolChainRoot = Settings.string ~scope:Workspace ~key:"toolChainRoot"

let env (pm : PackageManager.t) =
  match pm with
  | PackageManager.Global -> Ok Process.env |> Promise.resolve
  | Esy (cmd, root) ->
    Cmd.output cmd
      ~args:[| "command-env"; "--json"; "-P"; Path.toString root |]
      ~cwd:root
    |> Promise.map
         (Result.bind ~f:(fun stdout ->
              match Json.parse stdout with
              | Some json ->
                json |> Json.Decode.dict Json.Decode.string |> Result.return
              | None ->
                Error ("'esy command-env' returned non-json output: " ^ stdout)))
  | Opam (opam, switch) -> Opam.env opam ~switch

let availablePackageManagers () =
  let open Promise.O in
  let esy =
    Cmd.make ~cmd:"esy" () >>| fun esy ->
    match esy with
    | Ok cmd -> Some cmd
    | Error _ -> None
  in
  { PackageManager.Kind.Hmap.opam = Opam.make (); esy; global = () }

let ofSettings ~(projectRoot : Path.t) : PackageManager.t option Promise.t =
  let root =
    match Settings.get toolChainRoot with
    | None ->
      Path.toString projectRoot (* TODO stupid back and forth conversion *)
    | Some s -> s
  in
  let open Promise.O in
  let available = availablePackageManagers () in
  match
    (Settings.get PackageManager.Kind.setting : PackageManager.Kind.t option)
  with
  | None -> Promise.return None
  | Some Esy -> (
    available.esy >>| function
    | None ->
      (* TODO warn here that the user's choice can't be respected *)
      None
    | Some esy ->
      let root = Path.ofString root in
      Some (PackageManager.Esy (esy, root)) )
  | Some Opam -> (
    let open Promise.O in
    available.opam >>| function
    | None ->
      (* TODO Warn here *)
      None
    | Some opam ->
      (* TODO we need to validate this switch first *)
      Some (PackageManager.Opam (opam, Opam.Switch.ofString root)) )
  | Some PackageManager.Kind.Global ->
    Promise.return (Some PackageManager.Global)

let toSettings (pm : PackageManager.t) =
  let kindSet =
    Settings.set PackageManager.Kind.setting (PackageManager.kind pm)
  in
  let rootSet =
    match pm with
    | Global -> Promise.return () (* TODO wrong *)
    | Esy (_, p) -> Settings.set toolChainRoot (Path.toString p)
    | Opam (_, sw) -> Settings.set toolChainRoot (Opam.Switch.toString sw)
  in
  let open Promise.O in
  Js.Promise.all2 (kindSet, rootSet) >>| fun ((), ()) -> ()

let selectPackageManager choices =
  let placeHolder =
    "Which package manager would you like to manage the toolchain?"
  in
  let choices =
    let create = Window.QuickPickItem.create in
    List.map
      (fun pm ->
        let quickPick =
          match pm with
          | PackageManager.Opam (_, s) ->
            let label = Opam.Switch.toString s in
            let detail =
              match s with
              | Local _ -> "Local switch"
              | Named _ -> "Global switch"
            in
            create ~label ~detail ()
          | Esy (_, p) -> create ~label:(Path.toString p) ~description:"Esy" ()
          | Global ->
            create ~label:"Global"
              ~description:"Global toolchain inherited from the environment" ()
        in
        (quickPick, pm))
      choices
  in
  let options =
    Window.QuickPickOptions.make ~canPickMany:false ~placeHolder ()
  in
  Window.showQuickPickItems choices options

let sandboxCandidates ~projectRoot =
  let open Promise.O in
  let available = availablePackageManagers () in
  let esy =
    available.esy >>= function
    | None -> Promise.return []
    | Some cmd -> (
      Manifest.lookup projectRoot >>| function
      | Error _ -> [] (* TODO warn *)
      | Ok lookups ->
        Belt.List.keepMap lookups (function
          | Esy s -> Some (PackageManager.Esy (cmd, s))
          (* TODO this will not be necessary once we merge esy with manifest *)
          | Opam _ -> None) )
  in
  let opam =
    available.opam >>= function
    | None -> Promise.return []
    | Some opam ->
      Opam.switchList opam
      >>| List.map (fun sw -> PackageManager.Opam (opam, sw))
  in
  Promise.all2 (esy, opam) >>| fun (esy, opam) ->
  (PackageManager.Global :: esy) @ opam

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
      (progress.report [%bs.obj { increment = int_of_float 1. }] [@bs]);
      Cmd.output cmd ~cwd:root ~args:[||]
      |> Promise.map (fun _ ->
             (progress.report [%bs.obj { increment = int_of_float 100. }] [@bs]);
             Ok ()))

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
      |> Promise.map (fun () -> !succeeded))

type esyProjectState =
  | Ready
  | PendingEsy
  | PendingBsb

let esyProjectState ~cmd ~root ~projectRoot =
  let rootStr = Path.toString root in
  Cmd.output cmd ~args:[| "status"; "-P"; rootStr |] ~cwd:root
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
         else if Path.compare root projectRoot = 0 then
           PendingEsy
         else
           PendingBsb)

let setupToolChain { kind; projectRoot } =
  match kind with
  | Global -> Ok () |> Promise.resolve
  | Opam _ -> Ok () |> Promise.resolve
  | Esy (cmd, root) ->
    esyProjectState ~cmd ~root ~projectRoot
    |> Promise.then_ (function
         | Error e -> Error e |> Promise.resolve
         | Ok Ready -> Ok () |> Promise.resolve
         | Ok PendingEsy -> promptSetup (fun () -> setupEsy ~cmd ~root)
         | Ok PendingBsb -> setupBsb ~cmd ~envWithUnzip:Process.env root)

let runSetup resources =
  setupToolChain resources
  |> Promise.Result.bind (fun () -> env resources.kind)
  |> Promise.Result.bind (fun env ->
         (* This function/callback here is a temporary way to check ocamllsp if
            installed after setupToolChain completes. TODO: move it inside
            setupToolChain itself *)
         Cmd.make ~cmd:"ocamllsp" ~env ())
  |> Promise.map (function
       | Ok _ -> Ok ()
       | Error msg -> Error {j| Toolchain initialisation failed: $msg |j})

let makeResources ~projectRoot kind = { projectRoot; kind }

let select ~projectRoot =
  let open Promise.O in
  sandboxCandidates ~projectRoot >>= fun candidates ->
  selectPackageManager candidates >>| function
  | None -> None
  | Some choice ->
    let (_ : unit Promise.t) = toSettings choice in
    Some choice

let getLspCommand t =
  let name = "ocamllsp" in
  match t.kind with
  | Opam (opam, switch) -> Opam.exec opam ~switch ~args:[| name |]
  | Esy (cmd, root) -> (Cmd.binPath cmd, [| "-P"; Path.toString root; name |])
  | Global -> (name, [||])
