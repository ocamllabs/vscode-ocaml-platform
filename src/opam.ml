open Import

module Switch = struct
  type t =
    | Local of Path.t  (** if switch name is directory name where it's stored *)
    | Named of string  (** if switch is stored in ~/.opam *)

  let make switch_name =
    if Char.equal switch_name.[0] '/' then
      Local (Path.of_string switch_name)
    else
      Named switch_name

  let name = function
    | Named s -> s
    | Local p -> Path.to_string p

  let equal x y =
    match (x, y) with
    | Local x, Local y -> Path.equal x y
    | Named x, Named y -> String.equal x y
    | _, _ -> false
end

let binary = Path.of_string "opam"

type t = Cmd.spawn

let make () =
  let open Promise.Syntax in
  let+ spawn = Cmd.check_spawn { bin = binary; args = [] } in
  match spawn with
  | Error _ -> None
  | Ok cmd -> Some cmd

let parse_switch_list out =
  let lines = String.split_on_chars ~on:[ '\n' ] out in
  let result =
    lines
    |> List.filter_map ~f:(function
         | "" -> None
         | s -> Some (Switch.make s))
  in
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

let switch_arg switch = "--switch=" ^ Switch.name switch

let exec t ~switch ~args =
  Cmd.Spawn (Cmd.append t ("exec" :: switch_arg switch :: "--" :: args))

let exists t ~switch =
  let open Promise.Syntax in
  let+ switches = switch_list t in
  List.exists switches ~f:(Switch.equal switch)
