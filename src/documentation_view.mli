open Import

type t

val create : panel:WebviewPanel.t -> root:string -> extension_uri:Uri.t -> t
val root : t -> string
val is_disposed : t -> bool
val show : t -> path:string -> unit Promise.t
val dispose : t -> unit
