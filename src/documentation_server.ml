open Import

type t = Polka.Server.t

(** [debouncing_middleware ~timeout_in_ms f] on every request schedules [f] to
    be run in [timeout_in_ms] milliseconds; on every new request the last
    scheduled timeout is overridden *)
let debouncing_middleware ~timeout_in_ms f =
  let timeout = ref None in
  Staged.stage (fun ~request:_ ~response:_ ~next ->
      (* on every request, we clear previous timeout and set a new one *)
      Option.iter !timeout ~f:Node.clearTimeout;
      timeout := Some (Node.setTimeout f timeout_in_ms);
      next ())

let start ~path ?(port = 0) () =
  Promise.make @@ fun ~resolve ~reject:_ ->
  let polka = Polka.create () in
  (* Closes the server after some idle time *)
  let debouncing_server_termination_mdlw =
    debouncing_middleware
      ~timeout_in_ms:(60 * 10 * 1000)
      (fun () ->
        ignore @@ (Polka.Server.close (Polka.server polka) : Polka.Server.t))
  in
  let options = Polka.Sirv.Options.create ~dev:true in
  let serve =
    polka
    |> Polka.use
         [ Staged.unstage debouncing_server_termination_mdlw
         ; Polka.Sirv.serve (path |> Path.to_string) ~options ()
         ]
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
