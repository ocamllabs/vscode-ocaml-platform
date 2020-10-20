open Import

type t = Cmd.spawn

let binary = Path.of_string "esy"

module Manifest = struct
  type t =
    { root : Path.t
    ; file : string option
    }

  let path = function
    | { root; file = None } -> root
    | { root; file = Some file } -> Path.(root / file)

  let to_string manifest = Path.to_string (path manifest)

  let to_pretty_string = function
    | { root; file = None } -> Path.basename root
    | { root; file = Some file } -> Path.basename root ^ "/" ^ file
end

type discover =
  { manifest : Manifest.t
  ; status : (unit, string) result
  }

let make () =
  let open Promise.Syntax in
  Cmd.check_spawn { bin = binary; args = [] } >>| function
  | Error _ -> None
  | Ok cmd -> Some cmd

module Discover = struct
  let valid root file =
    Some { manifest = { root; file = Some file }; status = Ok () }

  let invalid_json root json_file =
    let message =
      Printf.sprintf "manifest file '%s' is not a valid json file" json_file
    in
    Some { manifest = { root; file = Some json_file }; status = Error message }

  let is_esy_compatible filename json =
    String.equal filename "esy.json"
    || ( property_exists json "dependencies"
       || property_exists json "devDependencies" )
       && property_exists json "esy"

  let parse_file project_root = function
    | "opam" -> Promise.return (valid project_root "opam")
    | opam_file when String.equal (Caml.Filename.extension opam_file) ".opam" ->
      Promise.return (valid project_root opam_file)
    | ("esy.json" | "package.json") as filename -> (
      let manifest_file = Path.(project_root / filename) |> Path.to_string in
      let open Promise.Syntax in
      Fs.readFile manifest_file >>| fun manifest ->
      match Jsonoo.try_parse_opt manifest with
      | None -> invalid_json project_root filename
      | Some json when is_esy_compatible filename json ->
        valid project_root filename
      | _ -> None )
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
  Cmd.Spawn
    (Cmd.append t ("-P" :: Path.to_string (Manifest.path manifest) :: args))

module State = struct
  type t =
    | Ready
    | Pending
end

let state t ~manifest =
  let path_str = Path.to_string (Manifest.path manifest) in
  let command = Cmd.append t [ "status"; "-P"; path_str ] in
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
    let root_dir = Path.to_string manifest.root in
    message `Info "Esy dependencies are not installed. Run esy under %s"
      root_dir
