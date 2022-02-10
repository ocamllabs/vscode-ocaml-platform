open Import

type t = Polka.Server.t

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
  let (_ : Polka.Server.t) = Polka.Server.close t in
  ()
