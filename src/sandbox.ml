open Import

module Package = struct
  (* TODO: this should be refactored. A list of package should be homogeneous,
     so a variant is not a good type.

     This is not too bad for now, as the type is not exposed in the interface,
     and the constructions only happens in [packages] and [root_packages]. *)
  type t =
    | Opam of Opam.Package.t
    | Esy of Esy.Package.t

  let of_opam opam_pkg = Opam opam_pkg
  let of_esy opam_pkg = Esy opam_pkg

  let name t =
    match t with
    | Opam pkg -> Opam.Package.name pkg
    | Esy pkg -> Esy.Package.name pkg
  ;;

  let version t =
    match t with
    | Opam pkg -> Opam.Package.version pkg
    | Esy pkg -> Esy.Package.version pkg
  ;;

  let synopsis t =
    match t with
    | Opam pkg -> Opam.Package.synopsis pkg
    | Esy pkg -> Esy.Package.synopsis pkg
  ;;

  let documentation t =
    match t with
    | Opam pkg -> Opam.Package.documentation pkg
    | Esy pkg -> Esy.Package.documentation pkg
  ;;

  let dependencies t =
    match t with
    | Opam pkg ->
      let open Promise.Result.Syntax in
      let+ deps = Opam.Package.dependencies pkg in
      List.map deps ~f:of_opam
    | Esy pkg ->
      let open Promise.Result.Syntax in
      let+ deps = Esy.Package.dependencies pkg in
      List.map deps ~f:of_esy
  ;;

  let has_dependencies t =
    match t with
    | Opam pkg -> Opam.Package.has_dependencies pkg
    | Esy pkg -> Esy.Package.has_dependencies pkg
  ;;
end

(** If [Workspace.workspaceFolders()] returns a list with a single element,
    returns it; otherwise, returns [None]. *)
