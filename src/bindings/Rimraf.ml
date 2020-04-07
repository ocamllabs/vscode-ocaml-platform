type t

external run' : string -> ('a Js.Nullable.t -> unit) -> unit = "rimraf"
  [@@bs.module]

let run p =
  Promise.make (fun ~resolve ~reject:_ ->
      run' p (fun err ->
          match Js.Nullable.toOption err with
          | Some _ -> ( resolve (Error ()) [@bs] )
          | None -> ( resolve (Ok ()) [@bs] )))
