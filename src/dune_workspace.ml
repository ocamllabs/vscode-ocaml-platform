open Import

type t =
  { root : Path.t
  ; build_context : Path.t
  }

type layout =
  { root : Path.t
  ; build_dir : Path.t
  }

let root (t : t) = t.root
let build_context (t : t) = t.build_context

module Environment = struct
  type t =
    { build_dir : string option
    ; root : string option
    ; workspace : string option
    ; cross_target : string option
    }

  let non_empty = function
    | Some value when not (String.is_empty value) -> Some value
    | None | Some _ -> None
  ;;

  let process () =
    { build_dir = Process.Env.get "DUNE_BUILD_DIR" |> non_empty
    ; root = Process.Env.get "DUNE_ROOT" |> non_empty
    ; workspace = Process.Env.get "DUNE_WORKSPACE" |> non_empty
    ; cross_target = Process.Env.get "DUNE_CROSS_TARGET" |> non_empty
    }
  ;;

  let json_field json name =
    if property_exists json name
    then Jsonoo.Decode.field name Jsonoo.Decode.string json |> Option.some |> non_empty
    else None
  ;;

  let of_json json =
    let inherited = process () in
    { build_dir = Option.first_some (json_field json "DUNE_BUILD_DIR") inherited.build_dir
    ; root = Option.first_some (json_field json "DUNE_ROOT") inherited.root
    ; workspace = Option.first_some (json_field json "DUNE_WORKSPACE") inherited.workspace
    ; cross_target =
        Option.first_some (json_field json "DUNE_CROSS_TARGET") inherited.cross_target
    }
  ;;

  let selected_sandbox sandbox ~cwd =
    match sandbox with
    | Sandbox.Esy (esy, manifest) ->
      let open Promise.Syntax in
      let+ output =
        Esy.exec esy manifest ~args:[ "command-env"; "--json" ] |> Cmd.output ~cwd
      in
      (match output with
       | Error error ->
         log_chan
           `Warn
           ~section:"Dune workspace"
           "Unable to read the esy command environment: %s"
           error;
         process ()
       | Ok output ->
         (match Jsonoo.try_parse_opt output with
          | Some json -> of_json json
          | None ->
            log_chan
              `Warn
              ~section:"Dune workspace"
              "Unable to parse `esy command-env --json` output.";
            process ()))
    | Opam _ | Global | Custom _ | Dune _ -> Promise.return (process ())
  ;;

  let needs_version_check t = Option.is_some t.root || Option.is_some t.cross_target

  let for_dune_version t version =
    { t with
      root =
        (if Dune.Dune_version.supports_root_environment version then t.root else None)
    ; cross_target =
        (if Dune.Dune_version.supports_cross_target_environment version
         then t.cross_target
         else None)
    }
  ;;
end

let resolve_from ~base path =
  let path = Path.of_string path in
  if Path.is_absolute path then path else Path.(base / to_string path)
;;

let find_root ~from =
  let priority = function
    | `Workspace -> 0
    | `Project -> 1
  in
  let rec loop dir candidate =
    let open Promise.Syntax in
    let* has_workspace, has_project =
      Promise.all2
        ( Fs.exists Path.(dir / "dune-workspace" |> to_string)
        , Fs.exists Path.(dir / "dune-project" |> to_string) )
    in
    let candidate =
      let found =
        if has_workspace
        then Some `Workspace
        else if has_project
        then Some `Project
        else None
      in
      match found, candidate with
      | None, candidate -> candidate
      | Some kind, None -> Some (kind, dir)
      | Some kind, Some (candidate_kind, _) when priority kind <= priority candidate_kind
        -> Some (kind, dir)
      | Some _, Some _ -> candidate
    in
    match Path.parent dir with
    | None -> Promise.return candidate
    | Some parent -> loop parent candidate
  in
  let open Promise.Syntax in
  let+ candidate = loop from None in
  match candidate with
  | Some (_, root) -> root
  | None -> from
;;

let field_values fields name =
  List.filter_map fields ~f:(function
    | Csexp.List [ Atom field_name; Atom value ] when String.equal field_name name ->
      Some value
    | Atom _ | List _ -> None)
;;

let find_field fields name = List.hd (field_values fields name)

let of_canonical_sexp input =
  match Csexp.parse_string input with
  | Error (pos, message) -> Error (Printf.sprintf "at byte %d: %s" pos message)
  | Ok (Csexp.Atom _) -> Error "expected a list of workspace fields"
  | Ok (List fields) ->
    (match find_field fields "root", find_field fields "build_context" with
     | Some root, Some build_context ->
       let root = Path.of_string root in
       let build_context = resolve_from ~base:root build_context in
       (match Path.parent build_context with
        | Some build_dir -> Ok { root; build_dir }
        | None -> Error "Dune workspace description has an invalid build_context field")
     | None, _ -> Error "Dune workspace description has no root field"
     | _, None -> Error "Dune workspace description has no build_context field")
