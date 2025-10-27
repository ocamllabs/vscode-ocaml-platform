open Import

type 'a setting =
  { key : string
  ; to_json : 'a -> Jsonoo.t
  ; of_json : Jsonoo.t -> 'a
  ; scope : ConfigurationTarget.t
  }

let create_setting ~scope ~key ~of_json ~to_json = { scope; key; to_json; of_json }

let get ?section setting =
  let section = Workspace.getConfiguration ?section () in
  match WorkspaceConfiguration.get section ~section:setting.key with
  | None -> None
  | Some v ->
    (match setting.of_json @@ [%js.to: Jsonoo.t] v with
     | s -> Some s
     | exception Jsonoo.Decode_error msg ->
       show_message `Error "Setting %s is invalid: %s" setting.key msg;
       None)
;;

let set ?section setting v =
  let section = Workspace.getConfiguration ?section () in
  match Workspace.name () with
  | None -> Promise.return ()
  | Some _ ->
    let value = [%js.of: Jsonoo.t] (setting.to_json v) in
    WorkspaceConfiguration.update
      section
      ~section:setting.key
      ~value
      ~configurationTarget:(`ConfigurationTarget setting.scope)
      ()
;;

let first_workspace_folder_var = "${firstWorkspaceFolder}"

let workspace_folder_var folder =
  Printf.sprintf "${workspaceFolder:%s}" (WorkspaceFolder.name folder)
;;

let workspace_folder_path folder = Uri.fsPath (WorkspaceFolder.uri folder)

let resolve_workspace_vars setting =
  let find_folder name =
    let pred folder = String.equal name (WorkspaceFolder.name folder) in
    List.find ~f:pred (Workspace.workspaceFolders ())
  in
  let regexp = Js_of_ocaml.Regexp.regexp "\\$\\{workspaceFolder:([^}]+)\\}" in
  let replacer ~matched ~captures ~offset:_ ~string:_ =
    match captures with
    | [ name ] ->
      (match find_folder name with
       | Some folder -> workspace_folder_path folder
       | None -> matched)
    | _ -> assert false
    (* name will always be captured *)
  in
  let first_workspace_folder_path =
    Workspace.workspaceFolders ()
    |> List.hd
    |> Option.value_map ~f:workspace_folder_path ~default:""
  in
  setting
  |> Interop.Regexp.replace ~regexp ~replacer
  |> String.substr_replace_all
       ~pattern:first_workspace_folder_var
       ~with_:first_workspace_folder_path
;;

let substitute_workspace_vars setting =
  (* Windows paths are case-insensitive *)
  let folder_replace_all =
    match Platform.t with
    | Win32 -> String.Caseless.substr_replace_all
    | _ -> String.substr_replace_all
  in
  List.fold (Workspace.workspaceFolders ()) ~init:setting ~f:(fun acc folder ->
    folder_replace_all
      acc
      ~pattern:(workspace_folder_path folder)
      ~with_:(workspace_folder_var folder))
;;

module ExtraEnv = struct
  let setting =
    let of_json =
      let dict_of_hashtbl hashtbl =
        Stdlib.Hashtbl.to_seq hashtbl |> Interop.Dict.of_seq
      in
      Jsonoo.Decode.(map (Option.map ~f:dict_of_hashtbl) (nullable (dict string)))
    in
    let to_json =
      let hashtbl_of_dict json = Interop.Dict.to_seq json |> Stdlib.Hashtbl.of_seq in
      Jsonoo.Encode.nullable (fun json ->
        hashtbl_of_dict json |> Jsonoo.Encode.(dict string))
    in
    create_setting
      ~scope:ConfigurationTarget.Workspace
      ~key:"ocaml.server.extraEnv"
      ~of_json
      ~to_json
  ;;

  let get () = get setting |> Option.join
end

let server_extraEnv = ExtraEnv.get

let server_args_setting =
  create_setting
    ~scope:ConfigurationTarget.Workspace
    ~key:"ocaml.server.args"
    ~of_json:Jsonoo.Decode.(list string)
    ~to_json:Jsonoo.Encode.(list string)
;;

let server_codelens_setting =
  create_setting
    ~scope:ConfigurationTarget.Workspace
    ~key:"ocaml.server.codelens.enable"
    ~of_json:Jsonoo.Decode.bool
    ~to_json:Jsonoo.Encode.bool
;;

let server_codelens_nested_bindings_setting =
  create_setting
    ~scope:ConfigurationTarget.Workspace
    ~key:"ocaml.server.codelens.forNestedBindings"
    ~of_json:Jsonoo.Decode.bool
    ~to_json:Jsonoo.Encode.bool
;;

let server_extendedHover_setting =
  create_setting
    ~scope:ConfigurationTarget.Workspace
    ~key:"ocaml.server.extendedHover"
    ~of_json:Jsonoo.Decode.bool
    ~to_json:Jsonoo.Encode.bool
;;

let server_duneDiagnostics_setting =
  create_setting
    ~scope:ConfigurationTarget.Workspace
    ~key:"ocaml.server.duneDiagnostics"
    ~of_json:Jsonoo.Decode.bool
    ~to_json:Jsonoo.Encode.bool
;;

let server_syntaxDocumentation_setting =
  create_setting
    ~scope:ConfigurationTarget.Workspace
    ~key:"ocaml.server.syntaxDocumentation"
    ~of_json:Jsonoo.Decode.bool
    ~to_json:Jsonoo.Encode.bool
;;

let server_typedHolesConstructAfterNavigate_setting =
  create_setting
    ~scope:ConfigurationTarget.Workspace
    ~key:"ocaml.commands.typedHoles.constructAfterNavigate"
    ~of_json:Jsonoo.Decode.bool
    ~to_json:Jsonoo.Encode.bool
;;

let server_constructRecursiveCalls_setting =
  create_setting
    ~scope:ConfigurationTarget.Workspace
    ~key:"ocaml.commands.construct.recursiveCalls"
    ~of_json:Jsonoo.Decode.bool
    ~to_json:Jsonoo.Encode.bool
;;
