open Import

type t = Opam.t * Opam.Switch.t

let of_opam (opam, switch) =
  let open Promise.Syntax in
  let+ is_installed = Opam.has_package opam switch ~package_name:"odig" in
  if is_installed then
    Ok (opam, switch)
  else
    Error
      "\"OCaml: the package \"odig\" must be installed to generate \
       documentation."

let cmd_ouput (opam, switch) args =
  let cmd = Opam.exec opam switch ~args in
  Cmd.output cmd

let cache_dir t =
  let opam, switch = t in
  let default_cache_dir =
    Path.(Opam.Switch.path opam switch / "/var/cache/odig/")
  in
  let open Promise.Syntax in
  let+ cache_dir = cmd_ouput t [ "odig"; "cache"; "path" ] in
  match cache_dir with
  | Ok cache_dir -> cache_dir |> String.strip |> Path.of_string
  | Error e ->
    let () = log "Failed to retrieve odig cache_dir: %s" e in
    default_cache_dir

let html_dir t =
  let open Promise.Syntax in
  let+ cache_dir = cache_dir t in
  Path.(cache_dir / "/html/")

let odoc_exec t ~package_name =
  let open Promise.Syntax in
  let* ouput = cmd_ouput t [ "odig"; "odoc"; package_name ] in
  let+ result =
    match ouput with
    | Ok _ as ok ->
      let* html_dir = html_dir t in
      let package_html_dir = Path.to_string html_dir ^ package_name in
      let+ dir_exists = Fs.exists package_html_dir in
      if dir_exists then
        ok
      else
        Error
          (Printf.sprintf
             "Directory %s should have been created but it doesn\'t exist."
             package_html_dir)
    | Error _ as e -> Promise.resolve e
  in
  result
  |> Result.map_error ~f:(fun error ->
         let () =
           log "Failed to generate documentation for package %s. Error: %s"
             package_name error
         in
         error)
