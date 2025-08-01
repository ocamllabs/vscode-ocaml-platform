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

let command t ~args = Cmd.Spawn (Cmd.append t.bin args)

let exec ~target ?(args = []) t =
  Cmd.Spawn (Cmd.append t.bin ([ "exec"; target; "--" ] @ args))
;;

let exec_pkg ~cmd ?(args = []) t = Cmd.Spawn (Cmd.append t.bin ([ "pkg"; cmd ] @ args))

let exec_tool ~tool ?(args = []) t cmd =
  match cmd with
  | `Exec_ -> Cmd.Spawn (Cmd.append t.bin ([ "tools"; "exec"; tool; "--" ] @ args))
  | `Which -> Cmd.Spawn (Cmd.append t.bin ([ "tools"; "which"; tool ] @ args))
;;

let equal d1 d2 = Path.equal d1.root d2.root
let root t = t.root

let is_ocamllsp_present t =
  (* use dune tools which ocamllsp *)
  let open Promise.Syntax in
  let+ ocamllsp_path = exec_tool ~tool:"ocamllsp" t `Which |> Cmd.output ~cwd:t.root in
  match ocamllsp_path with
  | Ok _path -> true
  | Error err ->
    log_chan `Info ~section:"dune" "Ocamllsp not found" err;
    false
;;
