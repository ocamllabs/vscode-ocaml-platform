open Import

type t =
  { root : Path.t
  ; bin : Cmd.spawn
  }

let binary = Path.of_string "dune"

let make root () =
  let open Promise.Syntax in
  (* Should we do something specific for Windows ? *)
  match root with
  | Some root ->
    let spawn = { Cmd.bin = binary; args = [] } in
    let+ spawn = Cmd.check_spawn spawn in
    (match spawn with
     | Ok bin -> Some { bin; root }
     | Error _ -> None)
  | None -> Promise.return None
;;

let is_project_locked t =
  (* Path to the dune.lock dir *)
  let dune_lock_path = Path.join t.root (Path.of_string "dune.lock") in
  Fs.exists (Path.to_string dune_lock_path)
;;

let is_ocamllsp_present t =
  (* Path to the ocaml-lsp-server.pkg file *)
  let ocamllsp =
    Path.join
      t.root
      (Path.join (Path.of_string "dev-tools.locks") (Path.of_string "ocaml-lsp-server"))
  in
  Fs.exists (Path.to_string ocamllsp)
;;

let command t ~args = Cmd.Spawn (Cmd.append t.bin args)

let exec ~target ?(args = []) t =
  Cmd.Spawn (Cmd.append t.bin ([ "exec"; target; "--" ] @ args))
;;

let exec_pkg ~cmd ?(args = []) t = Cmd.Spawn (Cmd.append t.bin ([ "pkg"; cmd ] @ args))

let exec_tool ~tool ?(args = []) t =
  Cmd.Spawn (Cmd.append t.bin ([ "tools"; "exec"; tool; "--" ] @ args))
;;

let equal d1 d2 = Path.equal d1.root d2.root
let root t = t.root
