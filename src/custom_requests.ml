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

module ExtendedHover = struct
  type request =
    { textDocument : TextDocumentIdentifier.t
    ; position : Position.t
    ; verbosity : int option
    }

  type response =
    { contents :
        [ `MarkdownString of MarkdownString.t
        | `MarkdownStringArray of MarkdownString.t list
        ]
    ; range : Range.t option
    }

  let hoverExtended =
    let encode_params { textDocument; position; verbosity } =
      Jsonoo.Encode.(
        object_
          [ ("textDocument", TextDocumentIdentifier.json_of_t textDocument)
          ; ("position", Position.json_of_t position)
          ; ("verbosity", nullable int verbosity)
          ])
    in
    let decode_response json =
      show_message
        `Info
        "ExtendedHover.decode_response %s"
        (Jsonoo.stringify json);
      Jsonoo.Decode.nullable
        (fun json ->
          let contents =
            let hover =
              Jsonoo.Decode.(field "contents" (field "value" string) json)
            in
            `MarkdownString (MarkdownString.make ~value:hover ())
          in
          let range =
            try Jsonoo.Decode.(nullable (field "range" Range.t_of_json) json)
            with _ ->
              show_message `Info "No range in hover response";
              None
          in
          { contents; range })
        json
    in
    { meth = ocamllsp_prefixed "hoverExtended"; encode_params; decode_response }
end

(* 

   { "contents": { "kind": "markdown", "value": "```ocaml\njs_person Js.t
   Js.constr\n```" }, "range": { "end": { "character": 28, "line": 22 },
   "start": { "character": 2, "line": 22 } } } *)
