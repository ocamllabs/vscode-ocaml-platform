open Import

type t' =
  { server : Polka.Server.t
  ; path : Path.t
  }

type t = t' option ref

let start ~path =
  Promise.make @@ fun ~resolve ~reject:_ ->
  let polka = Polka.create () in
  let options = Polka.Sirv.Options.create ~dev:true in
  let serve =
    polka
    |> Polka.use [ Polka.Sirv.serve (path |> Path.to_string) ~options () ]
    |> Polka.listen 0 ~callback:(fun () ->
           let server = Polka.server polka in
           resolve (Ok (ref (Some { server; path }))))
  in
  let polka = serve () in
  let server = Polka.server polka in
  Polka.Server.on server (`Error (fun ~err -> resolve (Error err)))

let get (t : t) =
  match !t with
  | None -> failwith "document server: already disposed"
  | Some t -> t

let path (t : t) = (get t).path

let port t =
  match Polka.Server.address (get t).server with
  | None ->
    (* if it's [None], server must not be listening, but we aim to have server
       only if it's listening *)
    assert false
  | Some a -> Polka.Server.Address.port a

(* TODO extract this from the server somehow *)
let host t =
  ignore (get t : t');
  "localhost"

let dispose (t : t) =
  match !t with
  | None -> Disposable.make ~dispose:(fun () -> ())
  | Some server ->
    t := None;
    Disposable.make ~dispose:(fun () ->
        let (_ : Polka.Server.t) =
          Polka.Server.close server.server
            ~callback:(fun error ->
              match error with
              | None -> ()
              | Some error ->
                show_message `Warn "Error closing server: %s"
                  (Ojs.string_of_js (Promise.error_to_js error)))
            ()
        in
        ())
