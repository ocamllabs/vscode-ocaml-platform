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
      message `Error "Setting %s is invalid: %s" t.key msg;
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

let workspace_folder_var = "${workspaceFolder}"

let workspace_path () =
  match Workspace.workspaceFolders () with
  | workspace_folder :: _ ->
    Some (workspace_folder |> WorkspaceFolder.uri |> Uri.fsPath)
  | [] -> None

let resolve_workspace_var setting =
  let path =
    match workspace_path () with
    | Some path -> path
    | None -> Process.cwd ()
  in
  String.substr_replace_all setting ~pattern:workspace_folder_var ~with_:path

let substitute_workspace_var setting =
  match workspace_path () with
  | Some path ->
    String.substr_replace_all setting ~pattern:path ~with_:workspace_folder_var
  | None -> setting
