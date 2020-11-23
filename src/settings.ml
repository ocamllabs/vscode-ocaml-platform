open Import

type 'a t =
  { key : string
  ; to_json : 'a -> Jsonoo.t
  ; of_json : Jsonoo.t -> 'a
  ; scope : ConfigurationTarget.t
  }

let create ~scope ~key ~of_json ~to_json = { scope; key; to_json; of_json }

let get ?section t =
  let section = Workspace.getConfiguration ?section () in
  match WorkspaceConfiguration.get section ~section:t.key () with
  | None -> None
  | Some v -> (
    match t.of_json v with
    | s -> Some s
    | exception Jsonoo.Decode_error msg ->
      show_message `Error "Setting %s is invalid: %s" t.key msg;
      None )

let set ?section t v =
  let section = Workspace.getConfiguration ?section () in
  match Workspace.name () with
  | None -> Promise.return ()
  | Some _ ->
    WorkspaceConfiguration.update section ~section:t.key ~value:(t.to_json v)
      ~configurationTarget:(`ConfigurationTarget t.scope) ()

let string =
  let to_json = Jsonoo.Encode.string in
  let of_json = Jsonoo.Decode.string in
  create ~of_json ~to_json

let workspace_folder_var folder =
  Printf.sprintf "${workspaceFolder:%s}" (WorkspaceFolder.name folder)

let workspace_folder_path folder = Uri.fsPath (WorkspaceFolder.uri folder)

let resolve_workspace_vars setting =
  let find_folder name =
    let pred folder = String.equal name (WorkspaceFolder.name folder) in
    List.find ~f:pred (Workspace.workspaceFolders ())
  in
  let regexp = Js_of_ocaml.Regexp.regexp "\\$\\{workspaceFolder:([^}]+)\\}" in
  let replacer ~matched ~captures ~offset:_ ~string:_ =
    match captures with
    | [ name ] -> (
      match find_folder name with
      | Some folder -> workspace_folder_path folder
      | None -> matched )
    | _ -> assert false
    (* name will always be captured *)
  in
  Interop.Regexp.replace setting ~regexp ~replacer

let substitute_workspace_vars setting =
  List.fold (Workspace.workspaceFolders ()) ~init:setting ~f:(fun acc folder ->
      String.substr_replace_all acc
        ~pattern:(workspace_folder_path folder)
        ~with_:(workspace_folder_var folder))
