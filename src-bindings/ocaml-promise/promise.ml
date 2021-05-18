[@@@ocaml.warning "-32-34"]

module Js = struct
  open Js_of_ocaml

  type +'a promise

  type +'a t = 'a promise Js.t

  type error = Js_of_ocaml.Js.Unsafe.any

  let promise_constr = Js.Unsafe.global##._Promise

  let indirect_promise_constr = Js.Unsafe.global##._IndirectPromise

  let wrap (value : 'a) : 'a = indirect_promise_constr##wrap value

  let unwrap (value : 'a) : 'b = indirect_promise_constr##unwrap value

  let make (type a e) (f : resolve:(a -> unit) -> reject:(e -> unit) -> unit) :
      a t =
    let f_safe resolve reject =
      let resolve_safe value = resolve (wrap value) in
      f ~resolve:resolve_safe ~reject
    in
    Js.Unsafe.new_obj promise_constr
      [| Js.Unsafe.inject @@ Js.wrap_callback f_safe |]

  let resolve (value : 'a) : 'a t = promise_constr##resolve (wrap value)

  let reject (reason : 'e) : 'a t = promise_constr##reject reason

  let catch (type a) ~(rejected : error -> a t) (promise : a t) : a t =
    (Js.Unsafe.coerce promise)##catch (Js.wrap_callback rejected)

  let then_ (type a b) ~(fulfilled : a -> b t)
      ?(rejected : (error -> b t) option) (promise : a t) : b t =
    let fulfilled_safe value = fulfilled (unwrap value) in
    match rejected with
    | None ->
      (Js.Unsafe.coerce promise)##then_ (Js.wrap_callback fulfilled_safe)
    | Some rejected ->
      (Js.Unsafe.coerce promise)##then_
        (Js.wrap_callback fulfilled_safe)
        (Js.wrap_callback rejected)

  let finally (type a) ~(f : unit -> unit) (promise : a t) : a t =
    (Js.Unsafe.coerce promise)##finally (Js.wrap_callback f)

  let all (type a) (promises : a t array) : a array t =
    promise_constr##all (Js.array promises)
    |> then_ ~fulfilled:(fun value ->
           resolve (Array.map unwrap (Js.to_array value)))

  let all2 (type a b) ((p1 : a t), (p2 : b t)) : (a * b) t =
    promise_constr##all
      (Js.array [| Js.Unsafe.coerce p1; Js.Unsafe.coerce p2 |])
    |> then_ ~fulfilled:(fun value ->
           let arr = Js.to_array value in
           resolve (unwrap arr.(0), unwrap arr.(1)))

  let all3 (type a b c) ((p1 : a t), (p2 : b t), (p3 : c t)) : (a * b * c) t =
    promise_constr##all
      (Js.array
         [| Js.Unsafe.coerce p1; Js.Unsafe.coerce p2; Js.Unsafe.coerce p3 |])
    |> then_ ~fulfilled:(fun value ->
           let arr = Js.to_array value in
           resolve (unwrap arr.(0), unwrap arr.(1), unwrap arr.(2)))

  let all_list (promises : 'a t list) : 'a list t =
    all (Array.of_list promises)
    |> then_ ~fulfilled:(fun value -> resolve (Array.to_list value))

  let race (promises : 'a t array) : 'a t =
    promise_constr##race (Js.array promises)

  let race_list (promises : 'a t list) : 'a t = race (Array.of_list promises)

  let return = resolve

  let map f promise = then_ ~fulfilled:(fun value -> return (f value)) promise

  let bind f promise = then_ ~fulfilled:f promise

  module Syntax = struct
    let ( >>| ) x f = map f x

    let ( >>= ) x f = bind f x

    let ( let+ ) x f = map f x

    let ( let* ) x f = bind f x
  end

  module Array = struct
    let find_map (type a b) (f : a -> b option t) (arr : a array) : b option t =
      let len = Array.length arr in
      let rec loop i =
        if i = len then
          return None
        else
          let open Syntax in
          let* res = f arr.(i) in
          match res with
          | None -> loop (succ i)
          | Some _ as x -> return x
      in
      loop 0

    let filter_map (type a b) (f : a -> b option t) (arr : a array) : b array t
        =
      let open Syntax in
      let+ arr = all (Array.map f arr) in
      let filter_map = List.filter_map (fun x -> x) in
      Array.of_list (filter_map (Array.to_list arr))
  end

  module List = struct
    let rec find_map : 'a 'b. ('a -> 'b option t) -> 'a list -> 'b option t =
     fun f xs ->
      match xs with
      | [] -> return None
      | x :: xs -> (
        let open Syntax in
        let* res = f x in
        match res with
        | None -> find_map f xs
        | Some _ as x -> return x)

    let filter_map (type a b) (f : a -> b option t) (xs : a list) : b list t =
      let open Syntax in
      let+ xs = all_list (List.map f xs) in
      List.filter_map (fun x -> x) xs
  end

  module Option = struct
    let iter f =
      bind @@ function
      | Some x -> return (f x : unit)
      | None -> return ()

    let map f =
      bind @@ function
      | Some x -> return (Some (f x))
      | None -> return None

    let bind f =
      bind @@ function
      | Some x -> f x
      | None -> return None

    let return x = return (Some x)

    module Syntax = struct
      let ( >>| ) x f = map f x

      let ( >>= ) x f = bind f x

      let ( let+ ) x f = map f x

      let ( let* ) x f = bind f x
    end
  end

  module Result = struct
    let from_catch promise =
      let fulfilled value = return (Ok value) in
      let rejected reason = return (Error reason) in
      promise |> then_ ~fulfilled ~rejected

    let iter ?(ok = ignore) ?(error = ignore) =
      bind @@ function
      | Ok o -> return (ok o)
      | Error e -> return (error e)

    let map f =
      bind @@ function
      | Ok o -> return (Ok (f o))
      | Error e -> return (Error e)

    let bind f =
      bind @@ function
      | Ok o -> f o
      | Error e -> return (Error e)

    let return x = return (Ok x)

    module Syntax = struct
      let ( >>| ) x f = map f x

      let ( >>= ) x f = bind f x

      let ( let+ ) x f = map f x

      let ( let* ) x f = bind f x
    end
  end

  let t_to_js (to_js : 'a -> Ojs.t) (promise : 'a t) : Ojs.t =
    Obj.magic (map to_js promise)

  let t_of_js (of_js : Ojs.t -> 'a) (promise : Ojs.t) : 'a t =
    map of_js (Obj.magic promise : Ojs.t t)

  type void = unit t

  let void_to_js = t_to_js (fun () -> Ojs.variable "undefined")

  let void_of_js = t_of_js (fun (_ : Ojs.t) -> ())

  let error_to_js : error -> Ojs.t = Obj.magic

  let error_of_js : Ojs.t -> error = Obj.magic
end

type 'a t = 'a Es5.Promise.t

type error = Es5.any

let t_of_jsoo (x : 'a Js.t) : 'a t = Obj.magic x

let t_to_jsoo (x : 'a t) : 'a Js.t = Obj.magic x

let return x = t_of_jsoo @@ Js.return x

let resolve x = t_of_jsoo @@ Js.resolve x

let reject x = t_of_jsoo @@ Js.reject x

let race_list x = t_of_jsoo @@ Js.race_list (List.map t_to_jsoo x)

let race x = t_of_jsoo @@ Js.race (Array.map t_to_jsoo x)

let all_list x = t_of_jsoo @@ Js.all_list (List.map t_to_jsoo x)

let all3 (p1, p2, p3) =
  t_of_jsoo @@ Js.all3 (t_to_jsoo p1, t_to_jsoo p2, t_to_jsoo p3)

let all2 (p1, p2) = t_of_jsoo @@ Js.all2 (t_to_jsoo p1, t_to_jsoo p2)

let all x = t_of_jsoo @@ Js.all (Array.map t_to_jsoo x)

let finally ~f x = t_of_jsoo @@ Js.finally ~f (t_to_jsoo x)

let then_ ~fulfilled ?rejected x =
  let fulfilled x = fulfilled x |> t_to_jsoo in
  let rejected =
    match rejected with
    | None -> None
    | Some f -> Some (fun (x : Js.error) -> f (Js.error_to_js x) |> t_to_jsoo)
  in
  t_of_jsoo @@ Js.then_ ~fulfilled ?rejected (t_to_jsoo x)

let catch ~rejected x =
  let rejected (x : Js.error) = rejected (Js.error_to_js x) |> t_to_jsoo in
  t_of_jsoo @@ Js.catch ~rejected (t_to_jsoo x)

let make x = t_of_jsoo @@ Js.make x

let map f promise = t_of_jsoo @@ Js.map f (t_to_jsoo promise)

let bind f promise =
  let f x = f x |> t_to_jsoo in
  t_of_jsoo @@ Js.then_ ~fulfilled:f (t_to_jsoo promise)

module Syntax = struct
  let ( >>| ) x f = map f x

  let ( >>= ) x f = bind f x

  let ( let+ ) x f = map f x

  let ( let* ) x f = bind f x
end

module Array = struct
  let find_map f arr =
    let f x = f x |> t_to_jsoo in
    Js.Array.find_map f arr |> t_of_jsoo

  let filter_map f arr =
    let f x = f x |> t_to_jsoo in
    Js.Array.filter_map f arr |> t_of_jsoo
end

module List = struct
  let find_map f xs =
    let f x = f x |> t_to_jsoo in
    Js.List.find_map f xs |> t_of_jsoo

  let filter_map f xs =
    let f x = f x |> t_to_jsoo in
    Js.List.filter_map f xs |> t_of_jsoo
end

module Option = struct
  let iter f x = Js.Option.iter f (t_to_jsoo x) |> t_of_jsoo

  let map f x = Js.Option.map f (t_to_jsoo x) |> t_of_jsoo

  let bind f x =
    let f x = f x |> t_to_jsoo in
    Js.Option.bind f (t_to_jsoo x) |> t_of_jsoo

  let return x = Js.Option.return x |> t_of_jsoo

  module Syntax = struct
    let ( >>| ) x f = map f x

    let ( >>= ) x f = bind f x

    let ( let+ ) x f = map f x

    let ( let* ) x f = bind f x
  end
end

module Result = struct
  let result_of_jsoo (x : ('a, 'b) result Js.t) : ('a, 'c) result t =
    Js.map (fun x -> Result.map_error Obj.magic x) x |> t_of_jsoo

  let result_to_jsoo (x : ('a, 'b) result t) : ('a, 'c) result Js.t =
    map (fun x -> Result.map_error Obj.magic x) x |> t_to_jsoo

  let from_catch promise =
    Js.Result.from_catch (t_to_jsoo promise) |> result_of_jsoo

  let iter ?ok ?error promise =
    Js.Result.iter ?ok ?error (result_to_jsoo promise) |> t_of_jsoo

  let map f x = Js.Result.map f (result_to_jsoo x) |> result_of_jsoo

  let bind f x =
    let f x = f x |> result_to_jsoo in
    Js.Result.bind f (result_to_jsoo x) |> result_of_jsoo

  let return x = Js.Result.return x |> result_of_jsoo

  module Syntax = struct
    let ( >>| ) x f = map f x

    let ( >>= ) x f = bind f x

    let ( let+ ) x f = map f x

    let ( let* ) x f = bind f x
  end
end

let t_to_js = Es5.Promise.t_to_js

let t_of_js = Es5.Promise.t_of_js

type void = unit t

let void_to_js = t_to_js (fun () -> Ojs.variable "undefined")

let void_of_js = t_of_js (fun (_ : Ojs.t) -> ())

let error_to_js : error -> Ojs.t = Obj.magic

let error_of_js : Ojs.t -> error = Obj.magic
