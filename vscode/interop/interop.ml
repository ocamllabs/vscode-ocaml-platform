let iter_set obj field f = function
  | Some value -> Ojs.set obj field (f value)
  | None -> ()

let undefined = Ojs.variable "undefined"

type 'a or_undefined = 'a option

let or_undefined_of_js ml_of_js js_val =
  if js_val != undefined && js_val != Ojs.null then
    Some (ml_of_js js_val)
  else
    None

let or_undefined_to_js ml_to_js = function
  | Some ml_val -> ml_to_js ml_val
  | None -> undefined

type 'a maybe_list = 'a list

let maybe_list_of_js ml_of_js js_val =
  if js_val != undefined && js_val != Ojs.null then
    Ojs.list_of_js ml_of_js js_val
  else
    []

let maybe_list_to_js ml_to_js = function
  | [] -> undefined
  | xs -> Ojs.list_to_js ml_to_js xs

module Regexp = struct
  type t = Js_of_ocaml.Regexp.regexp

  let t_of_js : Ojs.t -> Js_of_ocaml.Regexp.regexp = Obj.magic

  let t_to_js : Js_of_ocaml.Regexp.regexp -> Ojs.t = Obj.magic

  val replace :
       string
    -> regexp:t
    -> replacer:(string -> (Ojs.t list[@js.variadic]) -> string)
    -> string
    [@@js.call]

  type replacer =
       matched:string
    -> captures:string list
    -> offset:int
    -> string:string
    -> string

  let replace s ~regexp ~replacer =
    let rec separate acc = function
      | offset :: string :: _ when Ojs.type_of offset = "number" ->
        (List.rev acc, [%js.to: int] offset, [%js.to: string] string)
      | capture :: args -> separate ([%js.to: string] capture :: acc) args
      | _ -> assert false
      (* replacer arguments will always be terminated with a numeric offset and
         final string *)
    in
    let js_replacer matched args =
      let captures, offset, string = separate [] args in
      replacer ~matched ~captures ~offset ~string
    in
    replace s ~regexp ~replacer:js_replacer
end

module Dict = struct
  module StringMap = Map.Make (String)

  let t_of_js value_of_js js_obj =
    let ml_map = ref StringMap.empty in
    let iter key =
      let value = value_of_js (Ojs.get js_obj key) in
      ml_map := StringMap.add key value !ml_map
    in
    Ojs.iter_properties js_obj iter;
    !ml_map

  let t_to_js value_to_js ml_map =
    let to_js (k, v) = (k, value_to_js v) in
    StringMap.to_seq ml_map |> Seq.map to_js |> Array.of_seq |> Ojs.obj

  let of_alist alist = StringMap.of_seq (List.to_seq alist)

  include StringMap
end

module Js = struct
  module type T = sig
    type t

    val t_of_js : Ojs.t -> t

    val t_to_js : t -> Ojs.t
  end

  type 'a t = (module T with type t = 'a)

  module Any = struct
    type t = Ojs.t [@@js]
  end

  module Unit = struct
    type t = unit

    let t_of_js _ = ()

    let t_to_js _ = undefined
  end

  module Bool = struct
    type t = bool [@@js]
  end

  module Int = struct
    type t = int [@@js]
  end

  module String = struct
    type t = string [@@js]
  end

  module Option (T : T) = struct
    type t = T.t option [@@js]
  end

  module Result (Ok : T) (Error : T) = struct
    type t = (Ok.t, Error.t) result

    type js_result =
      { case : string
      ; ok : Ojs.t
      ; error : Ojs.t
      }
    [@@js]

    let t_of_js js_val =
      match js_result_of_js js_val with
      | { case = "ok"; ok; _ } -> Ok ([%js.to: Ok.t] ok)
      | { case = "error"; error; _ } -> Error ([%js.to: Error.t] error)
      | _ -> assert false

    let t_to_js = function
      | Ok ok ->
        let ok = [%js.of: Ok.t] ok in
        js_result_to_js { case = "ok"; ok; error = undefined }
      | Error error ->
        let error = [%js.of: Error.t] error in
        js_result_to_js { case = "error"; error; ok = undefined }
  end

  module Or_undefined (T : T) = struct
    type t = T.t or_undefined [@@js]
  end

  module List (T : T) = struct
    type t = T.t list [@@js]
  end

  module Dict (T : T) = struct
    type t = T.t Dict.t [@@js]
  end
end

module Interface = struct
  module Make () = struct
    type t = private Ojs.t [@@js]
  end

  module Extend (Super : Js.T) () = struct
    type t = private Super.t [@@js]
  end

  module Generic (Super : Js.T) () = struct
    type 'a t = Super.t

    type 'a generic = 'a t

    let generic_of_js _ = Super.t_of_js

    let generic_to_js _ = Super.t_to_js
  end
end

module Class = Interface
