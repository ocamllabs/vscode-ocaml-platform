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
    let uri = ("uri", string @@ Uri.toString uri ()) in
    let at =
      match at with
      | `Position p -> Position.json_of_t p
      | `Range r -> Range.json_of_t r
    in
    let at = ("at", at) in
    let index = ("index", int index) in
    let verbosity = ("verbosity", int verbosity) in
    object_ [ uri; at; index; verbosity ]

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

module Type_search = struct
  type type_search_result =
    { name : string
    ; typ : string
    ; loc : Range.t
    ; doc : string option
    ; cost : int
    ; constructible : string
    }

  type params =
    { uri : Uri.t
    ; position : Position.t
    ; limit : int
    ; query : string
    ; with_doc : bool
    }

  type response = type_search_result list

  let encode_params { uri; position; limit; query; with_doc } =
    let open Jsonoo.Encode in
    let uri =
      ("textDocument", object_ [ ("uri", string @@ Uri.toString uri ()) ])
    in
    let position = ("position", Position.json_of_t position) in
    let query = ("query", string query) in
    let limit = ("limit", int limit) in
    let with_doc = ("with_doc", bool with_doc) in
    object_ [ uri; position; query; limit; with_doc ]

  let decode_response response =
    let open Jsonoo.Decode in
    let decode_res response =
      let name = field "name" string response in
      let typ = field "typ" string response in
      let loc = field "loc" Range.t_of_json response in
      let doc = try_optional (field "doc" string) response in
      let cost = field "cost" int response in
      let constructible = field "constructible" string response in
      { name; typ; loc; doc; cost; constructible }
    in
    list decode_res response

  let make ~uri ~position ~limit ~query ~with_doc () =
    { uri; position; limit; query; with_doc }

  let request =
    { meth = ocamllsp_prefixed "typeSearch"; encode_params; decode_response }
end