let workspace_root () =
  match Workspace.workspaceFolders () with
  | [] -> None
  | [ workspace_folder ] ->
    Some (workspace_folder |> WorkspaceFolder.uri |> Uri.fsPath |> Path.of_string)
  | _ ->
    (* We don't support multiple workspace roots at the moment *)
    None
;;

type t =
  | Opam of Opam.t * Opam.Switch.t
  | Esy of Esy.t * Esy.Manifest.t
  | Global
  | Custom of string
  | Dune of Dune.t

let equal t1 t2 =
  match t1, t2 with
  | Global, Global -> true
  | Esy (e1, p1), Esy (e2, p2) -> Esy.Manifest.equal p1 p2 && Esy.equal e1 e2
  | Opam (o1, s1), Opam (o2, s2) -> Opam.Switch.equal s1 s2 && Opam.equal o1 o2
  | Custom s1, Custom s2 -> String.equal s1 s2
  | Dune d1, Dune d2 -> Dune.equal d1 d2
  | _, _ -> false
;;

let to_string = function
  | Esy (_, root) -> Printf.sprintf "esy(%s)" (Esy.Manifest.path root |> Path.to_string)
  | Opam (_, switch) -> Printf.sprintf "opam(%s)" (Opam.Switch.name switch)
  | Global -> "global"
  | Custom _ -> "custom"
  | Dune _ -> "dune"
;;

let to_pretty_string t =
  let print_opam = Printf.sprintf "opam(%s)" in
  let print_esy = Printf.sprintf "esy(%s)" in
  match t with
  | Esy (_, root) ->
    let project_name = Esy.Manifest.path root |> Path.basename in
    print_esy project_name
  | Opam (_, Named name) -> print_opam name
  | Opam (_, Local path) ->
    let project_name = Path.basename path in
    print_opam project_name
  | Global -> "Global OCaml"
  | Custom _ -> "Custom OCaml"
  | Dune _ -> "Dune Package Manager"
;;

module Kind = struct
  type t =
    | Opam
    | Esy
    | Global
    | Custom
    | Dune

  let of_string = function
    | "opam" -> Some Opam
    | "esy" -> Some Esy
    | "global" -> Some Global
    | "custom" -> Some Custom
    | "dune" -> Some Dune
    | _ -> None
  ;;

  let of_json json =
    let open Jsonoo.Decode in
    match of_string (string json) with
    | Some s -> s
    | None ->
      raise (Jsonoo.Decode_error "opam | esy | global | custom are the only valid values")
  ;;

  let to_string = function
    | Opam -> "opam"
    | Esy -> "esy"
    | Global -> "global"
    | Custom -> "custom"
    | Dune -> "dune"
  ;;

  let to_json s = Jsonoo.Encode.string (to_string s)
end

module Setting = struct
  type t =
    | Opam of Opam.Switch.t
    | Esy of Esy.Manifest.t
    | Global
    | Custom of string
    | Dune of Path.t * bool
  (* path to dune and is_opam: a flag indicating if the dune instance is installed into an Opam switch. *)

  let kind : t -> Kind.t = function
    | Opam _ -> Opam
    | Esy _ -> Esy
    | Global -> Global
    | Custom _ -> Custom
    | Dune _ -> Dune
  ;;

  let of_json json =
    let decode_vars json = Settings.resolve_workspace_vars (Jsonoo.Decode.string json) in
    let kind = Jsonoo.Decode.field "kind" Kind.of_json json in
    match (kind : Kind.t) with
    | Global -> Global
    | Esy ->
      let manifest =
        Jsonoo.Decode.field "root" decode_vars json
        |> Path.of_string
        |> Esy.Manifest.of_path
      in
      Esy manifest
    | Opam ->
      Jsonoo.Decode.field "switch" decode_vars json
      |> Opam.Switch.of_string
      |> (function
       | Some switch -> Opam switch
       | None -> Global)
    | Custom ->
      let template = Jsonoo.Decode.field "template" decode_vars json in
      Custom template
    | Dune ->
      let path = Jsonoo.Decode.field "path" decode_vars json in
      let is_opam =
        Jsonoo.Decode.field "is_opam" Jsonoo.Decode.string json
        |> function
        | "true" -> true
        | _ -> false
      in
      Dune (Path.of_string path, is_opam)
  ;;

  let to_json (t : t) =
    let open Jsonoo.Encode in
    let encode_vars str = string (Settings.substitute_workspace_vars str) in
    let kind = "kind", Kind.to_json (kind t) in
    match t with
    | Global -> Jsonoo.Encode.object_ [ kind ]
    | Esy manifest ->
      object_
        [ kind; "root", encode_vars @@ (manifest |> Esy.Manifest.path |> Path.to_string) ]
    | Opam switch -> object_ [ kind; "switch", encode_vars @@ Opam.Switch.name switch ]
    | Custom template -> object_ [ kind; "template", string template ]
    | Dune (path, is_opam) ->
      object_
        [ kind
        ; "path", string (Path.to_string path)
        ; "is_opam", string (Bool.to_string is_opam)
        ]
  ;;

  let t = Settings.create_setting ~scope:Workspace ~key:"sandbox" ~of_json ~to_json
end

type available_sandboxes =
  { opam : Opam.t option Promise.t
  ; esy : Esy.t option Promise.t
  }

let available_sandboxes () : available_sandboxes =
  { opam = Opam.make (); esy = Esy.make () }
;;

let of_settings () : t option Promise.t =
  let open Promise.Syntax in
  let available = available_sandboxes () in
  let not_available kind =
    let this_ =
      match kind with
      | `Esy -> "esy"
      | `Opam -> "opam"
      | `Dune -> "dune"
    in
    show_message
      `Warn
      "This workspace is configured to use an %s sandbox, but %s isn't available"
      this_
      this_
  in
  match (Settings.get ~section:"ocaml" Setting.t : Setting.t option) with
  | None -> Promise.return None
  | Some (Esy manifest) ->
    let+ esy = available.esy in
    (match esy with
     | None ->
       not_available `Esy;
       None
     | Some esy -> Some (Esy (esy, manifest)))
  | Some (Opam switch) ->
    let open Promise.Syntax in
    let* opam = available.opam in
    (match opam with
     | None ->
       not_available `Opam;
       Promise.return None
     | Some opam ->
       let+ exists = Opam.switch_exists opam switch in
       if exists
       then Some (Opam (opam, switch))
       else (
         show_message
           `Warn
           "Workspace is configured to use the switch %s. This switch does not exist."
           (Opam.Switch.name switch);
         None))
  | Some Global -> Promise.return (Some Global)
  | Some (Custom template) -> Promise.return (Some (Custom template))
  | Some (Dune (path, is_opam)) ->
    let open Promise.Option.Syntax in
    let* root = Promise.return (workspace_root ()) in
    let* dune = Dune.make ~working_dir:root ~dune_path:path ~is_opam () in
    Promise.return (Some (Dune dune))
;;

let detect_esy_sandbox ~project_root esy () =
  let open Promise.Option.Syntax in
  let* esy = esy in
  let open Promise.Syntax in
  let+ esy_build_dir_exists, manifest =
    Promise.all2
      ( Fs.exists Path.(project_root / "_esy" |> Path.to_string)
      , Esy.find_manifest_in_dir project_root )
  in
  match esy_build_dir_exists, manifest with
  | true, Some manifest ->
    (* Esy can be used with [esy.json], [package.json], or without any of those.
       So we check if we find an [_esy] directory, which means the user created
       an Esy sandbox.

       If we don't, but there is an [esy.json] file, we can assume the user
       wants to use Esy. *)
    Some (Esy (esy, manifest))
  | _ -> None
;;

let detect_opam_local_switch ~project_root opam () =
  let open Promise.Option.Syntax in
  let* opam = opam in
  let* switch = Opam.switch_show ~cwd:project_root opam in
  match switch with
  | Local _ as switch -> Promise.Option.return (Opam (opam, switch))
  | Named _ -> Promise.return None
;;

let detect_opam_sandbox ~project_root opam () =
  let open Promise.Option.Syntax in
  let* opam = opam in
  let+ switch = Opam.switch_show ~cwd:project_root opam in
  Opam (opam, switch)
;;

let detect_dune_pkg ~project_root () =
  let open Promise.Syntax in
  Dune.make ~working_dir:project_root ~dune_path:project_root ()
  >>= function
  | Some dune ->
    Dune.is_dpm_enabled dune >>| fun dpm -> if dpm then Some (Dune dune) else None
  | None -> Promise.return None
;;

let detect () =
  let open Promise.Option.Syntax in
  let* project_root = workspace_root () |> Promise.return in
  let available = available_sandboxes () in
  Promise.List.find_map
    (fun f -> f ())
    [ detect_dune_pkg ~project_root
    ; detect_opam_local_switch ~project_root available.opam
    ; detect_esy_sandbox ~project_root available.esy
    ; detect_opam_sandbox ~project_root available.opam
    ]
;;

let of_settings_or_detect () =
  let open Promise.Syntax in
  let* package_manager_opt = of_settings () in
  match package_manager_opt with
  | Some package_manager -> Promise.return (Some package_manager)
  | None -> detect ()
;;

let suggest_to_run_dune_pkg_lock () =
  let open Promise.Syntax in
  let (_ : unit Promise.t) =
    let* maybe_choice =
      Window.informationMessage
        ~options:(MessageOptions.create ~modal:true ())
        ~message:
          "Dune Package Manager is selected as the active sandbox, but dune package \
           management is not enabled in your workspace. One way of enabling it is \
           generate a lock file. Do you want to run dune pkg lock?"
        ~items:
          [ MessageItem.create ~title:"Generate lockfile" ()
          ; MessageItem.create
              ~isCloseAffordance:true
              ~title:"Select a different sandbox"
              ()
          ]
        ()
    in
    match maybe_choice with
    | Some item when Option.value ~default:false (MessageItem.isCloseAffordance item) ->
      Command_api.(execute Internal.select_sandbox) ()
    | None | Some _ -> Command_api.(execute Internal.run_dune_pkg_lock) ()
  in
  ()
;;

let save_to_settings sandbox =
  let open Promise.Syntax in
  let save_setting () =
    let to_setting = function
      | Esy (_, root) -> Setting.Esy root
      | Opam (_, switch) -> Setting.Opam switch
      | Global -> Setting.Global
      | Custom template -> Setting.Custom template
      | Dune dune ->
        let path = Dune.dune_path dune in
        let is_opam = Dune.is_opam dune in
        Setting.Dune (path, is_opam)
    in
    Settings.set ~section:"ocaml" Setting.t (to_setting sandbox)
  in
  match sandbox with
  | Dune dune ->
    Dune.is_dpm_enabled dune
    >>= (function
     | true -> save_setting ()
     | false -> Promise.return (suggest_to_run_dune_pkg_lock ()))
  | _ -> save_setting ()
;;

module Candidate = struct
  type nonrec t =
    { sandbox : t
    ; status : (unit, string) result
    }

  let to_quick_pick current_switch { sandbox; status } =
    let create = QuickPickItem.create in
    let description =
      match status with
      | Error s -> Some (Printf.sprintf "Invalid sandbox: %s" s)
      | Ok () ->
        (match sandbox with
         | Opam (_, switch) ->
           let switch_kind_s =
             match switch with
             | Local _ -> "Local switch"
             | Named _ -> "Global switch"
           in
           if Option.exists current_switch ~f:(Opam.Switch.equal switch)
           then Some (switch_kind_s ^ " | Currently active switch in project root")
           else Some switch_kind_s
         | Esy (_, _) -> Some "Esy"
         | Dune _ -> Some "Use Dune Package Management in this project"
         | Global | Custom _ -> None)
    in
    match sandbox with
    | Opam (_, Named name) -> create ~label:name ?description ()
    | Opam (_, Local path) ->
      let project_name = Path.basename path in
      let project_path = Path.to_string path in
      create ~label:project_name ~detail:project_path ?description ()
    | Esy (_, manifest) ->
      let p = Esy.Manifest.path manifest in
      let project_name = Path.basename p in
      let project_path = Path.to_string p in
      create ~detail:project_path ~label:project_name ?description ()
    | Global ->
      create
        ~label:"Global"
        ?description
        ~detail:"Global sandbox inherited from the environment"
        ()
    | Custom _ ->
      create
        ?description
        ~label:"Custom"
        ~detail:"Custom sandbox using a command template"
        ()
    | Dune _ -> create ~label:"Dune Package Manager" ()
  ;;

  let ok sandbox = { sandbox; status = Ok () }
end

let find_all_dune_binaries root opam () =
  let open Promise.Syntax in
  let* opam_dunes = Dune.get_opam_dunes opam in
  let* current_switch =
    let open Promise.Option.Syntax in
    let* opam = Promise.return opam in
    Opam.switch_show ~cwd:root opam
  in
  let+ system_dune = Dune.get_system_dune_path () in
  opam_dunes, current_switch, system_dune
;;

let custom_dune_input_validation root =
  let open Promise.Syntax in
  let validateInput ~value =
    let path = Path.of_string value in
    let* exists = Fs.exists (Path.to_string path) in
    if not exists
    then Promise.return (Some "Provided path does not exist")
    else (
      let cmd = Cmd.Spawn { bin = path; args = [ "--version" ] } in
      let+ output = Cmd.output cmd ~cwd:(Path.of_string "") in
      match output with
      | Error _ -> Some "Provided path is not a valid dune executable"
      | Ok v ->
        (match Dune.Dune_version.from_string v with
         | None -> Some "Unable to parse dune version"
         | Some version when Dune.Dune_version.is_valid version -> None
         | Some version ->
           let msg =
             Printf.sprintf
               "Dune version %s is not supported. Please use a more recent version."
               (Dune.Dune_version.to_string version)
           in
           Some msg))
  in
  let options =
    InputBoxOptions.create
      ~prompt:"Input the path to the dune executable"
      ~validateInput
      ()
  in
  let* input = Window.showInputBox ~options () in
  match input with
  | None -> Promise.return None
  | Some path_str ->
    Dune.make
      ~working_dir:root
      ~dune_path:(Path.of_string (String.strip path_str))
      ~is_opam:false
      ()
;;

let get_active_switch_for_dpm opam_dunes = function
  | None -> None
  | Some active ->
    List.find_map opam_dunes ~f:(fun (path, switch, version) ->
      if Opam.Switch.equal switch active
      then (
        let switch_kind_s =
          match switch with
          | Opam.Switch.Local _ -> "Local switch"
          | Opam.Switch.Named _ -> "Global switch"
        in
        let switch_name =
          match switch with
          | Opam.Switch.Local p -> Path.basename p
          | Opam.Switch.Named n -> n
        in
        let label =
          Printf.sprintf
            "Dune %s, via opam switch %s"
            (Dune.Dune_version.to_string version)
            switch_name
        in
        let description = switch_kind_s ^ " | Currently active switch in project root" in
        Some
          ( QuickPickItem.create
              ~label
              ~description
              ~detail:
                (Printf.sprintf "%s" (Path.to_string (Dune.construct_dune_path path)))
              ()
          , `Opam_dune (Dune.construct_dune_path path) ))
      else None)
