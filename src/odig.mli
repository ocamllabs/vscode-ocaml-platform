type t

type of_sandbox_error =
  | Not_supported_sandbox
  | Odig_not_installed

val of_sandbox : Sandbox.t -> (t, of_sandbox_error) result Promise.t

val odoc_exec : t -> string -> (string, string) result Promise.t

val cache_dir : t -> Path.t Promise.t

val html_dir : t -> Path.t Promise.t
