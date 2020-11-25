open Import

(* Terminology:
   - Toolchain: represents supported toolchains with Global as
     the fallback
   - project_root is different from Package_manager root (Eg. Opam
     (Path.of_string "/foo/bar")). Project root
     is the directory where manifest file (opam/esy.json/package.json)
     was found. Package_manager root is the directory that contains the
     manifest file responsible for setting up the toolchain - the two
     are same for Esy and Opam project but different for
     bucklescript. Bucklescript projects have this manifest file
     abstracted away from the user (at least at the moment)
   - Manifest: abstracts functions handling manifest files
     of the supported package managers *)

type t =
  | Opam of Opam.t * Opam.Switch.t
  | Esy of Esy.t * Path.t
  | Global
  | Custom of string

let equal t1 t2 =
  match (t1, t2) with
  | Global, Global -> true
  | Esy (e1, p1), Esy (e2, p2) -> Path.equal p1 p2 && Esy.equal e1 e2
  | Opam (o1, s1), Opam (o2, s2) -> Opam.Switch.equal s1 s2 && Opam.equal o1 o2
  | Custom s1, Custom s2 -> String.equal s1 s2
  | _, _ -> false

let to_string = function
  | Esy (_, root) -> Printf.sprintf "esy(%s)" (Path.to_string root)
  | Opam (_, switch) -> Printf.sprintf "opam(%s)" (Opam.Switch.name switch)
  | Global -> "global"
  | Custom _ -> "custom"

let to_pretty_string t =
  let print_opam = Printf.sprintf "opam(%s)" in
  let print_esy = Printf.sprintf "esy(%s)" in
  match t with
  | Esy (_, root) ->
    let project_name = Path.basename root in
    print_esy project_name
  | Opam (_, Named name) -> print_opam name
  | Opam (_, Local path) ->
    let project_name = Path.basename path in
    print_opam project_name
  | Global -> "Global OCaml"
  | Custom _ -> "Custom OCaml"

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

  let of_json json =
    let open Jsonoo.Decode in
    match of_string (string json) with
    | Some s -> s
    | None ->
      raise
        (Jsonoo.Decode_error
           "opam | esy | global | custom are the only valid values")

  let to_string = function
    | Opam -> "opam"
    | Esy -> "esy"
    | Global -> "global"
    | Custom -> "custom"

  let to_json s = Jsonoo.Encode.string (to_string s)
end

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

  let of_json json =
    let open Jsonoo.Decode in
    let decode_vars json = Settings.resolve_workspace_vars (string json) in
    let kind = field "kind" Kind.of_json json in
    match (kind : Kind.t) with
    | Global -> Global
    | Esy ->
      let manifest =
        field "root" (fun js -> Path.of_string (decode_vars js)) json
      in
      Esy manifest
    | Opam ->
      let switch =
        field "switch" (fun js -> Opam.Switch.make (decode_vars js)) json
      in
      Opam switch
    | Custom ->
      let template = field "template" decode_vars json in
      Custom template

  let to_json (t : t) =
    let open Jsonoo.Encode in
    let encode_vars str = string (Settings.substitute_workspace_vars str) in
    let kind = ("kind", Kind.to_json (kind t)) in
    match t with
    | Global -> Jsonoo.Encode.object_ [ kind ]
    | Esy manifest ->
      object_ [ kind; ("root", encode_vars @@ Path.to_string manifest) ]
    | Opam switch ->
      object_ [ kind; ("switch", encode_vars @@ Opam.Switch.name switch) ]
    | Custom template -> object_ [ kind; ("template", string template) ]

  let t = Settings.create ~scope:Workspace ~key:"sandbox" ~of_json ~to_json
end

let available_toolchains () =
  { Kind.Hmap.opam = Opam.make (); esy = Esy.make (); global = (); custom = () }

let of_settings () : t option Promise.t =
  let open Promise.Syntax in
  let available = available_toolchains () in
  let not_available kind =
    let this_ =
      match kind with
      | `Esy -> "esy"
      | `Opam -> "opam"
    in
    show_message `Warn
      "This workspace is configured to use an %s sandbox, but %s isn't \
       available"
      this_ this_
  in
  match (Settings.get ~section:"ocaml" Setting.t : Setting.t option) with
  | None -> Promise.return None
  | Some (Esy manifest) -> (
    let+ esy = available.esy in
    match esy with
    | None ->
      not_available `Esy;
      None
    | Some esy -> Some (Esy (esy, manifest)) )
  | Some (Opam switch) -> (
    let open Promise.Syntax in
    let* opam = available.opam in
    match opam with
    | None ->
      not_available `Opam;
      Promise.return None
    | Some opam ->
      let+ exists = Opam.exists opam ~switch in
      if exists then
        Some (Opam (opam, switch))
      else (
        show_message `Warn
          "Workspace is configured to use the switch %s. This switch does not \
           exist."
          (Opam.Switch.name switch);
        None
      ) )
  | Some Global -> Promise.return (Some Global)
  | Some (Custom template) -> Promise.return (Some (Custom template))

