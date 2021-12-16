type t

val start : port:int -> path:Path.t -> (t, Node.JsError.t) result Promise.t

val port : t -> int

val stop : t -> unit

val on_close : t -> f:(unit -> unit) -> unit
