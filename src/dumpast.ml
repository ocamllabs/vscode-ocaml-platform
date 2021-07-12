open Ppxlib

let parse_ast =
  let open Jsonoo.Encode in
  object
    inherit [Jsonoo.t] Traverse_ast.lift

    method unit () = null

    method tuple args = object_ (("type", string "tuple") :: args)

    method string value = string value

    method float value = float value

    method bool value = bool value

    method record label args = object_ (("type", string label) :: args)

    method other _ = string "serializing other values is not supported yet"

    method nativeint _ = string "serializing nativeint is not supported yet"

    method int64 _ = string "serializing int64 is not supported yet"

    method int32 _ = string "serializing int32 is not supported yet"

    method int value = int value

    method list f = list f

    method option f o =
      match o with
      | Some x ->
        let a = f x in
        a
      | None -> Jsonoo.Encode.object_ [ ("type", Jsonoo.Encode.string "None") ]

    method constr label args =
      match args with
      | [] -> object_ [ ("type", string label) ]
      | _ -> object_ (("type", string label) :: args)

    method char value = char value

    method array f arg = list id (Array.to_list arg |> List.map f)
  end

let transform source =
  try
    let v = Parse.implementation (Lexing.from_string source) in
    parse_ast#structure v
  with
  | _ -> Jsonoo.Encode.string "Syntax error"
