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

    let ofJson json =
      let open Json.Decode in
      match of_string (string json) with
      | Some s -> s
      | None ->
        raise (DecodeError "opma | esy | global are the only valid values")

    let to_string = function
      | Opam -> "opam"
      | Esy -> "esy"
      | Global -> "global"

    let toJson s = Json.Encode.string (to_string s)
  end

  type t =
    | Opam of Opam.t * Opam.Switch.t
    | Esy of Esy.t * Path.t
    | Global

  module Setting = struct
    type t =
      | Opam of Opam.Switch.t
      | Esy of Path.t
      | Global

    let kind : t -> Kind.t = function
      | Opam _ -> Opam
      | Esy _ -> Esy
      | Global -> Global

    let ofJson json =
      let open Json.Decode in
      let kind = field "kind" Kind.ofJson json in
      match (kind : Kind.t) with
      | Global -> Global
      | Esy ->
        let manifest =
          field "root" (fun js -> Path.ofString (string js)) json
        in
        Esy manifest
      | Opam ->
        let switch =
          field "switch" (fun js -> Opam.Switch.ofString (string js)) json
        in
        Opam switch

    let toJson (t : t) =
      let open Json.Encode in
      let kind = [ ("kind", Kind.toJson (kind t)) ] in
      match t with
      | Global -> Json.Encode.object_ kind
      | Esy manifest ->
        object_ @@ (("root", string @@ Path.toString manifest) :: kind)
      | Opam sw ->
        object_ @@ (("switch", string @@ Opam.Switch.toString sw) :: kind)

    let t = Settings.create ~scope:Workspace ~key:"sandbox" ~ofJson ~toJson
  end

  let toSetting = function
    | Esy (_, root) -> Setting.Esy root
    | Opam (_, switch) -> Setting.Opam switch
    | Global -> Setting.Global

  let toString = function
    | Esy (_, root) -> Printf.sprintf "esy(%s)" (Path.toString root)
    | Opam (_, switch) ->
      Printf.sprintf "opam(%s)" (Opam.Switch.toString switch)
    | Global -> "global"
end

type resources = PackageManager.t

let availablePackageManagers () =
  { PackageManager.Kind.Hmap.opam = Opam.make ()
  ; esy = Esy.make ()
  ; global = ()
  }

let ofSettings () : PackageManager.t option Promise.t =
  let open Promise.O in
  let available = availablePackageManagers () in
  let notAvailable kind =
    let this_ =
      match kind with
      | `Esy -> "esy"
      | `Opam -> "opam"
    in
    message `Warn
      "This workspace is configured to use an %s sandbox, but %s isn't \
       available"
      this_ this_
  in
  match
    (Settings.get PackageManager.Setting.t : PackageManager.Setting.t option)
  with
  | None -> Promise.return None
  | Some (Esy manifest) -> (
    available.esy >>| function
    | None ->
      notAvailable `Esy;
      None
    | Some esy -> Some (PackageManager.Esy (esy, manifest)) )
  | Some (Opam switch) -> (
    let open Promise.O in
    available.opam >>= function
    | None ->
      notAvailable `Opam;
      Promise.return None
    | Some opam -> (
      Opam.exists opam ~switch >>| function
      | false ->
        message `Warn
          "Workspace is configured to use the switch %s. This switch does not \
           exist."
          (Opam.Switch.toString switch);
        None
      | true -> Some (PackageManager.Opam (opam, switch)) ) )
  | Some PackageManager.Setting.Global ->
    Promise.return (Some PackageManager.Global)

let toSettings (pm : PackageManager.t) =
  Settings.set PackageManager.Setting.t (PackageManager.toSetting pm)

