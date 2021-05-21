open Import

let task_type = "dune"

let task_definition = Task_definition.create ~type_:task_type ()

let source = task_type

let problem_matchers = [ "$ocamlc" ]

module Setting = struct
  type t = bool

  let of_json json =
    let open Json.Decode in
    bool json

  let to_json (t : t) =
    let open Json.Encode in
    bool t

  let t =
    Settings.create ~scope:`Workspace ~key:"dune.autoDetect" ~of_json ~to_json
end

let folder_relative_path folders file =
  List.fold_left
    ~f:(fun acc (folder : Workspace_folder.t) ->
      match acc with
      | Some _ -> acc
      | None -> (
        let prefix = Uri.fs_path (Workspace_folder.uri folder) in
        match String.chop_prefix file ~prefix with
        | None -> acc
        | Some without_prefix -> Some (folder, without_prefix)))
    ~init:None folders

let get_shell_execution sandbox options =
  let command = Sandbox.get_dune_command sandbox [ "build" ] in
  Cmd.log command;
  match command with
  | Shell command_line ->
    Shell_execution.create_command_line ~command_line ~options ()
  | Spawn { bin; args } ->
    let command = `String (Path.to_string bin) in
    let args = List.map ~f:(fun a -> `String a) args in
    Shell_execution.create_command_args ~command ~args ~options ()

let compute_tasks token sandbox =
  let open Promise.Syntax in
  let folders = Workspace.workspace_folders () in
  let exclude =
    (* ignoring dune files from _build, _opam, _esy *)
    `String "{**/_*}"
  in
  let includes = `String "**/{dune,dune-project,dune-workspace}" in
  let+ dunes = Workspace.find_files includes ~exclude ~token () in
  let tasks =
    List.map dunes ~f:(fun dune ->
        let scope, relative_path =
          match folder_relative_path folders (Uri.fs_path dune) with
          | None -> (Task_scope.Workspace, Uri.fs_path dune)
          | Some (folder, relative_path) ->
            (Task_scope.Folder folder, relative_path)
        in
        let name = Printf.sprintf "build %s" relative_path in
        let execution =
          let cwd = Stdlib.Filename.dirname (Uri.fs_path dune) in
          let options = Shell_execution_options.create ~cwd () in
          (* the ocamlc matcher is not able to parse ocaml compiler errors
             unless they follow the short style. *)
          let env =
            let env = Shell_execution_options.env options in
            Shell_execution_options.Env.set env "OCAML_ERROR_STYLE" "short";
            env
          in
          Shell_execution_options.set_env options env;

          get_shell_execution sandbox options
        in
        let task =
          Task.create ~task_definition ~scope ~source ~name ~problem_matchers
            ~execution:(`ShellExecution execution) ()
        in
        Task.set_group task (Task_group.build ());
        task)
  in
  Some tasks

let provide_tasks instance ~token =
  match Settings.get ~section:"ocaml" Setting.t with
  | None
  | Some false ->
    `Promise (Promise.return None)
  | Some true ->
    let sandbox = Extension_instance.sandbox instance in
    `Promise (compute_tasks token sandbox)

let resolve_task ~task ~token:_ = `Value (Some task)

let register extension instance =
  let provide_tasks = provide_tasks instance in
  let resolve_task = resolve_task in
  let provider = Task_provider.create ~provide_tasks ~resolve_task in
  let disposable = Tasks.register_task_provider ~type_:task_type ~provider in
  Extension_context.subscribe extension disposable