let detect_esy_sandbox ~project_root esy () =
  let open Promise.Syntax in
  let* esy = esy in
  let* esy_build_dir_exists =
    Fs.exists Path.(project_root / "_esy" |> Path.to_string)
  in
  let+ manifest = Esy.find_manifest_in_dir project_root in
  match (esy, esy_build_dir_exists, manifest) with
  | Some esy, true, Some _ ->
    (* Some projects have both use both Esy and Opam, we can't assume that the user
       wants to use Esy just by looking for an "esy.json" file.

       Instead, we assume the user wants to use esy if these three conditions are met:
        - The esy command is in the user's system
        - There is an _esy build directory in the project root
        - There is an Esy manifest file in the project root
    *)
    Some (Esy (esy, project_root))
  | _ -> None

let detect_opam_sandbox ~project_root opam () =
  let open Promise.Option.Syntax in
  let* opam = opam in
  let+ switch = Opam.switch_show ~cwd:project_root opam in
  Opam (opam, switch)

let detect () =
  match Workspace.workspaceFolders () with
  | [] -> Promise.return None
  | [ workspace_folder ] -> (
    let project_root =
      workspace_folder |> WorkspaceFolder.uri |> Uri.path |> Path.of_string
    in
    let available = available_toolchains () in
    try
      Promise.List.find_map
        (fun f -> f ())
        [ detect_esy_sandbox ~project_root available.esy
        ; detect_opam_sandbox ~project_root available.opam
        ]
    with Assert_failure _ -> Promise.return None )
  | _ ->
    (* If there are several workspace folders, skip the detection entirely. *)
    Promise.return None

let of_settings_or_detect () =
  let open Promise.Syntax in
  let* package_manager_opt = of_settings () in
  match package_manager_opt with
  | Some package_manager -> Promise.return (Some package_manager)
  | None -> detect ()

let save_to_settings toolchain =
  let to_setting = function
    | Esy (_, root) -> Setting.Esy root
    | Opam (_, switch) -> Setting.Opam switch
    | Global -> Setting.Global
    | Custom template -> Setting.Custom template
  in
  Settings.set ~section:"ocaml" Setting.t (to_setting toolchain)

module Candidate = struct
  type nonrec t =
    { toolchain : t
    ; status : (unit, string) result
    }

  let to_quick_pick { toolchain; status } =
    let create = QuickPickItem.create in
    let description =
      match status with
      | Error s -> Some (Printf.sprintf "Invalid sandbox: %s" s)
      | Ok () -> (
        match toolchain with
        | Opam (_, Local _) -> Some "Local switch"
        | Opam (_, Named _) -> Some "Global switch"
        | Esy _ -> Some "Esy"
        | _ -> None )
    in
    match toolchain with
    | Opam (_, Named name) -> create ~label:name ?description ()
    | Opam (_, Local path) ->
      let project_name = Path.basename path in
      let project_path = Path.to_string path in
      create ~label:project_name ~detail:project_path ?description ()
    | Esy (_, p) ->
      let project_name = Path.basename p in
      let project_path = Path.to_string p in
      create ~detail:project_path ~label:project_name ?description ()
    | Global ->
      create ~label:"Global" ?description
        ~detail:"Global toolchain inherited from the environment" ()
    | Custom _ ->
      create ?description ~label:"Custom"
        ~detail:"Custom toolchain using a command template" ()

  let ok toolchain = { toolchain; status = Ok () }
end

let select_toolchain (choices : Candidate.t list) =
  let placeHolder =
    "Which package manager would you like to manage the toolchain?"
  in
  let choices =
    List.map
      ~f:(fun (toolchain : Candidate.t) ->
        let quick_pick = Candidate.to_quick_pick toolchain in
        (quick_pick, toolchain))
      choices
  in
  let options = QuickPickOptions.create ~canPickMany:false ~placeHolder () in
  Window.showQuickPickItems ~choices ~options ()

