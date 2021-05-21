open Import
open Vscode

type 'a t =
  { key : string
  ; to_json : 'a -> Json.t
  ; of_json : Json.t -> 'a
  ; scope : Configuration_target.t
  }

let create ~scope ~key ~of_json ~to_json = { scope; key; to_json; of_json }

let get ?section t =
  let section = Workspace.get_configuration ?section () in
  match Workspace_configuration.get section t.key with
  | None -> None
  | Some v -> (
    match t.of_json (Json.t_of_js v) with
    | s -> Some s
    | exception Json.Decode_error msg ->
      show_message `Error "Setting %s is invalid: %s" t.key msg;
      None)

let set ?section t v =
  let section = Workspace.get_configuration ?section () in
  match Workspace.name () with
  | None -> Promise.return ()
  | Some _ ->
    let value = Json.t_to_js (t.to_json v) in
    Workspace_configuration.update section ~section:t.key ~value
      ~configuration_target:(`Configuration_target t.scope) ()

let string =
  let to_json = Json.Encode.string in
  let of_json = Json.Decode.string in
  create ~of_json ~to_json

let workspace_folder_var folder =
  Printf.sprintf "${workspaceFolder:%s}" (Workspace_folder.name folder)

let workspace_folder_path folder = Uri.fs_path (Workspace_folder.uri folder)

let resolve_workspace_vars setting =
  let find_folder name =
    let pred folder = String.equal name (Workspace_folder.name folder) in
    List.find ~f:pred (Workspace.workspace_folders ())
  in
  let regexp = Reg_exp.create "\\$\\{workspaceFolder:([^}]+)\\}" in
  let replacer ~matched ~captures ~offset:_ ~string:_ =
    match captures with
    | [ name ] -> (
      match find_folder name with
      | Some folder -> workspace_folder_path folder
      | None -> matched)
    | _ -> assert false
    (* name will always be captured *)
  in
  Reg_exp.replace setting ~regexp ~replacer

let substitute_workspace_vars setting =
  List.fold (Workspace.workspace_folders ()) ~init:setting ~f:(fun acc folder ->
      String.substr_replace_all acc
        ~pattern:(workspace_folder_path folder)
        ~with_:(workspace_folder_var folder))
