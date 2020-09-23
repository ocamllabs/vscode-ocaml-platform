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
      | Custom

    module Hmap = struct
      type ('opam, 'esy, 'global, 'custom) t =
        { opam : 'opam
        ; esy : 'esy
        ; global : 'global
        ; custom : 'custom
        }
    end

    let of_string = function
      | "opam" -> Some Opam
      | "esy" -> Some Esy
      | "global" -> Some Global
      | "custom" -> Some Custom
      | _ -> None

    let ofJson json =
      let open Json.Decode in
      match of_string (string json) with
      | Some s -> s
      | None ->
        raise
          (DecodeError "opam | esy | global | custom are the only valid values")

    let to_string = function
      | Opam -> "opam"
      | Esy -> "esy"
      | Global -> "global"
      | Custom -> "custom"

    let toJson s = Json.Encode.string (to_string s)
  end

  type t =
    | Opam of Opam.t * Opam.Switch.t
    | Esy of Esy.t * Path.t
    | Global
    | Custom of string

  module Setting = struct
    type t =
      | Opam of Opam.Switch.t
      | Esy of Path.t
      | Global
      | Custom of string

    let kind : t -> Kind.t = function
      | Opam _ -> Opam
      | Esy _ -> Esy
      | Global -> Global
      | Custom _ -> Custom

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
          field "switch" (fun js -> Opam.Switch.make (string js)) json
        in
        Opam switch
      | Custom ->
        let template = field "template" string json in
        Custom template

    let toJson (t : t) =
      let open Json.Encode in
      let kind = ("kind", Kind.toJson (kind t)) in
      match t with
      | Global -> Json.Encode.object_ [ kind ]
      | Esy manifest ->
        object_ [ kind; ("root", string @@ Path.toString manifest) ]
      | Opam sw -> object_ [ kind; ("switch", string @@ Opam.Switch.name sw) ]
      | Custom template -> object_ [ kind; ("template", string template) ]

    let t = Settings.create ~scope:Workspace ~key:"sandbox" ~ofJson ~toJson
  end

  let toSetting = function
    | Esy (_, root) -> Setting.Esy root
    | Opam (_, switch) -> Setting.Opam switch
    | Global -> Setting.Global
    | Custom template -> Setting.Custom template

  let toString = function
    | Esy (_, root) -> Printf.sprintf "esy(%s)" (Path.toString root)
    | Opam (_, switch) -> Printf.sprintf "opam(%s)" (Opam.Switch.name switch)
    | Global -> "global"
    | Custom _ -> "custom"

  let toPrettyString t =
    let print_opam = Printf.sprintf "opam(%s)" in
    let print_esy = Printf.sprintf "esy(%s)" in
    match t with
    | Esy (_, root) ->
      let projectName = Path.basename root in
      print_esy projectName
    | Opam (_, Named name) -> print_opam name
    | Opam (_, Local path) ->
      let projectName = Path.basename path in
      print_opam projectName
    | Global -> "Global OCaml"
    | Custom _ -> "Custom OCaml"
end

type resources = PackageManager.t

let packageManager (t : resources) : PackageManager.t = t

let availablePackageManagers () =
  { PackageManager.Kind.Hmap.opam = Opam.make ()
  ; esy = Esy.make ()
  ; global = ()
  ; custom = ()
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
    ( Settings.get ~section:"ocaml" PackageManager.Setting.t
      : PackageManager.Setting.t option )
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
          (Opam.Switch.name switch);
        None
      | true -> Some (PackageManager.Opam (opam, switch)) ) )
  | Some Global -> Promise.return (Some PackageManager.Global)
  | Some (Custom template) ->
    Promise.return (Some (PackageManager.Custom template))

let toSettings (pm : PackageManager.t) =
  Settings.set ~section:"ocaml" PackageManager.Setting.t
    (PackageManager.toSetting pm)

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
      let label = Opam.Switch.name s in
      create ?detail ~label ()
    | Esy (_, p) ->
      create ?detail ~label:(Path.toString p) ~description:"Esy" ()
    | Global ->
      create ?detail ~label:"Global"
        ~description:"Global toolchain inherited from the environment" ()
    | Custom _ ->
      create ?detail ~label:"Custom"
        ~description:"Custom toolchain using a command template" ()

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
  let global = Candidate.ok PackageManager.Global in
  let custom =
    Candidate.ok (PackageManager.Custom "$prog $args")
    (* doesn't matter what the custom fields are set to here
       user will input custom commands in [select] *)
  in

  Promise.all2 (esy, opam) >>| fun (esy, opam) ->
  (global :: custom :: esy) @ opam

let setupToolChain (kind : PackageManager.t) =
  match kind with
  | Esy (esy, manifest) -> Esy.setupToolchain esy ~manifest
  | Opam _
  | Global
  | Custom _ ->
    Promise.Result.return ()

let makeResources kind = kind

let select () =
  let open Promise.O in
  let workspaceFolders = Vscode.Workspace.workspaceFolders () in
  sandboxCandidates ~workspaceFolders >>= fun candidates ->
  let open Promise.Option.O in
  selectPackageManager candidates >>= function
  | { status = Ok (); packageManager = Custom _ } ->
    let validateInput input =
      if Js.String.includes "$prog" input && Js.String.includes "$args" input
      then
        None
      else
        Some "Command template must include $prog and $args"
    in
    let options =
      Window.InputBoxOptions.make ~prompt:"Input a custom command template"
        ~value:"$prog $args" ~validateInput ()
    in
    Window.showInputBox options >>| String.trim >>= fun template ->
    Promise.Option.return @@ PackageManager.Custom template
  | { status; packageManager } -> (
    match status with
    | Error s ->
      message `Warn "This toolchain is invalid. Error: %s" s;
      Promise.return None
    | Ok () -> Promise.Option.return packageManager )

let selectAndSave () =
  let open Promise.Option.O in
  select () >>= fun packageManager ->
  let open Promise.O in
  toSettings packageManager >>| fun () -> Some packageManager

let getCommand (t : PackageManager.t) bin args : Cmd.t =
  match t with
  | Opam (opam, switch) -> Opam.exec opam ~switch ~args:(bin :: args)
  | Esy (esy, manifest) -> Esy.exec esy ~manifest ~args:(bin :: args)
  | Global -> Spawn { bin = Path.ofString bin; args }
  | Custom template ->
    let bin =
      if String.contains bin ' ' then
        "\"" ^ bin ^ "\""
      else
        bin
    in
    let command =
      template
      |> Js.String.replace "$prog" bin
      |> Js.String.replace "$args" (String.concat " " args)
      |> String.trim
    in
    Shell command

let getLspCommand ?(args = []) (t : PackageManager.t) : Cmd.t =
  getCommand t "ocamllsp" args

let getDuneCommand (t : PackageManager.t) args : Cmd.t =
  getCommand t "dune" args

let runSetup resources =
  let open Promise.Result.O in
  setupToolChain resources
  >>= (fun () ->
        let args = [ "--version" ] in
        let command = getLspCommand resources ~args in
        Cmd.check command >>= fun cmd -> Cmd.output cmd)
  |> Promise.map (function
       | Ok _ -> Ok ()
       | Error msg -> Error {j|Toolchain initialisation failed: $msg|j})
