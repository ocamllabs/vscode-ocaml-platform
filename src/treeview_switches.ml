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

  let to_treeitem t = t |> sexp_of_t |> Sexp.to_string

  let of_treeitem s = s |> Sexp.of_string |> t_of_sexp

  let label = function
    | Switch (Named name) -> name
    | Switch (Local path) ->
      let name = Path.to_string path in
      name
    | Dependency (dep, _) -> Opam.Package.name dep

  let description = function
    | Dependency (dep, _) -> Promise.return (Some (Opam.Package.version dep))
    | Switch switch -> Opam.Switch.compiler switch

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

let make_item ~extension_path dependency =
  let open Promise.Syntax in
  let icon = `LightDark (Dependency.icon ~extension_path dependency) in
  let collapsibleState = Dependency.collapsible_state dependency in
  let label =
    Vscode.TreeItemLabel.create ~label:(Dependency.label dependency) ()
  in
  let item = Vscode.TreeItem.make ~label ~collapsibleState () in
  TreeItem.set_id item (Dependency.to_string dependency);
  TreeItem.set_iconPath item icon;
  TreeItem.set_contextValue item (Dependency.context_value dependency);
  let+ _ =
    Promise.Option.iter
      (fun desc -> TreeItem.set_description item (`String desc))
      (Dependency.description dependency)
  in
  Option.iter (Dependency.tooltip dependency) ~f:(fun desc ->
      TreeItem.set_tooltip item (`String desc));
  item

let get_dependency_dependencies _dependency = Promise.return (Some [])

let get_switch_dependencies switch =
  let open Promise.Syntax in
  let* packages = Opam.get_switch_packages switch in
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

let get_dependencies ~extension_path element =
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
        List.fold_left ~init:(Promise.return [])
          ~f:(fun acc el ->
            let* acc = acc in
            let+ item = make_item ~extension_path el in
            item :: acc)
          deps
      in
      Promise.return (Some items)
  in
  match dependency with
  | Dependency.Switch switch ->
    let deps = get_switch_dependencies switch in
    dependencies_opt_to_tree_items deps
  | Dependency.Dependency dependency ->
    let deps = get_dependency_dependencies dependency in
    dependencies_opt_to_tree_items deps

let register extension =
  let open Promise.Syntax in
  let extension_path = Vscode.ExtensionContext.extensionPath extension in
  let+ opam = Opam.make () in
  let getChildren ~element =
    match element with
    | None ->
      let items =
        match opam with
        | None -> Promise.return None
        | Some opam ->
          let* switches = Opam.switch_list opam in
          let+ items =
            Promise.List.filter_map
              (function
                | Opam.Switch.Named name
                  when String.is_prefix name ~prefix:"vscode-ocaml-toolchain" ->
                  Promise.return None
                | switch ->
                  let+ deps =
                    make_item ~extension_path (Dependency.Switch switch)
                  in
                  Some deps)
              switches
          in
          Some items
      in
      `Promise items
    | Some element -> `Promise (get_dependencies ~extension_path element)
  in
  let getTreeItem ~element = Promise.return element in
  let event_emitter = Vscode.EventEmitter.make () in
  let event = Vscode.EventEmitter.event event_emitter in
  let treeDataProvider =
    Vscode.TreeDataProvider.create ~getTreeItem ~getChildren
      ~onDidChangeTreeData:event ()
  in
  let refresh () = EventEmitter.fire event_emitter Ojs.null in
  let disposable =
    Vscode.Window.registerTreeDataProvider ~viewId:"ocaml-switches"
      ~treeDataProvider
  in
  (disposable, refresh)
