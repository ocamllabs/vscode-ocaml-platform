type t

val start : path:Path.t -> (t, Node.JsError.t) result Promise.t

val port : t -> int

val stop : t -> (unit, Promise.error) result Promise.t

val on_close : t -> f:(unit -> unit) -> unit
