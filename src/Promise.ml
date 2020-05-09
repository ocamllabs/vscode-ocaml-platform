include Js.Promise

let map f promise = promise |> then_ (fun x -> resolve (f x))

let return = resolve

module O = struct
  let ( >>| ) x f = map f x

  let ( >>= ) x f = then_ f x
end

module Array = struct
  let findMap (type a b) (f : a -> b option t) (arr : a array) : b option t =
    let open O in
    Array.map f arr |> Js.Promise.all
    |> map (fun arr ->
           match
             Js.Array.find
               (function
                 | Some _ -> true
                 | None -> false)
               arr
           with
           | None -> None
           | Some (Some _ as x) -> x
           | Some None -> assert false)

  let filterMap (type a b) (f : a -> b option t) (a : a array) : b array t =
    let open O in
    Array.map f a |> Js.Promise.all >>| fun a ->
    Belt.Array.keepMap a (fun x -> x)
end

module Result = struct
  let bind fn promise =
    let open Js.Promise in
    promise
    |> then_ (function
         | Error e -> Error e |> resolve
         | Ok payload -> fn payload)

  let map f x =
    x
    |> then_ (fun x ->
           resolve
             ( match x with
             | Error _ as e -> e
             | Ok x -> Ok (f x) ))

  let return x = return (Ok x)

  module O = struct
    let ( >>= ) x f = bind f x

    let ( >>| ) x f = map f x
  end
end
