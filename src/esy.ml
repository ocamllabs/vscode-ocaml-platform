open Import

module Manifest = struct
  include Path

  let path t = t

  let of_path t = t
end

module Package = struct
  (* TODO: Implement Esy sandbox inspection *)

  type t = unit

  let name _t = failwith "Esy sandbox inspection is not supported yet."

  let version _t = failwith "Esy sandbox inspection is not supported yet."

  let documentation _t = failwith "Esy sandbox inspection is not supported yet."

  let synopsis _t = failwith "Esy sandbox inspection is not supported yet."

  let has_dependencies _t =
    failwith "Esy sandbox inspection is not supported yet."

  let dependencies _t = failwith "Esy sandbox inspection is not supported yet."
end

type t = Cmd.spawn

let binary = Path.of_string "esy"

type discover =
  { manifest : Manifest.t
  ; status : (unit, string) result
  }

let make () =
  let open Promise.Syntax in
  let+ spawn = Cmd.check_spawn { bin = binary; args = [] } in
  match spawn with
  | Error _ -> None
  | Ok cmd -> Some cmd

module Discover = struct
  let valid manifest = Some { manifest; status = Ok () }

  let compare l r =
    let compare_file = Path.compare in
    let compare_status = Result.compare Unit.compare String.compare in
    match compare_file l.manifest r.manifest with
    | 0 -> compare_status l.status r.status
    | n -> n

  let invalid_json manifest json_file =
    let message =
      Printf.sprintf "Esy manifest file '%s' is not a valid json file" json_file
    in
    Some { manifest; status = Error message }

  let is_esy_compatible filename json =
    String.equal filename "esy.json"
    || ( property_exists json "dependencies"
       || property_exists json "devDependencies" )
       && property_exists json "esy"

  let parse_file project_root = function
    | "opam" -> Promise.return (valid project_root)
    | s when String.equal (Caml.Filename.extension s) ".opam" ->
      Promise.return (valid project_root)
    | ("esy.json" | "package.json") as fname -> (
      let manifest_file = Path.(project_root / fname) |> Path.to_string in
      let open Promise.Syntax in
      let+ manifest = Fs.readFile manifest_file in
      match Jsonoo.try_parse_opt manifest with
      | None -> invalid_json project_root fname
      | Some json when is_esy_compatible fname json -> valid project_root
      | _ -> None )
    | _ -> Promise.return None

  let parse_dir dir =
    let open Promise.Syntax in
    let* dirs = Path.to_string dir |> Fs.readDir in
    match dirs with
    | Ok res ->
      let+ dirs = Promise.List.filter_map (parse_file dir) res in
      List.dedup_and_sort dirs ~compare
    | Error err ->
      let dir = Path.to_string dir in
      log "unable to read dir %s. error %s" dir err;
      show_message `Warn
        "Unable to read %s. No esy projects will be inferred from here" dir;
      Promise.return []

  let parse_dirs_up dir =
    let rec loop parsed_dirs dir =
      let parsed_dirs = parse_dir dir :: parsed_dirs in
      match Path.parent dir with
      | None -> parsed_dirs
      | Some dir -> loop parsed_dirs dir
    in
    loop [] dir

  let run ~dir : discover list Promise.t =
    let open Promise.Syntax in
    let+ discovered = dir |> parse_dirs_up |> Promise.all_list in
    List.concat discovered
end

let discover = Discover.run

let exec t manifest ~args =
  Cmd.Spawn (Cmd.append t ("-P" :: Path.to_string manifest :: args))

module State = struct
  type t =
    | Ready
    | Pending
end

let find_manifest_in_dir dir =
  let open Promise.Syntax in
  let esy_file = Path.(dir / "esy.json") in
  let package_file = Path.(dir / "package.json") in
  [ esy_file; package_file ]
  |> Promise.List.find_map (fun path ->
         let+ file_exists = path |> Path.to_string |> Fs.exists in
         Option.some_if file_exists path)

let state t manifest =
  let root_str = Manifest.to_string manifest in
  let command = Cmd.append t [ "status"; "-P"; root_str ] in
  let open Promise.Result.Syntax in
  let+ is_project_ready_for_dev =
    let open Promise.Syntax in
    let+ output = Cmd.output (Spawn command) in
    match output with
    | Error _ -> Ok false
    | Ok esy_output -> (
      match Jsonoo.try_parse_opt esy_output with
      | None -> Ok false
      | Some esy_response ->
        esy_response
        |> Jsonoo.Decode.field "isProjectReadyForDev" Jsonoo.Decode.bool
        |> Result.return )
  in
  if is_project_ready_for_dev then
    State.Ready
  else
    Pending

let setup_sandbox t manifest =
  let open Promise.Result.Syntax in
  let+ sandbox_state = state t manifest in
  match sandbox_state with
  | State.Ready -> ()
  | Pending ->
    let root_dir = Path.to_string manifest in
    show_message `Info "Esy dependencies are not installed. Run esy under %s"
      root_dir

let equal e1 e2 = Cmd.equal_spawn e1 e2

let packages _t _manifest =
  (* TODO: Implement Esy sandbox inspection *)
  Promise.return (Error "Esy sandbox inspection is not supported yet.")

let root_packages _t _manifest =
  (* TODO: Implement Esy sandbox inspection *)
  Promise.return (Error "Esy sandbox inspection is not supported yet.")
