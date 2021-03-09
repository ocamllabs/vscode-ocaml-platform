open Import

let task_type = "dune"

let definition = TaskDefinition.create ~type_:task_type ()

let source = task_type

let problemMatchers = [ "$ocamlc" ]

(* the ocamlc matcher is not able to parse ocaml compiler errors unless they
   follow the short style. *)
let env = Interop.Dict.of_alist [ ("OCAML_ERROR_STYLE", "short") ]

module Setting = struct
  type t = bool

  let of_json json =
    let open Jsonoo.Decode in
    bool json

  let to_json (t : t) =
    let open Jsonoo.Encode in
    bool t

  let t =
    Settings.create ~scope:Workspace ~key:"dune.autoDetect" ~of_json ~to_json
end

let folder_relative_path folders file =
  List.fold_left
    ~f:(fun acc (folder : WorkspaceFolder.t) ->
      match acc with
      | Some _ -> acc
      | None -> (
        let prefix = Uri.fsPath (WorkspaceFolder.uri folder) in
        match String.chop_prefix file ~prefix with
        | None -> acc
        | Some without_prefix -> Some (folder, without_prefix) ))
    ~init:None folders

let get_shell_execution sandbox options =
  let command = Sandbox.get_dune_command sandbox [ "build" ] in
  Cmd.log command;
  match command with
  | Shell commandLine -> ShellExecution.makeCommandLine ~commandLine ~options ()
  | Spawn { bin; args } ->
    let command = `String (Path.to_string bin) in
    let args = List.map ~f:(fun a -> `String a) args in
    ShellExecution.makeCommandArgs ~command ~args ~options ()

let compute_tasks token sandbox =
  let open Promise.Syntax in
  let folders = Workspace.workspaceFolders () in
  let excludes =
    (* ignoring dune files from _build, _opam, _esy *)
    `String "{**/_*}"
  in
  let includes = `String "**/{dune,dune-project,dune-workspace}" in
  let+ dunes = Workspace.findFiles ~includes ~excludes ~token () in
  let tasks =
    List.map dunes ~f:(fun dune ->
        let scope, relative_path =
          match folder_relative_path folders (Uri.fsPath dune) with
          | None -> (TaskScope.Workspace, Uri.fsPath dune)
          | Some (folder, relative_path) ->
            (TaskScope.Folder folder, relative_path)
        in
        let name = Printf.sprintf "build %s" relative_path in
        let execution =
          let cwd = Filename.dirname (Uri.fsPath dune) in
          let options = ShellExecutionOptions.create ~env ~cwd () in
          get_shell_execution sandbox options
        in
        let task =
          Task.make ~definition ~scope ~source ~name ~problemMatchers
            ~execution:(`ShellExecution execution) ()
        in
        Task.set_group task TaskGroup.build;
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
  let provideTasks = provide_tasks instance in
  let resolveTask = resolve_task in
  let provider = TaskProvider.Default.create ~provideTasks ~resolveTask in
  let disposable = Tasks.registerTaskProvider ~type_:task_type ~provider in
  ExtensionContext.subscribe extension ~disposable
