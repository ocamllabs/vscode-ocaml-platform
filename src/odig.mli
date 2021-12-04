type t

val of_sandbox : Sandbox.t -> (t, string) result Promise.t

val odoc_exec : t -> package_name:string -> (string, string) result Promise.t

val html_dir : t -> (Path.t, string) result Promise.t
