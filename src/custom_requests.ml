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

module Wrapping_ast_node = struct
  let meth = ocamllsp_prefixed "wrappingAstNode"

  let encode_params uri position =
    (* TODO: these params exist as a defined type in LSP *)
    Jsonoo.Encode.(
      object_
        [ ("uri", string @@ Uri.toString uri ())
        ; ("position", Position.json_of_t position)
        ])

  let decode_response json = Jsonoo.Decode.try_optional Range.t_of_json json

  let send_request client ~doc:uri ~position =
    let data = encode_params uri position in
    let open Promise.Syntax in
    let+ response = LanguageClient.sendRequest client ~meth ~data () in
    decode_response response
end