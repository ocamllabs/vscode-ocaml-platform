module Rimraf : sig
  type t

  (* Bindinds for https://www.npmjs.com/package/rimraf. rimraf is a
     cross-platform utility library to delete a directory and all its contens *)

  val run : string -> (unit, unit) result Js.Promise.t
end = struct
  type t

  external run' : string -> ('a Js.Nullable.t -> unit) -> unit = "rimraf"
    [@@bs.module]

  let run p =
    Js.Promise.make (fun ~resolve ~reject:_ ->
        run' p (fun err ->
            match Js.Nullable.toOption err with
            | Some _ -> ( resolve (Error ()) [@bs] )
            | None -> ( resolve (Ok ()) [@bs] )))
end
