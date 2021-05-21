[@@@ocaml.warning "-32-34"]

exception Decode_error of string

module Js = struct
  open Js_of_ocaml

  type json

  type t = json Js.t

  let decode_error message = raise (Decode_error message)

  let _JSON = Js.Unsafe.global##._JSON

  let try_parse_opt s =
    try Some (_JSON##parse (Js.string s)) with
    | _ -> None

  let try_parse_exn s =
    try _JSON##parse (Js.string s) with
    | _ -> decode_error ("Failed to parse JSON string \"" ^ s ^ "\"")

  let stringify ?spaces (json : t) =
    let js_string =
      match spaces with
      | None -> _JSON##stringify json
      | Some n ->
        let spaces = Js.number_of_float (float_of_int n) in
        _JSON##stringify json Js.undefined spaces
    in
    Js.to_string js_string

  module Decode = struct
    type 'a decoder = t -> 'a

    let expected typ (json : t) =
      decode_error ("Expected " ^ typ ^ ", got " ^ stringify json)

    let expected_length length array =
      decode_error
        ("Expected array of length " ^ string_of_int length
       ^ ", got array of length "
        ^ string_of_int (Array.length array))

    let typeof value = Js.to_string (Js.typeof value)

    let is_array value =
      let array_constr = Js.Unsafe.global##._Array in
      Js.instanceof value array_constr

    let id (json : t) = json

    let null (json : t) =
      if Js.Opt.test (Js.Opt.return json) then
        expected "null" json
      else
        Js.null

    let bool (json : t) =
      if typeof json = "boolean" then
        Js.to_bool (Js.Unsafe.coerce json)
      else
        expected "boolean" json

    let float (json : t) =
      if typeof json = "number" then
        Js.float_of_number (Js.Unsafe.coerce json)
      else
        expected "number" json

    let int (json : t) =
      let f = float json in
      if Float.is_finite f && Float.floor f = f then
        int_of_float f
      else
        expected "integer" json

    let string (json : t) =
      if typeof json = "string" then
        Js.to_string (Js.Unsafe.coerce json)
      else
        expected "string" json

    let char (json : t) =
      let s = string json in
      if String.length s = 1 then
        s.[0]
      else
        expected "single-character string" json

    let nullable decode (json : t) =
      if Js.Opt.test (Js.Opt.return json) then
        Some (decode json)
      else
        None

    let array decode (json : t) =
      if is_array json then
        let array = Js.to_array (Js.Unsafe.coerce json) in
        let convert i (json : t) =
          try decode json with
          | Decode_error message ->
            decode_error (message ^ "\n\tin array at index " ^ string_of_int i)
        in
        Array.mapi convert array
      else
        expected "array" json

    let list decode (json : t) = Array.to_list (array decode json)

    let tuple_element decode array i =
      try decode array.(i) with
      | Decode_error message ->
        decode_error (message ^ "\n\tin array at index " ^ string_of_int i)

    let pair decode_a decode_b (json : t) =
      let array = array id json in
      if Array.length array = 2 then
        let a = tuple_element decode_a array 0 in
        let b = tuple_element decode_b array 1 in
        (a, b)
      else
        expected_length 2 array

    let tuple2 = pair

    let tuple3 decode_a decode_b decode_c (json : t) =
      let array = array id json in
      if Array.length array = 3 then
        let a = tuple_element decode_a array 0 in
        let b = tuple_element decode_b array 1 in
        let c = tuple_element decode_c array 2 in
        (a, b, c)
      else
        expected_length 3 array

    let tuple4 decode_a decode_b decode_c decode_d (json : t) =
      let array = array id json in
      if Array.length array = 4 then
        let a = tuple_element decode_a array 0 in
        let b = tuple_element decode_b array 1 in
        let c = tuple_element decode_c array 2 in
        let d = tuple_element decode_d array 3 in
        (a, b, c, d)
      else
        expected_length 4 array

    let object_field decode js_object key =
      try decode (Js.Unsafe.get js_object key) with
      | Decode_error message ->
        decode_error
          (message ^ "\n\tin object at field '" ^ Js.to_string key ^ "'")

    let dict decode (json : t) =
      if
        typeof json = "object"
        && (not (is_array json))
        && Js.Opt.(test (return json))
      then (
        let keys = Js.to_array (Js.object_keys json) in
        let table = Hashtbl.create (Array.length keys) in
        let set key =
          let value = object_field decode json key in
          Hashtbl.add table (Js.to_string key) value
        in
        Array.iter set keys;
        table
      ) else
        expected "object" json

    let field key decode (json : t) =
      if
        typeof json = "object"
        && (not (is_array json))
        && Js.Opt.(test (return json))
      then
        let js_key = Js.string key in
        if Js.Optdef.(test @@ return (Js.Unsafe.get json js_key)) then
          object_field decode json js_key
        else
          decode_error ("Expected field '" ^ key ^ "'")
      else
        expected "object" json

    let rec at key_path decoder =
      match key_path with
      | [ key ] -> field key decoder
      | first :: rest -> field first (at rest decoder)
      | [] -> invalid_arg "Expected key_path to contain at least one element"

    let try_optional decode (json : t) =
      try Some (decode json) with
      | Decode_error _ -> None

    let try_default value decode (json : t) =
      try decode json with
      | Decode_error _ -> value

    let any decoders (json : t) =
      let rec inner errors = function
        | [] ->
          let rev_errors = List.rev errors in
          decode_error
            ("Value was not able to be decoded with the given decoders. \
              Errors: "
            ^ String.concat "\n" rev_errors)
        | decode :: rest -> (
          try decode json with
          | Decode_error e -> inner (e :: errors) rest)
      in
      inner [] decoders

    let either a b = any [ a; b ]

    let map f decode (json : t) = f (decode json)

    let bind b a (json : t) = b (a json) json
  end

  module Encode = struct
    let id (json : t) = json

    let null : t = Obj.magic Js.null

    let bool b : t = Js.Unsafe.coerce (Js.bool b)

    let float f : t = Js.Unsafe.coerce (Js.number_of_float f)

    let int i : t = Js.Unsafe.coerce (Js.number_of_float (float_of_int i))

    let string s : t = Js.Unsafe.coerce (Js.string s)

    let char c : t = string (String.make 1 c)

    let nullable encode = function
      | None -> null
      | Some v -> encode v

    let array encode a : t =
      let encoded : t array = Array.map encode a in
      Js.Unsafe.coerce (Js.array encoded)

    let list encode l : t = array encode (Array.of_list l)

    let pair encode_a encode_b (a, b) : t =
      let encoded : t array = [| encode_a a; encode_b b |] in
      Js.Unsafe.coerce (Js.array encoded)

    let tuple2 = pair

    let tuple3 encode_a encode_b encode_c (a, b, c) : t =
      let encoded : t array = [| encode_a a; encode_b b; encode_c c |] in
      Js.Unsafe.coerce (Js.array encoded)

    let tuple4 encode_a encode_b encode_c encode_d (a, b, c, d) : t =
      let encoded : t array =
        [| encode_a a; encode_b b; encode_c c; encode_d d |]
      in
      Js.Unsafe.coerce (Js.array encoded)

    let dict encode table : t =
      let encode_pair (k, v) = (k, Js.Unsafe.coerce (encode v)) in
      table |> Hashtbl.to_seq |> Array.of_seq |> Array.map encode_pair
      |> Js.Unsafe.obj

    let object_ (props : (string * t) list) : t =
      let coerce (k, v) = (k, Js.Unsafe.coerce v) in
      Js.Unsafe.obj (Array.map coerce @@ Array.of_list props)
  end

  let t_of_js : Ojs.t -> t = Obj.magic

  let t_to_js : t -> Ojs.t = Obj.magic
end

type t = Es5.Json.t

let t_of_js = Es5.Json.t_of_js

let t_to_js = Es5.Json.t_to_js

let t_of_jsoo x = x |> Js.t_to_js |> Es5.Json.t_of_js

let t_to_jsoo x = x |> Es5.Json.t_to_js |> Js.t_of_js

let try_parse_opt s = Js.try_parse_opt s |> Option.map t_of_jsoo

let try_parse_exn s = Js.try_parse_exn s |> t_of_jsoo

let stringify ?spaces t = Js.stringify ?spaces (t_to_jsoo t)

module Decode = struct
  type 'a decoder = t -> 'a

  let decoder_of_js (decoder : 'a Js.Decode.decoder) : 'a decoder =
   fun y -> decoder (t_to_jsoo y)

  let decoder_to_js (decoder : 'a decoder) : 'a Js.Decode.decoder =
   fun x -> decoder (t_of_jsoo x)

  let id x = Js.Decode.id (t_to_jsoo x) |> t_of_jsoo

  let null x = Js.Decode.null (t_to_jsoo x) |> Js_of_ocaml.Js.Opt.to_option

  let bool x = Js.Decode.bool (t_to_jsoo x)

  let float x = Js.Decode.float (t_to_jsoo x)

  let int x = Js.Decode.int (t_to_jsoo x)

  let string x = Js.Decode.string (t_to_jsoo x)

  let char x = Js.Decode.char (t_to_jsoo x)

  let nullable fn x =
    let fn x = t_of_jsoo x |> fn in
    Js.Decode.nullable fn (t_to_jsoo x)

  let array fn x =
    let fn x = t_of_jsoo x |> fn in
    Js.Decode.array fn (t_to_jsoo x)

  let list fn x =
    let fn x = t_of_jsoo x |> fn in
    Js.Decode.list fn (t_to_jsoo x)

  let pair fn1 fn2 x =
    let fn1 x = t_of_jsoo x |> fn1 in
    let fn2 x = t_of_jsoo x |> fn2 in
    Js.Decode.pair fn1 fn2 (t_to_jsoo x)

  let tuple2 fn1 fn2 x =
    let fn1 x = t_of_jsoo x |> fn1 in
    let fn2 x = t_of_jsoo x |> fn2 in
    Js.Decode.tuple2 fn1 fn2 (t_to_jsoo x)

  let tuple3 fn1 fn2 fn3 x =
    let fn1 x = t_of_jsoo x |> fn1 in
    let fn2 x = t_of_jsoo x |> fn2 in
    let fn3 x = t_of_jsoo x |> fn3 in
    Js.Decode.tuple3 fn1 fn2 fn3 (t_to_jsoo x)

  let tuple4 fn1 fn2 fn3 fn4 x =
    let fn1 x = t_of_jsoo x |> fn1 in
    let fn2 x = t_of_jsoo x |> fn2 in
    let fn3 x = t_of_jsoo x |> fn3 in
    let fn4 x = t_of_jsoo x |> fn4 in
    Js.Decode.tuple4 fn1 fn2 fn3 fn4 (t_to_jsoo x)

  let dict fn x =
    let fn x = t_of_jsoo x |> fn in
    Js.Decode.dict fn (t_to_jsoo x)

  let field x fn =
    let fn x = t_of_jsoo x |> fn in
    decoder_of_js (Js.Decode.field x fn)

  let at x fn =
    let fn x = t_of_jsoo x |> fn in
    decoder_of_js (Js.Decode.at x fn)

  let try_optional fn =
    Js.Decode.try_optional (decoder_to_js fn) |> decoder_of_js

  let try_default x fn =
    Js.Decode.try_default x (decoder_to_js fn) |> decoder_of_js

  let any fns = List.map decoder_to_js fns |> Js.Decode.any |> decoder_of_js

  let either fn1 fn2 =
    Js.Decode.either (decoder_to_js fn1) (decoder_to_js fn2) |> decoder_of_js

  let map fn dec = Js.Decode.map fn (decoder_to_js dec) |> decoder_of_js

  let bind fn dec =
    let fn x = fn x |> decoder_to_js in
    Js.Decode.bind fn (decoder_to_js dec) |> decoder_of_js
end

module Encode = struct
  type 'a encoder = 'a -> t

  let id x = Js.Encode.id (t_to_jsoo x) |> t_of_jsoo

  let null = Js.Encode.null |> t_of_jsoo

  let bool x = Js.Encode.bool x |> t_of_jsoo

  let float x = Js.Encode.float x |> t_of_jsoo

  let int x = Js.Encode.int x |> t_of_jsoo

  let string x = Js.Encode.string x |> t_of_jsoo

  let char x = Js.Encode.char x |> t_of_jsoo

  let nullable fn x =
    let fn x = fn x |> t_to_jsoo in
    Js.Encode.nullable fn x |> t_of_jsoo

  let array fn x =
    let fn x = fn x |> t_to_jsoo in
    Js.Encode.array fn x |> t_of_jsoo

  let list fn x =
    let fn x = fn x |> t_to_jsoo in
    Js.Encode.list fn x |> t_of_jsoo

  let pair fn1 fn2 x =
    let fn1 x = fn1 x |> t_to_jsoo in
    let fn2 x = fn2 x |> t_to_jsoo in
    Js.Encode.pair fn1 fn2 x |> t_of_jsoo

  let tuple2 fn1 fn2 x =
    let fn1 x = fn1 x |> t_to_jsoo in
    let fn2 x = fn2 x |> t_to_jsoo in
    Js.Encode.tuple2 fn1 fn2 x |> t_of_jsoo

  let tuple3 fn1 fn2 fn3 x =
    let fn1 x = fn1 x |> t_to_jsoo in
    let fn2 x = fn2 x |> t_to_jsoo in
    let fn3 x = fn3 x |> t_to_jsoo in
    Js.Encode.tuple3 fn1 fn2 fn3 x |> t_of_jsoo

  let tuple4 fn1 fn2 fn3 fn4 x =
    let fn1 x = fn1 x |> t_to_jsoo in
    let fn2 x = fn2 x |> t_to_jsoo in
    let fn3 x = fn3 x |> t_to_jsoo in
    let fn4 x = fn4 x |> t_to_jsoo in
    Js.Encode.tuple4 fn1 fn2 fn3 fn4 x |> t_of_jsoo

  let dict fn x =
    let fn x = fn x |> t_to_jsoo in
    Js.Encode.dict fn x |> t_of_jsoo

  let object_ x =
    List.map (fun (a, b) -> (a, t_to_jsoo b)) x
    |> Js.Encode.object_ |> t_of_jsoo
end
