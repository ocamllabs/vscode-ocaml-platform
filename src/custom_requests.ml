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

let typeEnclosing =
  { meth = ocamllsp_prefixed "typeEnclosing"
  ; encode_params =
      (fun (uri, at, index, verbosity) ->
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
        object_ [ uri; at; index; verbosity ])
  ; decode_response =
      (fun response ->
        let open Jsonoo.Decode in
        let index = field "index" int response in
        let type_ = field "type" string response in
        let enclosings = field "enclosings" (list Range.t_of_json) response in
        (index, type_, enclosings))
  }
