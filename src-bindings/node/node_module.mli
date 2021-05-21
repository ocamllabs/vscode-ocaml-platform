[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

open Es2020
open Node_globals

module Module : sig
  module Module : sig
    module Source_map_payload : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val get_file : t -> string [@@js.get "file"]

      val set_file : t -> string -> unit [@@js.set "file"]

      val get_version : t -> int [@@js.get "version"]

      val set_version : t -> int -> unit [@@js.set "version"]

      val get_sources : t -> string list [@@js.get "sources"]

      val set_sources : t -> string list -> unit [@@js.set "sources"]

      val get_sources_content : t -> string list [@@js.get "sourcesContent"]

      val set_sources_content : t -> string list -> unit
        [@@js.set "sourcesContent"]

      val get_names : t -> string list [@@js.get "names"]

      val set_names : t -> string list -> unit [@@js.set "names"]

      val get_mappings : t -> string [@@js.get "mappings"]

      val set_mappings : t -> string -> unit [@@js.set "mappings"]

      val get_source_root : t -> string [@@js.get "sourceRoot"]

      val set_source_root : t -> string -> unit [@@js.set "sourceRoot"]
    end
    [@@js.scope "SourceMapPayload"]

    module Source_mapping : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val get_generated_line : t -> int [@@js.get "generatedLine"]

      val set_generated_line : t -> int -> unit [@@js.set "generatedLine"]

      val get_generated_column : t -> int [@@js.get "generatedColumn"]

      val set_generated_column : t -> int -> unit [@@js.set "generatedColumn"]

      val get_original_source : t -> string [@@js.get "originalSource"]

      val set_original_source : t -> string -> unit [@@js.set "originalSource"]

      val get_original_line : t -> int [@@js.get "originalLine"]

      val set_original_line : t -> int -> unit [@@js.set "originalLine"]

      val get_original_column : t -> int [@@js.get "originalColumn"]

      val set_original_column : t -> int -> unit [@@js.set "originalColumn"]
    end
    [@@js.scope "SourceMapping"]

    module Source_map : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val get_payload : t -> Source_map_payload.t [@@js.get "payload"]

      val create : payload:Source_map_payload.t -> t [@@js.create]

      val find_entry : t -> line:int -> column:int -> Source_mapping.t
        [@@js.call "findEntry"]
    end
    [@@js.scope "SourceMap"]

    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val run_main : unit -> unit [@@js.global "runMain"]

    val wrap : code:string -> string [@@js.global "wrap"]

    val create_require_from_path : path:string -> Node_require.t
      [@@js.global "createRequireFromPath"]

    val create_require : path:Node_url.Url.Url.t or_string -> Node_require.t
      [@@js.global "createRequire"]

    val get_builtin_modules : unit -> string list [@@js.get "builtinModules"]

    val set_builtin_modules : string list -> unit [@@js.set "builtinModules"]

    val get_module : unit -> (* FIXME: unknown type 'typeof Module' *) any
      [@@js.get "Module"]

    val set_module : (* FIXME: unknown type 'typeof Module' *) any -> unit
      [@@js.set "Module"]

    val create : id:string -> ?parent:t -> unit -> t [@@js.create]

    val sync_builtin_esm_exports : unit -> unit
      [@@js.global "syncBuiltinESMExports"]

    val find_source_map : path:string -> ?error:Error.t -> unit -> Source_map.t
      [@@js.global "findSourceMap"]
  end
  [@@js.scope "Module"]
end
[@@js.scope Import.module_]
