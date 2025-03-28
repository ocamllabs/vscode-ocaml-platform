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
;;

let ocamllsp_prefixed s = "ocamllsp/" ^ s

let switchImplIntf =
  { meth = ocamllsp_prefixed "switchImplIntf"
  ; encode_params = Jsonoo.Encode.string
  ; decode_response = Jsonoo.Decode.(array string)
  }
;;

let inferIntf =
  { meth = ocamllsp_prefixed "inferIntf"
  ; encode_params = Jsonoo.Encode.string
  ; decode_response = Jsonoo.Decode.string
  }
;;

let typedHoles =
  { meth = ocamllsp_prefixed "typedHoles"
  ; encode_params =
      (fun uri -> Jsonoo.Encode.(object_ [ "uri", string @@ Uri.toString uri () ]))
  ; decode_response = Jsonoo.Decode.list Range.t_of_json
  }
;;

module Type_selection = struct
  type params =
    { uri : Uri.t
    ; at : [ `Position of Position.t | `Range of Range.t ]
    ; index : int
    ; verbosity : int
    }

  type response =
    { index : int
    ; type_ : string
    ; enclosings : Range.t array
    }

  let encode_params { uri; at; index; verbosity } =
    let open Jsonoo.Encode in
    let uri = "uri", string @@ Uri.toString uri () in
    let at =
      match at with
      | `Position p -> Position.json_of_t p
      | `Range r -> Range.json_of_t r
    in
    let at = "at", at in
    let index = "index", int index in
    let verbosity = "verbosity", int verbosity in
    object_ [ uri; at; index; verbosity ]
  ;;

  let decode_response response =
    let open Jsonoo.Decode in
    let index = field "index" int response in
    let type_ = field "type" string response in
    let enclosings = field "enclosings" (array Range.t_of_json) response in
    { index; type_; enclosings }
  ;;

  let make ~uri ~at ~index ~verbosity = { uri; at; index; verbosity }

  let request =
    { meth = ocamllsp_prefixed "typeEnclosing"; encode_params; decode_response }
  ;;
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
    let uri = "uri", string @@ Uri.toString uri () in
    let position = "position", Position.json_of_t position in
    let depth = "depth", Option.(value ~default:null (map ~f:(fun d -> int d) depth)) in
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
    object_ [ uri; position; depth; with_values ]
  ;;

  let decode_response response =
    let open Jsonoo.Decode in
    let position = field "position" Range.t_of_json response in
    let result = field "result" (list string) response in
    { position; result }
  ;;

  let make ~uri ~position ?(depth = None) ?(with_values = None) () =
    { uri; position; depth; with_values }
  ;;

  let request = { meth = ocamllsp_prefixed "construct"; encode_params; decode_response }
end

module Merlin_jump = struct
  type params =
    { uri : Uri.t
    ; position : Position.t
    }

  type response = (string * Position.t) list

  let encode_params { uri; position } =
    let open Jsonoo.Encode in
    let uri = "textDocument", object_ [ "uri", string @@ Uri.toString uri () ] in
    let position = "position", Position.json_of_t position in
    object_ [ uri; position ]
  ;;

  let decode_response (response : Jsonoo.t) : response =
    let open Jsonoo.Decode in
    field
      "jumps"
      (list (fun item ->
         let target = field "target" string item in
         let position = field "position" Position.t_of_json item in
         target, position))
      response
  ;;

  let make ~uri ~position = { uri; position }
  let request = { meth = ocamllsp_prefixed "jump"; encode_params; decode_response }
end

module Type_search = struct
  type type_search_result =
    { name : string
    ; typ : string
    ; loc : Range.t
    ; doc : MarkupContent.t option
    ; cost : int
    ; constructible : string
    }

  type params =
    { uri : Uri.t
    ; position : Position.t
    ; limit : int
    ; query : string
    ; with_doc : bool
    ; doc_format : MarkupKind.t option
    }

  type response = type_search_result list

  let encode_params { uri; position; limit; query; with_doc; doc_format } =
    let open Jsonoo.Encode in
    let uri = "textDocument", object_ [ "uri", string @@ Uri.toString uri () ] in
    let position = "position", Position.json_of_t position in
    let query = "query", string query in
    let limit = "limit", int limit in
    let with_doc = "with_doc", bool with_doc in
    let doc_format =
      ( "doc_format"
      , MarkupKind.json_of_t (Option.value ~default:MarkupKind.Markdown doc_format) )
    in
    object_ [ uri; position; query; limit; with_doc; doc_format ]
  ;;

  let decode_response response =
    let open Jsonoo.Decode in
    let decode_res response =
      let name = field "name" string response in
      let typ = field "typ" string response in
      let loc = field "loc" Range.t_of_json response in
      let doc = try_optional (field "doc" MarkupContent.t_of_json) response in
      let cost = field "cost" int response in
      let constructible = field "constructible" string response in
      { name; typ; loc; doc; cost; constructible }
    in
    list decode_res response
  ;;

  let make
        ~uri
        ~position
        ~limit
        ~query
        ~with_doc
        ?(doc_format = Some MarkupKind.Markdown)
        ()
    =
    { uri; position; limit; query; with_doc; doc_format }
  ;;

  let request = { meth = ocamllsp_prefixed "typeSearch"; encode_params; decode_response }
end
