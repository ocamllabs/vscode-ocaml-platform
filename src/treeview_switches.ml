open Import

module Dependency = struct
  type t =
    | Switch of Opam.Switch.t
    | Dependency of (Opam.Package.t * t option)

  let rec sexp_of_t : t -> Sexp.t = function
    | Switch (Named name) ->
      List [ Atom "switch"; List [ Atom "named"; Atom name ] ]
    | Switch (Local path) ->
      let name = Path.to_string path in
      List [ Atom "switch"; List [ Atom "local"; Atom name ] ]
    | Dependency (package, None) ->
      List
        [ Atom "dependency"
        ; List [ Atom "package"; Opam.Package.sexp_of_t package ]
        ]
    | Dependency (package, Some t) ->
      List
        [ Atom "dependency"
        ; List [ Atom "package"; Opam.Package.sexp_of_t package ]
        ; List [ Atom "parent"; sexp_of_t t ]
        ]

  let rec t_of_sexp : Sexp.t -> t = function
    | List [ Atom "switch"; List [ Atom "named"; Atom name ] ] ->
      Switch (Named name)
    | List [ Atom "switch"; List [ Atom "local"; Atom name ] ] ->
      let path = Path.of_string name in
      Switch (Local path)
    | List [ Atom "dependency"; List [ Atom "package"; package ] ] ->
      Dependency (Opam.Package.t_of_sexp package, None)
    | List
        [ Atom "dependency"
        ; List [ Atom "package"; package ]
        ; List [ Atom "parent"; parent ]
        ] ->
      Dependency (Opam.Package.t_of_sexp package, Some (t_of_sexp parent))
    | _ -> assert false

  let to_string t = t |> sexp_of_t |> Sexp.to_string

  let of_string s = s |> Sexp.of_string |> t_of_sexp

  let label = function
    | Switch (Named name) -> name
    | Switch (Local path) ->
      let name = Path.to_string path in
      name
    | Dependency (dep, _) -> Opam.Package.name dep

  let description ~opam = function
    | Dependency (dep, _) -> Promise.return (Some (Opam.Package.version dep))
    | Switch switch -> Opam.get_switch_compiler opam switch

  let tooltip = function
    | Dependency (dep, _) -> Opam.Package.synopsis dep
    | Switch (Named _) -> None
    | Switch (Local _) -> None

  let context_value = function
    | Dependency (dep, _) -> (
      match Opam.Package.documentation dep with
      | Some _ -> "package-with-doc"
      | None -> "package" )
    | Switch _ -> "switch"

  let icon ~extension_path = function
    | Dependency _ ->
      TreeItem.LightDarkIcon.
        { light = `String (extension_path ^ "/assets/number-light.svg")
        ; dark = `String (extension_path ^ "/assets/number-dark.svg")
        }
    | Switch _ ->
      TreeItem.LightDarkIcon.
        { light = `String (extension_path ^ "/assets/dependency-light.svg")
        ; dark = `String (extension_path ^ "/assets/dependency-dark.svg")
        }

  let collapsible_state = function
    | Dependency _ -> Vscode.TreeItemCollapsibleState.None
    | Switch _ -> Vscode.TreeItemCollapsibleState.Collapsed
end