;;

let root_of_environment (environment : Environment.t) ~cwd =
  match environment.root with
  | None -> find_root ~from:cwd
  | Some root -> Promise.return (resolve_from ~base:cwd root)
;;

let default_context (environment : Environment.t) =
  match environment.cross_target with
  | None -> "default"
  | Some target -> "default." ^ target
;;

let layout_of_environment (environment : Environment.t) ~root =
  let build_dir =
    match environment.build_dir with
    | None -> Path.(root / "_build")
    | Some build_dir -> resolve_from ~base:root build_dir
  in
  { root; build_dir }
;;

let preserve_equivalent_root ~fallback described =
  let open Promise.Syntax in
  let* fallback_realpath, described_realpath =
    Promise.all2
      ( Promise.Result.from_catch (Fs.realpath (Path.to_string fallback.root))
      , Promise.Result.from_catch (Fs.realpath (Path.to_string described.root)) )
  in
  let equal =
    match Platform.t with
    | Win32 -> Path.iequal
    | Darwin | Linux | Other -> Path.equal
  in
  match fallback_realpath, described_realpath with
  | Ok fallback_realpath, Ok described_realpath
    when equal (Path.of_string fallback_realpath) (Path.of_string described_realpath) ->
    Promise.return { described with root = fallback.root }
  | Ok _, Ok _ | Error _, _ | _, Error _ -> Promise.return described
;;

let realpath_or_original path =
  let open Promise.Syntax in
  let+ realpath = Promise.Result.from_catch (Fs.realpath (Path.to_string path)) in
  match realpath with
  | Ok realpath -> Path.of_string realpath
  | Error _ -> path
;;

let make { root; build_dir } ~context =
  { root; build_context = Path.(build_dir / context) }
;;

type cache_key =
  { sandbox : Sandbox.t
  ; cwd : Path.t
  ; build_dir : string option
  ; root : string option
  ; workspace : string option
  ; cross_target : string option
  }

let cache : (cache_key * t) list ref = ref []
let invalidate () = cache := []

let cache_key sandbox ~cwd =
  { sandbox
  ; cwd
  ; build_dir = Process.Env.get "DUNE_BUILD_DIR"
  ; root = Process.Env.get "DUNE_ROOT"
  ; workspace = Process.Env.get "DUNE_WORKSPACE"
  ; cross_target = Process.Env.get "DUNE_CROSS_TARGET"
  }
;;

let cache_key_equal left right =
  Sandbox.equal left.sandbox right.sandbox
  && Path.equal left.cwd right.cwd
  && Option.equal String.equal left.build_dir right.build_dir
  && Option.equal String.equal left.root right.root
  && Option.equal String.equal left.workspace right.workspace
  && Option.equal String.equal left.cross_target right.cross_target
;;

