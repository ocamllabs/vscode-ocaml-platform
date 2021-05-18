[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Wasi : sig
  module Wasi_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get_args : t -> string list [@@js.get "args"]

    val set_args : t -> string list -> unit [@@js.set "args"]

    val get_env : t -> untyped_object [@@js.get "env"]

    val set_env : t -> untyped_object -> unit [@@js.set "env"]

    val get_preopens : t -> string Dict.t [@@js.get "preopens"]

    val set_preopens : t -> string Dict.t -> unit [@@js.set "preopens"]

    val get_return_on_exit : t -> bool [@@js.get "returnOnExit"]

    val set_return_on_exit : t -> bool -> unit [@@js.set "returnOnExit"]

    val get_stdin : t -> int [@@js.get "stdin"]

    val set_stdin : t -> int -> unit [@@js.set "stdin"]

    val get_stdout : t -> int [@@js.get "stdout"]

    val set_stdout : t -> int -> unit [@@js.set "stdout"]

    val get_stderr : t -> int [@@js.get "stderr"]

    val set_stderr : t -> int -> unit [@@js.set "stderr"]
  end
  [@@js.scope "WASIOptions"]

  module Wasi : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create : ?options:Wasi_options.t -> unit -> t [@@js.create]

    val start : t -> instance:untyped_object -> unit [@@js.call "start"]

    val initialize : t -> instance:untyped_object -> unit
      [@@js.call "initialize"]

    val get_wasi_import : t -> any Dict.t [@@js.get "wasiImport"]
  end
  [@@js.scope "WASI"]
end
[@@js.scope Import.wasi]