;;

let get_non_active_opam_dunes opam_dunes current_switch =
  let inactive_dunes =
    List.filter opam_dunes ~f:(fun (_path, switch, _version) ->
      match current_switch with
      | Some active -> not (Opam.Switch.equal switch active)
      | None -> true)
  in
  let global_dunes, local_dunes =
    List.partition_tf inactive_dunes ~f:(fun (_, switch, _) ->
      match switch with
      | Opam.Switch.Named _ -> true
      | Opam.Switch.Local _ -> false)
  in
  let to_item (path, switch, version) =
    let switch_name =
      match switch with
      | Opam.Switch.Local p -> Path.basename p
      | Opam.Switch.Named n -> n
    in
    ( QuickPickItem.create
        ~label:
          (Printf.sprintf
             "Dune %s, via opam switch %s"
             (Dune.Dune_version.to_string version)
             switch_name)
        ~detail:(Printf.sprintf "%s" (Path.to_string (Dune.construct_dune_path path)))
        ()
    , `Opam_dune (Dune.construct_dune_path path) )
  in
  List.map ~f:to_item global_dunes, List.map ~f:to_item local_dunes
;;

let select_dune_binary () =
  let open Promise.Syntax in
  match workspace_root () with
  | None -> Promise.return None
  | Some root ->
    let* opam = Opam.make () in
    let create = QuickPickItem.create in
    let data = ref None in
    let options =
      ProgressOptions.create
        ~location:(`ProgressLocation Notification)
        ~title:"Discovering Dune binaries..."
        ~cancellable:false
        ()
    in
    let task ~progress:_ ~token:_ =
      let+ opam_dunes, current_switch, system_dune =
        find_all_dune_binaries root opam ()
      in
      data := Some (opam_dunes, current_switch, system_dune)
    in
    let* () = Window.withProgress (module Interop.Js.Unit) ~options ~task in
    (match !data with
     | None -> Promise.return None
     | Some (opam_dunes, current_switch, system_dune) ->
       let active_switch_item = get_active_switch_for_dpm opam_dunes current_switch in
       let global_dune_items, other_local_dune_items =
         get_non_active_opam_dunes opam_dunes current_switch
       in
       let system_dune_item =
         match system_dune with
         | Some (path, version) ->
           let label =
             Printf.sprintf
               "Dune %s, via system PATH"
               (Dune.Dune_version.to_string version)
           in
           Some
             ( create ~label ~description:"System Dune" ~detail:path ()
             , `System_dune (Path.of_string path) )
         | None -> None
       in
       let custom_dune_item =
         ( create
             ~label:"Custom path to dune"
             ~detail:"Provide a custom path to a dune executable"
             ()
         , `Custom_dune )
       in
       let separator =
         create ~label:"Other dunes" ~kind:QuickPickItemKind.Separator (), `Separator
       in
       let other_dune_items = global_dune_items @ other_local_dune_items in
       let choices =
         Option.to_list active_switch_item
         @ Option.to_list system_dune_item
         @ [ custom_dune_item ]
         @ if List.is_empty other_dune_items then [] else separator :: other_dune_items
       in
       let options =
         QuickPickOptions.create
           ~canPickMany:false
           ~placeHolder:
             "Which dune binary do you want to use for Dune Package Management?"
           ()
       in
       let* choice = Window.showQuickPickItems ~choices ~options () in
       (match choice with
        | None | Some `Separator -> Promise.return None
        | Some (`Opam_dune path) -> Dune.make ~working_dir:root ~dune_path:path ()
        | Some (`System_dune path) ->
          Dune.make ~working_dir:root ~dune_path:path ~is_opam:false ()
        | Some `Custom_dune -> custom_dune_input_validation root))
;;

let select_sandbox (choices : Candidate.t list) _t =
  let placeHolder = "Which package manager would you like to manage the sandbox?" in
  let open Promise.Syntax in
  let* current_switch =
    let open Promise.Option.Syntax in
    let* opam = Opam.make () in
    let* cwd = workspace_root () |> Promise.return in
    Opam.switch_show ~cwd opam
  in
  let choices =
    List.map
      ~f:(fun (sandbox : Candidate.t) ->
        let quick_pick = Candidate.to_quick_pick current_switch sandbox in
        quick_pick, sandbox)
      choices
  in
  let options = QuickPickOptions.create ~canPickMany:false ~placeHolder () in
  Window.showQuickPickItems ~choices ~options ()
;;

let sandbox_candidates ~workspace_folders =
  let open Promise.Syntax in
  let available = available_sandboxes () in
  let esy =
    let* esy = available.esy in
    match esy with
    | None -> Promise.return []
    | Some esy ->
      let+ esys =
        workspace_folders
        |> List.map ~f:(fun (folder : WorkspaceFolder.t) ->
          let dir = folder |> WorkspaceFolder.uri |> Uri.fsPath |> Path.of_string in
          Esy.discover ~dir)
        |> Promise.all_list
      in
      List.concat esys
      |> List.map ~f:(fun ({ manifest; status } : Esy.discover) ->
        { Candidate.sandbox = Esy (esy, manifest); status })
  in
  let opam =
    let* opam = available.opam in
    match opam with
    | None -> Promise.return ([], None)
    | Some opam ->
      let* current_switch =
        match workspace_root () with
        | None -> Promise.return None
        | Some cwd -> Opam.switch_show ~cwd opam
      in
      let+ switches = Opam.switch_list opam in
      (match current_switch with
       | None ->
         let switches =
           List.map switches ~f:(fun sw ->
             let sandbox = Opam (opam, sw) in
             { Candidate.sandbox; status = Ok () })
         in
         switches, None
       | Some current_switch ->
         let f sw =
           let sandbox = Opam (opam, sw) in
           if Opam.Switch.equal current_switch sw
           then None
           else Some { Candidate.sandbox; status = Ok () }
         in
         let sandboxes = List.filter_map switches ~f
         and current_switch_sandbox =
           let sandbox = Opam (opam, current_switch) in
           Some { Candidate.sandbox; status = Ok () }
         in
         sandboxes, current_switch_sandbox)
  in
  let global = Candidate.ok Global in
  let custom =
    Candidate.ok (Custom "$prog $args")
    (* doesn't matter what the custom fields are set to here user will input
       custom commands in [select] *)
  in
  let dune =
    match Platform.t with
    | Win32 -> Promise.return None
    | Darwin | Linux | Other ->
      let* opam = available.opam in
      (match workspace_root () with
       | None -> Promise.return None
       | Some root ->
         let* dune_binary = find_all_dune_binaries root opam () in
         let dune_path, is_opam =
           match dune_binary with
           | _, _, Some (path, _) -> Some path, false
           | (path, _, _) :: _, _, _ -> Some path, true
           | _ -> None, false
         in
         (match dune_path with
          | None -> Promise.return None
          | Some dune_path ->
            let+ dune =
              Dune.make
                ~working_dir:root
                ~dune_path:(Path.of_string dune_path)
                ~is_opam
                ()
            in
            (match dune with
             | Some dune -> Some { Candidate.sandbox = Dune dune; status = Ok () }
             | None -> None)))
  in
  let+ esy, (opam, current_switch), dune = Promise.all3 (esy, opam, dune) in
  let cs = global :: custom :: (Option.to_list dune @ esy @ opam) in
  Option.value_map current_switch ~default:cs ~f:(fun current_switch ->
    current_switch :: cs)
;;

let select_sandbox t =
  let open Promise.Syntax in
  let workspace_folders = Workspace.workspaceFolders () in
  let* candidates = sandbox_candidates ~workspace_folders in
  let open Promise.Option.Syntax in
  let* candidate = select_sandbox candidates t in
  match candidate with
  | { status = Ok (); sandbox = Custom _ } ->
    let validateInput ~value =
      if
        String.is_substring value ~substring:"$prog"
        && String.is_substring value ~substring:"$args"
      then Promise.return None
      else Promise.Option.return "Command template must include $prog and $args"
    in
    let options =
      InputBoxOptions.create
        ~prompt:"Input a custom command template"
        ~value:"$prog $args"
        ~validateInput
        ()
    in
    let* input = Window.showInputBox ~options () in
    let template = String.strip input in
    Promise.Option.return @@ Custom template
  | { status = Ok (); sandbox = Dune _ } ->
    let+ dune = select_dune_binary () in
    Dune dune
  | { status; sandbox } ->
    (match status with
     | Error s ->
       show_message `Warn "This sandbox is invalid. Error: %s" s;
       Promise.return None
     | Ok () -> Promise.Option.return sandbox)
