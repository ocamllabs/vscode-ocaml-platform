open Import

module Dune_version = struct
  type t =
    | Release of int * int * int
    | Preview of int * int * int

  let to_string t =
    match t with
    | Release (major, minor, patch) ->
      Printf.sprintf "(release) %d.%d.%d" major minor patch
    | Preview (y, m, d) -> Printf.sprintf "(nightly) %d-%d-%d" y m d
  ;;

  let compare v1 v2 =
    let open Stdlib in
    match v1, v2 with
    | Release (major1, minor1, patch1), Release (major2, minor2, patch2) ->
      compare (major1, minor1, patch1) (major2, minor2, patch2) |> Ordering.of_int
    | Preview (y1, m1, d1), Preview (y2, m2, d2) ->
      compare (y1, m1, d1) (y2, m2, d2) |> Ordering.of_int
    | Release _, Preview _ ->
      Ordering.of_int (-1)
      (* we assume that users using a preview version are using a more recent version or updating the  nightly previews frequently *)
    | Preview _, Release _ -> Ordering.of_int 1
  ;;

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

  (* Versions >= 3.24.0 and preview versions with a timestamp on or
     after 2026-06-11 support everything needed for VSCode to support DPM,
     e.g. `dune lock`, `dune tools exec`, support of various Dune dev tools etc. *)
  let is_valid version =
    match version with
    | Release (major, minor, patch) ->
      Stdlib.compare (major, minor, patch) (3, 24, 0) >= 0
    | Preview (y, m, d) -> Stdlib.compare (y, m, d) (2026, 6, 11) >= 0
  ;;
end

let construct_dune_path path = Path.(of_string (String.strip path) / "dune")

type t =
  { root : Path.t
  ; bin : Cmd.spawn
  }

let make ~working_dir ~dune_path =
  let open Promise.Syntax in
  let* spawn = Cmd.check_spawn { Cmd.bin = dune_path; args = [] } in
  match spawn with
  | Ok bin -> Promise.return (Some { root = working_dir; bin })
  | Error _ ->
    log_chan `Info ~section:"dune package management" "Dune not found in the environment.";
    Promise.return None
;;

let command t ~args = Cmd.Spawn (Cmd.append t.bin args)

let exec ~target ?(args = []) t =
  Cmd.Spawn (Cmd.append t.bin ([ "exec"; target; "--" ] @ args))
;;

let exec_pkg ~cmd ?(args = []) t = Cmd.Spawn (Cmd.append t.bin ([ "pkg"; cmd ] @ args))

let is_dpm_enabled t =
  let open Promise.Syntax in
  let+ { exitCode; _ } = Cmd.run (exec_pkg ~cmd:"enabled" t) in
  Int.equal exitCode 0
;;

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

let equal d1 d2 =
  let dune_bin = Path.equal d1.bin.bin d2.bin.bin in
  let root_equal = Path.equal d1.root d2.root in
  dune_bin && root_equal
;;

let root t = t.root
let dune_path t = t.bin.bin

let is_dune_in_switch opam switch =
  let open Promise.Syntax in
  Opam.var opam switch ~args:[ "dune:bin" ]
  |> Cmd.output
  >>= function
  | Error err ->
    log_chan
      `Info
      ~section:"dune package management"
      "Dune is not installed in switch %s: %s"
      (Opam.Switch.name switch)
      err;
    Promise.return None
  | Ok path ->
    command
      { root = Path.of_string ""
      ; bin = { Cmd.bin = construct_dune_path path; args = [] }
      }
      ~args:[ "--version" ]
    |> Cmd.output
    >>| (function
     | Ok v ->
       (match Dune_version.from_string v with
        | Some version when Dune_version.is_valid version -> Some (path, switch, version)
        | _ -> None)
     | Error _err -> None)
;;

let all_opam_switches_with_dune opam switches =
  Promise.List.filter_map (fun switch -> is_dune_in_switch opam switch) switches
;;

let get_opam_dunes opam =
  let open Promise.Syntax in
  let* opam_dunes =
    match opam with
    | Some opam ->
      let* opam_switches = Opam.switch_list opam in
      all_opam_switches_with_dune opam opam_switches
    | None -> Promise.return []
  in
  let sorted_opam_dunes =
    List.sort opam_dunes ~compare:(fun (_, _, v1) (_, _, v2) ->
      (* Sort descending: most recent version first *)
      Dune_version.compare v2 v1)
  in
  Promise.return sorted_opam_dunes
;;

let get_system_dune_path () =
  let open Promise.Syntax in
  let run_cmd cmd =
    let+ output = Cmd.output cmd ~cwd:(Path.of_string "") in
    match output with
    | Ok output ->
      (match String.split_lines (String.strip output) with
       | [ path; version_str ] ->
         let version = Dune_version.from_string (String.strip version_str) in
         (match version with
          | Some v -> Some (String.strip path, v)
          | None -> None)
       | _ -> None)
    | Error _ -> None
  in
  match Platform.t with
  | Win32 ->
    (* Dune package management is not supported on Windows at the moment
       See: https://github.com/ocaml/dune/issues/11161 *)
    Promise.return None
  | Darwin | Linux | Other ->
    let shell_script =
      "if which opam >/dev/null 2>&1; then eval $(opam env --revert || true); fi; "
      ^ "which dune && dune --version"
    in
    run_cmd (Cmd.Shell shell_script)
;;
