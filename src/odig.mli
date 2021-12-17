(** Provide an interface to Odig. *)

type t

val of_sandbox : Sandbox.t -> (t, string) result Promise.t

(** Generates the odoc API documentation and manual of [package_name]. Interface
    to the [odig odoc package_name] command *)
val odoc_exec : t -> package_name:string -> (string, string) result Promise.t

val html_dir : t -> (Path.t, string) result Promise.t
