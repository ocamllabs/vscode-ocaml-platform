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

    let t =
      Settings.create ~scope:Workspace ~key:"sandbox" ~ofJson ~toJson
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

type resources =
  { kind : PackageManager.t
  ; projectRoot : Path.t
  }

let availablePackageManagers () =
  { PackageManager.Kind.Hmap.opam = Opam.make ()
  ; esy = Esy.make ()
  ; global = ()
  }

let ofSettings () : PackageManager.t option Promise.t =
  let open Promise.O in
  let available = availablePackageManagers () in
  match
    (Settings.get PackageManager.Setting.t : PackageManager.Setting.t option)
  with
  | None -> Promise.return None
  | Some (Esy manifest) -> (
    available.esy >>| function
    | None ->
      (* TODO warn here that the user's choice can't be respected *)
      None
    | Some esy -> Some (PackageManager.Esy (esy, manifest)) )
  | Some (Opam switch) -> (
    let open Promise.O in
    available.opam >>| function
    | None ->
      (* TODO Warn here *)
      None
    | Some opam ->
      (* TODO we need to validate this switch first *)
      Some (PackageManager.Opam (opam, switch)) )
  | Some PackageManager.Setting.Global ->
    Promise.return (Some PackageManager.Global)

let toSettings (pm : PackageManager.t) =
  Settings.set PackageManager.Setting.t (PackageManager.toSetting pm)

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
    | Some esy ->
      Esy.discover ~dir:projectRoot
      >>| List.map (fun manifest -> PackageManager.Esy (esy, manifest))
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

let setupToolChain { kind; projectRoot } =
  match kind with
  | Global -> Ok () |> Promise.resolve
  | Opam _ -> Ok () |> Promise.resolve
  | Esy (esy, manifest) -> Esy.setupToolchain esy ~manifest ~projectRoot

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
  | Esy (esy, manifest) -> Esy.exec esy ~manifest ~args:[| name |]
  | Global -> (name, [||])

let runSetup resources =
  let open Promise.Result.O in
  setupToolChain resources
  >>= (fun () ->
        let cmd, args = getLspCommand resources in
        Cmd.make ~cmd () >>= fun cmd -> Cmd.output cmd ~args)
  |> Promise.map (function
       | Ok _ -> Ok ()
       | Error msg -> Error {j| Toolchain initialisation failed: $msg |j})
