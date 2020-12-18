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
end

module Package : sig
  type t

  val name : t -> string

  val of_path : Path.t -> t
end = struct
  type t =
    { name : string
    ; path : Path.t
    }

  let name t = t.name

  let of_path path =
    let name = Path.basename path in
    { name; path }
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
  let ( / ) = Path.( / ) in
  let home = Node.Process.Env.get "HOME" |> Stdlib.Option.get in
  let path =
    match switch with
    | Switch.Local path -> path / "_opam"
    | Switch.Named name ->
      (* TODO: probably only works on Unix *)
      Path.of_string home / (".opam/" ^ name)
  in
  let packages_path = path / ".opam-switch/" / "packages" in
  let open Promise.Result.Syntax in
  let+ l = Node.Fs.readDir (Path.to_string packages_path) in
  List.map l ~f:(fun fpath -> Path.of_string fpath |> Package.of_path)
