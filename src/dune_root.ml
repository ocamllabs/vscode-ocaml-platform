open Import

let rec find_from_dir dir =
  let open Promise.Syntax in
  let* exists = Fs.exists Path.(to_string (dir / "dune-project")) in
  if exists then Promise.return (Some dir)
  else
    match Path.parent dir with
    | None -> Promise.return None
    | Some parent -> find_from_dir parent

let find file =
  let real_file =
    match Path.realpath file with
    | exception _ -> file
    | p -> p
  in
  find_from_dir (Path.dirname real_file)
