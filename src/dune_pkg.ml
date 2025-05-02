open Import

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

type t =
  { root : Path.t
  ; bin : Cmd.spawn
  }

let binary = Path.of_string "dune"

let make ~root () =
  let open Promise.Syntax in
  (* Should we do something specific for Windows ? *)
  let spawn = { Cmd.bin = binary; args = [] } in
  let+ spawn = Cmd.check_spawn spawn in
  match spawn with
  | Ok bin -> Some { bin; root }
  | Error _ -> None
;;

let detect_dune_lock_dir project_root () =
  (* Path to the dune.lock dir *)
  let dune_lock_path = Path.join project_root (Path.of_string "dune.lock") in
  Fs.exists (Path.to_string dune_lock_path)
;;

let detect_dune_ocamllsp project_root () =
  (* Path to the ocaml-lsp-server.pkg file *)
  let ocamllsp =
    Path.join
      project_root
      (Path.join (Path.of_string "dev-tools.locks") (Path.of_string "ocaml-lsp-server"))
  in
  Fs.exists (Path.to_string ocamllsp)
;;

let exec t ~args = Cmd.Spawn (Cmd.append t.bin args)
let equal d1 d2 = Path.equal d1.root d2.root
let root t = t.root
