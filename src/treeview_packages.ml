open Import

module Dependency = struct
  type t =
    | Switch of Opam.Switch.t
    | Dependency of (string * t option)

  let rec sexp_of_t' =
    let open Sexp in
    function
    | Switch (Named name) ->
      List [ Atom "switch"; List [ Atom "named"; Atom name ] ]
    | Switch (Local path) ->
      let name = Path.to_string path in
      List [ Atom "switch"; List [ Atom "local"; Atom name ] ]
    | Dependency (dep, None) -> List [ Atom "dependency"; Atom dep ]
    | Dependency (dep, Some t) ->
      List [ Atom "dependency"; Atom dep; List [ Atom "parent"; sexp_of_t' t ] ]

  let sexp_of_t = sexp_of_t'

  let rec t_of_sexp' =
    let open Sexp in
    function
    | List [ Atom "switch"; List [ Atom "named"; Atom name ] ] ->
      Switch (Named name)
    | List [ Atom "switch"; List [ Atom "local"; Atom name ] ] ->
      let path = Path.of_string name in
      Switch (Local path)
    | List [ Atom "dependency"; Atom dep ] -> Dependency (dep, None)
    | List [ Atom "dependency"; Atom dep; Atom "parent"; sexp ] ->
      Dependency (dep, Some (t_of_sexp' sexp))
    | _ -> assert false

  let t_of_sexp = t_of_sexp'

  let to_string t = t |> sexp_of_t |> Sexp.to_string

  let of_string s = s |> Sexp.of_string |> t_of_sexp

  let label = function
    | Switch (Named name) -> name
    | Switch (Local path) ->
      let name = Path.to_string path in
      name
    | Dependency (dep, _) -> dep
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
  item

let get_dependency_dependencies _dependency = Promise.return (Some [])

let get_switch_dependencies switch =
  let open Promise.Syntax in
  let* packages = Opam.get_switch_packages switch in
  match packages with
  | Ok packages ->
    let names =
      List.map packages ~f:Opam.Package.name
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
    | None -> assert false
    | Some dep -> Dependency.of_string dep
  in
  match dependency with
  | Dependency.Switch switch ->
    let+ deps = get_switch_dependencies switch in
    deps |> Option.map ~f:(List.map ~f:(make_dependency_item ~extension_path))
  | Dependency.Dependency dependency ->
    let+ deps = get_dependency_dependencies dependency in
    deps |> Option.map ~f:(List.map ~f:(make_dependency_item ~extension_path))

let register extension =
  let open Promise.Syntax in
  let extension_path = Vscode.ExtensionContext.extensionPath extension in
  let* opam = Opam.make () in
  match opam with
  | None -> Promise.return ()
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
    let treeDataProvider =
      Vscode.TreeDataProvider.create ~getTreeItem ~getChildren ()
    in
    let _ =
      Vscode.Window.registerTreeDataProvider ~viewId:"ocaml-packages"
        ~treeDataProvider
    in
    ()
