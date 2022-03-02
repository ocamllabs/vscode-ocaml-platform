open Import

type t = Polka.Server.t

let start ~path =
  Promise.make @@ fun ~resolve ~reject:_ ->
  let polka = Polka.create () in
  let options = Polka.Sirv.Options.create ~dev:true in
  let serve =
    polka
    |> Polka.use [ Polka.Sirv.serve (path |> Path.to_string) ~options () ]
    |> Polka.listen 0 ~callback:(fun () ->
           let server = Polka.server polka in
           resolve (Ok server))
  in
  let polka = serve () in
  let server = Polka.server polka in
  Polka.Server.on server (`Error (fun ~err -> resolve (Error err)))

let port t =
  match Polka.Server.address t with
  | None ->
    (* if it's [None], server must not be listening, but we aim to have server
       only if it's listening *)
    assert false
  | Some a -> Polka.Server.Address.port a

let on_close t ~f = Polka.Server.on t (`Close f)

let stop t =
  Promise.make @@ fun ~resolve ~reject:_ ->
  let (_ : Polka.Server.t) =
    Polka.Server.close t
      ~callback:(fun error ->
        match error with
        | None -> resolve (Ok ())
        | Some error -> resolve (Error error))
      ()
  in
  ()
