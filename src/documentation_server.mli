type t

val start : path:Path.t -> (t, Node.JsError.t) result Promise.t

val port : t -> int

val host : t -> string

val dispose : t -> Vscode.Disposable.t
