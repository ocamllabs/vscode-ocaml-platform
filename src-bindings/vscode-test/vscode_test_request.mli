[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es5

val get_stream : api:string -> Node.Http.Incoming_message.t Promise.t
  [@@js.global "getStream"]

val get_json : api:string -> 'T Promise.t [@@js.global "getJSON"]