module Command = struct
  let remove_switch ~args =
    let (_ : unit Promise.t) =
      let arg = List.hd_exn args in
      let tree_item = TreeItem.t_of_js arg in
      let dependency =
        tree_item |> TreeItem.id |> Stdlib.Option.get |> Dependency.of_string
      in
      match dependency with
      | Dependency _ ->
        Promise.return
        @@ show_message `Warn
             "Cannot delete a switch from a package dependency."
      | Switch switch -> (
        let open Promise.Syntax in
        let* opam_opt = Opam.make () in
        match opam_opt with
        | None ->
          Promise.return
          @@ show_message `Warn "Opam could not be found on your system."
        | Some opam -> (
          let+ result = Opam.remove_switch opam switch |> Cmd.output in
          match result with
          | Error err -> show_message `Error "%s" err
          | Ok _ ->
            let (_ : Ojs.t option Promise.t) =
              Vscode.Commands.executeCommand
                (module Ojs)
                ~command:Extension_consts.Commands.refresh_switches ~args:[]
            in
            show_message `Info "The switch has been removed successfully." ) )
    in
    ()

  let open_documentation ~args =
    let (_ : unit Promise.t) =
      let arg = List.hd_exn args in
      let tree_item = TreeItem.t_of_js arg in
      let dependency =
        tree_item |> TreeItem.id |> Stdlib.Option.get |> Dependency.of_string
      in
      match dependency with
      | Switch _ ->
        Promise.return
        @@ show_message `Warn "Cannot open documentation of a switch."
      | Dependency (pkg, _) -> (
        let open Promise.Syntax in
        let doc = Opam.Package.documentation pkg in
        match doc with
        | None -> Promise.return ()
        | Some doc ->
          let+ _ =
            Vscode.Commands.executeCommand
              (module Ojs)
              ~command:"vscode.open"
              ~args:[ Vscode.Uri.parse doc () |> Vscode.Uri.t_to_js ]
          in
          () )
    in
    ()
end

let make_item ~extension_path ~opam dependency =
  let open Promise.Syntax in
  let icon = `LightDark (Dependency.icon ~extension_path dependency) in
  let collapsibleState = Dependency.collapsible_state dependency in
  let label =
    `TreeItemLabel
      (Vscode.TreeItemLabel.create ~label:(Dependency.label dependency) ())
  in
  let item = Vscode.TreeItem.make_label ~label ~collapsibleState () in
  TreeItem.set_id item (Dependency.to_string dependency);
  TreeItem.set_iconPath item icon;
  TreeItem.set_contextValue item (Dependency.context_value dependency);
  let+ _ =
    Promise.Option.iter
      (fun desc -> TreeItem.set_description item (`String desc))
      (Dependency.description ~opam dependency)
  in
  Option.iter (Dependency.tooltip dependency) ~f:(fun desc ->
      TreeItem.set_tooltip item (`String desc));
  item

let get_dependency_dependencies _dependency = Promise.return (Some [])

let get_switch_dependencies opam switch =
  let open Promise.Syntax in
  let* packages = Opam.get_switch_packages opam switch in
  match packages with
  | Ok packages ->
    let names =
      packages
      |> List.map ~f:(fun n ->
             Dependency.Dependency (n, Some (Dependency.Switch switch)))
    in
    Promise.return (Some names)
  | Error err ->
    let* _ =
      Vscode.Window.showInformationMessage
        ~message:
          (Printf.sprintf
             "An error occured while reading the switch dependencies: %s" err)
        ()
    in
    Promise.return None

let get_dependencies ~opam ~extension_path element =
  let open Promise.Syntax in
  let dependency =
    match Vscode.TreeItem.id element with
    | None ->
      (* This should never happen, the elements are always created with an ID. *)
      assert false
    | Some dep -> Dependency.of_string dep
  in
  let dependencies_opt_to_tree_items deps_opt =
    let* deps_opt = deps_opt in
    match deps_opt with
    | None -> Promise.return None
    | Some deps ->
      let* items =
        List.map deps ~f:(make_item ~opam ~extension_path) |> Promise.all_list
      in
      Promise.return (Some items)
  in
  match dependency with
  | Dependency.Switch switch ->
    let deps = get_switch_dependencies opam switch in
    dependencies_opt_to_tree_items deps
  | Dependency.Dependency dependency ->
    let deps = get_dependency_dependencies dependency in
    dependencies_opt_to_tree_items deps

let register extension =
  let (_ : unit Promise.t) =
    let open Promise.Syntax in
    let extension_path = Vscode.ExtensionContext.extensionPath extension in
    let+ opam = Opam.make () in
    let getChildren ?element () =
      match opam with
      | None -> `Value None
      | Some opam -> (
        match element with
        | Some element ->
          `Promise (get_dependencies ~opam ~extension_path element)
        | None ->
          let items =
            let* switches = Opam.switch_list opam in
            let+ items =
              Promise.List.filter_map
                (fun switch ->
                  let+ deps =
                    make_item ~opam ~extension_path (Dependency.Switch switch)
                  in
                  Some deps)
                switches
            in
            Some items
          in
          `Promise items )
    in
    let getTreeItem ~element = `Value element in
    let module EventEmitter =
      Vscode.EventEmitter.Make (Interop.Js.Or_undefined (TreeItem)) in
    let event_emitter = EventEmitter.make () in
    let event = EventEmitter.event event_emitter in
    let module TreeDataProvider = Vscode.TreeDataProvider.Make (Vscode.TreeItem) in
    let treeDataProvider =
      TreeDataProvider.create ~getTreeItem ~getChildren
        ~onDidChangeTreeData:event ()
    in

    let disposable =
      Vscode.Window.registerTreeDataProvider
        (module Vscode.TreeItem)
        ~viewId:"ocaml-switches" ~treeDataProvider
    in
    ExtensionContext.subscribe extension ~disposable;

    let disposable =
      Commands.registerCommand
        ~command:Extension_consts.Commands.open_documentation
        ~callback:Command.open_documentation
    in
    ExtensionContext.subscribe extension ~disposable;

    let disposable =
      Commands.registerCommand ~command:Extension_consts.Commands.remove_switch
        ~callback:Command.remove_switch
    in
    ExtensionContext.subscribe extension ~disposable;

    let disposable =
      Commands.registerCommand
        ~command:Extension_consts.Commands.refresh_switches
        ~callback:(fun ~args:_ -> EventEmitter.fire event_emitter None)
    in
    ExtensionContext.subscribe extension ~disposable
  in
  ()
