open Import

type ('params, 'response) custom_request =
  { meth : string
  ; encode_params : 'params -> Jsonoo.t
  ; decode_response : Jsonoo.t -> 'response
  }

let send_request client req params =
  let data = req.encode_params params in
  let open Promise.Syntax in
  let+ response = LanguageClient.sendRequest client ~meth:req.meth ~data () in
  req.decode_response response

let ocamllsp_prefixed s = "ocamllsp/" ^ s

module DocumentPosition = struct
  type t =
    { uri : Uri.t
    ; position : [ `Position of Position.t | `Range of Range.t ]
    }

  let encode { uri; position } =
    let open Jsonoo.Encode in
    let uri = ("uri", string @@ Uri.toString uri ()) in
    let position =
      ( "position"
      , match position with
        | `Position p -> Position.json_of_t p
        | `Range r -> Range.json_of_t r )
    in
    [ uri; position ]

  let decode response =
    let open Jsonoo.Decode in
    let uri = field "uri" string response in
    let position_or_range =
      match try_optional (field "position" Position.t_of_json) response with
      | Some position -> `Position position
      | None -> (
        match try_optional (field "range" Range.t_of_json) response with
        | Some range -> `Range range
        | None -> failwith "Expected either 'position' or 'range' field")
    in
    { uri = Uri.parse uri (); position = position_or_range }
end

let switchImplIntf =
  { meth = ocamllsp_prefixed "switchImplIntf"
  ; encode_params = Jsonoo.Encode.string
  ; decode_response = Jsonoo.Decode.(array string)
  }

let inferIntf =
  { meth = ocamllsp_prefixed "inferIntf"
  ; encode_params = Jsonoo.Encode.string
  ; decode_response = Jsonoo.Decode.string
  }

let typedHoles =
  { meth = ocamllsp_prefixed "typedHoles"
  ; encode_params =
      (fun uri ->
        Jsonoo.Encode.(object_ [ ("uri", string @@ Uri.toString uri ()) ]))
  ; decode_response = Jsonoo.Decode.list Range.t_of_json
  }

module Type_enclosing = struct
  type params =
    { uri : Uri.t
    ; at : [ `Position of Position.t | `Range of Range.t ]
    ; index : int
    ; verbosity : int
    }

  type response =
    { index : int
    ; type_ : string
    ; enclosings : Range.t list
    }

  let encode_params { uri; at; index; verbosity } =
    let open Jsonoo.Encode in
    let uri_position = DocumentPosition.encode { uri; position = at } in
    let index = ("index", int index) in
    let verbosity = ("verbosity", int verbosity) in
    object_ (uri_position @ [ index; verbosity ])

  let decode_response response =
    let open Jsonoo.Decode in
    let index = field "index" int response in
    let type_ = field "type" string response in
    let enclosings = field "enclosings" (list Range.t_of_json) response in
    { index; type_; enclosings }

  let make ~uri ~at ~index ~verbosity = { uri; at; index; verbosity }

  let request =
    { meth = ocamllsp_prefixed "typeEnclosing"; encode_params; decode_response }
end

module Get_documentation = struct
  type params =
    { uri : Uri.t
    ; position : Position.t
    ; identifier : string option
    ; contentFormat : [ `Plantext | `Markdown ] option
    }

  type response =
    { kind : string
    ; value : string
    }

  let encode_params { uri; position; identifier; contentFormat } =
    let open Jsonoo.Encode in
    let uri_position =
      DocumentPosition.encode { uri; position = `Position position }
    in
    let identifier =
      ( "identifier"
      , Option.(
          value ~default:null (map ~f:(fun ident -> string ident) identifier))
      )
    in
    let contentFormat =
      ( "contentFormat"
      , Option.(
          value
            ~default:null
            (map
               ~f:(fun cf ->
                 match cf with
                 | `Plantext -> string "plaintext"
                 | `Markdown -> string "markdown")
               contentFormat)) )
    in
    object_ (uri_position @ [ identifier; contentFormat ])

  let decode_response response =
    let open Jsonoo.Decode in
    let decode_doc json =
      let kind = field "kind" string json in
      let value = field "value" string json in
      { kind; value }
    in
    field "doc" decode_doc response

  let make ~uri ~position ?(identifier = None) ?(contentFormat = None) () =
    { uri; position; identifier; contentFormat }

  let request =
    { meth = ocamllsp_prefixed "getDocumentation"
    ; encode_params
    ; decode_response
    }
end

module Construct = struct
  type params =
    { uri : Uri.t
    ; position : Position.t
    ; depth : int option
    ; with_values : [ `None | `Local ] option
    }

  type response =
    { position : Range.t
    ; result : string list
    }

  let encode_params { uri; position; depth; with_values } =
    let open Jsonoo.Encode in
    let uri_position =
      DocumentPosition.encode { uri; position = `Position position }
    in
    let depth =
      ("depth", Option.(value ~default:null (map ~f:(fun d -> int d) depth)))
    in
    let with_values =
      ( "with_values"
      , Option.(
          value
            ~default:null
            (map
               ~f:(fun w ->
                 match w with
                 | `None -> string "none"
                 | `Local -> string "local")
               with_values)) )
    in
    object_ (uri_position @ [ depth; with_values ])

  let decode_response response =
    let open Jsonoo.Decode in
    let position = field "position" Range.t_of_json response in
    let result = field "result" (list string) response in
    { position; result }

  let make ~uri ~position ?(depth = None) ?(with_values = None) () =
    { uri; position; depth; with_values }

  let request =
    { meth = ocamllsp_prefixed "construct"; encode_params; decode_response }
end

module Hover_extended = struct
  type content =
    { kind : string
    ; value : string
    }

  type res =
    { contents : content
    ; range : Range.t
    }

  type params =
    { uri : Uri.t
    ; position : Position.t
    ; verbosity : int option
    }

  type response = res list

  let encode_params { uri; position; verbosity } =
    let open Jsonoo.Encode in
    let uri_position =
      DocumentPosition.encode { uri; position = `Position position }
    in
    let verbosity =
      ( "verbosity"
      , Option.(value ~default:null (map ~f:(fun d -> int d) verbosity)) )
    in
    object_ (uri_position @ [ verbosity ])

  let make ~uri ~position ?(verbosity = None) () = { uri; position; verbosity }

  let decode_response response =
    let open Jsonoo.Decode in
    let decode_content response =
      { kind = field "kind" string response
      ; value = field "value" string response
      }
    in
    let decode_res response =
      { contents = field "contents" decode_content response
      ; range = field "range" Range.t_of_json response
      }
    in
    list decode_res response

  let request =
    { meth = ocamllsp_prefixed "hoverExtended"; encode_params; decode_response }
end

module Merlin_jump = struct
  type params =
    { uri : Uri.t
    ; position : Position.t
    ; target : string
    }

  type response =
    { uri : Uri.t
    ; position : Position.t
    }

  let encode_params { uri; position; target } =
    let open Jsonoo.Encode in
    let uri_position =
      DocumentPosition.encode { uri; position = `Position position }
    in
    let target = ("target", string target) in
    object_ (uri_position @ [ target ])

  let decode_response response =
    let t = DocumentPosition.decode response in
    let position =
      match t.position with
      | `Position p -> p
      | `Range p -> Range.start p
    in
    { uri = t.uri; position }

  let make ~uri ~position ~target () = { uri; position; target }

  let request =
    { meth = ocamllsp_prefixed "jump"; encode_params; decode_response }
end
