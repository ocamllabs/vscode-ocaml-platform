open Import

type t =
  { make_cmd : string list -> Cmd.t
  ; cache_dir : Path.t
  }

(** TODO: propose to install odig. See
    https://github.com/ocamllabs/vscode-ocaml-platform/pull/771#discussion_r765297112 *)
let of_sandbox (sandbox : Sandbox.t) =
  let cmd = Sandbox.get_command sandbox "which" [ "odig" ] in
  let open Promise.Syntax in
  let* output = Cmd.output cmd in
  match output with
  | Ok _ -> (
    let make_cmd = Sandbox.get_command sandbox "odig" in
    let+ cache_dir = Cmd.output (make_cmd [ "cache"; "path" ]) in
    match cache_dir with
    | Ok cache_dir ->
      let cache_dir = cache_dir |> String.strip |> Path.of_string in
      Ok { make_cmd; cache_dir }
    | Error _ -> Error "OCaml: Failed to retrieve odig cache_dir")
  | Error _ ->
    Promise.resolve
      (Error
         "OCaml: the \"odig\" binary must be available in the current sandbox \
          to generate documentation.")

let cmd_output { make_cmd; _ } ~args = Cmd.output (make_cmd args)

let html_dir t = Path.(t.cache_dir / "/html/")

let odoc_exec t ~package_name =
  let open Promise.Syntax in
  let* ouput = cmd_output t ~args:[ "odoc"; package_name ] in
  let+ result =
    match ouput with
    | Error _ as e -> Promise.resolve e
    | Ok _ as ok ->
      let html_dir = html_dir t in
      let package_html_dir = Path.to_string html_dir ^ package_name in
      let open Promise.Syntax in
      let+ dir_exists = Fs.exists package_html_dir in
      if dir_exists then ok
      else
        Error
          (Printf.sprintf
             "Directory %s should have been created but it doesn\'t exist."
             package_html_dir)
  in
  Result.map_error result ~f:(fun error ->
      let () =
        log "Failed to generate documentation for package %s. Error: %s"
          package_name error
      in
      error)
