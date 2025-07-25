open Ppxlib

class virtual ['res] lift =
  object (self)
    method virtual record : string -> (string * 'res) list -> 'res
    method virtual constr : string -> (string * 'res) list -> 'res
    method virtual tuple : (string * 'res) list -> 'res
    method virtual bool : bool -> 'res
    method virtual char : char -> 'res
    method virtual int : int -> 'res
    method virtual list : 'a. ('a -> 'res) -> 'a list -> 'res
    method virtual option : 'a. ('a -> 'res) -> 'a option -> 'res
    method virtual string : string -> 'res

    method position : position -> 'res =
      fun { pos_fname; pos_lnum; pos_bol; pos_cnum } ->
        let pos_fname = self#string pos_fname in
        let pos_lnum = self#int pos_lnum in
        let pos_bol = self#int pos_bol in
        let pos_cnum = self#int pos_cnum in
        self#record
          "Lexing.position"
          [ "pos_fname", pos_fname
          ; "pos_lnum", pos_lnum
          ; "pos_bol", pos_bol
          ; "pos_cnum", pos_cnum
          ]

    method location : location -> 'res =
      fun { loc_start; loc_end; loc_ghost } ->
        let loc_start = self#position loc_start in
        let loc_end = self#position loc_end in
        let loc_ghost = self#bool loc_ghost in
        self#record
          "Location.t"
          [ "loc_start", loc_start; "loc_end", loc_end; "loc_ghost", loc_ghost ]

    method location_stack : location_stack -> 'res = self#list self#location

    method loc : 'a. ('a -> 'res) -> 'a loc -> 'res =
      fun _a { txt; loc } ->
        let txt = _a txt in
        let loc = self#location loc in
        self#record "loc" [ "txt", txt; "loc", loc ]

    method longident : longident -> 'res =
      fun x ->
        match x with
        | Lident a ->
          let a = self#string a in
          self#constr "Lident" [ "label", a ]
        | Ldot (a, b) ->
          let a = self#longident a in
          let b = self#string b in
          self#constr "Ldot" [ "longident", a; "label", b ]
        | Lapply (a, b) ->
          let a = self#longident a in
          let b = self#longident b in
          self#constr "Lapply" [ "longident1", a; "longident2", b ]

    method longident_loc : longident_loc -> 'res = self#loc self#longident

    method rec_flag : rec_flag -> 'res =
      fun x ->
        match x with
        | Nonrecursive -> self#constr "Nonrecursive" []
        | Recursive -> self#constr "Recursive" []

    method direction_flag : direction_flag -> 'res =
      fun x ->
        match x with
        | Upto -> self#constr "Upto" []
        | Downto -> self#constr "Downto" []

    method private_flag : private_flag -> 'res =
      fun x ->
        match x with
        | Private -> self#constr "Private" []
        | Public -> self#constr "Public" []

    method mutable_flag : mutable_flag -> 'res =
      fun x ->
        match x with
        | Immutable -> self#constr "Immutable" []
        | Mutable -> self#constr "Mutable" []

    method virtual_flag : virtual_flag -> 'res =
      fun x ->
        match x with
        | Virtual -> self#constr "Virtual" []
        | Concrete -> self#constr "Concrete" []

    method override_flag : override_flag -> 'res =
      fun x ->
        match x with
        | Override -> self#constr "Override" []
        | Fresh -> self#constr "Fresh" []

    method closed_flag : closed_flag -> 'res =
      fun x ->
        match x with
        | Closed -> self#constr "Closed" []
        | Open -> self#constr "Open" []

    method label : label -> 'res = self#string

    method arg_label : arg_label -> 'res =
      fun x ->
        match x with
        | Nolabel -> self#constr "Nolabel" []
        | Labelled a ->
          let a = self#string a in
          self#constr "Labelled" [ "label", a ]
        | Optional a ->
          let a = self#string a in
          self#constr "Optional" [ "label", a ]

    method variance : variance -> 'res =
      fun x ->
        match x with
        | Covariant -> self#constr "Covariant" []
        | Contravariant -> self#constr "Contravariant" []
        | NoVariance -> self#constr "NoVariance" []

    method injectivity : injectivity -> 'res =
      fun x ->
        match x with
        | Injective -> self#constr "Injective" []
        | NoInjectivity -> self#constr "NoInjectivity" []

    method constant : constant -> 'res =
      fun x ->
        match x with
        | Pconst_integer (a, b) ->
          let a = self#string a in
          let b = self#option self#char b in
          self#constr "Pconst_integer" [ "label", a; "char option", b ]
        | Pconst_char a ->
          let a = self#char a in
          self#constr "Pconst_char" [ "char", a ]
        | Pconst_string (a, b, c) ->
          let a = self#string a in
          let b = self#location b in
          let c = self#option self#string c in
          self#constr "Pconst_string" [ "label", a; "location", b; "label option", c ]
        | Pconst_float (a, b) ->
          let a = self#string a in
          let b = self#option self#char b in
          self#constr "Pconst_float" [ "label", a; "char option", b ]

    method attribute : attribute -> 'res =
      fun { attr_name; attr_payload; attr_loc } ->
        let attr_name = self#loc self#string attr_name in
        let attr_payload = self#payload attr_payload in
        let attr_loc = self#location attr_loc in
        self#record
          "attribute"
          [ "attr_name", attr_name; "attr_payload", attr_payload; "attr_loc", attr_loc ]

    method extension : extension -> 'res =
      fun (a, b) ->
        let a = self#loc self#string a in
        let b = self#payload b in
        self#tuple [ "label loc", a; "payload", b ]

    method attributes : attributes -> 'res = self#list self#attribute

    method str_loc_lst : string loc list -> 'res =
      fun lst -> self#list (self#loc self#string) lst

    method existentials = self#str_loc_lst
    method type_vars = self#str_loc_lst

    method payload : payload -> 'res =
      fun x ->
        match x with
        | PStr a ->
          let a = self#structure a in
          self#constr "PStr" [ "structure", a ]
        | PSig a ->
          let a = self#signature a in
          self#constr "PSig" [ "signature", a ]
        | PTyp a ->
          let a = self#core_type a in
          self#constr "PTyp" [ "core_type", a ]
        | PPat (a, b) ->
          let a = self#pattern a in
          let b = self#option self#expression b in
          self#constr "PPat" [ "pattern", a; "expression option", b ]

    method core_type : core_type -> 'res =
      fun { ptyp_desc; ptyp_loc; ptyp_loc_stack; ptyp_attributes } ->
        let ptyp_desc = self#core_type_desc ptyp_desc in
        let ptyp_loc = self#location ptyp_loc in
        let ptyp_loc_stack = self#location_stack ptyp_loc_stack in
        let ptyp_attributes = self#attributes ptyp_attributes in
        self#record
          "core_type"
          [ "ptyp_desc", ptyp_desc
          ; "ptyp_loc", ptyp_loc
          ; "ptyp_loc_stack", ptyp_loc_stack
          ; "ptyp_attributes", ptyp_attributes
          ]

    method core_type_desc : core_type_desc -> 'res =
      fun x ->
        match x with
        | Ptyp_any -> self#constr "Ptyp_any" []
        | Ptyp_var a ->
          let a = self#string a in
          self#constr "Ptyp_var" [ "label", a ]
        | Ptyp_arrow (a, b, c) ->
          let a = self#arg_label a in
          let b = self#core_type b in
          let c = self#core_type c in
          self#constr "Ptyp_arrow" [ "arg_label", a; "core_type1", b; "core_type2", c ]
        | Ptyp_tuple a ->
          let a = self#list self#core_type a in
          self#constr "Ptyp_tuple" [ "core_type list", a ]
        | Ptyp_constr (a, b) ->
          let a = self#longident_loc a in
          let b = self#list self#core_type b in
          self#constr "Ptyp_constr" [ "longident_loc", a; "core_type list", b ]
        | Ptyp_object (a, b) ->
          let a = self#list self#object_field a in
          let b = self#closed_flag b in
          self#constr "Ptyp_object" [ "object_field list", a; "closed_flag", b ]
        | Ptyp_class (a, b) ->
          let a = self#longident_loc a in
          let b = self#list self#core_type b in
          self#constr "Ptyp_class" [ "longident_loc", a; "core_type list", b ]
        | Ptyp_alias (a, b) ->
          let a = self#core_type a in
          let b = self#loc self#string b in
          self#constr "Ptyp_alias" [ "core_type", a; "label", b ]
        | Ptyp_variant (a, b, c) ->
          let a = self#list self#row_field a in
          let b = self#closed_flag b in
          let c = self#option (self#list self#label) c in
          self#constr
            "Ptyp_variant"
            [ "row_field list", a; "closed_flag", b; "label list option", c ]
        | Ptyp_poly (a, b) ->
          let a = self#list (self#loc self#string) a in
          let b = self#core_type b in
          self#constr "Ptyp_poly" [ "label loc list", a; "core_type", b ]
        | Ptyp_package a ->
          let a = self#package_type a in
          self#constr "Ptyp_package" [ "package_type", a ]
        | Ptyp_extension a ->
          let a = self#extension a in
          self#constr "Ptyp_extension" [ "extension", a ]
        | Ptyp_open (a, b) ->
          let a = self#longident_loc a in
          let b = self#core_type b in
          self#constr "Ptyp_open" [ "longident_loc", a; "core_type", b ]

    method package_type : package_type -> 'res =
      fun (a, b) ->
        let a = self#longident_loc a in
        let b =
          self#list
            (fun (a, b) ->
               let a = self#longident_loc a in
               let b = self#core_type b in
               self#tuple [ "longident_loc", a; "core_type", b ])
            b
        in
        self#tuple [ "longident_loc", a; "(longident_loc * core_type) list", b ]

    method row_field : row_field -> 'res =
      fun { prf_desc; prf_loc; prf_attributes } ->
        let prf_desc = self#row_field_desc prf_desc in
        let prf_loc = self#location prf_loc in
        let prf_attributes = self#attributes prf_attributes in
        self#record
          "row_field"
          [ "prf_desc", prf_desc; "prf_loc", prf_loc; "prf_attributes", prf_attributes ]

    method row_field_desc : row_field_desc -> 'res =
      fun x ->
        match x with
        | Rtag (a, b, c) ->
          let a = self#loc self#label a in
          let b = self#bool b in
          let c = self#list self#core_type c in
          self#constr "Rtag" [ "label loc", a; "bool", b; "core_type list", c ]
        | Rinherit a ->
          let a = self#core_type a in
          self#constr "Rinherit" [ "core_type", a ]

    method object_field : object_field -> 'res =
      fun { pof_desc; pof_loc; pof_attributes } ->
        let pof_desc = self#object_field_desc pof_desc in
        let pof_loc = self#location pof_loc in
        let pof_attributes = self#attributes pof_attributes in
        self#record
          "object_field"
          [ "pof_desc", pof_desc; "pof_loc", pof_loc; "pof_attributes", pof_attributes ]

    method object_field_desc : object_field_desc -> 'res =
      fun x ->
        match x with
        | Otag (a, b) ->
          let a = self#loc self#label a in
          let b = self#core_type b in
          self#constr "Otag" [ "label loc", a; "core_type", b ]
        | Oinherit a ->
          let a = self#core_type a in
          self#constr "Oinherit" [ "core_type", a ]

    method pattern : pattern -> 'res =
      fun { ppat_desc; ppat_loc; ppat_loc_stack; ppat_attributes } ->
        let ppat_desc = self#pattern_desc ppat_desc in
        let ppat_loc = self#location ppat_loc in
        let ppat_loc_stack = self#location_stack ppat_loc_stack in
        let ppat_attributes = self#attributes ppat_attributes in
        self#record
          "pattern"
          [ "ppat_desc", ppat_desc
          ; "ppat_loc", ppat_loc
          ; "ppat_loc_stack", ppat_loc_stack
          ; "ppat_attributes", ppat_attributes
          ]

    method pattern_desc : pattern_desc -> 'res =
      fun x ->
        match x with
        | Ppat_any -> self#constr "Ppat_any" []
        | Ppat_var a ->
          let a = self#loc self#string a in
          self#constr "Ppat_var" [ "label loc", a ]
        | Ppat_alias (a, b) ->
          let a = self#pattern a in
          let b = self#loc self#string b in
          self#constr "Ppat_alias" [ "pattern", a; "label loc", b ]
        | Ppat_constant a ->
          let a = self#constant a in
          self#constr "Ppat_constant" [ "constant", a ]
        | Ppat_interval (a, b) ->
          let a = self#constant a in
          let b = self#constant b in
          self#constr "Ppat_interval" [ "constant1", a; "constant2", b ]
        | Ppat_tuple a ->
          let a = self#list self#pattern a in
          self#constr "Ppat_tuple" [ "pattern list", a ]
        | Ppat_construct (a, b) ->
          let a = self#longident_loc a in
          let b =
            self#option
              (fun (existentials, patt) ->
                 let existentials = self#existentials existentials in
                 let patt = self#pattern patt in
                 self#tuple [ "existentials", existentials; "pattern", patt ])
              b
          in
          self#constr "Ppat_construct" [ "longident_loc", a; "args", b ]
        | Ppat_variant (a, b) ->
          let a = self#label a in
          let b = self#option self#pattern b in
          self#constr "Ppat_variant" [ "label", a; "pattern option", b ]
        | Ppat_record (a, b) ->
          let a =
            self#list
              (fun (a, b) ->
                 let a = self#longident_loc a in
                 let b = self#pattern b in
                 self#tuple [ "longident_loc", a; "pattern", b ])
              a
          in
          let b = self#closed_flag b in
          self#constr
            "Ppat_record"
            [ "(longident_loc * pattern) list", a; "closed_flag", b ]
        | Ppat_array a ->
          let a = self#list self#pattern a in
          self#constr "Ppat_array" [ "pattern list", a ]
        | Ppat_or (a, b) ->
          let a = self#pattern a in
          let b = self#pattern b in
          self#constr "Ppat_or" [ "pattern1", a; "pattern2", b ]
        | Ppat_constraint (a, b) ->
          let a = self#pattern a in
          let b = self#core_type b in
          self#constr "Ppat_constraint" [ "pattern", a; "core_type", b ]
        | Ppat_type a ->
          let a = self#longident_loc a in
          self#constr "Ppat_type" [ "longident_loc", a ]
        | Ppat_lazy a ->
          let a = self#pattern a in
          self#constr "Ppat_lazy" [ "pattern", a ]
        | Ppat_unpack a ->
          let a = self#loc (self#option self#string) a in
          self#constr "Ppat_unpack" [ "label option loc", a ]
        | Ppat_exception a ->
          let a = self#pattern a in
          self#constr "Ppat_exception" [ "pattern", a ]
        | Ppat_extension a ->
          let a = self#extension a in
          self#constr "Ppat_extension" [ "extension", a ]
        | Ppat_open (a, b) ->
          let a = self#longident_loc a in
          let b = self#pattern b in
          self#constr "Ppat_open" [ "longident_loc", a; "pattern", b ]

    method expression : expression -> 'res =
      fun { pexp_desc; pexp_loc; pexp_loc_stack; pexp_attributes } ->
        let pexp_desc = self#expression_desc pexp_desc in
        let pexp_loc = self#location pexp_loc in
        let pexp_loc_stack = self#location_stack pexp_loc_stack in
        let pexp_attributes = self#attributes pexp_attributes in
        self#record
          "expression"
          [ "pexp_desc", pexp_desc
          ; "pexp_loc", pexp_loc
          ; "pexp_loc_stack", pexp_loc_stack
          ; "pexp_attributes", pexp_attributes
          ]

    method expression_desc : expression_desc -> 'res =
      fun x ->
        match x with
        | Pexp_ident a ->
          let a = self#longident_loc a in
          self#constr "Pexp_ident" [ "longident_loc", a ]
        | Pexp_constant a ->
          let a = self#constant a in
          self#constr "Pexp_constant" [ "constant", a ]
        | Pexp_let (a, b, c) ->
          let a = self#rec_flag a in
          let b = self#list self#value_binding b in
          let c = self#expression c in
          self#constr
            "Pexp_let"
            [ "rec_flag", a; "value_binding list", b; "expression", c ]
        | Pexp_function (a, b, c) ->
          let a = self#list self#function_param a in
          let b = self#option self#type_constraint b in
          let c = self#function_body c in
          self#constr
            "Pexp_function"
            [ "function_param list", a; "type_constraint option", b; "function_body", c ]
        | Pexp_apply (a, b) ->
          let a = self#expression a in
          let b =
            self#list
              (fun (a, b) ->
                 let a = self#arg_label a in
                 let b = self#expression b in
                 self#tuple [ "arg_label", a; "expression", b ])
              b
          in
          self#constr "Pexp_apply" [ "expression", a; "(arg_label * expression) list", b ]
        | Pexp_match (a, b) ->
          let a = self#expression a in
          let b = self#cases b in
          self#constr "Pexp_match" [ "expression", a; "cases", b ]
        | Pexp_try (a, b) ->
          let a = self#expression a in
          let b = self#cases b in
          self#constr "Pexp_try" [ "expression", a; "cases", b ]
        | Pexp_tuple a ->
          let a = self#list self#expression a in
          self#constr "Pexp_tuple" [ "expression list", a ]
        | Pexp_construct (a, b) ->
          let a = self#longident_loc a in
          let b = self#option self#expression b in
          self#constr "Pexp_construct" [ "longident_loc", a; "expression option", b ]
        | Pexp_variant (a, b) ->
          let a = self#label a in
          let b = self#option self#expression b in
          self#constr "Pexp_variant" [ "label", a; "expression option", b ]
        | Pexp_record (a, b) ->
          let a =
            self#list
              (fun (a, b) ->
                 let a = self#longident_loc a in
                 let b = self#expression b in
                 self#tuple [ "longident_loc", a; "expression", b ])
              a
          in
          let b = self#option self#expression b in
          self#constr
            "Pexp_record"
            [ "(longident_loc * expression) list", a; "expression option", b ]
        | Pexp_field (a, b) ->
          let a = self#expression a in
          let b = self#longident_loc b in
          self#constr "Pexp_field" [ "expression", a; "longident_loc", b ]
        | Pexp_setfield (a, b, c) ->
          let a = self#expression a in
          let b = self#longident_loc b in
          let c = self#expression c in
          self#constr
            "Pexp_setfield"
            [ "expression1", a; "longident_loc", b; "expression2", c ]
        | Pexp_array a ->
          let a = self#list self#expression a in
          self#constr "Pexp_array" [ "expression list", a ]
        | Pexp_ifthenelse (a, b, c) ->
          let a = self#expression a in
          let b = self#expression b in
          let c = self#option self#expression c in
          self#constr
            "Pexp_ifthenelse"
            [ "expression1", a; "expression2", b; "expression option", c ]
        | Pexp_sequence (a, b) ->
          let a = self#expression a in
          let b = self#expression b in
          self#constr "Pexp_sequence" [ "expression1", a; "expression2", b ]
        | Pexp_while (a, b) ->
          let a = self#expression a in
          let b = self#expression b in
          self#constr "Pexp_while" [ "expression1", a; "expression2", b ]
        | Pexp_for (a, b, c, d, e) ->
          let a = self#pattern a in
          let b = self#expression b in
          let c = self#expression c in
          let d = self#direction_flag d in
          let e = self#expression e in
          self#constr
            "Pexp_for"
            [ "pattern", a
            ; "expression1", b
            ; "expression2", c
            ; "direction_flag", d
            ; "expression3", e
            ]
        | Pexp_constraint (a, b) ->
          let a = self#expression a in
          let b = self#core_type b in
          self#constr "Pexp_constraint" [ "expression", a; "core_type", b ]
        | Pexp_coerce (a, b, c) ->
          let a = self#expression a in
          let b = self#option self#core_type b in
          let c = self#core_type c in
          self#constr
            "Pexp_coerce"
            [ "expression", a; "core_type option", b; "core_type", c ]
        | Pexp_send (a, b) ->
          let a = self#expression a in
          let b = self#loc self#label b in
          self#constr "Pexp_send" [ "expression", a; "label loc", b ]
        | Pexp_new a ->
          let a = self#longident_loc a in
          self#constr "Pexp_new" [ "longident_loc", a ]
        | Pexp_setinstvar (a, b) ->
          let a = self#loc self#label a in
          let b = self#expression b in
          self#constr "Pexp_setinstvar" [ "label loc", a; "expression", b ]
        | Pexp_override a ->
          let a =
            self#list
              (fun (a, b) ->
                 let a = self#loc self#label a in
                 let b = self#expression b in
                 self#tuple [ "label loc", a; "expression", b ])
              a
          in
          self#constr "Pexp_override" [ "(label loc * expression) list", a ]
        | Pexp_letmodule (a, b, c) ->
          let a = self#loc (self#option self#string) a in
          let b = self#module_expr b in
          let c = self#expression c in
          self#constr
            "Pexp_letmodule"
            [ "label option loc", a; "module_expr", b; "expression", c ]
        | Pexp_letexception (a, b) ->
          let a = self#extension_constructor a in
          let b = self#expression b in
          self#constr
            "Pexp_letexception"
            [ "Parsetree.extension_constructor", a; "expression", b ]
        | Pexp_assert a ->
          let a = self#expression a in
          self#constr "Pexp_assert" [ "expression", a ]
        | Pexp_lazy a ->
          let a = self#expression a in
          self#constr "Pexp_lazy" [ "expression", a ]
        | Pexp_poly (a, b) ->
          let a = self#expression a in
          let b = self#option self#core_type b in
          self#constr "Pexp_poly" [ "expression", a; "core_type option", b ]
        | Pexp_object a ->
          let a = self#class_structure a in
          self#constr "Pexp_object" [ "class_structure", a ]
        | Pexp_newtype (a, b) ->
          let a = self#loc self#string a in
          let b = self#expression b in
          self#constr "Pexp_newtype" [ "label loc", a; "expression", b ]
        | Pexp_pack a ->
          let a = self#module_expr a in
          self#constr "Pexp_pack" [ "module_expr", a ]
        | Pexp_open (a, b) ->
          let a = self#open_declaration a in
          let b = self#expression b in
          self#constr "Pexp_open" [ "open_declaration", a; "expression", b ]
        | Pexp_letop a ->
          let a = self#letop a in
          self#constr "Pexp_letop" [ "letop", a ]
        | Pexp_extension a ->
          let a = self#extension a in
          self#constr "Pexp_extension" [ "extension", a ]
        | Pexp_unreachable -> self#constr "Pexp_unreachable" []

    method case : case -> 'res =
      fun { pc_lhs; pc_guard; pc_rhs } ->
        let pc_lhs = self#pattern pc_lhs in
        let pc_guard = self#option self#expression pc_guard in
        let pc_rhs = self#expression pc_rhs in
        self#record "case" [ "pc_lhs", pc_lhs; "pc_guard", pc_guard; "pc_rhs", pc_rhs ]

    method letop : letop -> 'res =
      fun { let_; ands; body } ->
        let let_ = self#binding_op let_ in
        let ands = self#list self#binding_op ands in
        let body = self#expression body in
        self#record "letop" [ "let_", let_; "ands", ands; "body", body ]

    method binding_op : binding_op -> 'res =
      fun { pbop_op; pbop_pat; pbop_exp; pbop_loc } ->
        let pbop_op = self#loc self#string pbop_op in
        let pbop_pat = self#pattern pbop_pat in
        let pbop_exp = self#expression pbop_exp in
        let pbop_loc = self#location pbop_loc in
        self#record
          "binding_op"
          [ "pbop_op", pbop_op
          ; "pbop_pat", pbop_pat
          ; "pbop_exp", pbop_exp
          ; "pbop_loc", pbop_loc
          ]

    method value_description : value_description -> 'res =
      fun { pval_name; pval_type; pval_prim; pval_attributes; pval_loc } ->
        let pval_name = self#loc self#string pval_name in
        let pval_type = self#core_type pval_type in
        let pval_prim = self#list self#string pval_prim in
        let pval_attributes = self#attributes pval_attributes in
        let pval_loc = self#location pval_loc in
        self#record
          "value_description"
          [ "pval_name", pval_name
          ; "pval_type", pval_type
          ; "pval_prim", pval_prim
          ; "pval_attributes", pval_attributes
          ; "pval_loc", pval_loc
          ]

    method type_declaration : type_declaration -> 'res =
      fun { ptype_name
          ; ptype_params
          ; ptype_cstrs
          ; ptype_kind
          ; ptype_private
          ; ptype_manifest
          ; ptype_attributes
          ; ptype_loc
          } ->
        let ptype_name = self#loc self#string ptype_name in
        let ptype_params =
          self#list
            (fun (a, b) ->
               let a = self#core_type a in
               let b =
                 (fun (a, b) ->
                    let a = self#variance a in
                    let b = self#injectivity b in
                    self#tuple [ "variance", a; "injectivity", b ])
                   b
               in
               self#tuple [ "core_type", a; "(variance * injectivity)", b ])
            ptype_params
        in
        let ptype_cstrs =
          self#list
            (fun (a, b, c) ->
               let a = self#core_type a in
               let b = self#core_type b in
               let c = self#location c in
               self#tuple [ "core_type1", a; "core_type2", b; "location", c ])
            ptype_cstrs
        in
        let ptype_kind = self#type_kind ptype_kind in
        let ptype_private = self#private_flag ptype_private in
        let ptype_manifest = self#option self#core_type ptype_manifest in
        let ptype_attributes = self#attributes ptype_attributes in
        let ptype_loc = self#location ptype_loc in
        self#record
          "type_declaration"
          [ "ptype_name", ptype_name
          ; "ptype_params", ptype_params
          ; "ptype_cstrs", ptype_cstrs
          ; "ptype_kind", ptype_kind
          ; "ptype_private", ptype_private
          ; "ptype_manifest", ptype_manifest
          ; "ptype_attributes", ptype_attributes
          ; "ptype_loc", ptype_loc
          ]

    method type_kind : type_kind -> 'res =
      fun x ->
        match x with
        | Ptype_abstract -> self#constr "Ptype_abstract" []
        | Ptype_variant a ->
          let a = self#list self#constructor_declaration a in
          self#constr "Ptype_variant" [ "constructor_declaration list", a ]
        | Ptype_record a ->
          let a = self#list self#label_declaration a in
          self#constr "Ptype_record" [ "label_declaration list", a ]
        | Ptype_open -> self#constr "Ptype_open" []

    method label_declaration : label_declaration -> 'res =
      fun { pld_name; pld_mutable; pld_type; pld_loc; pld_attributes } ->
        let pld_name = self#loc self#string pld_name in
        let pld_mutable = self#mutable_flag pld_mutable in
        let pld_type = self#core_type pld_type in
        let pld_loc = self#location pld_loc in
        let pld_attributes = self#attributes pld_attributes in
        self#record
          "label_declaration"
          [ "pld_name", pld_name
          ; "pld_mutable", pld_mutable
          ; "pld_type", pld_type
          ; "pld_loc", pld_loc
          ; "pld_attributes", pld_attributes
          ]

    method constructor_declaration : constructor_declaration -> 'res =
      fun { pcd_name; pcd_vars; pcd_args; pcd_res; pcd_loc; pcd_attributes } ->
        let pcd_name = self#loc self#string pcd_name in
        let pcd_vars = self#type_vars pcd_vars in
        let pcd_args = self#constructor_arguments pcd_args in
        let pcd_res = self#option self#core_type pcd_res in
        let pcd_loc = self#location pcd_loc in
        let pcd_attributes = self#attributes pcd_attributes in
        self#record
          "constructor_declaration"
          [ "pcd_name", pcd_name
          ; "pcd_vars", pcd_vars
          ; "pcd_args", pcd_args
          ; "pcd_res", pcd_res
          ; "pcd_loc", pcd_loc
          ; "pcd_attributes", pcd_attributes
          ]

    method constructor_arguments : constructor_arguments -> 'res =
      fun x ->
        match x with
        | Pcstr_tuple a ->
          let a = self#list self#core_type a in
          self#constr "Pcstr_tuple" [ "core_type list", a ]
        | Pcstr_record a ->
          let a = self#list self#label_declaration a in
          self#constr "Pcstr_record" [ "label_declaration list", a ]

    method type_extension : type_extension -> 'res =
      fun { ptyext_path
          ; ptyext_params
          ; ptyext_constructors
          ; ptyext_private
          ; ptyext_loc
          ; ptyext_attributes
          } ->
        let ptyext_path = self#longident_loc ptyext_path in
        let ptyext_params =
          self#list
            (fun (a, b) ->
               let a = self#core_type a in
               let b =
                 (fun (a, b) ->
                    let a = self#variance a in
                    let b = self#injectivity b in
                    self#tuple [ "variance", a; "injectivity", b ])
                   b
               in
               self#tuple [ "core_type", a; "(variance * injectivity)", b ])
            ptyext_params
        in
        let ptyext_constructors =
          self#list self#extension_constructor ptyext_constructors
        in
        let ptyext_private = self#private_flag ptyext_private in
        let ptyext_loc = self#location ptyext_loc in
        let ptyext_attributes = self#attributes ptyext_attributes in
        self#record
          "type_extension"
          [ "ptyext_path", ptyext_path
          ; "ptyext_params", ptyext_params
          ; "ptyext_constructors", ptyext_constructors
          ; "ptyext_private", ptyext_private
          ; "ptyext_loc", ptyext_loc
          ; "ptyext_attributes", ptyext_attributes
          ]

    method extension_constructor : extension_constructor -> 'res =
      fun { pext_name; pext_kind; pext_loc; pext_attributes } ->
        let pext_name = self#loc self#string pext_name in
        let pext_kind = self#extension_constructor_kind pext_kind in
        let pext_loc = self#location pext_loc in
        let pext_attributes = self#attributes pext_attributes in
        self#record
          "extension_constructor"
          [ "pext_name", pext_name
          ; "pext_kind", pext_kind
          ; "pext_loc", pext_loc
          ; "pext_attributes", pext_attributes
          ]

    method type_exception : type_exception -> 'res =
      fun { ptyexn_constructor; ptyexn_loc; ptyexn_attributes } ->
        let ptyexn_constructor = self#extension_constructor ptyexn_constructor in
        let ptyexn_loc = self#location ptyexn_loc in
        let ptyexn_attributes = self#attributes ptyexn_attributes in
        self#record
          "type_exception"
          [ "ptyexn_constructor", ptyexn_constructor
          ; "ptyexn_loc", ptyexn_loc
          ; "ptyexn_attributes", ptyexn_attributes
          ]

    method extension_constructor_kind : extension_constructor_kind -> 'res =
      fun x ->
        match x with
        | Pext_decl (existentials, c_args, t_opt) ->
          let existentials = self#existentials existentials in
          let c_args = self#constructor_arguments c_args in
          let t_opt = self#option self#core_type t_opt in
          self#constr
            "Pext_decl"
            [ "existentials", existentials
            ; "constructor_arguments", c_args
            ; "core_type option", t_opt
            ]
        | Pext_rebind a ->
          let a = self#longident_loc a in
          self#constr "Pext_rebind" [ "longident_loc", a ]

    method class_type : class_type -> 'res =
      fun { pcty_desc; pcty_loc; pcty_attributes } ->
        let pcty_desc = self#class_type_desc pcty_desc in
        let pcty_loc = self#location pcty_loc in
        let pcty_attributes = self#attributes pcty_attributes in
        self#record
          "class_type"
          [ "pcty_desc", pcty_desc
          ; "pcty_loc", pcty_loc
          ; "pcty_attributes", pcty_attributes
          ]

    method class_type_desc : class_type_desc -> 'res =
      fun x ->
        match x with
        | Pcty_constr (a, b) ->
          let a = self#longident_loc a in
          let b = self#list self#core_type b in
          self#constr "Pcty_constr" [ "longident_loc", a; "core_type list", b ]
        | Pcty_signature a ->
          let a = self#class_signature a in
          self#constr "Pcty_signature" [ "class_signature", a ]
        | Pcty_arrow (a, b, c) ->
          let a = self#arg_label a in
          let b = self#core_type b in
          let c = self#class_type c in
          self#constr "Pcty_arrow" [ "arg_label", a; "core_type", b; "class_type", c ]
        | Pcty_extension a ->
          let a = self#extension a in
          self#constr "Pcty_extension" [ "extension", a ]
        | Pcty_open (a, b) ->
          let a = self#open_description a in
          let b = self#class_type b in
          self#constr "Pcty_open" [ "open_description", a; "class_type", b ]

    method class_signature : class_signature -> 'res =
      fun { pcsig_self; pcsig_fields } ->
        let pcsig_self = self#core_type pcsig_self in
        let pcsig_fields = self#list self#class_type_field pcsig_fields in
        self#record
          "class_signature"
          [ "pcsig_self", pcsig_self; "pcsig_fields", pcsig_fields ]

    method class_type_field : class_type_field -> 'res =
      fun { pctf_desc; pctf_loc; pctf_attributes } ->
        let pctf_desc = self#class_type_field_desc pctf_desc in
        let pctf_loc = self#location pctf_loc in
        let pctf_attributes = self#attributes pctf_attributes in
        self#record
          "class_type_field"
          [ "pctf_desc", pctf_desc
          ; "pctf_loc", pctf_loc
          ; "pctf_attributes", pctf_attributes
          ]

    method class_type_field_desc : class_type_field_desc -> 'res =
      fun x ->
        match x with
        | Pctf_inherit a ->
          let a = self#class_type a in
          self#constr "Pctf_inherit" [ "class_type", a ]
        | Pctf_val a ->
          let a =
            (fun (a, b, c, d) ->
               let a = self#loc self#label a in
               let b = self#mutable_flag b in
               let c = self#virtual_flag c in
               let d = self#core_type d in
               self#tuple
                 [ "label loc", a; "mutable_flag", b; "virtual_flag", c; "core_type", d ])
              a
          in
          self#constr
            "Pctf_val"
            [ "(label loc * mutable_flag * virtual_flag * core_type)", a ]
        | Pctf_method a ->
          let a =
            (fun (a, b, c, d) ->
               let a = self#loc self#label a in
               let b = self#private_flag b in
               let c = self#virtual_flag c in
               let d = self#core_type d in
               self#tuple
                 [ "label loc ", a; "private_flag", b; "virtual_flag", c; "core_type", d ])
              a
          in
          self#constr
            "Pctf_method"
            [ "(label loc * private_flag * virtual_flag * core_type)", a ]
        | Pctf_constraint a ->
          let a =
            (fun (a, b) ->
               let a = self#core_type a in
               let b = self#core_type b in
               self#tuple [ "core_type1", a; "core_type2", b ])
              a
          in
          self#constr "Pctf_constraint" [ "(core_type * core_type)", a ]
        | Pctf_attribute a ->
          let a = self#attribute a in
          self#constr "Pctf_attribute" [ "attribute", a ]
        | Pctf_extension a ->
          let a = self#extension a in
          self#constr "Pctf_extension" [ "extension", a ]

    method class_infos : 'a. ('a -> 'res) -> 'a class_infos -> 'res =
      fun _a { pci_virt; pci_params; pci_name; pci_expr; pci_loc; pci_attributes } ->
        let pci_virt = self#virtual_flag pci_virt in
        let pci_params =
          self#list
            (fun (a, b) ->
               let a = self#core_type a in
               let b =
                 (fun (a, b) ->
                    let a = self#variance a in
                    let b = self#injectivity b in
                    self#tuple [ "variance", a; "injectivity", b ])
                   b
               in
               self#tuple [ "core_type", a; "(variance * injectivity)", b ])
            pci_params
        in
        let pci_name = self#loc self#string pci_name in
        let pci_expr = _a pci_expr in
        let pci_loc = self#location pci_loc in
        let pci_attributes = self#attributes pci_attributes in
        self#record
          "class_infos"
          [ "pci_virt", pci_virt
          ; "pci_params", pci_params
          ; "pci_name", pci_name
          ; "pci_expr", pci_expr
          ; "pci_loc", pci_loc
          ; "pci_attributes", pci_attributes
          ]

    method class_description : class_description -> 'res =
      self#class_infos self#class_type

    method class_type_declaration : class_type_declaration -> 'res =
      self#class_infos self#class_type

    method class_expr : class_expr -> 'res =
      fun { pcl_desc; pcl_loc; pcl_attributes } ->
        let pcl_desc = self#class_expr_desc pcl_desc in
        let pcl_loc = self#location pcl_loc in
        let pcl_attributes = self#attributes pcl_attributes in
        self#record
          "class_expr"
          [ "pcl_desc", pcl_desc; "pcl_loc", pcl_loc; "pcl_attributes", pcl_attributes ]

    method class_expr_desc : class_expr_desc -> 'res =
      fun x ->
        match x with
        | Pcl_constr (a, b) ->
          let a = self#longident_loc a in
          let b = self#list self#core_type b in
          self#constr "Pcl_constr" [ "longident_loc", a; "core_type list", b ]
        | Pcl_structure a ->
          let a = self#class_structure a in
          self#constr "Pcl_structure" [ "class_structure", a ]
        | Pcl_fun (a, b, c, d) ->
          let a = self#arg_label a in
          let b = self#option self#expression b in
          let c = self#pattern c in
          let d = self#class_expr d in
          self#constr
            "Pcl_fun"
            [ "arg_label", a; "expression option", b; "pattern", c; "class_expr", d ]
        | Pcl_apply (a, b) ->
          let a = self#class_expr a in
          let b =
            self#list
              (fun (a, b) ->
                 let a = self#arg_label a in
                 let b = self#expression b in
                 self#tuple [ "arg_label", a; "expression", b ])
              b
          in
          self#constr "Pcl_apply" [ "class_expr", a; "(arg_label * expression) list", b ]
        | Pcl_let (a, b, c) ->
          let a = self#rec_flag a in
          let b = self#list self#value_binding b in
          let c = self#class_expr c in
          self#constr
            "Pcl_let"
            [ "rec_flag", a; "value_binding list", b; "class_expr", c ]
        | Pcl_constraint (a, b) ->
          let a = self#class_expr a in
          let b = self#class_type b in
          self#constr "Pcl_constraint" [ "class_expr", a; "class_type", b ]
        | Pcl_extension a ->
          let a = self#extension a in
          self#constr "Pcl_extension" [ "extension", a ]
        | Pcl_open (a, b) ->
          let a = self#open_description a in
          let b = self#class_expr b in
          self#constr "Pcl_open" [ "open_description", a; "class_expr", b ]

    method class_structure : class_structure -> 'res =
      fun { pcstr_self; pcstr_fields } ->
        let pcstr_self = self#pattern pcstr_self in
        let pcstr_fields = self#list self#class_field pcstr_fields in
        self#record
          "class_structure"
          [ "pcstr_self", pcstr_self; "pcstr_fields", pcstr_fields ]

    method class_field : class_field -> 'res =
      fun { pcf_desc; pcf_loc; pcf_attributes } ->
        let pcf_desc = self#class_field_desc pcf_desc in
        let pcf_loc = self#location pcf_loc in
        let pcf_attributes = self#attributes pcf_attributes in
        self#record
          "class_field"
          [ "pcf_desc", pcf_desc; "pcf_loc", pcf_loc; "pcf_attributes", pcf_attributes ]

    method class_field_desc : class_field_desc -> 'res =
      fun x ->
        match x with
        | Pcf_inherit (a, b, c) ->
          let a = self#override_flag a in
          let b = self#class_expr b in
          let c = self#option (self#loc self#string) c in
          self#constr
            "Pcf_inherit"
            [ "override_flag", a; "class_expr", b; "label loc option", c ]
        | Pcf_val a ->
          let a =
            (fun (a, b, c) ->
               let a = self#loc self#label a in
               let b = self#mutable_flag b in
               let c = self#class_field_kind c in
               self#tuple [ "label loc", a; "mutable_flag", b; "class_field_kind", c ])
              a
          in
          self#constr "Pcf_val" [ "(label loc * mutable_flag * class_field_kind)", a ]
        | Pcf_method a ->
          let a =
            (fun (a, b, c) ->
               let a = self#loc self#label a in
               let b = self#private_flag b in
               let c = self#class_field_kind c in
               self#tuple [ "label loc", a; "private_flag", b; "class_field_kind", c ])
              a
          in
          self#constr "Pcf_method" [ "(label loc * private_flag * class_field_kind)", a ]
        | Pcf_constraint a ->
          let a =
            (fun (a, b) ->
               let a = self#core_type a in
               let b = self#core_type b in
               self#tuple [ "core_type1", a; "core_type2", b ])
              a
          in
          self#constr "Pcf_constraint" [ "(core_type * core_type)", a ]
        | Pcf_initializer a ->
          let a = self#expression a in
          self#constr "Pcf_initializer" [ "expression", a ]
        | Pcf_attribute a ->
          let a = self#attribute a in
          self#constr "Pcf_attribute" [ "attribute", a ]
        | Pcf_extension a ->
          let a = self#extension a in
          self#constr "Pcf_extension" [ "extension", a ]

    method class_field_kind : class_field_kind -> 'res =
      fun x ->
        match x with
        | Cfk_virtual a ->
          let a = self#core_type a in
          self#constr "Cfk_virtual" [ "core_type", a ]
        | Cfk_concrete (a, b) ->
          let a = self#override_flag a in
          let b = self#expression b in
          self#constr "Cfk_concrete" [ "override_flag", a; "expression", b ]

    method class_declaration : class_declaration -> 'res =
      self#class_infos self#class_expr

    method module_type : module_type -> 'res =
      fun { pmty_desc; pmty_loc; pmty_attributes } ->
        let pmty_desc = self#module_type_desc pmty_desc in
        let pmty_loc = self#location pmty_loc in
        let pmty_attributes = self#attributes pmty_attributes in
        self#record
          "module_type"
          [ "pmty_desc", pmty_desc
          ; "pmty_loc", pmty_loc
          ; "pmty_attributes", pmty_attributes
          ]

    method module_type_desc : module_type_desc -> 'res =
      fun x ->
        match x with
        | Pmty_ident a ->
          let a = self#longident_loc a in
          self#constr "Pmty_ident" [ "longident_loc", a ]
        | Pmty_signature a ->
          let a = self#signature a in
          self#constr "Pmty_signature" [ "signature", a ]
        | Pmty_functor (a, b) ->
          let a = self#functor_parameter a in
          let b = self#module_type b in
          self#constr "Pmty_functor" [ "functor_parameter", a; "module_type", b ]
        | Pmty_with (a, b) ->
          let a = self#module_type a in
          let b = self#list self#with_constraint b in
          self#constr "Pmty_with" [ "module_type", a; "with_constraint list", b ]
        | Pmty_typeof a ->
          let a = self#module_expr a in
          self#constr "Pmty_typeof" [ "module_expr", a ]
        | Pmty_extension a ->
          let a = self#extension a in
          self#constr "Pmty_extension" [ "extension", a ]
        | Pmty_alias a ->
          let a = self#longident_loc a in
          self#constr "Pmty_alias" [ "longident_loc", a ]

    method functor_parameter : functor_parameter -> 'res =
      fun x ->
        match x with
        | Unit -> self#constr "Unit" []
        | Named (a, b) ->
          let a = self#loc (self#option self#string) a in
          let b = self#module_type b in
          self#constr "Named" [ "label option loc", a; "module_type", b ]

    method signature : signature -> 'res = self#list self#signature_item

    method signature_item : signature_item -> 'res =
      fun { psig_desc; psig_loc } ->
        let psig_desc = self#signature_item_desc psig_desc in
        let psig_loc = self#location psig_loc in
        self#record "signature_item" [ "psig_desc", psig_desc; "psig_loc", psig_loc ]

    method signature_item_desc : signature_item_desc -> 'res =
      fun x ->
        match x with
        | Psig_value a ->
          let a = self#value_description a in
          self#constr "Psig_value" [ "value_description", a ]
        | Psig_type (a, b) ->
          let a = self#rec_flag a in
          let b = self#list self#type_declaration b in
          self#constr "Psig_type" [ "rec_flag", a; "type_declaration list", b ]
        | Psig_typesubst a ->
          let a = self#list self#type_declaration a in
          self#constr "Psig_typesubst" [ "type_declaration list", a ]
        | Psig_typext a ->
          let a = self#type_extension a in
          self#constr "Psig_typext" [ "type_extension", a ]
        | Psig_exception a ->
          let a = self#type_exception a in
          self#constr "Psig_exception" [ "type_exception", a ]
        | Psig_module a ->
          let a = self#module_declaration a in
          self#constr "Psig_module" [ "module_declaration", a ]
        | Psig_modsubst a ->
          let a = self#module_substitution a in
          self#constr "Psig_modsubst" [ "module_substitution", a ]
        | Psig_recmodule a ->
          let a = self#list self#module_declaration a in
          self#constr "Psig_recmodule" [ "module_declaration list", a ]
        | Psig_modtype a ->
          let a = self#module_type_declaration a in
          self#constr "Psig_modtype" [ "module_type_declaration", a ]
        | Psig_modtypesubst a ->
          let a = self#module_type_declaration a in
          self#constr "Psig_modtypesubstr" [ "module_type_declaration", a ]
        | Psig_open a ->
          let a = self#open_description a in
          self#constr "Psig_open" [ "open_description", a ]
        | Psig_include a ->
          let a = self#include_description a in
          self#constr "Psig_include" [ "include_description", a ]
        | Psig_class a ->
          let a = self#list self#class_description a in
          self#constr "Psig_class" [ "class_description list", a ]
        | Psig_class_type a ->
          let a = self#list self#class_type_declaration a in
          self#constr "Psig_class_type" [ "class_type_declaration list", a ]
        | Psig_attribute a ->
          let a = self#attribute a in
          self#constr "Psig_attribute" [ "attribute", a ]
        | Psig_extension (a, b) ->
          let a = self#extension a in
          let b = self#attributes b in
          self#constr "Psig_extension" [ "extension", a; "attributes", b ]

    method module_declaration : module_declaration -> 'res =
      fun { pmd_name; pmd_type; pmd_attributes; pmd_loc } ->
        let pmd_name = self#loc (self#option self#string) pmd_name in
        let pmd_type = self#module_type pmd_type in
        let pmd_attributes = self#attributes pmd_attributes in
        let pmd_loc = self#location pmd_loc in
        self#record
          "module_declaration"
          [ "pmd_name", pmd_name
          ; "pmd_type", pmd_type
          ; "pmd_attributes", pmd_attributes
          ; "pmd_loc", pmd_loc
          ]

    method module_substitution : module_substitution -> 'res =
      fun { pms_name; pms_manifest; pms_attributes; pms_loc } ->
        let pms_name = self#loc self#string pms_name in
        let pms_manifest = self#longident_loc pms_manifest in
        let pms_attributes = self#attributes pms_attributes in
        let pms_loc = self#location pms_loc in
        self#record
          "module_substitution"
          [ "pms_name", pms_name
          ; "pms_manifest", pms_manifest
          ; "pms_attributes", pms_attributes
          ; "pms_loc", pms_loc
          ]

    method module_type_declaration : module_type_declaration -> 'res =
      fun { pmtd_name; pmtd_type; pmtd_attributes; pmtd_loc } ->
        let pmtd_name = self#loc self#string pmtd_name in
        let pmtd_type = self#option self#module_type pmtd_type in
        let pmtd_attributes = self#attributes pmtd_attributes in
        let pmtd_loc = self#location pmtd_loc in
        self#record
          "module_type_declaration"
          [ "pmtd_name", pmtd_name
          ; "pmtd_type", pmtd_type
          ; "pmtd_attributes", pmtd_attributes
          ; "pmtd_loc", pmtd_loc
          ]

    method open_infos : 'a. ('a -> 'res) -> 'a open_infos -> 'res =
      fun _a { popen_expr; popen_override; popen_loc; popen_attributes } ->
        let popen_expr = _a popen_expr in
        let popen_override = self#override_flag popen_override in
        let popen_loc = self#location popen_loc in
        let popen_attributes = self#attributes popen_attributes in
        self#record
          "open_infos"
          [ "popen_expr", popen_expr
          ; "popen_override", popen_override
          ; "popen_loc", popen_loc
          ; "popen_attributes", popen_attributes
          ]

    method open_description : open_description -> 'res =
      self#open_infos self#longident_loc

    method open_declaration : open_declaration -> 'res = self#open_infos self#module_expr

    method include_infos : 'a. ('a -> 'res) -> 'a include_infos -> 'res =
      fun _a { pincl_mod; pincl_loc; pincl_attributes } ->
        let pincl_mod = _a pincl_mod in
        let pincl_loc = self#location pincl_loc in
        let pincl_attributes = self#attributes pincl_attributes in
        self#record
          "include_infos"
          [ "pincl_mod", pincl_mod
          ; "pincl_loc", pincl_loc
          ; "pincl_attributes", pincl_attributes
          ]

    method include_description : include_description -> 'res =
      self#include_infos self#module_type

    method include_declaration : include_declaration -> 'res =
      self#include_infos self#module_expr

    method with_constraint : with_constraint -> 'res =
      fun x ->
        match x with
        | Pwith_type (a, b) ->
          let a = self#longident_loc a in
          let b = self#type_declaration b in
          self#constr "Pwith_type" [ "longident_loc", a; "type_declaration", b ]
        | Pwith_module (a, b) ->
          let a = self#longident_loc a in
          let b = self#longident_loc b in
          self#constr "Pwith_module" [ "longident_loc1", a; "longident_loc2", b ]
        | Pwith_modtype (a, b) ->
          let a = self#longident_loc a in
          let b = self#module_type b in
          self#constr "Pwith_modtype" [ "longident_loc", a; "module_type", b ]
        | Pwith_modtypesubst (a, b) ->
          let a = self#longident_loc a in
          let b = self#module_type b in
          self#constr "Pwith_modtypesubstr" [ "longident_loc", a; "module_type", b ]
        | Pwith_typesubst (a, b) ->
          let a = self#longident_loc a in
          let b = self#type_declaration b in
          self#constr "Pwith_typesubst" [ "longident_loc", a; "type_declaration", b ]
        | Pwith_modsubst (a, b) ->
          let a = self#longident_loc a in
          let b = self#longident_loc b in
          self#constr "Pwith_modsubst" [ "longident_loc1", a; "longident_loc2", b ]

    method module_expr : module_expr -> 'res =
      fun { pmod_desc; pmod_loc; pmod_attributes } ->
        let pmod_desc = self#module_expr_desc pmod_desc in
        let pmod_loc = self#location pmod_loc in
        let pmod_attributes = self#attributes pmod_attributes in
        self#record
          "module_expr"
          [ "pmod_desc", pmod_desc
          ; "pmod_loc", pmod_loc
          ; "pmod_attributes", pmod_attributes
          ]

    method module_expr_desc : module_expr_desc -> 'res =
      fun x ->
        match x with
        | Pmod_ident a ->
          let a = self#longident_loc a in
          self#constr "Pmod_ident" [ "longident_loc", a ]
        | Pmod_structure a ->
          let a = self#structure a in
          self#constr "Pmod_structure" [ "structure", a ]
        | Pmod_functor (a, b) ->
          let a = self#functor_parameter a in
          let b = self#module_expr b in
          self#constr "Pmod_functor" [ "functor_parameter", a; "module_expr", b ]
        | Pmod_apply (a, b) ->
          let a = self#module_expr a in
          let b = self#module_expr b in
          self#constr "Pmod_apply" [ "module_expr1", a; "module_expr2", b ]
        | Pmod_constraint (a, b) ->
          let a = self#module_expr a in
          let b = self#module_type b in
          self#constr "Pmod_constraint" [ "module_expr", a; "module_type", b ]
        | Pmod_unpack a ->
          let a = self#expression a in
          self#constr "Pmod_unpack" [ "expression", a ]
        | Pmod_extension a ->
          let a = self#extension a in
          self#constr "Pmod_extension" [ "extension", a ]
        | Pmod_apply_unit a ->
          let a = self#module_expr a in
          self#constr "Pmod_apply_unit" [ "module_expr", a ]

    method structure : structure -> 'res = self#list self#structure_item

    method structure_item : structure_item -> 'res =
      fun { pstr_desc; pstr_loc } ->
        let pstr_desc = self#structure_item_desc pstr_desc in
        let pstr_loc = self#location pstr_loc in
        self#record "structure_item" [ "pstr_desc", pstr_desc; "pstr_loc", pstr_loc ]

    method structure_item_desc : structure_item_desc -> 'res =
      fun x ->
        match x with
        | Pstr_eval (a, b) ->
          let a = self#expression a in
          let b = self#attributes b in
          self#constr "Pstr_eval" [ "expression", a; "attributes", b ]
        | Pstr_value (a, b) ->
          let a = self#rec_flag a in
          let b = self#list self#value_binding b in
          self#constr "Pstr_value" [ "rec_flag", a; "value_binding list", b ]
        | Pstr_primitive a ->
          let a = self#value_description a in
          self#constr "Pstr_primitive" [ "value_description", a ]
        | Pstr_type (a, b) ->
          let a = self#rec_flag a in
          let b = self#list self#type_declaration b in
          self#constr "Pstr_type" [ "rec_flag", a; "type_declaration list", b ]
        | Pstr_typext a ->
          let a = self#type_extension a in
          self#constr "Pstr_typext" [ "type_extension", a ]
        | Pstr_exception a ->
          let a = self#type_exception a in
          self#constr "Pstr_exception" [ "type_exception", a ]
        | Pstr_module a ->
          let a = self#module_binding a in
          self#constr "Pstr_module" [ "module_binding", a ]
        | Pstr_recmodule a ->
          let a = self#list self#module_binding a in
          self#constr "Pstr_recmodule" [ "module_binding list", a ]
        | Pstr_modtype a ->
          let a = self#module_type_declaration a in
          self#constr "Pstr_modtype" [ "module_type_declaration", a ]
        | Pstr_open a ->
          let a = self#open_declaration a in
          self#constr "Pstr_open" [ "open_declaration", a ]
        | Pstr_class a ->
          let a = self#list self#class_declaration a in
          self#constr "Pstr_class" [ "class_declaration list", a ]
        | Pstr_class_type a ->
          let a = self#list self#class_type_declaration a in
          self#constr "Pstr_class_type" [ "class_type_declaration list", a ]
        | Pstr_include a ->
          let a = self#include_declaration a in
          self#constr "Pstr_include" [ "include_declaration", a ]
        | Pstr_attribute a ->
          let a = self#attribute a in
          self#constr "Pstr_attribute" [ "attribute", a ]
        | Pstr_extension (a, b) ->
          let a = self#extension a in
          let b = self#attributes b in
          self#constr "Pstr_extension" [ "extension", a; "attributes", b ]

    method value_binding : value_binding -> 'res =
      fun { pvb_pat; pvb_expr; pvb_attributes; pvb_loc; pvb_constraint } ->
        let pvb_pat = self#pattern pvb_pat in
        let pvb_expr = self#expression pvb_expr in
        let pvb_attributes = self#attributes pvb_attributes in
        let pvb_loc = self#location pvb_loc in
        let pvb_constraint = self#option self#value_constraint pvb_constraint in
        self#record
          "value_binding"
          [ "pvb_pat", pvb_pat
          ; "pvb_expr", pvb_expr
          ; "pvb_attributes", pvb_attributes
          ; "pvb_loc", pvb_loc
          ; "pvb_constraint", pvb_constraint
          ]

    method module_binding : module_binding -> 'res =
      fun { pmb_name; pmb_expr; pmb_attributes; pmb_loc } ->
        let pmb_name = self#loc (self#option self#string) pmb_name in
        let pmb_expr = self#module_expr pmb_expr in
        let pmb_attributes = self#attributes pmb_attributes in
        let pmb_loc = self#location pmb_loc in
        self#record
          "module_binding"
          [ "pmb_name", pmb_name
          ; "pmb_expr", pmb_expr
          ; "pmb_attributes", pmb_attributes
          ; "pmb_loc", pmb_loc
          ]

    method toplevel_phrase : toplevel_phrase -> 'res =
      fun x ->
        match x with
        | Ptop_def a ->
          let a = self#structure a in
          self#constr "Ptop_def" [ "structure", a ]
        | Ptop_dir a ->
          let a = self#toplevel_directive a in
          self#constr "Ptop_dir" [ "toplevel_directive", a ]

    method toplevel_directive : toplevel_directive -> 'res =
      fun { pdir_name; pdir_arg; pdir_loc } ->
        let pdir_name = self#loc self#string pdir_name in
        let pdir_arg = self#option self#directive_argument pdir_arg in
        let pdir_loc = self#location pdir_loc in
        self#record
          "toplevel_directive"
          [ "pdir_name", pdir_name; "pdir_arg", pdir_arg; "pdir_loc", pdir_loc ]

    method directive_argument : directive_argument -> 'res =
      fun { pdira_desc; pdira_loc } ->
        let pdira_desc = self#directive_argument_desc pdira_desc in
        let pdira_loc = self#location pdira_loc in
        self#record
          "directive_argument"
          [ "pdira_desc", pdira_desc; "pdira_loc", pdira_loc ]

    method directive_argument_desc : directive_argument_desc -> 'res =
      fun x ->
        match x with
        | Pdir_string a ->
          let a = self#string a in
          self#constr "Pdir_string" [ "label", a ]
        | Pdir_int (a, b) ->
          let a = self#string a in
          let b = self#option self#char b in
          self#constr "Pdir_int" [ "label", a; "char option", b ]
        | Pdir_ident a ->
          let a = self#longident a in
          self#constr "Pdir_ident" [ "longident", a ]
        | Pdir_bool a ->
          let a = self#bool a in
          self#constr "Pdir_bool" [ "bool", a ]

    method cases : cases -> 'res = self#list self#case

    method function_param : function_param -> 'res =
      fun { pparam_loc; pparam_desc } ->
        let pparam_loc = self#location pparam_loc in
        let pparam_desc = self#function_param_desc pparam_desc in
        self#record
          "function_param"
          [ "pparam_loc", pparam_loc; "pparam_desc", pparam_desc ]

    method function_param_desc : function_param_desc -> 'res =
      fun x ->
        match x with
        | Pparam_val (a, b, c) ->
          let a = self#arg_label a in
          let b = self#option self#expression b in
          let c = self#pattern c in
          self#constr
            "Pparam_val"
            [ "arg_label", a; "expression option", b; "pattern", c ]
        | Pparam_newtype a ->
          let a = self#loc self#string a in
          self#constr "Pparam_newtype" [ "string loc", a ]

    method type_constraint : type_constraint -> 'res =
      fun x ->
        match x with
        | Pconstraint a ->
          let a = self#core_type a in
          self#constr "Pconstraint" [ "core_type", a ]
        | Pcoerce (a, b) ->
          let a = self#option self#core_type a in
          let b = self#core_type b in
          self#constr "Pcoerce" [ "core_type option", a; "core_type", b ]

    method value_constraint : value_constraint -> 'res =
      fun x ->
        match x with
        | Pvc_constraint { locally_abstract_univars; typ } ->
          let locally_abstract_univars =
            self#list (self#loc self#string) locally_abstract_univars
          in
          let typ = self#core_type typ in
          self#constr
            "Pvc_constraint"
            [ "locally_abstract_univars", locally_abstract_univars; "typ", typ ]
        | Pvc_coercion { ground; coercion } ->
          let ground = self#option self#core_type ground in
          let coercion = self#core_type coercion in
          self#constr "Pvc_coercion" [ "ground", ground; "coercion", coercion ]

    method function_body : function_body -> 'res =
      fun x ->
        match x with
        | Pfunction_body a ->
          let a = self#expression a in
          self#constr "Pfunction_body" [ "expression", a ]
        | Pfunction_cases (a, b, c) ->
          let a = self#cases a in
          let b = self#location b in
          let c = self#attributes c in
          self#constr "Pfunction_cases" [ "cases", a; "location", b; "attributes", c ]
  end
