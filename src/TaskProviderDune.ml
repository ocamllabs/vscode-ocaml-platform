open Import

let taskDefinition = { Task.type_ = "dune" }

let source = "dune"

let problemMatchers = [| "ocamlc" |]

(* the ocamlc matcher is not able to parse ocaml compiler errors unless they
   follow the short style. *)
let env = Js.Dict.fromList [ ("OCAML_ERROR_STYLE", "short") ]

let folderRelativePath folders file =
  Array.fold_left
    (fun acc (folder : Folder.t) ->
      match acc with
      | Some _ -> acc
      | None -> (
        match String.startsWith ~s:file ~prefix:folder.uri.fsPath with
        | false -> acc
        | true ->
          Some (folder, String.removePrefix ~s:file ~prefix:folder.uri.fsPath) ))
    None folders

let commandLine () =
  let open Promise.O in
  Toolchain.ofSettings () >>| function
  | None -> "dune build"
  | Some pm ->
    let resources = Toolchain.makeResources pm in
    let cmd, args = Toolchain.getCommand resources "dune" [ "build" ] in
    Js.Array.joinWith " " (Js.Array.concat args [| Path.toString cmd |])

let provideTasks =
 fun [@bs] cancellationToken ->
  let open Promise.O in
  let folders = Workspace.workspaceFolders () in
  let excl =
    (* ignoring dune files from _build, _opam, _esy *)
    Some "{**/_*,}"
  in
  let inc = "**/{dune,dune-project,dune-workspace}" in
  Workspace.findFiles ~inc ~excl ~maxResults:None cancellationToken
  >>= fun dunes ->
  commandLine () >>| fun commandLine ->
  let tasks =
    Array.map
      (fun dune ->
        let scope, relativePath =
          match folderRelativePath folders dune.TextDocument.fsPath with
          | None -> (Task.Workspace, dune.fsPath)
          | Some (folder, relativePath) -> (Task.Folder folder, relativePath)
        in
        let name = Printf.sprintf "build %s" relativePath in
        let execution =
          let cwd = Filename.dirname dune.fsPath in
          let options =
            Some
              { ShellExecution.env = Some env
              ; cwd = Some cwd
              ; executable = None
              ; shellArgs = None
              ; shellQuoting = None
              }
          in
          ShellExecution.make ~commandLine ~options
        in
        Task.make ~taskDefinition ~scope ~source ~name ~problemMatchers
          ~execution:(`Shell execution) ~group:TaskGroup.build ())
      dunes
  in
  Some tasks

let resolveTask =
 fun [@bs] task _cancellationToken -> Js.Promise.resolve (Some task)

let create () =
  let provider = { TaskProvider.provideTasks; resolveTask } in
  Tasks.registerTaskProvider ~typ:"dune" ~provider
