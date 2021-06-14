open Import

type t =
  { bin : Cmd.spawn
  ; root : Path.t
  }

let opam_binary = Path.of_string "opam"

let make ?root () =
  let spawn =
    if Ocaml_windows.use_ocaml_env () then
      Ocaml_windows.spawn_ocaml_env [ "opam" ]
    else
      { Cmd.bin = opam_binary; args = [] }
  in
  let open Promise.Syntax in
  let* spawn = Cmd.check_spawn spawn in
  match (spawn, root) with
  | Error _, _ -> Promise.return None
  | Ok bin, Some root -> Promise.return (Some { bin; root })
  | Ok bin, None -> (
    let var_root_cmd = Cmd.Spawn (Cmd.append bin [ "var"; "root" ]) in
    let+ var_root_output = Cmd.output var_root_cmd in
    match var_root_output with
    | Error _ -> None
    | Ok output ->
      let root = String.strip output |> Path.of_string in
      Some { bin; root })

let spawn t args =
  let rec insert_root_flag opamroot = function
    | [] -> [ "--root"; Path.to_string opamroot ]
    | "--" :: args -> "--root" :: Path.to_string opamroot :: "--" :: args
    | arg :: args -> arg :: insert_root_flag opamroot args
  in
  let args = insert_root_flag t.root args in
  Cmd.Spawn (Cmd.append t.bin args)

module Opam_parser = struct
  let rec string name = function
    | [] -> None
    | OpamParserTypes.Variable (_, s, String (_, v)) :: _
      when String.equal s name ->
      Some v
    | _ :: rest -> string name rest

  let rec list name = function
    | [] -> None
    | OpamParserTypes.Variable (_, s, List (_, l)) :: _ when String.equal s name
      ->
      let rec aux acc = function
        | [] -> acc |> List.rev
        | OpamParserTypes.String (_, v) :: rest -> aux (v :: acc) rest
        | _ -> assert false
      in
      Some (aux [] l)
    | _ :: rest -> list name rest
end

module Opam_path = struct
  let package_dir root pkg = Path.(root / ".opam-switch" / "packages" / pkg)

  let switch_state root = Path.(root / ".opam-switch" / "switch-state")
end

