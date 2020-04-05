open Import

module Switch = struct
  type t =
    | Local of Path.t
    | Named of string

  let ofString line =
    if line.[0] = '/' then
      Local (Path.ofString line)
    else
      Named line

  let toString = function
    | Named s -> s
    | Local p -> Path.toString p
end

let binary = "opam"

type t = Cmd.t

let make () =
  Cmd.make ~cmd:binary ()
  |> Promise.map (function
       | Error _ -> None
       | Ok cmd -> Some cmd)

let parseSwitchList out =
  let lines = String.split_on_char '\n' out in
  let result =
    Belt.List.keepMap lines (function
      | "" -> None
      | s -> Some (Switch.ofString s))
  in
  Js.Console.log (sprintf "%d switches" (List.length result));
  result

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

let switchList t =
  Cmd.output t ~args:[| "switch"; "list"; "-s" |]
  |> Promise.map (function
       | Error _ ->
         (* TODO Warn *)
         []
       | Ok out -> parseSwitchList out)

let switchArg switch = "--switch=" ^ Switch.toString switch

let env t ~switch =
  let args = [| "env"; "--sexp"; switchArg switch |] in
  Cmd.output t ~args |> Promise.map (Result.bind ~f:parseEnvOutput)

let exec t ~switch ~args =
  (Cmd.binPath t, Array.append [| "exec"; switchArg switch; "--" |] args)
