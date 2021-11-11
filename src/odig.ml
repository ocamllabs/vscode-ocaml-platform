open Import

type t = Opam.t * Opam.Switch.t

type of_opam_error = Odig_not_installed

let of_opam (opam, switch) =
  let open Promise.Syntax in
  let+ is_installed = Opam.has_package opam switch "odig" in
  if is_installed then
    Ok (opam, switch)
  else
    Error Odig_not_installed

let cmd_ouput (opam, switch) args =
  let cmd = Opam.exec opam switch ~args in
  Cmd.output cmd

let conf t key =
  let open Promise.Syntax in
  let+ odig_conf_result = cmd_ouput t [ "odig"; "conf" ] in
  match odig_conf_result with
  | Error _ -> None
  | Ok conf ->
    let lines = String.split_lines conf in
    let is_whitespace_or_single_quote c =
      Char.equal c '\'' || Char.is_whitespace c
    in
    List.map lines ~f:(String.rsplit2 ~on:':')
    |> List.filter_opt
    |> List.find_map ~f:(fun (k, v) ->
           if String.equal k key then
             Some
               (String.strip v ~drop:is_whitespace_or_single_quote
               |> Path.of_string)
           else
             None)

let cache_dir t =
  let opam, switch = t in
  let default_cache_dir = Path.(Opam.path opam switch / "/var/cache/odig/") in
  let open Promise.Syntax in
  let+ cache_dir = conf t "cache-dir" in
  Option.value cache_dir ~default:default_cache_dir

let html_dir t =
  let open Promise.Syntax in
  let+ cache_dir = cache_dir t in
  Path.(cache_dir / "/html/")

let odoc_exec t name =
  let open Promise.Syntax in
  let* ouput = cmd_ouput t [ "odig"; "odoc"; name ] in
  match ouput with
  | Ok _ as ok ->
    let* html_dir = html_dir t in
    let+ dir_exists = Fs.exists (Path.to_string html_dir ^ name) in
    if dir_exists then
      ok
    else
      Error ""
  | Error _ as e -> Promise.resolve e