module Switch = struct
  type t =
    | Local of Path.t  (** if switch name is directory name where it's stored *)
    | Named of string  (** if switch is stored in ~/.opam *)

  let of_string = function
    | "" -> None
    | switch_name ->
      let switch_name = String.strip switch_name in
      if Path.is_absolute (Path.of_string switch_name) then
        Some (Local (Path.of_string switch_name))
      else
        Some (Named switch_name)

  let name = function
    | Named s -> s
    | Local p -> Path.to_string p

  let path opam t =
    match t with
    | Local p -> Path.(p / "_opam")
    | Named n -> Path.(opam.root / n)

  let equal x y =
    match (x, y) with
    | Local x, Local y -> Path.equal x y
    | Named x, Named y -> String.equal x y
    | _, _ -> false
end

module Switch_state : sig
  type opam := t

  type t

  val of_switch : opam -> Switch.t -> t Promise.t

  val compilers : t -> string list option

  val root : t -> string list option

  val installed : t -> string list option
end = struct
  type t = OpamParserTypes.opamfile_item list

  let of_switch opam switch =
    let open Promise.Syntax in
    let path = Switch.path opam switch in
    let switch_state_filepath = Opam_path.switch_state path |> Path.to_string in
    let+ file_content = Fs.readFile switch_state_filepath in
    let { OpamParserTypes.file_contents; _ } =
      OpamParser.FullPos.string file_content switch_state_filepath
      |> OpamParser.FullPos.to_opamfile
    in
    file_contents

  let compilers = Opam_parser.list "compiler"

  let root = Opam_parser.list "roots"

  let installed = Opam_parser.list "installed"
end

module Package = struct
  type t =
    { path : Path.t
    ; items : OpamParserTypes.opamfile_item list
    ; name : string
    ; version : string
    }

  let of_path path =
    match String.split (Path.basename path) ~on:'.' with
    | [] -> Promise.return None
    | name :: version_parts ->
      let open Promise.Syntax in
      let opam_filepath = Path.(path / "opam") |> Path.to_string in
      let* file_exists = Fs.exists opam_filepath in
      if not file_exists then
        Promise.return None
      else
        let+ file_content = Fs.readFile opam_filepath in
        let { OpamParserTypes.file_contents; _ } =
          OpamParser.FullPos.string file_content opam_filepath
          |> OpamParser.FullPos.to_opamfile
        in
        let version = String.concat version_parts ~sep:"." in
        Some { path; name; version; items = file_contents }

  let path t = t.path

  let name t = t.name

  let version t = t.version

  let documentation t = Opam_parser.string "doc" t.items

  let synopsis t = Opam_parser.string "synopsis" t.items

  let depends t =
    let rec parser = function
      | [] -> None
      | OpamParserTypes.Variable (_, s, List (_, l)) :: _
        when String.equal s "depends" ->
        let rec aux acc = function
          | [] -> acc |> List.rev
          | OpamParserTypes.String (_, v) :: rest -> aux (v :: acc) rest
          | _ :: rest -> aux acc rest
        in
        Some (aux [] l)
      | _ :: rest -> parser rest
    in
    parser t.items

  let has_dependencies t =
    match depends t with
    | None
    | Some [] ->
      false
    | _ -> true

  let get_switch_package name ~package_path =
    let open Promise.Syntax in
    let* l = Node.Fs.readDir (Path.to_string package_path) in
    match l with
    | Error _ -> Promise.return None
    | Ok l ->
      Promise.List.find_map
        (fun fpath ->
          let basename = Stdlib.Filename.basename fpath in
          if String.is_prefix basename ~prefix:name then
            of_path Path.(package_path / fpath)
          else
            Promise.return None)
        l

  let dependencies package =
    match depends package with
    | None ->
      Promise.return
        (Error "Could not get the root packaged from the switch state")
    | Some l ->
      Promise.List.filter_map
        (fun pkg ->
          let package_path =
            (* The package path is never the root, so it's safe to use
               [value_exn] *)
            Option.value_exn (Path.parent (path package))
          in
          get_switch_package pkg ~package_path)
        l
      |> Promise.map Result.return
end

let switch_arg switch = "--switch=" ^ Switch.name switch

let exec t switch ~args = spawn t ("exec" :: switch_arg switch :: "--" :: args)

let init t = spawn t [ "init"; "-y" ]

let parse_switch_list out =
  let lines = String.split_on_chars ~on:[ '\n' ] out in
  let result = lines |> List.filter_map ~f:Switch.of_string in
  result

let switch_create t ~name ~args = spawn t ("switch" :: "create" :: name :: args)

let switch_list t =
  let command = spawn t [ "switch"; "list"; "-s" ] in
  let open Promise.Syntax in
  let+ output = Cmd.output command in
  match output with
  | Error _ ->
    show_message `Warn "Unable to read the list of switches.";
    []
  | Ok out -> parse_switch_list out

let switch_exists t switch =
  let open Promise.Syntax in
  let+ switches = switch_list t in
  List.exists switches ~f:(Switch.equal switch)

let equal o1 o2 = Cmd.equal_spawn o1.bin o2.bin && Path.equal o1.root o2.root

let switch_show ?cwd t =
  let command = spawn t [ "switch"; "show" ] in
  let open Promise.Syntax in
  let+ output = Cmd.output ?cwd command in
  match output with
  | Ok out -> Switch.of_string out
  | Error _ ->
    show_message `Warn "Unable to read the current switch.";
    None

let switch_remove t switch =
  let name = Switch.name switch in
  spawn t [ "switch"; "remove"; name; "-y" ]

let install t switch ~packages =
  spawn t ("install" :: switch_arg switch :: "-y" :: packages)

let update t switch = spawn t [ "update"; switch_arg switch ]

let upgrade t switch = spawn t [ "upgrade"; switch_arg switch; "-y" ]

let remove t switch packages =
  spawn t ("remove" :: switch_arg switch :: "-y" :: packages)

let switch_compiler t switch =
  let open Promise.Syntax in
  let+ switch_state = Switch_state.of_switch t switch in
  let compilers = Switch_state.compilers switch_state in
  Option.bind compilers ~f:List.hd

let packages_from_switch_state_field t switch callback =
  let open Promise.Syntax in
  let* switch_state = Switch_state.of_switch t switch in
  match callback switch_state with
  | None ->
    Promise.return (Error "Could not get the packages from the switch state")
  | Some l ->
    let path = Switch.path t switch in
    Promise.List.filter_map
      (fun name ->
        let package_path = Opam_path.package_dir path name in
        Package.of_path package_path)
      l
    |> Promise.map Result.return

let packages t switch =
  packages_from_switch_state_field t switch Switch_state.installed

let root_packages t switch =
  packages_from_switch_state_field t switch Switch_state.root

let package_remove t switch packages =
  let names = List.map ~f:Package.name packages in
  remove t switch names