module Candidate = struct
  type t =
    { packageManager : PackageManager.t
    ; status : (unit, string) result
    }

  let toQuickPick { packageManager; status } =
    let create = Window.QuickPickItem.create in
    let detail =
      match status with
      | Error s -> Some (sprintf "invalid: %s" s)
      | Ok () -> (
        match packageManager with
        | Opam (_, Local _) -> Some "Local switch"
        | Opam (_, Named _) -> Some "Global switch"
        | _ -> None )
    in
    match packageManager with
    | PackageManager.Opam (_, s) ->
      let label = Opam.Switch.toString s in
      create ~label ?detail ()
    | Esy (_, p) ->
      create ?detail ~label:(Path.toString p) ~description:"Esy" ()
    | Global ->
      create ?detail ~label:"Global"
        ~description:"Global toolchain inherited from the environment" ()

  let ok packageManager = { packageManager; status = Ok () }
end

let selectPackageManager (choices : Candidate.t list) =
  let placeHolder =
    "Which package manager would you like to manage the toolchain?"
  in
  let choices =
    List.map
      (fun (pm : Candidate.t) ->
        let quickPick = Candidate.toQuickPick pm in
        (quickPick, pm))
      choices
  in
  let options =
    Window.QuickPickOptions.make ~canPickMany:false ~placeHolder ()
  in
  Window.showQuickPickItems choices options

let sandboxCandidates ~workspaceFolders =
  let open Promise.O in
  let available = availablePackageManagers () in
  let esy =
    available.esy >>= function
    | None -> Promise.return []
    | Some esy ->
      workspaceFolders
      |> Array.map (fun (folder : Vscode.Folder.t) ->
             let dir = Path.ofString folder.uri.fsPath in
             Esy.discover ~dir)
      |> Promise.all
      >>| fun esys ->
      Array.to_list esys |> List.concat
      |> List.map (fun (manifest : Esy.discover) ->
             { Candidate.packageManager = PackageManager.Esy (esy, manifest.file)
             ; status = manifest.status
             })
  in
  let opam =
    available.opam >>= function
    | None -> Promise.return []
    | Some opam ->
      Opam.switchList opam
      >>| List.map (fun sw ->
              let packageManager = PackageManager.Opam (opam, sw) in
              { Candidate.packageManager; status = Ok () })
  in
  Promise.all2 (esy, opam) >>| fun (esy, opam) ->
  (Candidate.ok PackageManager.Global :: esy) @ opam

let setupToolChain (kind : PackageManager.t) =
  match kind with
  | Global -> Ok () |> Promise.resolve
  | Opam _ -> Ok () |> Promise.resolve
  | Esy (esy, manifest) -> Esy.setupToolchain esy ~manifest

let makeResources kind = kind

let selectAndSave () =
  let open Promise.O in
  let workspaceFolders = Vscode.Workspace.workspaceFolders () in
  sandboxCandidates ~workspaceFolders >>= fun candidates ->
  selectPackageManager candidates >>| function
  | None -> None
  | Some choice -> (
    match choice.status with
    | Error s ->
      message `Warn "This toolchain is invalid. Error: %s" s;
      None
    | Ok () ->
      let (_ : unit Promise.t) = toSettings choice.packageManager in
      Some choice.packageManager )

let getLspCommand (t : PackageManager.t) : Path.t * string array =
  let name = "ocamllsp" in
  match t with
  | Opam (opam, switch) -> Opam.exec opam ~switch ~args:[| name |]
  | Esy (esy, manifest) -> Esy.exec esy ~manifest ~args:[| name |]
  | Global -> (Path.ofString name, [||])

let addLspCheckArg args = Array.append args [| "--help=plain" |]

let runSetup resources =
  let open Promise.Result.O in
  setupToolChain resources
  >>= (fun () ->
        let cmd, args = getLspCommand resources in
        Cmd.make ~cmd () >>= fun cmd ->
        Cmd.output cmd ~args:(addLspCheckArg args))
  |> Promise.map (function
       | Ok _ -> Ok ()
       | Error msg -> Error {j| Toolchain initialisation failed: $msg |j})
