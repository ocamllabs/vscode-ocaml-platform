type 'a or_undefined = 'a option

type 'a maybe_list = 'a list

let undefined = Ojs.variable "undefined"

let or_undefined_of_js ml_of_js js_val =
  if js_val != undefined && js_val != Ojs.null then
    Some (ml_of_js js_val)
  else
    None

let or_undefined_to_js ml_to_js = function
  | Some ml_val -> ml_to_js ml_val
  | None -> undefined

let maybe_list_of_js ml_of_js js_val =
  if js_val != undefined && js_val != Ojs.null then
    Ojs.list_of_js ml_of_js js_val
  else
    []

let maybe_list_to_js ml_to_js = function
  | [] -> undefined
  | xs -> Ojs.list_to_js ml_to_js xs

let iter_set obj field f value =
  Option.iter (fun value -> Ojs.set obj field (f value)) value

module Regexp = struct
  type t = Js_of_ocaml.Regexp.regexp

  let t_to_js : Js_of_ocaml.Regexp.regexp -> Ojs.t = Obj.magic

  let t_of_js : Ojs.t -> Js_of_ocaml.Regexp.regexp = Obj.magic
end

module Dict = struct
  open Core_kernel

  type 'a t = (string, 'a) Hashtbl.t

  let t_to_js to_js tbl =
    let obj = Ojs.empty_obj () in
    let set ~key ~data = Ojs.set obj key (to_js data) in
    Hashtbl.iteri tbl ~f:set;
    obj

  let t_of_js of_js obj =
    let count = ref 0 in
    Ojs.iter_properties obj (fun (_ : string) -> count := !count + 1);
    let tbl = Hashtbl.Poly.create () in
    let set key =
      let data = of_js (Ojs.get obj key) in
      Hashtbl.add_exn tbl ~key ~data
    in
    Ojs.iter_properties obj set;
    tbl
end
