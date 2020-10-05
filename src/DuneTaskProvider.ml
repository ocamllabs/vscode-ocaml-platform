open Import

type t = Disposable.t option ref

let task_type = "dune"

let definition = TaskDefinition.create ~type_:task_type ()

let source = task_type

let problemMatchers = [ "$ocamlc" ]

(* the ocamlc matcher is not able to parse ocaml compiler errors unless they
   follow the short style. *)
let env =
  Core_kernel.Hashtbl.of_alist_exn
    (module Core_kernel.String)
    [ ("OCAML_ERROR_STYLE", "short") ]

module Setting = struct
  type t = bool

  let ofJson json =
    let open Jsonoo.Decode in
    bool json

  let toJson (t : t) =
    let open Jsonoo.Encode in
    bool t

  let t =
    Settings.create ~scope:Workspace ~key:"dune.autoDetect" ~ofJson ~toJson
end

let folderRelativePath folders file =
  List.fold_left
    (fun acc (folder : WorkspaceFolder.t) ->
      match acc with
      | Some _ -> acc
      | None -> (
        let prefix = Uri.fsPath (WorkspaceFolder.uri folder) in
        match Core_kernel.String.chop_prefix file ~prefix with
        | None -> acc
        | Some withoutPrefix -> Some (folder, withoutPrefix) ))
    None folders

let getShellExecution toolchain options =
  let command = Toolchain.getDuneCommand toolchain [ "build" ] in
  Cmd.log command;
  match command with
  | Shell commandLine -> ShellExecution.makeCommandLine ~commandLine ~options ()
  | Spawn { bin; args } ->
    let command = `String (Path.toString bin) in
    let args = List.map (fun a -> `String a) args in
    ShellExecution.makeCommandArgs ~command ~args ~options ()

let computeTasks ?token toolchain =
  let open Promise.Syntax in
  let folders = Workspace.workspaceFolders () in
  let excludes =
    (* ignoring dune files from _build, _opam, _esy *)
    `String "{**/_*}"
  in
  let includes = `String "**/{dune,dune-project,dune-workspace}" in
  Workspace.findFiles ~includes ~excludes ?token () >>| fun dunes ->
  let tasks =
    List.map
      (fun dune ->
        let scope, relativePath =
          match folderRelativePath folders (Uri.fsPath dune) with
          | None -> (TaskScope.Workspace, Uri.fsPath dune)
          | Some (folder, relativePath) ->
            (TaskScope.Folder folder, relativePath)
        in
        let name = Printf.sprintf "build %s" relativePath in
        let execution =
          let cwd = Filename.dirname (Uri.fsPath dune) in
          let options = ShellExecutionOptions.create ~env ~cwd () in
          getShellExecution toolchain options
        in
        let task =
          Task.make ~definition ~scope ~source ~name ~problemMatchers
            ~execution:(`ShellExecution execution) ()
        in
        Task.set_group task TaskGroup.build;
        task)
      dunes
  in
  Some tasks

let provideTasks toolchain ?token () =
  match Settings.get ~section:"ocaml" Setting.t with
  | None
  | Some false ->
    `Promise (Promise.return None)
  | Some true -> `Promise (computeTasks ?token toolchain)

let resolveTasks ~task ?token:_ () = `Promise (Promise.Option.return task)

let create () = ref None

let register t toolchain =
  let provideTasks = provideTasks toolchain in
  let provider = TaskProvider.create ~provideTasks ~resolveTasks in
  t := Some (Tasks.registerTaskProvider ~type_:task_type ~provider)

let dispose (t : t) =
  Core_kernel.Option.iter ~f:Disposable.dispose !t;
  t := None
