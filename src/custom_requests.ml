open Import

let ocamllsp_prefixed s = "ocamllsp/" ^ s

module Typed_holes : sig
  (** [send_request client ~for_doc] will fetch ranges of holes in the file at
      the URI [for_doc] *)
  val send_request : LanguageClient.t -> for_doc:Uri.t -> Range.t list Promise.t
end = struct
  let meth = ocamllsp_prefixed "typedHoles"

  let encode_params uri =
    Jsonoo.Encode.(object_ [ ("uri", string @@ Uri.toString uri ()) ])

  let decode_response json = Jsonoo.Decode.list Range.t_of_json json

  let send_request client ~for_doc:uri =
    let data = encode_params uri in
    let open Promise.Syntax in
    let+ response = LanguageClient.sendRequest client ~meth ~data () in
    decode_response response
end
