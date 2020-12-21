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
        ; List [ Atom "package"; package; Atom "parent"; sexp ]
        ] ->
      Dependency (Opam.Package.t_of_sexp package, Some (t_of_sexp sexp))
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
    | Dependency (dep, _) -> Some (Opam.Package.version dep)
    | Switch (Named _) -> None
    | Switch (Local _) -> None

  let tooltip = function
    | Dependency (dep, _) -> Opam.Package.synopsis dep
    | Switch (Named _) -> None
    | Switch (Local _) -> None
end

let make_switch_item ~extension_path switch =
  let icon =
    `LightDark
      TreeItem.LightDarkIcon.
        { light = `String (extension_path ^ "/assets/dependency-light.svg")
        ; dark = `String (extension_path ^ "/assets/dependency-dark.svg")
        }
  in
  let dependency = Dependency.Switch switch in
  let label =
    Vscode.TreeItemLabel.create ~label:(Dependency.label dependency) ()
  in
  let item =
    Vscode.TreeItem.make ~label
      ~collapsibleState:Vscode.TreeItemCollapsibleState.Collapsed ()
  in
  TreeItem.set_id item (Dependency.to_string dependency);
  TreeItem.set_iconPath item icon;
  TreeItem.set_contextValue item "switch";
  Option.iter (Dependency.description dependency) ~f:(fun desc ->
      TreeItem.set_description item (`String desc));
  Option.iter (Dependency.tooltip dependency) ~f:(fun desc ->
      TreeItem.set_tooltip item (`String desc));
  item

let make_dependency_item ~extension_path dependency =
  let icon =
    `LightDark
      TreeItem.LightDarkIcon.
        { light = `String (extension_path ^ "/assets/number-light.svg")
        ; dark = `String (extension_path ^ "/assets/number-dark.svg")
        }
  in
  let label =
    Vscode.TreeItemLabel.create ~label:(Dependency.label dependency) ()
  in
  let item = Vscode.TreeItem.make ~label () in
  TreeItem.set_id item (Dependency.to_string dependency);
  TreeItem.set_iconPath item icon;
  TreeItem.set_contextValue item "package";
  Option.iter (Dependency.description dependency) ~f:(fun desc ->
      TreeItem.set_description item (`String desc));
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
  let dependencies_opt_to_tree_items =
    Option.map ~f:(List.map ~f:(make_dependency_item ~extension_path))
  in
  match dependency with
  | Dependency.Switch switch ->
    let+ deps = get_switch_dependencies switch in
    dependencies_opt_to_tree_items deps
  | Dependency.Dependency dependency ->
    let+ deps = get_dependency_dependencies dependency in
    dependencies_opt_to_tree_items deps

let register extension =
  let open Promise.Syntax in
  let extension_path = Vscode.ExtensionContext.extensionPath extension in
  let* opam = Opam.make () in
  match opam with
  | None -> Promise.return None
  | Some opam ->
    let+ switches = Opam.switch_list opam in
    let items =
      List.filter_map switches ~f:(function
        | Opam.Switch.Named name
          when String.is_prefix name ~prefix:"vscode-ocaml-toolchain" ->
          None
        | switch -> Some (make_switch_item ~extension_path switch))
    in
    let getChildren ~element =
      match element with
      | None -> `Promise (Promise.return (Some items))
      | Some element -> `Promise (get_dependencies ~extension_path element)
    in
    let getTreeItem ~element = Promise.return element in
    let event_emitter = Vscode.EventEmitter.make () in
    let event = Vscode.EventEmitter.event event_emitter in
    let treeDataProvider =
      Vscode.TreeDataProvider.create ~getTreeItem ~getChildren
        ~onDidChangeTreeData:event ()
    in
    let _ =
      Vscode.Window.registerTreeDataProvider ~viewId:"ocaml-switches"
        ~treeDataProvider
    in
    Some event_emitter
