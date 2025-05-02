open Import

module LockDir = struct
  type t = Path.t

  let workspace_root () =
    match Workspace.workspaceFolders () with
    | [] -> None
    | [ workspace_folder ] ->
      Some (workspace_folder |> WorkspaceFolder.uri |> Uri.path |> Path.of_string)
    | _ ->
      (* We don't support multiple workspace roots at the moment *)
      None
  ;;

  let make () =
    let open Promise.Syntax in
    match workspace_root () with
    | None -> Promise.return None
    | Some project_root ->
      let dune_lock_path = Path.join project_root (Path.of_string "dune.lock") in
      let+ dune_lock_exists = Fs.exists (Path.to_string dune_lock_path) in
      if dune_lock_exists then Some dune_lock_path else None
  ;;

  let detect project_root () =
    (* Path to the dune.lock dir *)
    let dune_lock_path = Path.join project_root (Path.of_string "dune.lock") in
    Fs.exists (Path.to_string dune_lock_path)
  ;;

  let equal p1 p2 = Path.equal p1 p2
end

module Package = struct
  (* TODO: Implement dune package inspection *)

  type t = unit

  let name _t = failwith "Dune inspection is not supported yet."
  let version _t = failwith "Dune inspection is not supported yet."
  let documentation _t = failwith "Dune inspection is not supported yet."
  let synopsis _t = failwith "Dune inspection is not supported yet."
  let has_dependencies _t = failwith "Dune inspection is not supported yet."
  let dependencies _t = failwith "Dune inspection is not supported yet."
end

type t = Path.t

let binary = Path.of_string "dune"

let detect_dune_ocamllsp project_root () =
  (* Path to the ocaml-lsp-server.pkg file *)
  let ocamllsp =
    Path.join
      project_root
      (Path.join (Path.of_string "dev-tools.locks") (Path.of_string "ocaml-lsp-server"))
  in
  Fs.exists (Path.to_string ocamllsp)
;;

let exec ~args = Cmd.Spawn (Cmd.append { bin = binary; args = [] } args)
let equal p1 p2 = Path.equal p1 p2
