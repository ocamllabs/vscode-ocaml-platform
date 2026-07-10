open Import

let rec find_from_dir real_dir =
  let open Promise.Syntax in
  let* exists = Fs.exists Path.(to_string (real_dir / "dune-project")) in
  if exists then Promise.return (Some real_dir)
  else
    match Path.parent real_dir with
    | None -> Promise.return None
    | Some parent -> find_from_dir parent

let find_nearest_dune_project file =
  match Path.parent file with
  | None -> file
  | Some dir ->
      (* determine the absolute parent path that doesn't contain symlinks
         (as if we did 'cd DIR; cd ..; pwd' with a naive shell) *)
      dir
      |> Path.realpath
      |> find_from_dir