let toolchain_candidates ~workspace_folders =
  let open Promise.Syntax in
  let available = available_toolchains () in
  let esy =
    let* esy = available.esy in
    match esy with
    | None -> Promise.return []
    | Some esy ->
      let+ esys =
        workspace_folders
        |> List.map ~f:(fun (folder : WorkspaceFolder.t) ->
               let dir =
                 folder |> WorkspaceFolder.uri |> Uri.fsPath |> Path.of_string
               in
               Esy.discover ~dir)
        |> Promise.all_list
      in
      List.concat esys
      |> List.map ~f:(fun (manifest : Esy.discover) ->
             { Candidate.toolchain = Esy (esy, manifest.file)
             ; status = manifest.status
             })
  in
  let opam =
    let* opam = available.opam in
    match opam with
    | None -> Promise.return []
    | Some opam ->
      let+ switches = Opam.switch_list opam in
      List.map switches ~f:(fun sw ->
          let toolchain = Opam (opam, sw) in
          { Candidate.toolchain; status = Ok () })
  in
  let global = Candidate.ok Global in
  let custom =
    Candidate.ok (Custom "$prog $args")
    (* doesn't matter what the custom fields are set to here
       user will input custom commands in [select] *)
  in

  let+ esy, opam = Promise.all2 (esy, opam) in
  (global :: custom :: esy) @ opam

let setup_toolchain (kind : t) =
  match kind with
  | Esy (esy, manifest) -> Esy.setup_toolchain esy ~manifest
  | Opam _
  | Global
  | Custom _ ->
    Promise.Result.return ()

let select_toolchain () =
  let open Promise.Syntax in
  let workspace_folders = Workspace.workspaceFolders () in
  let* candidates = toolchain_candidates ~workspace_folders in
  let open Promise.Option.Syntax in
  let* candidate = select_toolchain candidates in
  match candidate with
  | { status = Ok (); toolchain = Custom _ } ->
    let validateInput ~value =
      if
        String.is_substring value ~substring:"$prog"
        && String.is_substring value ~substring:"$args"
      then
        Promise.return None
      else
        Promise.Option.return "Command template must include $prog and $args"
    in
    let options =
      InputBoxOptions.create ~prompt:"Input a custom command template"
        ~value:"$prog $args" ~validateInput ()
    in
    let* input = Window.showInputBox ~options () in
    let template = String.strip input in
    Promise.Option.return @@ Custom template
  | { status; toolchain } -> (
    match status with
    | Error s ->
      show_message `Warn "This toolchain is invalid. Error: %s" s;
      Promise.return None
    | Ok () -> Promise.Option.return toolchain )

let select_toolchain_and_save () =
  let open Promise.Option.Syntax in
  let* toolchain = select_toolchain () in
  let open Promise.Syntax in
  let+ () = save_to_settings toolchain in
  Some toolchain

let get_command toolchain bin args : Cmd.t =
  match toolchain with
  | Opam (opam, switch) -> Opam.exec opam ~switch ~args:(bin :: args)
  | Esy (esy, manifest) -> Esy.exec esy ~manifest ~args:(bin :: args)
  | Global -> Spawn { bin = Path.of_string bin; args }
  | Custom template ->
    let bin =
      if String.contains bin ' ' then
        "\"" ^ bin ^ "\""
      else
        bin
    in
    let command =
      template
      |> String.substr_replace_all ~pattern:"$prog" ~with_:bin
      |> String.substr_replace_all ~pattern:"$args"
           ~with_:(String.concat ~sep:" " args)
      |> String.strip
    in
    Shell command

let get_lsp_command ?(args = []) toolchain : Cmd.t =
  get_command toolchain "ocamllsp" args

let get_dune_command toolchain args : Cmd.t = get_command toolchain "dune" args

let run_setup toolchain =
  let open Promise.Syntax in
  let+ output =
    let open Promise.Result.Syntax in
    let* () = setup_toolchain toolchain in
    let args = [ "--version" ] in
    let* command = Cmd.check (get_lsp_command toolchain ~args) in
    Cmd.output command
  in
  match output with
  | Ok _ -> Ok ()
  | Error msg ->
    (* TODO: if ocamllsp not found, suggest to install it on press of a button;
       consider checking and suggesting installation for other tools: formatter, etc. *)
    Error (Printf.sprintf "Toolchain initialisation failed: %s" msg)
