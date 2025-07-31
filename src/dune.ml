open Import
open Base

module Dune_version = struct
  type t =
    | Release of int * int * int
    | Preview of int * int * int

  let parse_release_version version_str =
    match String.split_on_chars ~on:[ '.' ] version_str with
    | [ major; minor; patch ] ->
      (try
         let major = Int.of_string major in
         let minor = Int.of_string minor in
         let patch = Int.of_string patch in
         Some (Release (major, minor, patch))
       with
       | Failure _ -> None)
    | _ -> None
  ;;

  (** Parses a developer preview string to extract the build timestamp.
      Example: "Dune Developer Preview: build 2025-07-29T03:07:10Z, ..."
      Returns None if the format is invalid or the timestamp cannot be parsed. *)
  let parse_preview_version preview_str =
    let prefix = "Dune Developer Preview: build " in
    if String.is_prefix preview_str ~prefix
    then (
      let rest =
        String.sub
          ~pos:(String.length prefix)
          ~len:(String.length preview_str - String.length prefix)
          preview_str
      in
      match String.split_on_chars ~on:[ ',' ] rest with
      | timestamp_str :: _ ->
        (try
           Stdlib.Scanf.sscanf
             (String.strip timestamp_str)
             "%d-%d-%dT%d:%d:%dZ"
             (fun y m d _h _min _s -> Some (Preview (y, m, d)))
         with
         | Stdlib.Scanf.Scan_failure _ | End_of_file -> None)
      | _ -> None)
    else None
  ;;

  (** Parses the raw output of `dune --version`. *)
  let from_string str =
    let str = String.strip str in
    match parse_preview_version str with
    | Some version -> Some version
    | None ->
      (* If that fails, try parsing as a standard release *)
      let prefix = "Dune " in
      if String.is_prefix str ~prefix
      then (
        let version_part =
          String.sub
            ~pos:(String.length prefix)
            ~len:(String.length str - String.length prefix)
            str
        in
        parse_release_version version_part)
      else parse_release_version str
  ;;

  (** Checks if the parsed version is valid.
      - A release version is valid if it is >= 3.19.1.
      - A preview version is valid if its timestamp is on or after 2025-07-29. *)
  let is_valid version =
    match version with
    | Release (major, minor, patch) ->
      Stdlib.compare (major, minor, patch) (3, 19, 1) >= 0
    | Preview (y, m, d) -> Stdlib.compare (y, m, d) (2025, 7, 29) >= 0
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

let make root () =
  let open Promise.Syntax in
  (* Should we do something specific for Windows ? *)
  match root with
  | Some root ->
    let spawn = { Cmd.bin = binary; args = [] } in
    let* spawn = Cmd.check_spawn spawn in
    (match spawn with
     | Ok bin ->
       let+ dune_version_output =
         command { root; bin } ~args:[ "--version" ] |> Cmd.output ~cwd:root
       in
       (match dune_version_output with
        | Ok v ->
          (match Dune_version.from_string v with
           | Some version when Dune_version.is_valid version -> Some { bin; root }
           | _ -> None)
        | Error _ -> None)
     | Error _ -> Promise.return None)
  | None -> Promise.return None
;;
