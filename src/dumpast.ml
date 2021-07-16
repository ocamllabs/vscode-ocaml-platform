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

    (* method! structure_item { pstr_desc; pstr_loc } = object_ [ ("type",
       string "structure_item") ; ("pstr_desc", super#structure_item_desc
       pstr_desc) ; ("pstr_loc", super#location pstr_loc) ] *)

    (* method! expression_desc = function | Pexp_constraint ({ pexp_desc; _ },
       _) -> super#expression_desc pexp_desc | arg -> super#expression_desc arg *)
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

    (* method! structure s = object_ [ ("structure", list self#structure_item s)
       ] *)
    (* method! class_infos : 'a . ('a -> Jsonoo.t) -> 'a class_infos ->
       Jsonoo.t= fun _a -> fun { pci_virt; pci_params; pci_name; pci_expr;
       pci_loc; pci_attributes } -> let pci_virt = self#virtual_flag pci_virt in
       let pci_params = self#list (fun (a, b) -> let a = self#core_type a in let
       b = (fun (a, b) -> let a = self#variance a in let b = self#injectivity b
       in tuple2 id id (a,b)) b in tuple2 id id (a,b)) pci_params in let
       pci_name = self#loc self#string pci_name in let pci_expr = _a pci_expr in
       let pci_loc = self#location pci_loc in let pci_attributes =
       self#attributes pci_attributes in self#record "class_infos" [("pci_virt",
       pci_virt); ("pci_params", pci_params); ("pci_name", pci_name);
       ("pci_expr", pci_expr); ("pci_loc", pci_loc); ("pci_attributes",
       pci_attributes)] *)
  end

let warn_ast_diff method_name =
  let _ =
    Import.show_message `Warn
      "Unable to match the original AST with the reparsed one starting at %s \
       method. cf issue_ref"
      (*TODO: open an issue explaining the context.*) method_name
  in
  ()

let reparse_ast =
  let open Traverse_ast2 in
  object (self)
    inherit [Jsonoo.t] lift2 as super

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
      try super#directive_argument_desc x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#directive_argument_desc x

    method! toplevel_phrase x x' =
      try super#toplevel_phrase x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#toplevel_phrase x

    method! structure_item_desc x x' =
      try super#structure_item_desc x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#structure_item_desc x

    method! module_expr_desc x x' =
      try super#module_expr_desc x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#module_expr_desc x

    method! with_constraint x x' =
      try super#with_constraint x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#with_constraint x

    method! signature_item_desc x x' =
      try super#signature_item_desc x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#signature_item_desc x

    method! functor_parameter x x' =
      try super#functor_parameter x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#functor_parameter x

    method! module_type_desc x x' =
      try super#module_type_desc x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#module_type_desc x

    method! class_field_kind x x' =
      try super#class_field_kind x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#class_field_kind x

    method! class_field_desc x x' =
      try super#class_field_desc x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#class_field_desc x

    method! class_expr_desc x x' =
      try super#class_expr_desc x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#class_expr_desc x

    method! class_type_field_desc x x' =
      try super#class_type_field_desc x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#class_type_field_desc x

    method! class_type_desc x x' =
      try super#class_type_desc x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#class_type_desc x

    method! extension_constructor_kind x x' =
      try super#extension_constructor_kind x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#extension_constructor_kind x

    method! constructor_arguments x x' =
      try super#constructor_arguments x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#constructor_arguments x

    method! type_kind x x' =
      try super#type_kind x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#type_kind x

    method! expression_desc x x' =
      try super#expression_desc x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#expression_desc x

    method! pattern_desc x x' =
      try super#pattern_desc x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#pattern_desc x

    method! object_field_desc x x' =
      try super#object_field_desc x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#object_field_desc x

    method! row_field_desc x x' =
      try super#row_field_desc x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#row_field_desc x

    method! core_type_desc x x' =
      try super#core_type_desc x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#core_type_desc x

    method! payload x x' =
      try super#payload x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#payload x

    method! constant x x' =
      try super#constant x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#constant x

    method! injectivity x x' =
      try super#injectivity x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#injectivity x

    method! arg_label x x' =
      try super#arg_label x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#arg_label x

    method! variance x x' =
      try super#variance x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#variance x

    method! closed_flag x x' =
      try super#closed_flag x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#closed_flag x

    method! override_flag x x' =
      try super#override_flag x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#override_flag x

    method! virtual_flag x x' =
      try super#virtual_flag x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#virtual_flag x

    method! mutable_flag x x' =
      try super#mutable_flag x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#mutable_flag x

    method! private_flag x x' =
      try super#private_flag x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#private_flag x

    method! direction_flag x x' =
      try super#direction_flag x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#direction_flag x

    method! rec_flag x x' =
      try super#rec_flag x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#rec_flag x

    method! longident x x' =
      try super#longident x x' with
      | Reparse_error m ->
        warn_ast_diff m;
        parse_ast#longident x
  end

let transform source =
  try
    let v = Parse.implementation (Lexing.from_string source) in
    parse_ast#structure v
  with
  | _ -> Jsonoo.Encode.string "Syntax error"

let from_structure (structure : Parsetree.structure) =
  try parse_ast#structure structure with
  | _ -> Jsonoo.Encode.string "Syntax error"

let reparse s s' = reparse_ast#structure s s'
