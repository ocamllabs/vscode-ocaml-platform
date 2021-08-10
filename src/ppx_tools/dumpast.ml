open Ppxlib

let parse_ast =
  let open Jsonoo.Encode in
  object (self)
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

    (*FIXME*)
    method! open_infos _a { popen_expr; popen_override; popen_loc; _ } =
      let popen_expr = _a popen_expr in
      let popen_override = self#override_flag popen_override in
      let popen_loc = self#location popen_loc in
      let popen_attributes = null in
      self#record "open_infos"
        [ ("popen_expr", popen_expr)
        ; ("popen_override", popen_override)
        ; ("popen_loc", popen_loc)
        ; ("popen_attributes", popen_attributes)
        ]
  end

let warn_ast_diff method_name =
  let (_ : _ Promise.t) =
    Vscode.Window.showErrorMessage
      ~message:
        ("Unable to match the original AST with the reparsed one starting at  "
       ^ method_name)
      ()
  in
  ()

let reparse_ast =
  let with_reparse f on_reparse =
    try f () with
    | Traverse_ast2.Reparse_error m ->
      warn_ast_diff m;
      on_reparse ()
  in
  object (self)
    inherit [Jsonoo.t] Traverse_ast2.lift2 as super

    method unit () = Jsonoo.Encode.null

    method tuple args =
      Jsonoo.Encode.object_ (("type", Jsonoo.Encode.string "tuple") :: args)

    method string value _ = Jsonoo.Encode.string value

    method float value _ = Jsonoo.Encode.float value

    method bool value _ = Jsonoo.Encode.bool value

    method record label args =
      Jsonoo.Encode.object_ (("type", Jsonoo.Encode.string label) :: args)

    method other _ _ =
      Jsonoo.Encode.string "serializing other values is not supported yet"

    method nativeint _ _ =
      Jsonoo.Encode.string "serializing nativeint is not supported yet"

    method int64 _ _ =
      Jsonoo.Encode.string "serializing int64 is not supported yet"

    method int32 _ _ =
      Jsonoo.Encode.string "serializing int32 is not supported yet"

    method int value _ = Jsonoo.Encode.int value

    method list f l l' =
      (*FIXME different length?*)
      if List.length l > List.length l' then
        List.map2 f l l |> Jsonoo.Encode.list (fun x -> x)
      else if List.length l < List.length l' then
        List.map2 f l' l' |> Jsonoo.Encode.list (fun x -> x)
      else
        List.map2 f l l' |> Jsonoo.Encode.list (fun x -> x)

    method option f o o' =
      match (o, o') with
      | Some x, Some x' ->
        let a = f x x' in
        a
      | None, None ->
        Jsonoo.Encode.object_ [ ("type", Jsonoo.Encode.string "None") ]
      | _ -> raise (Traverse_ast2.Reparse_error "option")

    method constr label args =
      match args with
      | [] -> Jsonoo.Encode.object_ [ ("type", Jsonoo.Encode.string label) ]
      | _ ->
        Jsonoo.Encode.object_ (("type", Jsonoo.Encode.string label) :: args)

    method char value _ = Jsonoo.Encode.char value

    method! location : location -> location -> Jsonoo.t =
      fun { loc_start; loc_end; loc_ghost }
          { loc_start = loc_start'; loc_end = loc_end'; loc_ghost = loc_ghost' } ->
        let loc_start = super#position loc_start loc_start in
        let real_loc_start = super#position loc_start' loc_start' in
        let loc_end = super#position loc_end loc_end in
        let real_loc_end = super#position loc_end' loc_end' in
        let loc_ghost = self#bool loc_ghost loc_ghost' in
        self#record "Location.t"
          [ ("loc_start", real_loc_start)
          ; ("origin_loc_start", loc_start)
          ; ("loc_end", real_loc_end)
          ; ("origin_loc_end", loc_end)
          ; ("loc_ghost", loc_ghost)
          ]

    method! open_infos _a { popen_expr; popen_override; popen_loc; _ }
        { popen_expr = popen_expr'
        ; popen_override = popen_override'
        ; popen_loc = popen_loc'
        ; _
        } =
      let popen_expr = _a popen_expr popen_expr' in
      let popen_override = self#override_flag popen_override popen_override' in
      let popen_loc = self#location popen_loc popen_loc' in
      let popen_attributes = Jsonoo.Encode.null in
      (*FIXME*)
      self#record "open_infos"
        [ ("popen_expr", popen_expr)
        ; ("popen_override", popen_override)
        ; ("popen_loc", popen_loc)
        ; ("popen_attributes", popen_attributes)
        ]

    method! directive_argument_desc x x' =
      with_reparse
        (fun () -> super#directive_argument_desc x x')
        (fun () -> parse_ast#directive_argument_desc x)

    method! toplevel_phrase x x' =
      with_reparse
        (fun () -> super#toplevel_phrase x x')
        (fun () -> parse_ast#toplevel_phrase x)

    method! structure_item_desc x x' =
      with_reparse
        (fun () -> super#structure_item_desc x x')
        (fun () -> parse_ast#structure_item_desc x)

    method! module_expr_desc x x' =
      with_reparse
        (fun () -> super#module_expr_desc x x')
        (fun () -> parse_ast#module_expr_desc x)

    method! with_constraint x x' =
      with_reparse
        (fun () -> super#with_constraint x x')
        (fun () -> parse_ast#with_constraint x)

    method! signature_item_desc x x' =
      with_reparse
        (fun () -> super#signature_item_desc x x')
        (fun () -> parse_ast#signature_item_desc x)

    method! functor_parameter x x' =
      with_reparse
        (fun () -> super#functor_parameter x x')
        (fun () -> parse_ast#functor_parameter x)

    method! module_type_desc x x' =
      with_reparse
        (fun () -> super#module_type_desc x x')
        (fun () -> parse_ast#module_type_desc x)

    method! class_field_kind x x' =
      with_reparse
        (fun () -> super#class_field_kind x x')
        (fun () -> parse_ast#class_field_kind x)

    method! class_field_desc x x' =
      with_reparse
        (fun () -> super#class_field_desc x x')
        (fun () -> parse_ast#class_field_desc x)

    method! class_expr_desc x x' =
      with_reparse
        (fun () -> super#class_expr_desc x x')
        (fun () -> parse_ast#class_expr_desc x)

    method! class_type_field_desc x x' =
      with_reparse
        (fun () -> super#class_type_field_desc x x')
        (fun () -> parse_ast#class_type_field_desc x)

    method! class_type_desc x x' =
      with_reparse
        (fun () -> super#class_type_desc x x')
        (fun () -> parse_ast#class_type_desc x)

    method! extension_constructor_kind x x' =
      with_reparse
        (fun () -> super#extension_constructor_kind x x')
        (fun () -> parse_ast#extension_constructor_kind x)

    method! constructor_arguments x x' =
      with_reparse
        (fun () -> super#constructor_arguments x x')
        (fun () -> parse_ast#constructor_arguments x)

    method! type_kind x x' =
      with_reparse
        (fun () -> super#type_kind x x')
        (fun () -> parse_ast#type_kind x)

    method! expression_desc x x' =
      with_reparse
        (fun () -> super#expression_desc x x')
        (fun () -> parse_ast#expression_desc x)

    method! pattern_desc x x' =
      with_reparse
        (fun () -> super#pattern_desc x x')
        (fun () -> parse_ast#pattern_desc x)

    method! object_field_desc x x' =
      with_reparse
        (fun () -> super#object_field_desc x x')
        (fun () -> parse_ast#object_field_desc x)

    method! row_field_desc x x' =
      with_reparse
        (fun () -> super#row_field_desc x x')
        (fun () -> parse_ast#row_field_desc x)

    method! core_type_desc x x' =
      with_reparse
        (fun () -> super#core_type_desc x x')
        (fun () -> parse_ast#core_type_desc x)

    method! payload x x' =
      with_reparse
        (fun () -> super#payload x x')
        (fun () -> parse_ast#payload x)

    method! constant x x' =
      with_reparse
        (fun () -> super#constant x x')
        (fun () -> parse_ast#constant x)

    method! injectivity x x' =
      with_reparse
        (fun () -> super#injectivity x x')
        (fun () -> parse_ast#injectivity x)

    method! arg_label x x' =
      with_reparse
        (fun () -> super#arg_label x x')
        (fun () -> parse_ast#arg_label x)

    method! variance x x' =
      with_reparse
        (fun () -> super#variance x x')
        (fun () -> parse_ast#variance x)

    method! closed_flag x x' =
      with_reparse
        (fun () -> super#closed_flag x x')
        (fun () -> parse_ast#closed_flag x)

    method! override_flag x x' =
      with_reparse
        (fun () -> super#override_flag x x')
        (fun () -> parse_ast#override_flag x)

    method! virtual_flag x x' =
      with_reparse
        (fun () -> super#virtual_flag x x')
        (fun () -> parse_ast#virtual_flag x)

    method! mutable_flag x x' =
      with_reparse
        (fun () -> super#mutable_flag x x')
        (fun () -> parse_ast#mutable_flag x)

    method! private_flag x x' =
      with_reparse
        (fun () -> super#private_flag x x')
        (fun () -> parse_ast#private_flag x)

    method! direction_flag x x' =
      with_reparse
        (fun () -> super#direction_flag x x')
        (fun () -> parse_ast#direction_flag x)

    method! rec_flag x x' =
      with_reparse
        (fun () -> super#rec_flag x x')
        (fun () -> parse_ast#rec_flag x)

    method! longident x x' =
      with_reparse
        (fun () -> super#longident x x')
        (fun () -> parse_ast#longident x)
  end

let transform source kind =
  let open Pp_path in
  try
    match kind with
    | Structure ->
      let v = Parse.implementation (Lexing.from_string source) in
      parse_ast#structure v
    | Signature ->
      let v = Parse.interface (Lexing.from_string source) in
      parse_ast#signature v
    | Unknown -> Jsonoo.Encode.string "Unknown file extension"
  with
  | Syntaxerr.Error _ -> Jsonoo.Encode.null

let from_structure (structure : Parsetree.structure) =
  try parse_ast#structure structure with
  | Syntaxerr.Error _ -> Jsonoo.Encode.null

let reparse s s' = reparse_ast#structure s s'

let reparse_signature s s' = reparse_ast#signature s s'
