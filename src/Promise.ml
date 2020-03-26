include Js.Promise

let mapOk fn promise =
  let open Js.Promise in
  promise
  |> then_ (function
       | Error e -> Error e |> resolve
       | Ok payload -> fn payload)

let map f promise = promise |> then_ (fun x -> resolve (f x))
