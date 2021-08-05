open Import

type 'a setting =
  { key : string
  ; to_json : 'a -> Jsonoo.t
  ; of_json : Jsonoo.t -> 'a
  ; scope : ConfigurationTarget.t
  }

let create_setting ~scope ~key ~of_json ~to_json =
  { scope; key; to_json; of_json }

let get ?section setting =
  let section = Workspace.getConfiguration ?section () in
  match WorkspaceConfiguration.get section ~section:setting.key with
  | None -> None
  | Some v -> (
    match setting.of_json (Jsonoo.t_of_js v) with
    | s -> Some s
    | exception Jsonoo.Decode_error msg ->
      show_message `Error "Setting %s is invalid: %s" setting.key msg;
      None)

let set ?section setting v =
  let section = Workspace.getConfiguration ?section () in
  match Workspace.name () with
  | None -> Promise.return ()
  | Some _ ->
    let value = Jsonoo.t_to_js (setting.to_json v) in
    WorkspaceConfiguration.update section ~section:setting.key ~value
      ~configurationTarget:(`ConfigurationTarget setting.scope) ()

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
      | None -> matched)
    | _ -> assert false
    (* name will always be captured *)
  in
  Interop.Regexp.replace setting ~regexp ~replacer

let substitute_workspace_vars setting =
  (* Windows paths are case-insensitive *)
  let folder_replace_all =
    match Platform.t with
    | Win32 -> String.Caseless.substr_replace_all
    | _ -> String.substr_replace_all
  in
  List.fold (Workspace.workspaceFolders ()) ~init:setting ~f:(fun acc folder ->
      folder_replace_all acc
        ~pattern:(workspace_folder_path folder)
        ~with_:(workspace_folder_var folder))

module ExtraEnv = struct
  let setting =
    let of_json =
      let dict_of_hashtbl hashtbl =
        Stdlib.Hashtbl.to_seq hashtbl |> Interop.Dict.of_seq
      in
      Jsonoo.Decode.(
        map (Option.map ~f:dict_of_hashtbl) (nullable (dict string)))
    in
    let to_json =
      let hashtbl_of_dict json =
        Interop.Dict.to_seq json |> Stdlib.Hashtbl.of_seq
      in
      Jsonoo.Encode.nullable (fun json ->
          hashtbl_of_dict json |> Jsonoo.Encode.(dict string))
    in
    create_setting ~scope:ConfigurationTarget.Workspace
      ~key:"ocaml.server.extraEnv" ~of_json ~to_json

  let get () = get setting |> Option.join
end

let server_extraEnv = ExtraEnv.get

module Repl_path = struct
  type t = string option

  let of_json json = Jsonoo.Decode.(nullable string) json

  let to_json (t : t) = Jsonoo.Encode.(nullable string) t

  let key = "ocaml.repl.path"

  let setting =
    create_setting ~scope:ConfigurationTarget.Workspace ~key ~of_json ~to_json

  let get () = get setting |> Option.join
end

let repl_path = Repl_path.get

module Repl_args = struct
  type t = string list option

  let of_json json = Jsonoo.Decode.(nullable (list string)) json

  let to_json (t : t) = Jsonoo.Encode.(nullable (list string)) t

  let key = "ocaml.repl.args"

  let setting =
    create_setting ~scope:ConfigurationTarget.Workspace ~key ~of_json ~to_json

  let get () = get setting |> Option.join
end

let repl_args = Repl_args.get
