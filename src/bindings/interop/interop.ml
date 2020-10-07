let iter_set obj field f value =
  Option.iter (fun value -> Ojs.set obj field (f value)) value

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

  let t_to_js : Js_of_ocaml.Regexp.regexp -> Ojs.t = Obj.magic

  let t_of_js : Ojs.t -> Js_of_ocaml.Regexp.regexp = Obj.magic
end

module JsDict = struct
  open Core_kernel

  type 'a t = (string, 'a) Map.Poly.t

  let t_to_js to_js m =
    let obj = Ojs.empty_obj () in
    let set ~key ~data = Ojs.set obj key (to_js data) in
    Map.iteri ~f:set m;
    obj

  let t_of_js of_js obj =
    let iteri ~f =
      Ojs.iter_properties obj (fun key ->
          let data = of_js (Ojs.get obj key) in
          f ~key ~data)
    in
    match Map.Poly.of_iteri ~iteri with
    | `Ok m -> m
    | `Duplicate_key _ -> assert false
end
