open Import

type t = Cmd.spawn

let binary = Path.of_string "esy"

type discover =
  { file : Path.t
  ; status : (unit, string) result
  }

let make () =
  let open Promise.Syntax in
  Cmd.check_spawn { bin = binary; args = [] } >>| function
  | Error _ -> None
  | Ok cmd -> Some cmd

module Discover = struct
  let valid file = Some { file; status = Ok () }

  let compare l r = Path.compare l.file r.file

  let invalid_json file = Some { file; status = Error "unable to parse json" }

  let parse_file project_root = function
    | "esy.json"
    | "opam" ->
      Promise.return (valid project_root)
    | s when String.equal (Caml.Filename.extension s) ".opam" ->
      Promise.return (valid project_root)
    | "package.json" as fname -> (
      let manifest_file = Path.(project_root / fname) |> Path.to_string in
      let open Promise.Syntax in
      Fs.readFile manifest_file >>| fun manifest ->
      match Jsonoo.try_parse_opt manifest with
      | None -> invalid_json project_root
      | Some json ->
        if
          ( property_exists json "dependencies"
          || property_exists json "devDependencies" )
          && property_exists json "esy"
        then
          valid project_root
        else
          None )
    | _ -> Promise.return None

  let parse_dir dir =
    let open Promise.Syntax in
    Path.to_string dir |> Fs.readDir
    >>| (function
          | Ok res -> res
          | Error err ->
            let dir = Path.to_string dir in
            log "unable to read dir %s. error %s" dir err;
            message `Warn
              "Unable to read %s. No esy projects will be inferred from here"
              dir;
            [])
    >>= Promise.List.filter_map (parse_file dir)
    >>| List.dedup_and_sort ~compare

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
    dir |> parse_dirs_up |> Promise.all_list >>| List.concat
end

let discover = Discover.run

let exec t ~manifest ~args =
  Cmd.Spawn (Cmd.append t ("-P" :: Path.to_string manifest :: args))

module State = struct
  type t =
    | Ready
    | Pending
end

let state t ~manifest =
  let root_str = Path.to_string manifest in
  let command = Cmd.append t [ "status"; "-P"; root_str ] in
  let open Promise.Syntax in
  Cmd.output (Spawn command)
  >>| (function
        | Error _ -> Ok false
        | Ok esy_output -> (
          match Jsonoo.try_parse_opt esy_output with
          | None -> Ok false
          | Some esy_response ->
            esy_response
            |> Jsonoo.Decode.field "isProjectReadyForDev" Jsonoo.Decode.bool
            |> Result.return ))
  |> Promise.Result.map (fun is_project_ready_for_dev ->
         if is_project_ready_for_dev then
           State.Ready
         else
           Pending)

let setup_toolchain t ~manifest =
  let open Promise.Result.Syntax in
  state t ~manifest >>| function
  | State.Ready -> ()
  | Pending ->
    let root_dir = Path.to_string manifest in
    message `Info "Esy dependencies are not installed. Run esy under %s"
      root_dir