let dune_output sandbox ~cwd args =
  Sandbox.get_command sandbox "dune" args `Command |> Cmd.output ~cwd
;;

let contexts_of_output output =
  String.split_lines output
  |> List.filter_map ~f:(fun context ->
    let context = String.strip context in
    if String.is_empty context then None else Some context)
;;

let fallback_context (environment : Environment.t) contexts =
  let preferred = default_context environment in
  if List.mem contexts preferred ~equal:String.equal
  then preferred
  else (
    let cross_context =
      Option.bind environment.cross_target ~f:(fun target ->
        List.find contexts ~f:(String.is_suffix ~suffix:("." ^ target)))
    in
    Option.first_some cross_context (List.hd contexts) |> Option.value ~default:preferred)
;;

let query_contexts sandbox ~cwd =
  let open Promise.Syntax in
  let+ contexts = dune_output sandbox ~cwd [ "describe"; "contexts" ] in
  Result.map contexts ~f:contexts_of_output
;;

let query_layout sandbox ~cwd ~context ~fallback =
  let args =
    [ "describe"; "workspace"; "--format=csexp"; "--lang=0.1"; "--context=" ^ context ]
  in
  let open Promise.Syntax in
  let* described = dune_output sandbox ~cwd args in
  match described with
  | Error error ->
    log_chan
      `Warn
      ~section:"Dune workspace"
      "Unable to run `dune describe workspace`; using Dune's environment/default path \
       layout: %s"
      error;
    Promise.return fallback
  | Ok output ->
    (match of_canonical_sexp output with
     | Ok layout -> preserve_equivalent_root ~fallback layout
     | Error error ->
       log_chan
         `Warn
         ~section:"Dune workspace"
         "Unable to decode `dune describe workspace`: %s"
         error;
       Promise.return fallback)
;;

let environment_for_dune sandbox environment ~cwd =
  if not (Environment.needs_version_check environment)
  then Promise.return environment
  else
    let open Promise.Syntax in
    let+ output = dune_output sandbox ~cwd [ "--version" ] in
    match output with
    | Error _ -> environment
    | Ok output ->
      (match Dune.Dune_version.from_string (String.strip output) with
       | None -> environment
       | Some version -> Environment.for_dune_version environment version)
;;

let merlin_context_of_output ~build_dirs ~contexts output =
  let context_of_path path =
    let path = Path.of_string path in
    List.find contexts ~f:(fun context ->
      List.exists build_dirs ~f:(fun build_dir ->
        Path.is_inside ~dir:Path.(build_dir / context) path))
  in
  match Csexp.parse_string output with
  | Error (pos, message) -> Error (Printf.sprintf "at byte %d: %s" pos message)
  | Ok (Csexp.Atom _) -> Error "expected a list of Merlin configuration fields"
  | Ok (List fields) ->
    let from_paths paths = List.find_map paths ~f:context_of_path in
    (match
       Option.first_some
         (from_paths (field_values fields "INDEX"))
         (from_paths (List.rev (field_values fields "B")))
     with
     | Some context -> Ok context
     | None -> Error "Merlin configuration does not identify a build context")
;;

let query_merlin_context sandbox ~cwd ~source ~(layout : layout) ~contexts =
  let open Promise.Syntax in
  let* source, physical_build_dir =
    Promise.all2 (realpath_or_original source, realpath_or_original layout.build_dir)
  in
  let build_dirs = [ layout.build_dir; physical_build_dir ] in
  let request = Csexp.(to_string (List [ Atom "File"; Atom (Path.to_string source) ])) in
  let command = Sandbox.get_command sandbox "dune" [ "ocaml-merlin" ] `Command in
  let+ output = Cmd.output command ~cwd ~stdin:request in
  Result.bind output ~f:(merlin_context_of_output ~build_dirs ~contexts)
;;

let select_context
      sandbox
      (environment : Environment.t)
      ~cwd
      ~source
      ~layout
      ~fallback
      contexts
  =
  match environment.cross_target, contexts with
  | Some _, _ | None, ([] | [ _ ]) -> Promise.return fallback
  | None, _ :: _ :: _ ->
    let open Promise.Syntax in
    let+ merlin_context = query_merlin_context sandbox ~cwd ~source ~layout ~contexts in
    (match merlin_context with
     | Ok context -> context
     | Error _ -> fallback)
;;

let discover sandbox ~cwd ~source =
  let key = cache_key sandbox ~cwd in
  match List.Assoc.find !cache key ~equal:cache_key_equal with
  | Some workspace -> Promise.return workspace
  | None ->
    let open Promise.Syntax in
    let* environment = Environment.selected_sandbox sandbox ~cwd in
    let* environment = environment_for_dune sandbox environment ~cwd in
    let* root = root_of_environment environment ~cwd in
    let fallback_layout = layout_of_environment environment ~root in
    let* has_workspace_file = Fs.exists Path.(root / "dune-workspace" |> to_string) in
    let authoritative_workspace =
      match sandbox with
      | Sandbox.Opam _ | Custom _ -> true
      | Global | Esy _ | Dune _ -> false
    in
    let needs_contexts =
      authoritative_workspace
      || Option.is_some environment.workspace
      || has_workspace_file
    in
    let* contexts_result =
      if needs_contexts then query_contexts sandbox ~cwd else Promise.return (Ok [])
    in
    let contexts =
      match contexts_result with
      | Ok contexts -> contexts
      | Error error ->
        log_chan
          `Warn
          ~section:"Dune workspace"
          "Unable to run `dune describe contexts`; using Dune's default context: %s"
          error;
        []
    in
    let preferred_context = fallback_context environment contexts in
    let* layout =
      if authoritative_workspace
      then query_layout sandbox ~cwd ~context:preferred_context ~fallback:fallback_layout
      else Promise.return fallback_layout
    in
    let* context =
      select_context
        sandbox
        environment
        ~cwd
        ~source
        ~layout
        ~fallback:preferred_context
        contexts
    in
    let workspace = make layout ~context in
    cache := (key, workspace) :: !cache;
    Promise.return workspace
;;
