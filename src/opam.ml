open Import

module Switch = struct
  type t =
    | Local of Path.t  (** if switch name is directory name where it's stored *)
    | Named of string  (** if switch is stored in ~/.opam *)

  let make switch_name =
    if switch_name.[0] = '/' then
      Local (Path.ofString switch_name)
    else
      Named switch_name

  let name = function
    | Named s -> s
    | Local p -> Path.toString p
end

let binary = Path.ofString "opam"

type t = Cmd.spawn

let make () =
  let open Promise.O in
  Cmd.checkSpawn { bin = binary; args = [] } >>| function
  | Error _ -> None
  | Ok cmd -> Some cmd

let parseSwitchList out =
  let lines = String.split_on_char '\n' out in
  let result =
    Belt.List.keepMap lines (function
      | "" -> None
      | s -> Some (Switch.make s))
  in
  log "%d switches" (List.length result);
  result

let switchList t =
  let command = Cmd.append t [ "switch"; "list"; "-s" ] in
  let open Promise.O in
  Cmd.output (Spawn command) >>| function
  | Error _ ->
    message `Warn "Unable to read the list of switches.";
    []
  | Ok out -> parseSwitchList out

let switchArg switch = "--switch=" ^ Switch.name switch

let exec t ~switch ~args =
  Cmd.Spawn (Cmd.append t ("exec" :: switchArg switch :: "--" :: args))

let exists t ~switch =
  let open Promise.O in
  switchList t >>| List.exists (fun sw -> sw = switch)
