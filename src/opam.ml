open Import

module Switch = struct
  type t =
    | Local of Path.t
    | Named of string

  let ofLine line =
    if line.[0] = '/' then
      Local (Path.ofString line)
    else
      Named line
end

let parseSwitchList out =
  let lines = String.split_on_char '\n' out in
  List.map Switch.ofLine lines

let switchList ~cmd ~cwd =
  Cmd.output cmd ~args:[| "switch"; "list"; "-s" |] ~cwd
  |> Promise.Result.map parseSwitchList

let parseEnvOutput (opamEnvOutput : string) =
  let error message =
    Error ("invalid opam output: " ^ message ^ "\n" ^ opamEnvOutput)
  in
  match Sexp.parse_string opamEnvOutput with
  | Error s -> error s
  | Ok (Sexp.Atom a) -> error ("unexpected atom " ^ a)
  | Ok (Sexp.List s) -> (
    match
      List.map
        (function
          | Sexp.List [ Sexp.Atom key; Atom value ] -> (key, value)
          | _ -> raise Exit)
        s
    with
    | exception Exit -> error "unable to parse key value list"
    | kvs -> Ok (Js.Dict.fromList kvs) )

let env ?switch ~cmd ~cwd () =
  let args =
    let args = [| "env"; "--sexp" |] in
    match switch with
    | None -> args
    | Some sw -> Js.Array.concat [| "--switch=" ^ sw |] args
  in
  Cmd.output cmd ~args ~cwd |> Promise.map (Result.bind ~f:parseEnvOutput)