;;

let select_sandbox_and_save t =
  let open Promise.Option.Syntax in
  let* sandbox = select_sandbox t in
  let open Promise.Syntax in
  let+ () = save_to_settings sandbox in
  Some sandbox
;;

let get_command
      sandbox
      bin
      args
      (dune_cmd_type : [> `Tool | `Command | `Exec | `Install ])
  : Cmd.t
  =
  match sandbox with
  | Opam (opam, switch) -> Opam.exec opam switch ~args:(bin :: args)
  | Esy (esy, manifest) -> Esy.exec esy manifest ~args:(bin :: args)
  | Dune dune ->
    (match dune_cmd_type with
     | `Install -> Dune.tools ~tool:bin ~args dune `Install
     | `Tool -> Dune.tools ~tool:bin ~args dune `Exec_
     | `Command -> Dune.command dune ~args
     | `Exec -> Dune.exec ~target:bin ~args dune)
  | Global -> Spawn { bin = Path.of_string bin; args }
  | Custom template ->
    let command =
      template
      |> String.substr_replace_all ~pattern:"$prog" ~with_:(Cmd.quote bin)
      |> String.substr_replace_all ~pattern:"$args" ~with_:(String.concat ~sep:" " args)
      |> String.strip
    in
    Shell command
;;

let get_install_command sandbox tools =
  match sandbox with
  | Opam (opam, switch) -> Some (Opam.install opam switch ~packages:tools)
  | Esy (esy, manifest) -> Some (Esy.install esy manifest ~packages:tools)
  | _ -> None
