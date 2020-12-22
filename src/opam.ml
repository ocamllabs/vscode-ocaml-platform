open Import

module Switch = struct
  type t =
    | Local of Path.t  (** if switch name is directory name where it's stored *)
    | Named of string  (** if switch is stored in ~/.opam *)

  let of_string = function
    | "" -> None
    | switch_name ->
      let switch_name = String.strip switch_name in
      if Char.equal switch_name.[0] '/' then
        Some (Local (Path.of_string switch_name))
      else
        Some (Named switch_name)

  let name = function
    | Named s -> s
    | Local p -> Path.to_string p

  let equal x y =
    match (x, y) with
    | Local x, Local y -> Path.equal x y
    | Named x, Named y -> String.equal x y
    | _, _ -> false

  let path =
    let home = Node.Process.Env.get "HOME" |> Stdlib.Option.get in
    function
    | Named s -> Path.(of_string home / ".opam" / s)
    | Local p -> Path.(p / "_opam")

  let compiler t =
    let open Promise.Syntax in
    let rec compiler_of_fields = function
      | [] ->
        show_message `Info "Read None";
        None
      | OpamParserTypes.Variable (_, "compiler", String (_, v)) :: _
      | OpamParserTypes.Variable (_, "compiler", List (_, String (_, v) :: _))
        :: _ ->
        show_message `Info "Read %s" v;
        Some v
      | _ :: rest -> compiler_of_fields rest
    in
    let path = path t in
    let switch_state_filepath =
      Path.(path / ".opam-switch" / "switch-state") |> Path.to_string
    in
    let+ file_content = Fs.readFile switch_state_filepath in
    let OpamParserTypes.{ file_contents; _ } =
      OpamParser.string file_content switch_state_filepath
    in
    compiler_of_fields file_contents
end

module Package = struct
  type t =
    { name : string
    ; version : string
    ; documentation : string option
    ; synopsis : string option
    ; path : Path.t
    }

  let name t = t.name

  let version t = t.version

  let documentation t = t.documentation

  let synopsis t = t.synopsis

  let rec documentation_of_fields = function
    | [] -> None
    | OpamParserTypes.Variable (_, "doc", String (_, v)) :: _ -> Some v
    | _ :: rest -> documentation_of_fields rest

  let rec synopsis_of_fields = function
    | [] -> None
    | OpamParserTypes.Variable (_, "synopsis", String (_, v)) :: _ -> Some v
    | _ :: rest -> synopsis_of_fields rest

  let of_path path =
    match String.split (Path.basename path) ~on:'.' with
    | name :: version_parts ->
      let open Promise.Syntax in
      let opam_filepath = Path.(path / "opam") |> Path.to_string in
      let+ file_content = Fs.readFile opam_filepath in
      let OpamParserTypes.{ file_contents; _ } =
        OpamParser.string file_content opam_filepath
      in
      let version = String.concat version_parts ~sep:"." in
      let documentation = documentation_of_fields file_contents in
      let synopsis = synopsis_of_fields file_contents in
      Some { name; version; path; documentation; synopsis }
    | _ -> Promise.return None

  let sexp_of_t t =
    Sexp.List
      [ Sexp.Atom "name"
      ; Sexp.Atom t.name
      ; Sexp.Atom "version"
      ; Sexp.Atom t.version
      ; Sexp.Atom "documentation"
      ; Sexp.Atom (Option.value t.documentation ~default:"")
      ; Sexp.Atom "synopsys"
      ; Sexp.Atom (Option.value t.synopsis ~default:"")
      ; Sexp.Atom "path"
      ; Sexp.Atom (t.path |> Path.to_string)
      ]

  let t_of_sexp = function
    | Sexp.List
        [ Sexp.Atom "name"
        ; Sexp.Atom name
        ; Sexp.Atom "version"
        ; Sexp.Atom version
        ; Sexp.Atom "documentation"
        ; Sexp.Atom documentation
        ; Sexp.Atom "synopsys"
        ; Sexp.Atom synopsis
        ; Sexp.Atom "path"
        ; Sexp.Atom path
        ] ->
      { name
      ; version
      ; path = Path.of_string path
      ; documentation =
          ( match documentation with
          | "" -> None
          | _ -> Some documentation )
      ; synopsis =
          ( match synopsis with
          | "" -> None
          | _ -> Some synopsis )
      }
    | _ -> assert false
end

type t = Cmd.spawn

let opam_binary = Path.of_string "opam"

let ocaml_env_binary = Path.of_string "ocaml-env"

let ocaml_env_setting =
  Settings.create ~scope:Global ~key:"ocaml.useOcamlEnv"
    ~of_json:Jsonoo.Decode.bool ~to_json:Jsonoo.Encode.bool

let make () =
  let spawn =
    match (Platform.t, Settings.get ocaml_env_setting) with
    | Win32, Some true ->
      { Cmd.bin = ocaml_env_binary; args = [ "exec"; "--"; "opam" ] }
    | _ -> { Cmd.bin = opam_binary; args = [] }
  in
  let open Promise.Syntax in
  let+ spawn = Cmd.check_spawn spawn in
  match spawn with
  | Error _ -> None
  | Ok cmd -> Some cmd

let parse_switch_list out =
  let lines = String.split_on_chars ~on:[ '\n' ] out in
  let result = lines |> List.filter_map ~f:Switch.of_string in
  log "%d switches" (List.length result);
  result

let switch_list t =
  let command = Cmd.append t [ "switch"; "list"; "-s" ] in
  let open Promise.Syntax in
  let+ output = Cmd.output (Spawn command) in
  match output with
  | Error _ ->
    show_message `Warn "Unable to read the list of switches.";
    []
  | Ok out -> parse_switch_list out

let switch_show ?cwd t =
  let command = Cmd.append t [ "switch"; "show" ] in
  let open Promise.Syntax in
  let+ output = Cmd.output ?cwd (Spawn command) in
  match output with
  | Ok out -> Switch.of_string out
  | Error _ ->
    show_message `Warn "Unable to read the current switch.";
    None

let switch_arg switch = "--switch=" ^ Switch.name switch

let exec t ~switch ~args =
  Cmd.Spawn (Cmd.append t ("exec" :: switch_arg switch :: "--" :: args))

let exists t ~switch =
  let open Promise.Syntax in
  let+ switches = switch_list t in
  List.exists switches ~f:(Switch.equal switch)

let equal o1 o2 = Cmd.equal_spawn o1 o2

let get_switch_packages switch =
  let packages_path =
    Path.(Switch.path switch / ".opam-switch/" / "packages")
  in
  let open Promise.Result.Syntax in
  let* l = Node.Fs.readDir (Path.to_string packages_path) in
  Promise.List.filter_map
    (fun fpath -> Package.of_path Path.(packages_path / fpath))
    l
  |> Promise.map (fun x -> Ok x)

let remove_switch t switch =
  let name = Switch.name switch in
  Cmd.Spawn (Cmd.append t [ "-y"; "switch"; "remove"; name ])

let uninstall_package t ~switch ~package =
  exec t ~switch ~args:[ "uninstall"; Package.name package ]
