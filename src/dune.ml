open Import

module Dune_version = struct
  type t =
    | Release of int * int * int
    | Preview of int * int * int

  let parse_release_version version_str =
    let extract_int s =
      let digits = String.filter s ~f:Char.is_digit in
      if String.is_empty digits then None else Some (Int.of_string digits)
    in
    (* When building from source, dune versions look like 3.20.2-744-gfefffb8,
       and we only care about the prefix before the '-'. *)
    match String.split_on_chars ~on:[ '-' ] version_str with
    | [] -> None
    | version_prefix :: _ ->
      (match String.split_on_chars ~on:[ '.' ] version_prefix with
       | [ major; minor; patch ] ->
         (match extract_int major, extract_int minor, extract_int patch with
          | Some major, Some minor, Some patch_num ->
            Some (Release (major, minor, patch_num))
          | _ -> None)
       | _ -> None)
  ;;

  let parse_preview_version str =
    (* NOTE: This is coupled with the CD configuration for building the nightly at
       https://github.com/ocaml-dune/binary-distribution/blob/de7bc19e5557451856e12d3561a88daf1e14da5a/.github/workflows/binary.yaml#L88 *)
    let legacy_preview_prefix =
      (* This was the prefix used prior to 2025-11-25 *)
      "\"Dune Developer Preview: build"
    in
    let nightly_prefix = "\"Nightly build " in
    let suffix =
      match String.chop_prefix ~prefix:legacy_preview_prefix str with
      | Some suffix -> Some suffix
      | None ->
        (match String.chop_prefix ~prefix:nightly_prefix str with
         | Some suffix -> Some suffix
         | None -> None)
    in
    match suffix with
    | None -> None
    | Some rest ->
      (match String.split_on_chars ~on:[ ',' ] rest with
       | timestamp_str :: _ ->
         (try
            Stdlib.Scanf.sscanf
              (String.strip timestamp_str)
              "%d-%d-%dT%d:%d:%dZ"
              (fun y m d _h _min _s -> Some (Preview (y, m, d)))
          with
          | Stdlib.Scanf.Scan_failure _ | End_of_file -> None)
       | [] -> None)
  ;;

  let from_string str =
    match parse_preview_version str with
    | Some version -> Some version
    | None -> parse_release_version str
  ;;

  (* Versions >= 3.20.0 and preview versions with a timestamp on or
     after 2025-07-30 support everything needed for VSCode to support DPM,
     e.g. `dune lock`, `dune tools exec`, support of various Dune dev tools etc.
     The last feature needed was implemented on 2025-07-29 and ensures that
     other Dune dev tools (in particular ocamlformat) are included in the PATH
     of the `ocamllsp` process. *)
  let is_valid version =
    match version with
    | Release (major, minor, patch) ->
      Stdlib.compare (major, minor, patch) (3, 20, 0) >= 0
    | Preview (y, m, d) -> Stdlib.compare (y, m, d) (2025, 7, 30) >= 0
  ;;
end

type t =
  { root : Path.t
  ; bin : Cmd.spawn
  }

let binary = Path.of_string "dune"

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

let tools ~tool ?(args = []) t cmd =
  match cmd with
  | `Exec_ -> Cmd.Spawn (Cmd.append t.bin ([ "tools"; "exec"; tool; "--" ] @ args))
  | `Which -> Cmd.Spawn (Cmd.append t.bin ([ "tools"; "which"; tool ] @ args))
  | `Install -> Cmd.Spawn (Cmd.append t.bin ([ "tools"; "install"; tool ] @ args))
;;

let is_ocamllsp_present t =
  let open Promise.Syntax in
  let+ ocamllsp_path = tools ~tool:"ocamllsp" t `Which |> Cmd.output ~cwd:t.root in
  match ocamllsp_path with
  | Ok _path -> true
  | Error err ->
    log_chan `Info ~section:"dune" "Ocamllsp not found with error %s" err;
    false
;;

let equal d1 d2 = Path.equal d1.root d2.root
let root t = t.root

let make root () =
  let open Promise.Syntax in
  let dune_version_output bin root =
    command { root; bin } ~args:[ "--version" ] |> Cmd.output ~cwd:root
  in
  (* Should we do something specific for Windows ? *)
  match root with
  | Some root ->
    let spawn = { Cmd.bin = binary; args = [] } in
    let* spawn = Cmd.check_spawn spawn in
    (match spawn with
     | Ok bin ->
       let+ dune_version_output = dune_version_output bin root in
       (match dune_version_output with
        | Ok v ->
          (match Dune_version.from_string v with
           | Some version when Dune_version.is_valid version -> Some { bin; root }
           | _ -> None)
        | Error _err -> None)
     | Error _err ->
       let* check_if_dune_is_installed_with_opam =
         command
           { root; bin = { Cmd.bin = Path.of_string "opam"; args = [] } }
           ~args:[ "exec"; "--"; "which"; "dune" ]
         |> Cmd.output ~cwd:root
       in
       (match check_if_dune_is_installed_with_opam with
        | Error _err -> Promise.return None
        | Ok path when String.is_empty path -> Promise.return None
        | Ok path ->
          let bin = { Cmd.bin = Path.of_string path; args = [] } in
          let* dune_version_output = dune_version_output bin root in
          (match dune_version_output with
           | Ok v ->
             (match Dune_version.from_string v with
              | Some version when Dune_version.is_valid version ->
                Promise.return (Some { bin; root })
              | _ -> Promise.return None)
           | Error _err -> Promise.return None)))
  | None -> Promise.return None
;;