;;

let get_exec_command sandbox tools =
  match sandbox with
  | Opam (opam, switch) -> Some (Opam.exec opam switch ~args:tools)
  | Esy (esy, manifest) -> Some (Esy.exec esy manifest ~args:tools)
  | _ -> None
;;

let ocaml_version sandbox =
  let open Promise.Result.Syntax in
  let cmd = get_command sandbox "ocamlc" [ "-version" ] `Exec in
  let* cmd = Cmd.check cmd in
  let+ output = Cmd.output cmd in
  String.strip output
;;

let packages t =
  let open Promise.Result.Syntax in
  match t with
  | Global -> Promise.Result.return []
  | Custom _ | Dune _ -> Promise.Result.return []
  | Esy (esy, manifest) ->
    let+ r = Esy.packages esy manifest in
    List.map r ~f:Package.of_esy
  | Opam (opam, switch) ->
    let+ r = Opam.packages opam switch in
    List.map r ~f:Package.of_opam
;;

let root_packages t =
  let open Promise.Result.Syntax in
  match t with
  | Global -> Promise.Result.return []
  | Custom _ | Dune _ -> Promise.Result.return []
  | Esy (esy, manifest) ->
    let+ r = Esy.root_packages esy manifest in
    List.map r ~f:Package.of_esy
  | Opam (opam, switch) ->
    let+ r = Opam.root_packages opam switch in
    List.map r ~f:Package.of_opam
;;

let uninstall_packages t packages =
  let options =
    ProgressOptions.create
      ~location:(`ProgressLocation Notification)
      ~title:"Uninstalling sandbox packages"
      ~cancellable:false
      ()
  in
  match t with
  | Global ->
    show_message `Error "Uninstalling packages is not supported for Global sandboxes";
    Promise.return ()
  | Custom _ ->
    show_message `Error "Uninstalling packages is not supported for Custom sandboxes";
    Promise.return ()
  | Dune _ ->
    show_message
      `Error
      "Uninstalling packages is not yet supported for Dune Package Manager";
    Promise.return ()
  | Esy (_esy, _manifest) ->
    (* TODO: Implement Esy sandbox inspection *)
    show_message `Error "Uninstalling packages is not supported for Esy sandboxes";
    Promise.return ()
  | Opam (opam, switch) ->
    let opam_packages =
      List.filter_map
        ~f:(function
          | Package.Esy _ -> None
          | Opam pkg -> Some pkg)
        packages
    in
    let task ~progress:_ ~token:_ =
      let open Promise.Syntax in
      let+ result =
        let open Promise.Result.Syntax in
        let+ _ = Opam.package_remove opam switch opam_packages |> Cmd.output in
        ()
      in
      match result with
      | Ok () -> ()
      | Error err ->
        show_message `Error "An error occured while uninstalling the packages: %s" err
    in
    let open Promise.Syntax in
    let+ () = Vscode.Window.withProgress (module Interop.Js.Unit) ~options ~task in
    ()
;;

let install_packages t packages =
  let options =
    ProgressOptions.create
      ~location:(`ProgressLocation Notification)
      ~title:("Installing sandbox packages: " ^ String.concat ~sep:", " packages)
      ~cancellable:false
      ()
  in
  match t with
  | Global ->
    show_message `Error "Installing packages is not supported for Global sandboxes";
    Promise.return ()
  | Custom _ ->
    show_message `Error "Installing packages is not supported for Custom sandboxes";
    Promise.return ()
  | Dune _ ->
    show_message
      `Error
      "Installing packages is not yet supported for Dune Package Manager";
    Promise.return ()
  | Esy (_esy, _manifest) ->
    (* TODO: Implement Esy sandbox inspection *)
    show_message `Error "Installing packages is not supported for Esy sandboxes";
    Promise.return ()
  | Opam (opam, switch) ->
    let task ~progress:_ ~token:_ =
      let open Promise.Syntax in
      let+ result =
        let open Promise.Result.Syntax in
        let* _ = Opam.update opam switch |> Cmd.output in
        let+ _ = Opam.install opam switch ~packages |> Cmd.output in
        ()
      in
      match result with
      | Ok () -> ()
      | Error err ->
        show_message `Error "An error occured while installing the packages: %s" err
    in
    let open Promise.Syntax in
    let+ () = Vscode.Window.withProgress (module Interop.Js.Unit) ~options ~task in
    ()
;;

let upgrade_packages ?(packages = []) t =
  let options =
    ProgressOptions.create
      ~location:(`ProgressLocation Notification)
      ~title:"Upgrading sandbox packages"
      ~cancellable:false
      ()
  in
  match t with
  | Global ->
    show_message `Error "Upgrading packages is not supported for Global sandboxes";
    Promise.return ()
  | Custom _ ->
    show_message `Error "Upgrading packages is not supported for Custom sandboxes";
    Promise.return ()
  | Dune _ ->
    show_message `Error "Upgrading packages is not yet supported for Dune Package Manager";
    Promise.return ()
  | Esy (_esy, _manifest) ->
    (* TODO: Implement Esy sandbox inspection *)
    show_message `Error "Upgrading packages is not supported for Esy sandboxes";
    Promise.return ()
  | Opam (opam, switch) ->
    let task ~progress:_ ~token:_ =
      let open Promise.Syntax in
      let+ result =
        let open Promise.Result.Syntax in
        let* _ = Opam.update opam switch |> Cmd.output in
        let+ _ = Opam.upgrade ~packages opam switch |> Cmd.output in
        ()
      in
      match result with
      | Ok () -> ()
      | Error err ->
        show_message `Error "An error occured while upgrading the packages: %s" err
    in
    let open Promise.Syntax in
    let+ () = Vscode.Window.withProgress (module Interop.Js.Unit) ~options ~task in
    ()
;;

let focus_on_package_command ?sandbox () =
  match sandbox with
  | None | Some (Opam _) ->
    let (lazy output) = Output.command_output_channel in
    Vscode.OutputChannel.show output ()
  | _ -> ()
;;
