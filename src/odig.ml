open Import

type t = { cache_dir : Path.t }

let make_odig_cmd sandbox = Sandbox.get_command sandbox "odig"

(** TODO: propose to install odig. See
    https://github.com/ocamllabs/vscode-ocaml-platform/pull/771#discussion_r765297112
*)
let of_sandbox (sandbox : Sandbox.t) =
  let make_odig_cmd = make_odig_cmd sandbox in
  let odig_version = make_odig_cmd [ "--version" ] in
  let open Promise.Syntax in
  let* output = Cmd.output odig_version in
  match output with
  | Ok _ -> (
    let+ cache_dir = Cmd.output (make_odig_cmd [ "cache"; "path" ]) in
    match cache_dir with
    | Ok cache_dir ->
      let cache_dir = cache_dir |> String.strip |> Path.of_string in
      Ok { cache_dir }
    | Error _ -> Error "OCaml: Failed to retrieve odig cache_dir")
  | Error _ ->
    Promise.resolve
      (Error
         "OCaml: the \"odig\" binary must be available in the current sandbox \
          to generate documentation.")

let cmd_output ~sandbox ~args = Cmd.output (make_odig_cmd sandbox args)

let html_dir t = Path.(t.cache_dir / "/html/")

let odoc_exec t ~sandbox ~package_name =
  let open Promise.Syntax in
  let* ouput = cmd_output ~sandbox ~args:[ "odoc"; package_name ] in
  let+ result =
    match ouput with
    | Error _ as e -> Promise.resolve e
    | Ok _ ->
      let html_dir = html_dir t in
      let package_html_dir = Path.(html_dir / package_name) |> Path.to_string in
      let open Promise.Syntax in
      let+ dir_exists = Fs.exists package_html_dir in
      if dir_exists then Ok ()
      else
        Error
          (Printf.sprintf
             "Directory %s should have been created but it doesn\'t exist."
             package_html_dir)
  in
  Result.map_error result ~f:(fun error ->
      let () =
        log
          "Failed to generate documentation for package %s. Error: %s"
          package_name
          error
      in
      error)
