open Import

type t =
  { server : Polka.Server.t
  ; port : int
  }

let start ~path ?(port = 0) () =
  Promise.make @@ fun ~resolve ~reject:_ ->
  let polka = Polka.create () in

  let timeout_ref = ref None in

  let timeout_middleware ~request:_ ~response:_ ~next =
    let () =
      Option.iter !timeout_ref ~f:Node.clearTimeout;
      timeout_ref :=
        Some
          (Node.setTimeout
             (fun () ->
               let (_ : Polka.Server.t) =
                 Polka.Server.close (Polka.server polka)
               in
               ())
             (* 10 minutes (in ms) *)
             (60 * 10 * 1000))
    in
    next ()
  in

  let serve =
    polka
    |> Polka.use
         [ timeout_middleware; Polka.Sirv.serve (path |> Path.to_string) ]
    |> Polka.listen port ~callback:(fun () ->
           let server = Polka.server polka in
           let address = Polka.Server.address server in
           let port = Polka.Server.Address.port address in
           resolve (Ok { server; port }))
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
