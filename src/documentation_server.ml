open Import

type t =
  { server : Polka.Server.t
  ; port : int
  }

let start ~port ~path =
  Promise.make @@ fun ~resolve ~reject:_ ->
  let polka = Polka.create () in
  let serve =
    polka
    |> Polka.use [ Polka.Sirv.serve (path |> Path.to_string) ]
    |> Polka.listen port ~callback:(fun () ->
           resolve (Ok { server = Polka.server polka; port }))
  in
  let polka = serve () in
  let server = Polka.server polka in
  let () = Polka.Server.on server (`Error (fun ~err -> resolve (Error err))) in
  ()

let port t = t.port

let on_close t ~f = Polka.Server.on t.server (`Close f)

let stop t =
  let (_ : Polka.Server.t) = Polka.Server.close t.server in
  ()
