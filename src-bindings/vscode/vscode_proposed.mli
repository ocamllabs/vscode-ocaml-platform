[@@@ocaml.warning "-7-11-32-33-39"]

[@@@js.implem [@@@ocaml.warning "-7-11-32-33-39"]]

[@@@js.scope "__LIB__VSCODE__IMPORTS"]

open Es2015
open Vscode

module Vscode : sig
  module Anonymous_interface16 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get : t -> string -> any [@@js.index_get]

    val set : t -> string -> any -> unit [@@js.index_set]
  end

  module Anonymous_interface8 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val include_ : t -> Glob_pattern.t [@@js.get "include"]

    val set_include : t -> Glob_pattern.t -> unit [@@js.set "include"]

    val exclude : t -> Glob_pattern.t [@@js.get "exclude"]

    val set_exclude : t -> Glob_pattern.t -> unit [@@js.set "exclude"]
  end

  module Notebook_filename_pattern : sig
    type t = (Glob_pattern.t, Anonymous_interface8.t) union2

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Anonymous_interface6 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val editable : t -> bool or_null [@@js.get "editable"]

    val set_editable : t -> bool or_null -> unit [@@js.set "editable"]

    val cell_editable : t -> bool or_null [@@js.get "cellEditable"]

    val set_cell_editable : t -> bool or_null -> unit [@@js.set "cellEditable"]

    val custom : t -> Anonymous_interface16.t or_null [@@js.get "custom"]

    val set_custom : t -> Anonymous_interface16.t or_null -> unit
      [@@js.set "custom"]

    val trusted : t -> bool or_null [@@js.get "trusted"]

    val set_trusted : t -> bool or_null -> unit [@@js.set "trusted"]
  end

  module Notebook_document_metadata : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val editable : t -> bool [@@js.get "editable"]

    val cell_editable : t -> bool [@@js.get "cellEditable"]

    val custom : t -> Anonymous_interface16.t [@@js.get "custom"]

    val trusted : t -> bool [@@js.get "trusted"]

    val create :
         ?editable:bool
      -> ?cell_editable:bool
      -> ?custom:Anonymous_interface16.t
      -> ?trusted:bool
      -> unit
      -> t
      [@@js.create]

    val with_ : t -> change:Anonymous_interface6.t -> t [@@js.call "with"]
  end
  [@@js.scope "NotebookDocumentMetadata"]

  module Anonymous_interface13 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val start : t -> int [@@js.get "start"]

    val set_start : t -> int -> unit [@@js.set "start"]

    val end_ : t -> int [@@js.get "end"]

    val set_end : t -> int -> unit [@@js.set "end"]
  end

  module Notebook_cell_range : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val start : t -> int [@@js.get "start"]

    val end_ : t -> int [@@js.get "end"]

    val is_empty : t -> bool [@@js.get "isEmpty"]

    val create : start:int -> end_:int -> t [@@js.create]

    val with_ : t -> change:Anonymous_interface13.t -> t [@@js.call "with"]
  end
  [@@js.scope "NotebookCellRange"]

  module Notebook_cell_output_item : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val mime : t -> string [@@js.get "mime"]

    val value : t -> unknown [@@js.get "value"]

    val metadata : t -> (string, any) Record.t [@@js.get "metadata"]

    val create :
         mime:string
      -> value:unknown
      -> ?metadata:(string, any) Record.t
      -> unit
      -> t
      [@@js.create]
  end
  [@@js.scope "NotebookCellOutputItem"]

  module Notebook_cell_output : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val outputs : t -> Notebook_cell_output_item.t list [@@js.get "outputs"]

    val metadata : t -> (string, any) Record.t [@@js.get "metadata"]

    val create :
         outputs:Notebook_cell_output_item.t list
      -> ?metadata:(string, any) Record.t
      -> unit
      -> t
      [@@js.create]

    val create' :
         outputs:Notebook_cell_output_item.t list
      -> id:string
      -> ?metadata:(string, any) Record.t
      -> unit
      -> t
      [@@js.create]
  end
  [@@js.scope "NotebookCellOutput"]

  module Notebook_cell_kind : sig
    type t =
      ([ `Markdown [@js 1]
       | `Code [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Anonymous_interface5 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val editable : t -> bool or_null [@@js.get "editable"]

    val set_editable : t -> bool or_null -> unit [@@js.set "editable"]

    val breakpoint_margin : t -> bool or_null [@@js.get "breakpointMargin"]

    val set_breakpoint_margin : t -> bool or_null -> unit
      [@@js.set "breakpointMargin"]

    val status_message : t -> string or_null [@@js.get "statusMessage"]

    val set_status_message : t -> string or_null -> unit
      [@@js.set "statusMessage"]

    val last_run_duration : t -> int or_null [@@js.get "lastRunDuration"]

    val set_last_run_duration : t -> int or_null -> unit
      [@@js.set "lastRunDuration"]

    val input_collapsed : t -> bool or_null [@@js.get "inputCollapsed"]

    val set_input_collapsed : t -> bool or_null -> unit
      [@@js.set "inputCollapsed"]

    val output_collapsed : t -> bool or_null [@@js.get "outputCollapsed"]

    val set_output_collapsed : t -> bool or_null -> unit
      [@@js.set "outputCollapsed"]

    val custom : t -> (string, any) Record.t or_null [@@js.get "custom"]

    val set_custom : t -> (string, any) Record.t or_null -> unit
      [@@js.set "custom"]
  end

  module Notebook_cell_metadata : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val editable : t -> bool [@@js.get "editable"]

    val breakpoint_margin : t -> bool [@@js.get "breakpointMargin"]

    val output_collapsed : t -> bool [@@js.get "outputCollapsed"]

    val input_collapsed : t -> bool [@@js.get "inputCollapsed"]

    val custom : t -> (string, any) Record.t [@@js.get "custom"]

    val status_message : t -> string [@@js.get "statusMessage"]

    val create :
         ?editable:bool
      -> ?breakpoint_margin:bool
      -> ?status_message:string
      -> ?last_run_duration:int
      -> ?input_collapsed:bool
      -> ?output_collapsed:bool
      -> ?custom:(string, any) Record.t
      -> unit
      -> t
      [@@js.create]

    val with_ : t -> change:Anonymous_interface5.t -> t [@@js.call "with"]
  end
  [@@js.scope "NotebookCellMetadata"]

  module Notebook_cell_execution_summary : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val execution_order : t -> int [@@js.get "executionOrder"]

    val set_execution_order : t -> int -> unit [@@js.set "executionOrder"]

    val success : t -> bool [@@js.get "success"]

    val set_success : t -> bool -> unit [@@js.set "success"]

    val duration : t -> int [@@js.get "duration"]

    val set_duration : t -> int -> unit [@@js.set "duration"]
  end
  [@@js.scope "NotebookCellExecutionSummary"]

  module Notebook_cell : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val index : t -> int [@@js.get "index"]

    (* val notebook : t -> Notebook_document.t [@@js.get "notebook"] *)

    val kind : t -> Notebook_cell_kind.t [@@js.get "kind"]

    val document : t -> Text_document.t [@@js.get "document"]

    val metadata : t -> Notebook_cell_metadata.t [@@js.get "metadata"]

    val outputs : t -> Notebook_cell_output.t list [@@js.get "outputs"]

    val latest_execution_summary :
      t -> Notebook_cell_execution_summary.t or_undefined
      [@@js.get "latestExecutionSummary"]
  end
  [@@js.scope "NotebookCell"]

  module Notebook_document : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val uri : t -> Uri.t [@@js.get "uri"]

    val version : t -> int [@@js.get "version"]

    val file_name : t -> string [@@js.get "fileName"]

    val is_dirty : t -> bool [@@js.get "isDirty"]

    val is_untitled : t -> bool [@@js.get "isUntitled"]

    val is_closed : t -> bool [@@js.get "isClosed"]

    val metadata : t -> Notebook_document_metadata.t [@@js.get "metadata"]

    val view_type : t -> string [@@js.get "viewType"]

    val cell_count : t -> int [@@js.get "cellCount"]

    val cell_at : t -> index:int -> Notebook_cell.t [@@js.call "cellAt"]

    val get_cells :
      t -> ?range:Notebook_cell_range.t -> unit -> Notebook_cell.t list
      [@@js.call "getCells"]

    val save : t -> bool Promise.t [@@js.call "save"]
  end
  [@@js.scope "NotebookDocument"]

  module Notebook_document_content_options : sig
    module Transient_metadata : sig
      type t

      val t_to_js : t -> Ojs.t

      val t_of_js : Ojs.t -> t

      val create :
           ?editable:bool
        -> ?cell_editable:bool
        -> ?custom:bool
        -> ?trusted:bool
        -> ?runnable:bool
        -> unit
        -> t
        [@@js.builder]
    end

    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val transient_outputs : t -> bool [@@js.get "transientOutputs"]

    val set_transient_outputs : t -> bool -> unit [@@js.set "transientOutputs"]

    val transient_metadata : t -> Transient_metadata.t
      [@@js.get "transientMetadata"]

    val set_transient_metadata : t -> Transient_metadata.t -> unit
      [@@js.set "transientMetadata"]

    val create :
         ?transient_outputs:bool
      -> ?transient_metadata:Transient_metadata.t
      -> unit
      -> t
      [@@js.builder]
  end
  [@@js.scope "NotebookDocumentContentOptions"]

  module Notebook_kernel : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]

    val description : t -> string [@@js.get "description"]

    val set_description : t -> string -> unit [@@js.set "description"]

    val detail : t -> string [@@js.get "detail"]

    val set_detail : t -> string -> unit [@@js.set "detail"]

    val is_preferred : t -> bool [@@js.get "isPreferred"]

    val set_is_preferred : t -> bool -> unit [@@js.set "isPreferred"]

    val preloads : t -> Uri.t list [@@js.get "preloads"]

    val set_preloads : t -> Uri.t list -> unit [@@js.set "preloads"]

    val supported_languages : t -> string list [@@js.get "supportedLanguages"]

    val set_supported_languages : t -> string list -> unit
      [@@js.set "supportedLanguages"]

    val interrupt : t -> document:Notebook_document.t -> unit
      [@@js.call "interrupt"]

    val execute_cells_request :
         t
      -> document:Notebook_document.t
      -> ranges:Notebook_cell_range.t list
      -> unit Promise.t
      [@@js.call "executeCellsRequest"]
  end
  [@@js.scope "NotebookKernel"]

  module Anonymous_interface3 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val display_name : t -> string [@@js.get "displayName"]

    val set_display_name : t -> string -> unit [@@js.set "displayName"]

    val filename_pattern : t -> Notebook_filename_pattern.t list
      [@@js.get "filenamePattern"]

    val set_filename_pattern : t -> Notebook_filename_pattern.t list -> unit
      [@@js.set "filenamePattern"]

    val exclusive : t -> bool [@@js.get "exclusive"]

    val set_exclusive : t -> bool -> unit [@@js.set "exclusive"]
  end

  module Anonymous_interface4 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val document : t -> Notebook_document.t [@@js.get "document"]

    val set_document : t -> Notebook_document.t -> unit [@@js.set "document"]

    val kernel : t -> Notebook_kernel.t or_undefined [@@js.get "kernel"]

    val set_kernel : t -> Notebook_kernel.t or_undefined -> unit
      [@@js.set "kernel"]
  end

  module Anonymous_interface7 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val elevation : t -> bool [@@js.get "elevation"]

    val set_elevation : t -> bool -> unit [@@js.set "elevation"]

    val public : t -> bool [@@js.get "public"]

    val set_public : t -> bool -> unit [@@js.set "public"]
  end

  module Anonymous_interface9 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val light : t -> Uri.t [@@js.get "light"]

    val set_light : t -> Uri.t -> unit [@@js.set "light"]

    val dark : t -> Uri.t [@@js.get "dark"]

    val set_dark : t -> Uri.t -> unit [@@js.set "dark"]
  end

  module Anonymous_interface10 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val pid : t -> int [@@js.get "pid"]

    val set_pid : t -> int -> unit [@@js.set "pid"]

    val port_range : t -> int * int [@@js.get "portRange"]

    val set_port_range : t -> int * int -> unit [@@js.set "portRange"]

    val command_matcher : t -> regexp [@@js.get "commandMatcher"]

    val set_command_matcher : t -> regexp -> unit [@@js.set "commandMatcher"]
  end

  module Anonymous_interface11 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val port : t -> int [@@js.get "port"]

    val set_port : t -> int -> unit [@@js.set "port"]

    val host : t -> string [@@js.get "host"]

    val set_host : t -> string -> unit [@@js.set "host"]
  end

  module Anonymous_interface12 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val select : t -> bool [@@js.get "select"]

    val set_select : t -> bool -> unit [@@js.set "select"]

    val focus : t -> bool [@@js.get "focus"]

    val set_focus : t -> bool -> unit [@@js.set "focus"]

    val expand : t -> bool or_number [@@js.get "expand"]

    val set_expand : t -> bool or_number -> unit [@@js.set "expand"]
  end

  module Anonymous_interface14 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val timestamp : t -> int [@@js.get "timestamp"]

    val set_timestamp : t -> int -> unit [@@js.set "timestamp"]

    val id : t -> string [@@js.get "id"]

    val set_id : t -> string -> unit [@@js.set "id"]
  end

  module Anonymous_interface15 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val view_options : t -> Anonymous_interface3.t [@@js.get "viewOptions"]

    val set_view_options : t -> Anonymous_interface3.t -> unit
      [@@js.set "viewOptions"]
  end

  module Anonymous_interface17 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val get : t -> string -> string or_null [@@js.index_get]

    val set : t -> string -> string or_null -> unit [@@js.index_set]
  end

  module Authentication_providers_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val added : t -> Authentication_provider_information.t list
      [@@js.get "added"]

    val removed : t -> Authentication_provider_information.t list
      [@@js.get "removed"]
  end
  [@@js.scope "AuthenticationProvidersChangeEvent"]

  module Authentication : sig
    val on_did_change_authentication_providers :
      Authentication_providers_change_event.t Event.t
      [@@js.global "onDidChangeAuthenticationProviders"]

    val providers : Authentication_provider_information.t list
      [@@js.global "providers"]

    val logout : provider_id:string -> session_id:string -> unit Promise.t
      [@@js.global "logout"]
  end
  [@@js.scope "authentication"]

  module Message_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val use_custom : t -> bool [@@js.get "useCustom"]

    val set_use_custom : t -> bool -> unit [@@js.set "useCustom"]
  end
  [@@js.scope "MessageOptions"]

  module Remote_authority_resolver_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val resolve_attempt : t -> int [@@js.get "resolveAttempt"]

    val set_resolve_attempt : t -> int -> unit [@@js.set "resolveAttempt"]
  end
  [@@js.scope "RemoteAuthorityResolverContext"]

  module Resolved_authority : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val host : t -> string [@@js.get "host"]

    val port : t -> int [@@js.get "port"]

    val connection_token : t -> string or_undefined [@@js.get "connectionToken"]

    val create :
      host:string -> port:int -> ?connection_token:string -> unit -> t
      [@@js.create]
  end
  [@@js.scope "ResolvedAuthority"]

  module Resolved_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val extension_host_env : t -> Anonymous_interface17.t
      [@@js.get "extensionHostEnv"]

    val set_extension_host_env : t -> Anonymous_interface17.t -> unit
      [@@js.set "extensionHostEnv"]
  end
  [@@js.scope "ResolvedOptions"]

  module Tunnel_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val remote_address : t -> Anonymous_interface11.t [@@js.get "remoteAddress"]

    val set_remote_address : t -> Anonymous_interface11.t -> unit
      [@@js.set "remoteAddress"]

    val local_address_port : t -> int [@@js.get "localAddressPort"]

    val set_local_address_port : t -> int -> unit [@@js.set "localAddressPort"]

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]

    val public : t -> bool [@@js.get "public"]

    val set_public : t -> bool -> unit [@@js.set "public"]
  end
  [@@js.scope "TunnelOptions"]

  module Tunnel_description : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val remote_address : t -> Anonymous_interface11.t [@@js.get "remoteAddress"]

    val set_remote_address : t -> Anonymous_interface11.t -> unit
      [@@js.set "remoteAddress"]

    val local_address : t -> Anonymous_interface11.t or_string
      [@@js.get "localAddress"]

    val set_local_address : t -> Anonymous_interface11.t or_string -> unit
      [@@js.set "localAddress"]

    val public : t -> bool [@@js.get "public"]

    val set_public : t -> bool -> unit [@@js.set "public"]
  end
  [@@js.scope "TunnelDescription"]

  module Tunnel : sig
    include module type of struct
      include Tunnel_description
    end

    val on_did_dispose : t -> unit Event.t [@@js.get "onDidDispose"]

    val set_on_did_dispose : t -> unit Event.t -> unit [@@js.set "onDidDispose"]

    val dispose : t -> (unit, unit Promise.t) union2 [@@js.call "dispose"]
  end
  [@@js.scope "Tunnel"]

  module Tunnel_information : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val environment_tunnels : t -> Tunnel_description.t list
      [@@js.get "environmentTunnels"]

    val set_environment_tunnels : t -> Tunnel_description.t list -> unit
      [@@js.set "environmentTunnels"]
  end
  [@@js.scope "TunnelInformation"]

  module Tunnel_creation_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val elevation_required : t -> bool [@@js.get "elevationRequired"]

    val set_elevation_required : t -> bool -> unit
      [@@js.set "elevationRequired"]
  end
  [@@js.scope "TunnelCreationOptions"]

  module Candidate_port_source : sig
    type t =
      ([ `None [@js 0]
       | `Process [@js 1]
       | `Output [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Resolver_result : sig
    type t =
      ( Resolved_authority.t
      , Resolved_options.t
      , Tunnel_information.t )
      intersection3

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Remote_authority_resolver_error : sig
    include module type of struct
      include Error
    end

    val not_available : ?message:string -> ?handled:bool -> unit -> t
      [@@js.global "NotAvailable"]

    val temporarily_not_available : ?message:string -> unit -> t
      [@@js.global "TemporarilyNotAvailable"]

    val create : ?message:string -> unit -> t [@@js.create]
  end
  [@@js.scope "RemoteAuthorityResolverError"]

  module Remote_authority_resolver : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val resolve :
         t
      -> authority:string
      -> context:Remote_authority_resolver_context.t
      -> (Resolver_result.t, Resolver_result.t Promise.t) union2
      [@@js.call "resolve"]

    val tunnel_factory :
         t
      -> tunnel_options:Tunnel_options.t
      -> tunnel_creation_options:Tunnel_creation_options.t
      -> Tunnel.t Promise.t or_undefined
      [@@js.call "tunnelFactory"]

    val show_candidate_port :
      t -> host:string -> port:int -> detail:string -> bool Promise.t
      [@@js.call "showCandidatePort"]

    val tunnel_features : t -> Anonymous_interface7.t
      [@@js.get "tunnelFeatures"]

    val set_tunnel_features : t -> Anonymous_interface7.t -> unit
      [@@js.set "tunnelFeatures"]

    val candidate_port_source : t -> Candidate_port_source.t
      [@@js.get "candidatePortSource"]

    val set_candidate_port_source : t -> Candidate_port_source.t -> unit
      [@@js.set "candidatePortSource"]
  end
  [@@js.scope "RemoteAuthorityResolver"]

  module Resource_label_formatting : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]

    val separator :
      t -> ([ `L_s0 [@js ""] | `L_s1 [@js "/"] | `L_s2 [@js "\\"] ][@js.enum])
      [@@js.get "separator"]

    val set_separator : t -> ([ `L_s0 | `L_s1 | `L_s2 ][@js.enum]) -> unit
      [@@js.set "separator"]

    val tildify : t -> bool [@@js.get "tildify"]

    val set_tildify : t -> bool -> unit [@@js.set "tildify"]

    val normalize_drive_letter : t -> bool [@@js.get "normalizeDriveLetter"]

    val set_normalize_drive_letter : t -> bool -> unit
      [@@js.set "normalizeDriveLetter"]

    val workspace_suffix : t -> string [@@js.get "workspaceSuffix"]

    val set_workspace_suffix : t -> string -> unit [@@js.set "workspaceSuffix"]

    val authority_prefix : t -> string [@@js.get "authorityPrefix"]

    val set_authority_prefix : t -> string -> unit [@@js.set "authorityPrefix"]

    val strip_path_starting_separator : t -> bool
      [@@js.get "stripPathStartingSeparator"]

    val set_strip_path_starting_separator : t -> bool -> unit
      [@@js.set "stripPathStartingSeparator"]
  end
  [@@js.scope "ResourceLabelFormatting"]

  module Resource_label_formatter : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val scheme : t -> string [@@js.get "scheme"]

    val set_scheme : t -> string -> unit [@@js.set "scheme"]

    val authority : t -> string [@@js.get "authority"]

    val set_authority : t -> string -> unit [@@js.set "authority"]

    val formatting : t -> Resource_label_formatting.t [@@js.get "formatting"]

    val set_formatting : t -> Resource_label_formatting.t -> unit
      [@@js.set "formatting"]
  end
  [@@js.scope "ResourceLabelFormatter"]

  module Anonymous_interface1 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val create : t -> bool [@@js.get "create"]

    val set_create : t -> bool -> unit [@@js.set "create"]
  end

  module File_system_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val open_ :
         t
      -> resource:Uri.t
      -> options:Anonymous_interface1.t
      -> int Promise.t or_number
      [@@js.call "open"]

    val close : t -> fd:int -> (unit, unit Promise.t) union2 [@@js.call "close"]

    val read :
         t
      -> fd:int
      -> pos:int
      -> data:Uint8_array.t
      -> offset:int
      -> length:int
      -> int Promise.t or_number
      [@@js.call "read"]

    val write :
         t
      -> fd:int
      -> pos:int
      -> data:Uint8_array.t
      -> offset:int
      -> length:int
      -> int Promise.t or_number
      [@@js.call "write"]
  end
  [@@js.scope "FileSystemProvider"]

  module Text_search_query : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val pattern : t -> string [@@js.get "pattern"]

    val set_pattern : t -> string -> unit [@@js.set "pattern"]

    val is_multiline : t -> bool [@@js.get "isMultiline"]

    val set_is_multiline : t -> bool -> unit [@@js.set "isMultiline"]

    val is_reg_exp : t -> bool [@@js.get "isRegExp"]

    val set_is_reg_exp : t -> bool -> unit [@@js.set "isRegExp"]

    val is_case_sensitive : t -> bool [@@js.get "isCaseSensitive"]

    val set_is_case_sensitive : t -> bool -> unit [@@js.set "isCaseSensitive"]

    val is_word_match : t -> bool [@@js.get "isWordMatch"]

    val set_is_word_match : t -> bool -> unit [@@js.set "isWordMatch"]
  end
  [@@js.scope "TextSearchQuery"]

  module Glob_string : sig
    type t = string

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Search_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val folder : t -> Uri.t [@@js.get "folder"]

    val set_folder : t -> Uri.t -> unit [@@js.set "folder"]

    val includes : t -> Glob_string.t list [@@js.get "includes"]

    val set_includes : t -> Glob_string.t list -> unit [@@js.set "includes"]

    val excludes : t -> Glob_string.t list [@@js.get "excludes"]

    val set_excludes : t -> Glob_string.t list -> unit [@@js.set "excludes"]

    val use_ignore_files : t -> bool [@@js.get "useIgnoreFiles"]

    val set_use_ignore_files : t -> bool -> unit [@@js.set "useIgnoreFiles"]

    val follow_symlinks : t -> bool [@@js.get "followSymlinks"]

    val set_follow_symlinks : t -> bool -> unit [@@js.set "followSymlinks"]

    val use_global_ignore_files : t -> bool [@@js.get "useGlobalIgnoreFiles"]

    val set_use_global_ignore_files : t -> bool -> unit
      [@@js.set "useGlobalIgnoreFiles"]
  end
  [@@js.scope "SearchOptions"]

  module Text_search_preview_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val match_lines : t -> int [@@js.get "matchLines"]

    val set_match_lines : t -> int -> unit [@@js.set "matchLines"]

    val chars_per_line : t -> int [@@js.get "charsPerLine"]

    val set_chars_per_line : t -> int -> unit [@@js.set "charsPerLine"]
  end
  [@@js.scope "TextSearchPreviewOptions"]

  module Text_search_options : sig
    include module type of struct
      include Search_options
    end

    val max_results : t -> int [@@js.get "maxResults"]

    val set_max_results : t -> int -> unit [@@js.set "maxResults"]

    val preview_options : t -> Text_search_preview_options.t
      [@@js.get "previewOptions"]

    val set_preview_options : t -> Text_search_preview_options.t -> unit
      [@@js.set "previewOptions"]

    val max_file_size : t -> int [@@js.get "maxFileSize"]

    val set_max_file_size : t -> int -> unit [@@js.set "maxFileSize"]

    val encoding : t -> string [@@js.get "encoding"]

    val set_encoding : t -> string -> unit [@@js.set "encoding"]

    val before_context : t -> int [@@js.get "beforeContext"]

    val set_before_context : t -> int -> unit [@@js.set "beforeContext"]

    val after_context : t -> int [@@js.get "afterContext"]

    val set_after_context : t -> int -> unit [@@js.set "afterContext"]
  end
  [@@js.scope "TextSearchOptions"]

  module Text_search_complete : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val limit_hit : t -> bool [@@js.get "limitHit"]

    val set_limit_hit : t -> bool -> unit [@@js.set "limitHit"]
  end
  [@@js.scope "TextSearchComplete"]

  module Text_search_match_preview : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val text : t -> string [@@js.get "text"]

    val set_text : t -> string -> unit [@@js.set "text"]

    val matches : t -> (Range.t, Range.t) or_array [@@js.get "matches"]

    val set_matches : t -> (Range.t, Range.t) or_array -> unit
      [@@js.set "matches"]
  end
  [@@js.scope "TextSearchMatchPreview"]

  module Text_search_match : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val uri : t -> Uri.t [@@js.get "uri"]

    val set_uri : t -> Uri.t -> unit [@@js.set "uri"]

    val ranges : t -> (Range.t, Range.t) or_array [@@js.get "ranges"]

    val set_ranges : t -> (Range.t, Range.t) or_array -> unit
      [@@js.set "ranges"]

    val preview : t -> Text_search_match_preview.t [@@js.get "preview"]

    val set_preview : t -> Text_search_match_preview.t -> unit
      [@@js.set "preview"]
  end
  [@@js.scope "TextSearchMatch"]

  module Text_search_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val uri : t -> Uri.t [@@js.get "uri"]

    val set_uri : t -> Uri.t -> unit [@@js.set "uri"]

    val text : t -> string [@@js.get "text"]

    val set_text : t -> string -> unit [@@js.set "text"]

    val line_number : t -> int [@@js.get "lineNumber"]

    val set_line_number : t -> int -> unit [@@js.set "lineNumber"]
  end
  [@@js.scope "TextSearchContext"]

  module Text_search_result : sig
    type t = (Text_search_context.t, Text_search_match.t) union2

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Text_search_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_text_search_results :
         t
      -> query:Text_search_query.t
      -> options:Text_search_options.t
      -> progress:Text_search_result.t Progress.t
      -> token:Cancellation_token.t
      -> Text_search_complete.t Provider_result.t
      [@@js.call "provideTextSearchResults"]
  end
  [@@js.scope "TextSearchProvider"]

  module File_search_query : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val pattern : t -> string [@@js.get "pattern"]

    val set_pattern : t -> string -> unit [@@js.set "pattern"]
  end
  [@@js.scope "FileSearchQuery"]

  module File_search_options : sig
    include module type of struct
      include Search_options
    end

    val max_results : t -> int [@@js.get "maxResults"]

    val set_max_results : t -> int -> unit [@@js.set "maxResults"]

    val session : t -> Cancellation_token.t [@@js.get "session"]

    val set_session : t -> Cancellation_token.t -> unit [@@js.set "session"]
  end
  [@@js.scope "FileSearchOptions"]

  module File_search_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_file_search_results :
         t
      -> query:File_search_query.t
      -> options:File_search_options.t
      -> token:Cancellation_token.t
      -> Uri.t list Provider_result.t
      [@@js.call "provideFileSearchResults"]
  end
  [@@js.scope "FileSearchProvider"]

  module Webview_editor_inset : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val editor : t -> Text_editor.t [@@js.get "editor"]

    val line : t -> int [@@js.get "line"]

    val height : t -> int [@@js.get "height"]

    val webview : t -> Webview.t [@@js.get "webview"]

    val on_did_dispose : t -> unit Event.t [@@js.get "onDidDispose"]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "WebviewEditorInset"]

  module Terminal_data_write_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val terminal : t -> Terminal.t [@@js.get "terminal"]

    val data : t -> string [@@js.get "data"]
  end
  [@@js.scope "TerminalDataWriteEvent"]

  module Terminal_dimensions_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val terminal : t -> Terminal.t [@@js.get "terminal"]

    val dimensions : t -> Terminal_dimensions.t [@@js.get "dimensions"]
  end
  [@@js.scope "TerminalDimensionsChangeEvent"]

  module Terminal : sig
    type t = Terminal.t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val dimensions : t -> Terminal_dimensions.t or_undefined
      [@@js.get "dimensions"]
  end
  [@@js.scope "Terminal"]

  module Terminal_options : sig
    type t = Terminal_options.t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val icon : t -> string [@@js.get "icon"]

    val message : t -> string [@@js.get "message"]
  end
  [@@js.scope "TerminalOptions"]

  module Find_text_in_files_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val include_ : t -> Glob_pattern.t [@@js.get "include"]

    val set_include : t -> Glob_pattern.t -> unit [@@js.set "include"]

    val exclude : t -> Glob_pattern.t [@@js.get "exclude"]

    val set_exclude : t -> Glob_pattern.t -> unit [@@js.set "exclude"]

    val use_default_excludes : t -> bool [@@js.get "useDefaultExcludes"]

    val set_use_default_excludes : t -> bool -> unit
      [@@js.set "useDefaultExcludes"]

    val max_results : t -> int [@@js.get "maxResults"]

    val set_max_results : t -> int -> unit [@@js.set "maxResults"]

    val use_ignore_files : t -> bool [@@js.get "useIgnoreFiles"]

    val set_use_ignore_files : t -> bool -> unit [@@js.set "useIgnoreFiles"]

    val use_global_ignore_files : t -> bool [@@js.get "useGlobalIgnoreFiles"]

    val set_use_global_ignore_files : t -> bool -> unit
      [@@js.set "useGlobalIgnoreFiles"]

    val follow_symlinks : t -> bool [@@js.get "followSymlinks"]

    val set_follow_symlinks : t -> bool -> unit [@@js.set "followSymlinks"]

    val encoding : t -> string [@@js.get "encoding"]

    val set_encoding : t -> string -> unit [@@js.set "encoding"]

    val preview_options : t -> Text_search_preview_options.t
      [@@js.get "previewOptions"]

    val set_preview_options : t -> Text_search_preview_options.t -> unit
      [@@js.set "previewOptions"]

    val before_context : t -> int [@@js.get "beforeContext"]

    val set_before_context : t -> int -> unit [@@js.set "beforeContext"]

    val after_context : t -> int [@@js.get "afterContext"]

    val set_after_context : t -> int -> unit [@@js.set "afterContext"]
  end
  [@@js.scope "FindTextInFilesOptions"]

  module Line_change : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val original_start_line_number : t -> int
      [@@js.get "originalStartLineNumber"]

    val original_end_line_number : t -> int [@@js.get "originalEndLineNumber"]

    val modified_start_line_number : t -> int
      [@@js.get "modifiedStartLineNumber"]

    val modified_end_line_number : t -> int [@@js.get "modifiedEndLineNumber"]
  end
  [@@js.scope "LineChange"]

  module Commands : sig
    val register_diff_information_command :
         command:string
      -> callback:
           (diff:Line_change.t list -> args:(any list[@js.variadic]) -> any)
      -> ?this_arg:any
      -> unit
      -> Disposable.t
      [@@js.global "registerDiffInformationCommand"]
  end
  [@@js.scope "commands"]

  module Debug_protocol_variable_container : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Debug_protocol_variable : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Source_control_input_box_validation_type : sig
    type t =
      ([ `Error [@js 0]
       | `Warning [@js 1]
       | `Information [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Source_control_input_box_validation : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val message : t -> string [@@js.get "message"]

    val type_ : t -> Source_control_input_box_validation_type.t
      [@@js.get "type"]
  end
  [@@js.scope "SourceControlInputBoxValidation"]

  module Source_control_input_box : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val focus : t -> unit [@@js.call "focus"]

    val show_validation_message :
         t
      -> message:string
      -> type_:Source_control_input_box_validation_type.t
      -> unit
      [@@js.call "showValidationMessage"]

    val validate_input :
         t
      -> value:string
      -> cursor_position:int
      -> Source_control_input_box_validation.t Provider_result.t
      [@@js.call "validateInput"]
  end
  [@@js.scope "SourceControlInputBox"]

  module Source_control : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val selected : t -> bool [@@js.get "selected"]

    val on_did_change_selection : t -> bool Event.t
      [@@js.get "onDidChangeSelection"]
  end
  [@@js.scope "SourceControl"]

  module Document_filter : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val exclusive : t -> bool [@@js.get "exclusive"]
  end
  [@@js.scope "DocumentFilter"]

  module Tree_view : sig
    include module type of struct
      include Disposable
    end

    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val reveal :
         'T t
      -> element:'T or_undefined
      -> ?options:Anonymous_interface12.t
      -> unit
      -> unit Promise.t
      [@@js.call "reveal"]
  end
  [@@js.scope "TreeView"]

  module Task_presentation_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val group : t -> string [@@js.get "group"]

    val set_group : t -> string -> unit [@@js.set "group"]
  end
  [@@js.scope "TaskPresentationOptions"]

  module Status_bar_item_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val set_id : t -> string -> unit [@@js.set "id"]

    val name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]

    val accessibility_information : t -> Accessibility_information.t
      [@@js.get "accessibilityInformation"]

    val set_accessibility_information : t -> Accessibility_information.t -> unit
      [@@js.set "accessibilityInformation"]

    val alignment : t -> Status_bar_alignment.t [@@js.get "alignment"]

    val set_alignment : t -> Status_bar_alignment.t -> unit
      [@@js.set "alignment"]

    val priority : t -> int [@@js.get "priority"]

    val set_priority : t -> int -> unit [@@js.set "priority"]
  end
  [@@js.scope "StatusBarItemOptions"]

  module Custom_text_editor_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val move_custom_text_editor :
         t
      -> new_document:Text_document.t
      -> existing_webview_panel:Webview_panel.t
      -> token:Cancellation_token.t
      -> unit Promise.t
      [@@js.call "moveCustomTextEditor"]
  end
  [@@js.scope "CustomTextEditorProvider"]

  module Quick_pick : sig
    include module type of struct
      include Quick_input
    end

    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    val sort_by_label : 'T t -> bool [@@js.get "sortByLabel"]

    val set_sort_by_label : 'T t -> bool -> unit [@@js.set "sortByLabel"]
  end
  [@@js.scope "QuickPick"]

  module Quick_pick_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val title : t -> string [@@js.get "title"]

    val set_title : t -> string -> unit [@@js.set "title"]
  end
  [@@js.scope "QuickPickOptions"]

  module Input_box_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val title : t -> string [@@js.get "title"]

    val set_title : t -> string -> unit [@@js.set "title"]
  end
  [@@js.scope "InputBoxOptions"]

  module Notebook_editor_reveal_type : sig
    type t =
      ([ `Default [@js 0]
       | `InCenter [@js 1]
       | `InCenterIfOutsideViewport [@js 2]
       | `AtTop [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Notebook_cell_data : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val kind : t -> Notebook_cell_kind.t [@@js.get "kind"]

    val set_kind : t -> Notebook_cell_kind.t -> unit [@@js.set "kind"]

    val source : t -> string [@@js.get "source"]

    val set_source : t -> string -> unit [@@js.set "source"]

    val language : t -> string [@@js.get "language"]

    val set_language : t -> string -> unit [@@js.set "language"]

    val outputs : t -> Notebook_cell_output.t list [@@js.get "outputs"]

    val set_outputs : t -> Notebook_cell_output.t list -> unit
      [@@js.set "outputs"]

    val metadata : t -> Notebook_cell_metadata.t [@@js.get "metadata"]

    val set_metadata : t -> Notebook_cell_metadata.t -> unit
      [@@js.set "metadata"]

    val latest_execution_summary : t -> Notebook_cell_execution_summary.t
      [@@js.get "latestExecutionSummary"]

    val set_latest_execution_summary :
      t -> Notebook_cell_execution_summary.t -> unit
      [@@js.set "latestExecutionSummary"]

    val create :
         kind:Notebook_cell_kind.t
      -> source:string
      -> language:string
      -> ?outputs:Notebook_cell_output.t list
      -> ?metadata:Notebook_cell_metadata.t
      -> ?latest_execution_summary:Notebook_cell_execution_summary.t
      -> unit
      -> t
      [@@js.create]
  end
  [@@js.scope "NotebookCellData"]

  module Notebook_editor_edit : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val replace_metadata : t -> value:Notebook_document_metadata.t -> unit
      [@@js.call "replaceMetadata"]

    val replace_cells :
      t -> start:int -> end_:int -> cells:Notebook_cell_data.t list -> unit
      [@@js.call "replaceCells"]

    val replace_cell_output :
      t -> index:int -> outputs:Notebook_cell_output.t list -> unit
      [@@js.call "replaceCellOutput"]

    val replace_cell_metadata :
      t -> index:int -> metadata:Notebook_cell_metadata.t -> unit
      [@@js.call "replaceCellMetadata"]
  end
  [@@js.scope "NotebookEditorEdit"]

  module Notebook_editor_decoration_type : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val key : t -> string [@@js.get "key"]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "NotebookEditorDecorationType"]

  module Notebook_editor : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val set_decorations :
         t
      -> decoration_type:Notebook_editor_decoration_type.t
      -> range:Notebook_cell_range.t
      -> unit
      [@@js.call "setDecorations"]

    val kernel : t -> Notebook_kernel.t [@@js.get "kernel"]

    val edit :
         t
      -> callback:(editBuilder:Notebook_editor_edit.t -> unit)
      -> bool Promise.t
      [@@js.call "edit"]

    val document : t -> Notebook_document.t [@@js.get "document"]

    val selection : t -> Notebook_cell.t [@@js.get "selection"]

    val selections : t -> Notebook_cell_range.t list [@@js.get "selections"]

    val visible_ranges : t -> Notebook_cell_range.t list
      [@@js.get "visibleRanges"]

    val reveal_range :
         t
      -> range:Notebook_cell_range.t
      -> ?reveal_type:Notebook_editor_reveal_type.t
      -> unit
      -> unit
      [@@js.call "revealRange"]

    val view_column : t -> View_column.t [@@js.get "viewColumn"]
  end
  [@@js.scope "NotebookEditor"]

  module Notebook_document_metadata_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val document : t -> Notebook_document.t [@@js.get "document"]
  end
  [@@js.scope "NotebookDocumentMetadataChangeEvent"]

  module Notebook_cells_change_data : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val start : t -> int [@@js.get "start"]

    val deleted_count : t -> int [@@js.get "deletedCount"]

    val deleted_items : t -> Notebook_cell.t list [@@js.get "deletedItems"]

    val items : t -> Notebook_cell.t list [@@js.get "items"]
  end
  [@@js.scope "NotebookCellsChangeData"]

  module Notebook_cells_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val document : t -> Notebook_document.t [@@js.get "document"]

    val changes : t -> Notebook_cells_change_data.t list [@@js.get "changes"]
  end
  [@@js.scope "NotebookCellsChangeEvent"]

  module Notebook_cell_outputs_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val document : t -> Notebook_document.t [@@js.get "document"]

    val cells : t -> Notebook_cell.t list [@@js.get "cells"]
  end
  [@@js.scope "NotebookCellOutputsChangeEvent"]

  module Notebook_cell_metadata_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val document : t -> Notebook_document.t [@@js.get "document"]

    val cell : t -> Notebook_cell.t [@@js.get "cell"]
  end
  [@@js.scope "NotebookCellMetadataChangeEvent"]

  module Notebook_editor_selection_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val notebook_editor : t -> Notebook_editor.t [@@js.get "notebookEditor"]

    val selections : t -> Notebook_cell_range.t list [@@js.get "selections"]
  end
  [@@js.scope "NotebookEditorSelectionChangeEvent"]

  module Notebook_editor_visible_ranges_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val notebook_editor : t -> Notebook_editor.t [@@js.get "notebookEditor"]

    val visible_ranges : t -> Notebook_cell_range.t list
      [@@js.get "visibleRanges"]
  end
  [@@js.scope "NotebookEditorVisibleRangesChangeEvent"]

  module Notebook_cell_execution_state : sig
    type t =
      ([ `Idle [@js 1]
       | `Pending [@js 2]
       | `Executing [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Notebook_cell_execution_state_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val document : t -> Notebook_document.t [@@js.get "document"]

    val cell : t -> Notebook_cell.t [@@js.get "cell"]

    val execution_state : t -> Notebook_cell_execution_state.t
      [@@js.get "executionState"]
  end
  [@@js.scope "NotebookCellExecutionStateChangeEvent"]

  module Notebook_data : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val cells : t -> Notebook_cell_data.t list [@@js.get "cells"]

    val set_cells : t -> Notebook_cell_data.t list -> unit [@@js.set "cells"]

    val metadata : t -> Notebook_document_metadata.t [@@js.get "metadata"]

    val set_metadata : t -> Notebook_document_metadata.t -> unit
      [@@js.set "metadata"]

    val create :
         cells:Notebook_cell_data.t list
      -> ?metadata:Notebook_document_metadata.t
      -> unit
      -> t
      [@@js.create]
  end
  [@@js.scope "NotebookData"]

  module Notebook_communication : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val editor_id : t -> string [@@js.get "editorId"]

    val on_did_receive_message : t -> any Event.t
      [@@js.get "onDidReceiveMessage"]

    val post_message : t -> message:any -> bool Promise.t
      [@@js.call "postMessage"]

    val as_webview_uri : t -> local_resource:Uri.t -> Uri.t
      [@@js.call "asWebviewUri"]
  end
  [@@js.scope "NotebookCommunication"]

  module Notebook_document_show_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val view_column : t -> View_column.t [@@js.get "viewColumn"]

    val set_view_column : t -> View_column.t -> unit [@@js.set "viewColumn"]

    val preserve_focus : t -> bool [@@js.get "preserveFocus"]

    val set_preserve_focus : t -> bool -> unit [@@js.set "preserveFocus"]

    val preview : t -> bool [@@js.get "preview"]

    val set_preview : t -> bool -> unit [@@js.set "preview"]

    val selection : t -> Notebook_cell_range.t [@@js.get "selection"]

    val set_selection : t -> Notebook_cell_range.t -> unit
      [@@js.set "selection"]
  end
  [@@js.scope "NotebookDocumentShowOptions"]

  module Notebook_serializer : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val data_to_notebook :
         t
      -> data:Uint8_array.t
      -> (Notebook_data.t, Notebook_data.t Promise.t) union2
      [@@js.call "dataToNotebook"]

    val notebook_to_data :
         t
      -> data:Notebook_data.t
      -> (Uint8_array.t, Uint8_array.t Promise.t) union2
      [@@js.call "notebookToData"]

    val create :
         deserialize_notebook:
           (   content:Uint8_array.t
            -> token:Cancellation_token.t
            -> Notebook_data.t Promise.t)
      -> serialize_notebook:
           (   data:Notebook_data.t
            -> token:Cancellation_token.t
            -> Uint8_array.t Promise.t)
      -> t
      [@@js.builder]
  end
  [@@js.scope "NotebookSerializer"]

  module Notebook_filter : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val view_type : t -> string [@@js.get "viewType"]

    val scheme : t -> string [@@js.get "scheme"]

    val pattern : t -> Glob_pattern.t [@@js.get "pattern"]
  end
  [@@js.scope "NotebookFilter"]

  module Notebook_selector : sig
    type t =
      (Notebook_filter.t, Notebook_filter.t or_string list) union2 or_string

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Notebook_cell_execute_start_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val start_time : t -> int [@@js.get "startTime"]

    val set_start_time : t -> int -> unit [@@js.set "startTime"]
  end
  [@@js.scope "NotebookCellExecuteStartContext"]

  module Notebook_cell_execute_end_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val success : t -> bool [@@js.get "success"]

    val set_success : t -> bool -> unit [@@js.set "success"]

    val duration : t -> int [@@js.get "duration"]

    val set_duration : t -> int -> unit [@@js.set "duration"]
  end
  [@@js.scope "NotebookCellExecuteEndContext"]

  module Notebook_cell_execution_task : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val document : t -> Notebook_document.t [@@js.get "document"]

    val cell : t -> Notebook_cell.t [@@js.get "cell"]

    val start :
      t -> ?context:Notebook_cell_execute_start_context.t -> unit -> unit
      [@@js.call "start"]

    val execution_order : t -> int or_undefined [@@js.get "executionOrder"]

    val set_execution_order : t -> int or_undefined -> unit
      [@@js.set "executionOrder"]

    val end_ : t -> ?result:Notebook_cell_execute_end_context.t -> unit -> unit
      [@@js.call "end"]

    val token : t -> Cancellation_token.t [@@js.get "token"]

    val clear_output : t -> ?cell_index:int -> unit -> unit Promise.t
      [@@js.call "clearOutput"]

    val append_output :
         t
      -> out:(Notebook_cell_output.t, Notebook_cell_output.t) or_array
      -> ?cell_index:int
      -> unit
      -> unit Promise.t
      [@@js.call "appendOutput"]

    val replace_output :
         t
      -> out:(Notebook_cell_output.t, Notebook_cell_output.t) or_array
      -> ?cell_index:int
      -> unit
      -> unit Promise.t
      [@@js.call "replaceOutput"]

    val append_output_items :
         t
      -> items:
           (Notebook_cell_output_item.t, Notebook_cell_output_item.t) or_array
      -> output_id:string
      -> unit Promise.t
      [@@js.call "appendOutputItems"]

    val replace_output_items :
         t
      -> items:
           (Notebook_cell_output_item.t, Notebook_cell_output_item.t) or_array
      -> output_id:string
      -> unit Promise.t
      [@@js.call "replaceOutputItems"]
  end
  [@@js.scope "NotebookCellExecutionTask"]

  module Notebook_decoration_render_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val background_color : t -> Theme_color.t or_string
      [@@js.get "backgroundColor"]

    val set_background_color : t -> Theme_color.t or_string -> unit
      [@@js.set "backgroundColor"]

    val border_color : t -> Theme_color.t or_string [@@js.get "borderColor"]

    val set_border_color : t -> Theme_color.t or_string -> unit
      [@@js.set "borderColor"]

    val top : t -> Themable_decoration_attachment_render_options.t
      [@@js.get "top"]

    val set_top : t -> Themable_decoration_attachment_render_options.t -> unit
      [@@js.set "top"]
  end
  [@@js.scope "NotebookDecorationRenderOptions"]

  module Notebook_kernel_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val set_id : t -> string -> unit [@@js.set "id"]

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]

    val description : t -> string [@@js.get "description"]

    val set_description : t -> string -> unit [@@js.set "description"]

    val selector : t -> Notebook_selector.t [@@js.get "selector"]

    val set_selector : t -> Notebook_selector.t -> unit [@@js.set "selector"]

    val supported_languages : t -> string list [@@js.get "supportedLanguages"]

    val set_supported_languages : t -> string list -> unit
      [@@js.set "supportedLanguages"]

    val has_execution_order : t -> bool [@@js.get "hasExecutionOrder"]

    val set_has_execution_order : t -> bool -> unit
      [@@js.set "hasExecutionOrder"]

    val execute_handler :
      t -> executions:Notebook_cell_execution_task.t list -> unit
      [@@js.call "executeHandler"]

    val interrupt_handler : t -> notebook:Notebook_document.t -> unit
      [@@js.call "interruptHandler"]
  end
  [@@js.scope "NotebookKernelOptions"]

  module Notebook_kernel2 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val selector : t -> Notebook_selector.t [@@js.get "selector"]

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]

    val description : t -> string [@@js.get "description"]

    val set_description : t -> string -> unit [@@js.set "description"]

    val supported_languages : t -> string list [@@js.get "supportedLanguages"]

    val set_supported_languages : t -> string list -> unit
      [@@js.set "supportedLanguages"]

    val has_execution_order : t -> bool [@@js.get "hasExecutionOrder"]

    val set_has_execution_order : t -> bool -> unit
      [@@js.set "hasExecutionOrder"]

    val execute_handler :
      t -> executions:Notebook_cell_execution_task.t list -> unit
      [@@js.call "executeHandler"]

    val interrupt_handler : t -> notebook:Notebook_document.t -> unit
      [@@js.call "interruptHandler"]

    val dispose : t -> unit [@@js.call "dispose"]

    val create_notebook_cell_execution_task :
      t -> cell:Notebook_cell.t -> Notebook_cell_execution_task.t
      [@@js.call "createNotebookCellExecutionTask"]
  end
  [@@js.scope "NotebookKernel2"]

  module Notebook_document_backup : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val delete : t -> unit [@@js.call "delete"]
  end
  [@@js.scope "NotebookDocumentBackup"]

  module Notebook_document_backup_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val destination : t -> Uri.t [@@js.get "destination"]
  end
  [@@js.scope "NotebookDocumentBackupContext"]

  module Notebook_document_open_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val backup_id : t -> string [@@js.get "backupId"]

    val untitled_document_data : t -> Uint8_array.t
      [@@js.get "untitledDocumentData"]
  end
  [@@js.scope "NotebookDocumentOpenContext"]

  module Notebook_content_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val options : t -> Notebook_document_content_options.t [@@js.get "options"]

    val on_did_change_notebook_content_options :
      t -> Notebook_document_content_options.t Event.t
      [@@js.get "onDidChangeNotebookContentOptions"]

    val open_notebook :
         t
      -> uri:Uri.t
      -> open_context:Notebook_document_open_context.t
      -> token:Cancellation_token.t
      -> (Notebook_data.t, Notebook_data.t Promise.t) union2
      [@@js.call "openNotebook"]

    val save_notebook :
         t
      -> document:Notebook_document.t
      -> token:Cancellation_token.t
      -> unit Promise.t
      [@@js.call "saveNotebook"]

    val save_notebook_as :
         t
      -> target_resource:Uri.t
      -> document:Notebook_document.t
      -> token:Cancellation_token.t
      -> unit Promise.t
      [@@js.call "saveNotebookAs"]

    val backup_notebook :
         t
      -> document:Notebook_document.t
      -> context:Notebook_document_backup_context.t
      -> token:Cancellation_token.t
      -> Notebook_document_backup.t Promise.t
      [@@js.call "backupNotebook"]
  end
  [@@js.scope "NotebookContentProvider"]

  module Notebook_document_filter : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val view_type : t -> string list [@@js.get "viewType"]

    val set_view_type : t -> string list -> unit [@@js.set "viewType"]

    val filename_pattern : t -> Notebook_filename_pattern.t
      [@@js.get "filenamePattern"]

    val set_filename_pattern : t -> Notebook_filename_pattern.t -> unit
      [@@js.set "filenamePattern"]
  end
  [@@js.scope "NotebookDocumentFilter"]

  module Notebook_kernel_provider : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    type t_0 = Notebook_kernel.t t

    val t_0_to_js : t_0 -> Ojs.t

    val t_0_of_js : Ojs.t -> t_0

    val on_did_change_kernels : 'T t -> Notebook_document.t or_undefined Event.t
      [@@js.get "onDidChangeKernels"]

    val set_on_did_change_kernels :
      'T t -> Notebook_document.t or_undefined Event.t -> unit
      [@@js.set "onDidChangeKernels"]

    val provide_kernels :
         'T t
      -> document:Notebook_document.t
      -> token:Cancellation_token.t
      -> 'T list Provider_result.t
      [@@js.call "provideKernels"]

    val resolve_kernel :
         'T t
      -> kernel:'T
      -> document:Notebook_document.t
      -> webview:Notebook_communication.t
      -> token:Cancellation_token.t
      -> unit Provider_result.t
      [@@js.call "resolveKernel"]
  end
  [@@js.scope "NotebookKernelProvider"]

  module Notebook_cell_status_bar_alignment : sig
    type t =
      ([ `Left [@js 1]
       | `Right [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Notebook_cell_status_bar_item : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val cell : t -> Notebook_cell.t [@@js.get "cell"]

    val alignment : t -> Notebook_cell_status_bar_alignment.t
      [@@js.get "alignment"]

    val priority : t -> int [@@js.get "priority"]

    val text : t -> string [@@js.get "text"]

    val set_text : t -> string -> unit [@@js.set "text"]

    val tooltip : t -> string or_undefined [@@js.get "tooltip"]

    val set_tooltip : t -> string or_undefined -> unit [@@js.set "tooltip"]

    val command : t -> Command.t or_string or_undefined [@@js.get "command"]

    val set_command : t -> Command.t or_string or_undefined -> unit
      [@@js.set "command"]

    val accessibility_information : t -> Accessibility_information.t
      [@@js.get "accessibilityInformation"]

    val set_accessibility_information : t -> Accessibility_information.t -> unit
      [@@js.set "accessibilityInformation"]

    val show : t -> unit [@@js.call "show"]

    val hide : t -> unit [@@js.call "hide"]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "NotebookCellStatusBarItem"]

  module Notebook_concat_text_document : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val uri : t -> Uri.t [@@js.get "uri"]

    val set_uri : t -> Uri.t -> unit [@@js.set "uri"]

    val is_closed : t -> bool [@@js.get "isClosed"]

    val set_is_closed : t -> bool -> unit [@@js.set "isClosed"]

    val dispose : t -> unit [@@js.call "dispose"]

    val on_did_change : t -> unit Event.t [@@js.get "onDidChange"]

    val set_on_did_change : t -> unit Event.t -> unit [@@js.set "onDidChange"]

    val version : t -> int [@@js.get "version"]

    val set_version : t -> int -> unit [@@js.set "version"]

    val get_text : t -> string [@@js.call "getText"]

    val get_text' : t -> range:Range.t -> string [@@js.call "getText"]

    val offset_at : t -> position:Position.t -> int [@@js.call "offsetAt"]

    val position_at : t -> offset:int -> Position.t [@@js.call "positionAt"]

    val validate_range : t -> range:Range.t -> Range.t
      [@@js.call "validateRange"]

    val validate_position : t -> position:Position.t -> Position.t
      [@@js.call "validatePosition"]

    val location_at :
      t -> position_or_range:(Position.t, Range.t) union2 -> Location.t
      [@@js.call "locationAt"]

    val position_at' : t -> location:Location.t -> Position.t
      [@@js.call "positionAt"]

    val contains : t -> uri:Uri.t -> bool [@@js.call "contains"]
  end
  [@@js.scope "NotebookConcatTextDocument"]

  module Notebook : sig
    val open_notebook_document : uri:Uri.t -> Notebook_document.t Promise.t
      [@@js.global "openNotebookDocument"]

    val on_did_open_notebook_document : Notebook_document.t Event.t
      [@@js.global "onDidOpenNotebookDocument"]

    val on_did_close_notebook_document : Notebook_document.t Event.t
      [@@js.global "onDidCloseNotebookDocument"]

    val on_did_save_notebook_document : Notebook_document.t Event.t
      [@@js.global "onDidSaveNotebookDocument"]

    val notebook_documents : Notebook_document.t list
      [@@js.global "notebookDocuments"]

    val on_did_change_notebook_document_metadata :
      Notebook_document_metadata_change_event.t Event.t
      [@@js.global "onDidChangeNotebookDocumentMetadata"]

    val on_did_change_notebook_cells : Notebook_cells_change_event.t Event.t
      [@@js.global "onDidChangeNotebookCells"]

    val on_did_change_cell_outputs :
      Notebook_cell_outputs_change_event.t Event.t
      [@@js.global "onDidChangeCellOutputs"]

    val on_did_change_cell_metadata :
      Notebook_cell_metadata_change_event.t Event.t
      [@@js.global "onDidChangeCellMetadata"]

    val register_notebook_serializer :
         notebook_type:string
      -> provider:Notebook_serializer.t
      -> ?options:Notebook_document_content_options.t
      -> unit
      -> Disposable.t
      [@@js.global "registerNotebookSerializer"]

    val create_notebook_kernel :
      options:Notebook_kernel_options.t -> Notebook_kernel2.t
      [@@js.global "createNotebookKernel"]

    val register_notebook_content_provider :
         notebook_type:string
      -> provider:Notebook_content_provider.t
      -> ?options:
           ( Notebook_document_content_options.t
           , Anonymous_interface15.t )
           intersection2
      -> unit
      -> Disposable.t
      [@@js.global "registerNotebookContentProvider"]

    val create_notebook_cell_execution_task :
         uri:Uri.t
      -> index:int
      -> kernel_id:string
      -> Notebook_cell_execution_task.t or_undefined
      [@@js.global "createNotebookCellExecutionTask"]

    val on_did_change_cell_execution_state :
      Notebook_cell_execution_state_change_event.t Event.t
      [@@js.global "onDidChangeCellExecutionState"]

    val on_did_change_active_notebook_kernel : Anonymous_interface4.t Event.t
      [@@js.global "onDidChangeActiveNotebookKernel"]

    val register_notebook_kernel_provider :
         selector:Notebook_document_filter.t
      -> provider:Notebook_kernel.t Notebook_kernel_provider.t
      -> Disposable.t
      [@@js.global "registerNotebookKernelProvider"]

    val create_notebook_editor_decoration_type :
         options:Notebook_decoration_render_options.t
      -> Notebook_editor_decoration_type.t
      [@@js.global "createNotebookEditorDecorationType"]

    val create_cell_status_bar_item :
         cell:Notebook_cell.t
      -> ?alignment:Notebook_cell_status_bar_alignment.t
      -> ?priority:int
      -> unit
      -> Notebook_cell_status_bar_item.t
      [@@js.global "createCellStatusBarItem"]

    val create_concat_text_document :
         notebook:Notebook_document.t
      -> ?selector:Document_selector.t
      -> unit
      -> Notebook_concat_text_document.t
      [@@js.global "createConcatTextDocument"]
  end
  [@@js.scope "notebook"]

  module Workspace_edit : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val replace_notebook_metadata :
      t -> uri:Uri.t -> value:Notebook_document_metadata.t -> unit
      [@@js.call "replaceNotebookMetadata"]

    val replace_notebook_cells :
         t
      -> uri:Uri.t
      -> start:int
      -> end_:int
      -> cells:Notebook_cell_data.t list
      -> ?metadata:Workspace_edit_entry_metadata.t
      -> unit
      -> unit
      [@@js.call "replaceNotebookCells"]

    val replace_notebook_cell_metadata :
         t
      -> uri:Uri.t
      -> index:int
      -> cell_metadata:Notebook_cell_metadata.t
      -> ?metadata:Workspace_edit_entry_metadata.t
      -> unit
      -> unit
      [@@js.call "replaceNotebookCellMetadata"]

    val replace_notebook_cell_output :
         t
      -> uri:Uri.t
      -> index:int
      -> outputs:Notebook_cell_output.t list
      -> ?metadata:Workspace_edit_entry_metadata.t
      -> unit
      -> unit
      [@@js.call "replaceNotebookCellOutput"]

    val append_notebook_cell_output :
         t
      -> uri:Uri.t
      -> index:int
      -> outputs:Notebook_cell_output.t list
      -> ?metadata:Workspace_edit_entry_metadata.t
      -> unit
      -> unit
      [@@js.call "appendNotebookCellOutput"]

    val replace_notebook_cell_output_items :
         t
      -> uri:Uri.t
      -> index:int
      -> output_id:string
      -> items:Notebook_cell_output_item.t list
      -> ?metadata:Workspace_edit_entry_metadata.t
      -> unit
      -> unit
      [@@js.call "replaceNotebookCellOutputItems"]

    val append_notebook_cell_output_items :
         t
      -> uri:Uri.t
      -> index:int
      -> output_id:string
      -> items:Notebook_cell_output_item.t list
      -> ?metadata:Workspace_edit_entry_metadata.t
      -> unit
      -> unit
      [@@js.call "appendNotebookCellOutputItems"]
  end
  [@@js.scope "WorkspaceEdit"]

  module Completion_item_label : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]

    val parameters : t -> string [@@js.get "parameters"]

    val set_parameters : t -> string -> unit [@@js.set "parameters"]

    val qualifier : t -> string [@@js.get "qualifier"]

    val set_qualifier : t -> string -> unit [@@js.set "qualifier"]

    val type_ : t -> string [@@js.get "type"]

    val set_type : t -> string -> unit [@@js.set "type"]
  end
  [@@js.scope "CompletionItemLabel"]

  module Completion_item : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val label2 : t -> Completion_item_label.t [@@js.get "label2"]

    val set_label2 : t -> Completion_item_label.t -> unit [@@js.set "label2"]
  end
  [@@js.scope "CompletionItem"]

  module Timeline_item : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val timestamp : t -> int [@@js.get "timestamp"]

    val set_timestamp : t -> int -> unit [@@js.set "timestamp"]

    val label : t -> string [@@js.get "label"]

    val set_label : t -> string -> unit [@@js.set "label"]

    val id : t -> string [@@js.get "id"]

    val set_id : t -> string -> unit [@@js.set "id"]

    val icon_path : t -> (Theme_icon.t, Uri.t, Anonymous_interface9.t) union3
      [@@js.get "iconPath"]

    val set_icon_path :
      t -> (Theme_icon.t, Uri.t, Anonymous_interface9.t) union3 -> unit
      [@@js.set "iconPath"]

    val description : t -> string [@@js.get "description"]

    val set_description : t -> string -> unit [@@js.set "description"]

    val detail : t -> string [@@js.get "detail"]

    val set_detail : t -> string -> unit [@@js.set "detail"]

    val command : t -> Command.t [@@js.get "command"]

    val set_command : t -> Command.t -> unit [@@js.set "command"]

    val context_value : t -> string [@@js.get "contextValue"]

    val set_context_value : t -> string -> unit [@@js.set "contextValue"]

    val accessibility_information : t -> Accessibility_information.t
      [@@js.get "accessibilityInformation"]

    val set_accessibility_information : t -> Accessibility_information.t -> unit
      [@@js.set "accessibilityInformation"]

    val create : label:string -> timestamp:int -> t [@@js.create]
  end
  [@@js.scope "TimelineItem"]

  module Timeline_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val uri : t -> Uri.t [@@js.get "uri"]

    val set_uri : t -> Uri.t -> unit [@@js.set "uri"]

    val reset : t -> bool [@@js.get "reset"]

    val set_reset : t -> bool -> unit [@@js.set "reset"]
  end
  [@@js.scope "TimelineChangeEvent"]

  module Anonymous_interface2 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val cursor : t -> string or_undefined [@@js.get "cursor"]
  end

  module Timeline : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val paging : t -> Anonymous_interface2.t [@@js.get "paging"]

    val items : t -> Timeline_item.t list [@@js.get "items"]
  end
  [@@js.scope "Timeline"]

  module Timeline_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val cursor : t -> string [@@js.get "cursor"]

    val set_cursor : t -> string -> unit [@@js.set "cursor"]

    val limit : t -> Anonymous_interface14.t or_number [@@js.get "limit"]

    val set_limit : t -> Anonymous_interface14.t or_number -> unit
      [@@js.set "limit"]
  end
  [@@js.scope "TimelineOptions"]

  module Timeline_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val on_did_change : t -> Timeline_change_event.t or_undefined Event.t
      [@@js.get "onDidChange"]

    val set_on_did_change :
      t -> Timeline_change_event.t or_undefined Event.t -> unit
      [@@js.set "onDidChange"]

    val id : t -> string [@@js.get "id"]

    val label : t -> string [@@js.get "label"]

    val provide_timeline :
         t
      -> uri:Uri.t
      -> options:Timeline_options.t
      -> token:Cancellation_token.t
      -> Timeline.t Provider_result.t
      [@@js.call "provideTimeline"]
  end
  [@@js.scope "TimelineProvider"]

  module Standard_token_type : sig
    type t =
      ([ `Other [@js 0]
       | `Comment [@js 1]
       | `String [@js 2]
       | `RegEx [@js 4]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Token_information : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val type_ : t -> Standard_token_type.t [@@js.get "type"]

    val set_type : t -> Standard_token_type.t -> unit [@@js.set "type"]

    val range : t -> Range.t [@@js.get "range"]

    val set_range : t -> Range.t -> unit [@@js.set "range"]
  end
  [@@js.scope "TokenInformation"]

  module Inline_hint_kind : sig
    type t =
      ([ `Other [@js 0]
       | `Type [@js 1]
       | `Parameter [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Inline_hint : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val text : t -> string [@@js.get "text"]

    val set_text : t -> string -> unit [@@js.set "text"]

    val range : t -> Range.t [@@js.get "range"]

    val set_range : t -> Range.t -> unit [@@js.set "range"]

    val kind : t -> Inline_hint_kind.t [@@js.get "kind"]

    val set_kind : t -> Inline_hint_kind.t -> unit [@@js.set "kind"]

    val description : t -> Markdown_string.t or_string [@@js.get "description"]

    val set_description : t -> Markdown_string.t or_string -> unit
      [@@js.set "description"]

    val whitespace_before : t -> bool [@@js.get "whitespaceBefore"]

    val set_whitespace_before : t -> bool -> unit [@@js.set "whitespaceBefore"]

    val whitespace_after : t -> bool [@@js.get "whitespaceAfter"]

    val set_whitespace_after : t -> bool -> unit [@@js.set "whitespaceAfter"]

    val create :
      text:string -> range:Range.t -> ?kind:Inline_hint_kind.t -> unit -> t
      [@@js.create]
  end
  [@@js.scope "InlineHint"]

  module Inline_hints_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val on_did_change_inline_hints : t -> unit Event.t
      [@@js.get "onDidChangeInlineHints"]

    val set_on_did_change_inline_hints : t -> unit Event.t -> unit
      [@@js.set "onDidChangeInlineHints"]

    val provide_inline_hints :
         t
      -> model:Text_document.t
      -> range:Range.t
      -> token:Cancellation_token.t
      -> Inline_hint.t list Provider_result.t
      [@@js.call "provideInlineHints"]
  end
  [@@js.scope "InlineHintsProvider"]

  module Languages : sig
    val get_token_information_at_position :
         document:Text_document.t
      -> position:Position.t
      -> Token_information.t Promise.t
      [@@js.global "getTokenInformationAtPosition"]

    val register_inline_hints_provider :
         selector:Document_selector.t
      -> provider:Inline_hints_provider.t
      -> Disposable.t
      [@@js.global "registerInlineHintsProvider"]
  end
  [@@js.scope "languages"]

  module Extension_runtime : sig
    type t =
      ([ `Node [@js 1]
       | `Webworker [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Extension_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val extension_runtime : t -> Extension_runtime.t
      [@@js.get "extensionRuntime"]
  end
  [@@js.scope "ExtensionContext"]

  module Text_document : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val notebook : t -> Notebook_document.t or_undefined [@@js.get "notebook"]

    val set_notebook : t -> Notebook_document.t or_undefined -> unit
      [@@js.set "notebook"]
  end
  [@@js.scope "TextDocument"]

  module Test_children_collection : sig
    include module type of struct
      include Iterable
    end

    val size : 'T t -> int [@@js.get "size"]

    val get : 'T t -> id:string -> 'T or_undefined [@@js.call "get"]

    val add : 'T t -> child:'T -> unit [@@js.call "add"]

    val delete : 'T t -> child:'T or_string -> unit [@@js.call "delete"]

    val clear : 'T t -> unit [@@js.call "clear"]
  end
  [@@js.scope "TestChildrenCollection"]

  module Anonymous_interface0 : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val busy : t -> bool [@@js.get "busy"]

    val set_busy : t -> bool -> unit [@@js.set "busy"]
  end

  module Test_item : sig
    type 'TChildren t

    val t_to_js : ('TChildren -> Ojs.t) -> 'TChildren t -> Ojs.t

    val t_of_js : (Ojs.t -> 'TChildren) -> Ojs.t -> 'TChildren t

    type t_0 = any t

    val t_0_to_js : t_0 -> Ojs.t

    val t_0_of_js : Ojs.t -> t_0

    val id : 'TChildren t -> string [@@js.get "id"]

    val uri : 'TChildren t -> Uri.t [@@js.get "uri"]

    val children : 'TChildren t -> 'TChildren Test_children_collection.t
      [@@js.get "children"]

    val label : 'TChildren t -> string [@@js.get "label"]

    val set_label : 'TChildren t -> string -> unit [@@js.set "label"]

    val description : 'TChildren t -> string [@@js.get "description"]

    val set_description : 'TChildren t -> string -> unit
      [@@js.set "description"]

    val range : 'TChildren t -> Range.t [@@js.get "range"]

    val set_range : 'TChildren t -> Range.t -> unit [@@js.set "range"]

    val runnable : 'TChildren t -> bool [@@js.get "runnable"]

    val set_runnable : 'TChildren t -> bool -> unit [@@js.set "runnable"]

    val debuggable : 'TChildren t -> bool [@@js.get "debuggable"]

    val set_debuggable : 'TChildren t -> bool -> unit [@@js.set "debuggable"]

    val expandable : 'TChildren t -> bool [@@js.get "expandable"]

    val set_expandable : 'TChildren t -> bool -> unit [@@js.set "expandable"]

    val create :
      id:string -> label:string -> uri:Uri.t -> expandable:bool -> 'TChildren t
      [@@js.create]

    val invalidate : 'TChildren t -> unit [@@js.call "invalidate"]

    val discover_children :
         'TChildren t
      -> progress:Anonymous_interface0.t Progress.t
      -> token:Cancellation_token.t
      -> unit
      [@@js.call "discoverChildren"]
  end
  [@@js.scope "TestItem"]

  module Tests_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val added : t -> any Test_item.t list [@@js.get "added"]

    val updated : t -> any Test_item.t list [@@js.get "updated"]

    val removed : t -> any Test_item.t list [@@js.get "removed"]
  end
  [@@js.scope "TestsChangeEvent"]

  module Test_observer : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val tests : t -> any Test_item.t list [@@js.get "tests"]

    val on_did_change_test : t -> Tests_change_event.t Event.t
      [@@js.get "onDidChangeTest"]

    val on_did_discover_initial_tests : t -> unit Event.t
      [@@js.get "onDidDiscoverInitialTests"]

    val dispose : t -> unit [@@js.call "dispose"]
  end
  [@@js.scope "TestObserver"]

  module Test_run_request : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    type t_0 = any Test_item.t t

    val t_0_to_js : t_0 -> Ojs.t

    val t_0_of_js : Ojs.t -> t_0

    val tests : 'T t -> 'T list [@@js.get "tests"]

    val set_tests : 'T t -> 'T list -> unit [@@js.set "tests"]

    val exclude : 'T t -> 'T list [@@js.get "exclude"]

    val set_exclude : 'T t -> 'T list -> unit [@@js.set "exclude"]

    val debug : 'T t -> bool [@@js.get "debug"]

    val set_debug : 'T t -> bool -> unit [@@js.set "debug"]
  end
  [@@js.scope "TestRunRequest"]

  module Test_result_state : sig
    type t =
      ([ `Unset [@js 0]
       | `Queued [@js 1]
       | `Running [@js 2]
       | `Passed [@js 3]
       | `Failed [@js 4]
       | `Skipped [@js 5]
       | `Errored [@js 6]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Test_message_severity : sig
    type t =
      ([ `Error [@js 0]
       | `Warning [@js 1]
       | `Information [@js 2]
       | `Hint [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Test_message : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val message : t -> Markdown_string.t or_string [@@js.get "message"]

    val set_message : t -> Markdown_string.t or_string -> unit
      [@@js.set "message"]

    val severity : t -> Test_message_severity.t [@@js.get "severity"]

    val set_severity : t -> Test_message_severity.t -> unit
      [@@js.set "severity"]

    val expected_output : t -> string [@@js.get "expectedOutput"]

    val set_expected_output : t -> string -> unit [@@js.set "expectedOutput"]

    val actual_output : t -> string [@@js.get "actualOutput"]

    val set_actual_output : t -> string -> unit [@@js.set "actualOutput"]

    val location : t -> Location.t [@@js.get "location"]

    val set_location : t -> Location.t -> unit [@@js.set "location"]

    val diff :
         message:Markdown_string.t or_string
      -> expected:string
      -> actual:string
      -> t
      [@@js.global "diff"]

    val create : message:Markdown_string.t or_string -> t [@@js.create]
  end
  [@@js.scope "TestMessage"]

  module Test_result_snapshot : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val id : t -> string [@@js.get "id"]

    val uri : t -> Uri.t [@@js.get "uri"]

    val label : t -> string [@@js.get "label"]

    val description : t -> string [@@js.get "description"]

    val range : t -> Range.t [@@js.get "range"]

    val state : t -> Test_result_state.t [@@js.get "state"]

    val duration : t -> int [@@js.get "duration"]

    val messages : t -> Test_message.t list [@@js.get "messages"]

    val children : t -> t Readonly.t list [@@js.get "children"]
  end
  [@@js.scope "TestResultSnapshot"]

  module Test_run_result : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val completed_at : t -> int [@@js.get "completedAt"]

    val set_completed_at : t -> int -> unit [@@js.set "completedAt"]

    val output : t -> string [@@js.get "output"]

    val set_output : t -> string -> unit [@@js.set "output"]

    val results : t -> Test_result_snapshot.t Readonly.t list
      [@@js.get "results"]

    val set_results : t -> Test_result_snapshot.t Readonly.t list -> unit
      [@@js.set "results"]
  end
  [@@js.scope "TestRunResult"]

  module Test_run_options : sig
    include module type of struct
      include Test_run_request
    end

    type t_0 = any Test_item.t t

    val t_0_to_js : t_0 -> Ojs.t

    val t_0_of_js : Ojs.t -> t_0

    val set_state :
         'T t
      -> test:'T
      -> state:Test_result_state.t
      -> ?duration:int
      -> unit
      -> unit
      [@@js.call "setState"]

    val append_message : 'T t -> test:'T -> message:Test_message.t -> unit
      [@@js.call "appendMessage"]

    val append_output : 'T t -> output:string -> unit [@@js.call "appendOutput"]
  end
  [@@js.scope "TestRunOptions"]

  module Test_provider : sig
    type 'T t

    val t_to_js : ('T -> Ojs.t) -> 'T t -> Ojs.t

    val t_of_js : (Ojs.t -> 'T) -> Ojs.t -> 'T t

    type t_0 = any Test_item.t t

    val t_0_to_js : t_0 -> Ojs.t

    val t_0_of_js : Ojs.t -> t_0

    val provide_workspace_test_root :
         'T t
      -> workspace:Workspace_folder.t
      -> token:Cancellation_token.t
      -> 'T Provider_result.t
      [@@js.call "provideWorkspaceTestRoot"]

    val provide_document_test_root :
         'T t
      -> document:Text_document.t
      -> token:Cancellation_token.t
      -> 'T Provider_result.t
      [@@js.call "provideDocumentTestRoot"]

    val run_tests :
         'T t
      -> options:'T Test_run_options.t
      -> token:Cancellation_token.t
      -> unit Provider_result.t
      [@@js.call "runTests"]
  end
  [@@js.scope "TestProvider"]

  module Test : sig
    val register_test_provider :
      test_provider:'T Test_provider.t -> Disposable.t
      [@@js.global "registerTestProvider"]

    val run_tests :
         run:'T Test_run_request.t
      -> ?token:Cancellation_token.t
      -> unit
      -> unit Promise.t
      [@@js.global "runTests"]

    val create_workspace_test_observer :
      workspace_folder:Workspace_folder.t -> Test_observer.t
      [@@js.global "createWorkspaceTestObserver"]

    val create_document_test_observer :
      document:Text_document.t -> Test_observer.t
      [@@js.global "createDocumentTestObserver"]

    val publish_test_result :
      results:Test_run_result.t -> ?persist:bool -> unit -> unit
      [@@js.global "publishTestResult"]

    val test_results : Test_run_result.t list [@@js.global "testResults"]

    val on_did_change_test_results : unit Event.t
      [@@js.global "onDidChangeTestResults"]
  end
  [@@js.scope "test"]

  module External_uri_opener_priority : sig
    type t =
      ([ `None [@js 0]
       | `Option [@js 1]
       | `Default [@js 2]
       | `Preferred [@js 3]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Open_external_uri_context : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val source_uri : t -> Uri.t [@@js.get "sourceUri"]
  end
  [@@js.scope "OpenExternalUriContext"]

  module External_uri_opener : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val can_open_external_uri :
         t
      -> uri:Uri.t
      -> token:Cancellation_token.t
      -> ( ( External_uri_opener_priority.t
           , External_uri_opener_priority.t Promise.t )
           union2
         , ([ `Default [@js 2]
            | `None [@js 0]
            | `Option [@js 1]
            | `Preferred [@js 3]
            ]
           [@js.enum]) )
         or_enum
      [@@js.call "canOpenExternalUri"]

    val open_external_uri :
         t
      -> resolved_uri:Uri.t
      -> ctx:Open_external_uri_context.t
      -> token:Cancellation_token.t
      -> (unit, unit Promise.t) union2
      [@@js.call "openExternalUri"]
  end
  [@@js.scope "ExternalUriOpener"]

  module External_uri_opener_metadata : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val schemes : t -> string list [@@js.get "schemes"]

    val label : t -> string [@@js.get "label"]
  end
  [@@js.scope "ExternalUriOpenerMetadata"]

  module Open_external_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val allow_contributed_openers : t -> bool or_string
      [@@js.get "allowContributedOpeners"]
  end
  [@@js.scope "OpenExternalOptions"]

  module Env : sig
    val open_external :
      target:Uri.t -> ?options:Open_external_options.t -> unit -> bool Promise.t
      [@@js.global "openExternal"]
  end
  [@@js.scope "env"]

  module Open_editor_info : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val name : t -> string [@@js.get "name"]

    val set_name : t -> string -> unit [@@js.set "name"]

    val resource : t -> Uri.t [@@js.get "resource"]

    val set_resource : t -> Uri.t -> unit [@@js.set "resource"]
  end
  [@@js.scope "OpenEditorInfo"]

  module Workspace_trust_state : sig
    type t =
      ([ `Untrusted [@js 0]
       | `Trusted [@js 1]
       | `Unspecified [@js 2]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Workspace_trust_state_change_event : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val new_trust_state : t -> Workspace_trust_state.t
      [@@js.get "newTrustState"]
  end
  [@@js.scope "WorkspaceTrustStateChangeEvent"]

  module Workspace_trust_request_options : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val modal : t -> bool [@@js.get "modal"]
  end
  [@@js.scope "WorkspaceTrustRequestOptions"]

  module Webview : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val post_message : t -> message:any -> bool Promise.t
      [@@js.call "postMessage"]
  end
  [@@js.scope "Webview"]

  module Port_auto_forward_action : sig
    type t =
      ([ `Notify [@js 1]
       | `OpenBrowser [@js 2]
       | `OpenPreview [@js 3]
       | `Silent [@js 4]
       | `Ignore [@js 5]
       ]
      [@js.enum])

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t
  end

  module Port_attributes : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val port : t -> int [@@js.get "port"]

    val set_port : t -> int -> unit [@@js.set "port"]

    val auto_forward_action : t -> Port_auto_forward_action.t
      [@@js.get "autoForwardAction"]

    val set_auto_forward_action : t -> Port_auto_forward_action.t -> unit
      [@@js.set "autoForwardAction"]
  end
  [@@js.scope "PortAttributes"]

  module Port_attributes_provider : sig
    type t

    val t_to_js : t -> Ojs.t

    val t_of_js : Ojs.t -> t

    val provide_port_attributes :
         t
      -> port:int
      -> pid:int or_undefined
      -> command_line:string or_undefined
      -> token:Cancellation_token.t
      -> Port_attributes.t Provider_result.t
      [@@js.call "providePortAttributes"]
  end
  [@@js.scope "PortAttributesProvider"]

  module Window : sig
    val create_webview_text_editor_inset :
         editor:Text_editor.t
      -> line:int
      -> height:int
      -> ?options:Webview_options.t
      -> unit
      -> Webview_editor_inset.t
      [@@js.global "createWebviewTextEditorInset"]

    val on_did_write_terminal_data : Terminal_data_write_event.t Event.t
      [@@js.global "onDidWriteTerminalData"]

    val on_did_change_terminal_dimensions :
      Terminal_dimensions_change_event.t Event.t
      [@@js.global "onDidChangeTerminalDimensions"]

    val create_status_bar_item :
      ?options:Status_bar_item_options.t -> unit -> Status_bar_item.t
      [@@js.global "createStatusBarItem"]

    val visible_notebook_editors : Notebook_editor.t list
      [@@js.global "visibleNotebookEditors"]

    val on_did_change_visible_notebook_editors : Notebook_editor.t list Event.t
      [@@js.global "onDidChangeVisibleNotebookEditors"]

    val active_notebook_editor : Notebook_editor.t or_undefined
      [@@js.global "activeNotebookEditor"]

    val on_did_change_active_notebook_editor :
      Notebook_editor.t or_undefined Event.t
      [@@js.global "onDidChangeActiveNotebookEditor"]

    val on_did_change_notebook_editor_selection :
      Notebook_editor_selection_change_event.t Event.t
      [@@js.global "onDidChangeNotebookEditorSelection"]

    val on_did_change_notebook_editor_visible_ranges :
      Notebook_editor_visible_ranges_change_event.t Event.t
      [@@js.global "onDidChangeNotebookEditorVisibleRanges"]

    val show_notebook_document :
         uri:Uri.t
      -> ?options:Notebook_document_show_options.t
      -> unit
      -> Notebook_editor.t Promise.t
      [@@js.global "showNotebookDocument"]

    val show_notebook_document :
         document:Notebook_document.t
      -> ?options:Notebook_document_show_options.t
      -> unit
      -> Notebook_editor.t Promise.t
      [@@js.global "showNotebookDocument"]

    val register_external_uri_opener :
         id:string
      -> opener:External_uri_opener.t
      -> metadata:External_uri_opener_metadata.t
      -> Disposable.t
      [@@js.global "registerExternalUriOpener"]

    val open_editors : Open_editor_info.t list [@@js.global "openEditors"]

    val on_did_change_open_editors : unit Event.t
      [@@js.global "onDidChangeOpenEditors"]
  end
  [@@js.scope "window"]

  module Workspace : sig
    val open_tunnel : tunnel_options:Tunnel_options.t -> Tunnel.t Promise.t
      [@@js.global "openTunnel"]

    val tunnels : Tunnel_description.t list Promise.t [@@js.global "tunnels"]

    val on_did_change_tunnels : unit Event.t [@@js.global "onDidChangeTunnels"]

    val register_remote_authority_resolver :
         authority_prefix:string
      -> resolver:Remote_authority_resolver.t
      -> Disposable.t
      [@@js.global "registerRemoteAuthorityResolver"]

    val register_resource_label_formatter :
      formatter:Resource_label_formatter.t -> Disposable.t
      [@@js.global "registerResourceLabelFormatter"]

    val register_file_search_provider :
      scheme:string -> provider:File_search_provider.t -> Disposable.t
      [@@js.global "registerFileSearchProvider"]

    val register_text_search_provider :
      scheme:string -> provider:Text_search_provider.t -> Disposable.t
      [@@js.global "registerTextSearchProvider"]

    val find_text_in_files :
         query:Text_search_query.t
      -> callback:(result:Text_search_result.t -> unit)
      -> ?token:Cancellation_token.t
      -> unit
      -> Text_search_complete.t Promise.t
      [@@js.global "findTextInFiles"]

    val find_text_in_files :
         query:Text_search_query.t
      -> options:Find_text_in_files_options.t
      -> callback:(result:Text_search_result.t -> unit)
      -> ?token:Cancellation_token.t
      -> unit
      -> Text_search_complete.t Promise.t
      [@@js.global "findTextInFiles"]

    val register_timeline_provider :
      scheme:string list -> provider:Timeline_provider.t -> Disposable.t
      [@@js.global "registerTimelineProvider"]

    val trust_state : Workspace_trust_state.t [@@js.global "trustState"]

    val request_workspace_trust :
         ?options:Workspace_trust_request_options.t
      -> unit
      -> Workspace_trust_state.t or_undefined Promise.t
      [@@js.global "requestWorkspaceTrust"]

    val on_did_change_workspace_trust_state :
      Workspace_trust_state_change_event.t Event.t
      [@@js.global "onDidChangeWorkspaceTrustState"]

    val register_port_attributes_provider :
         port_selector:Anonymous_interface10.t
      -> provider:Port_attributes_provider.t
      -> Disposable.t
      [@@js.global "registerPortAttributesProvider"]
  end
  [@@js.scope "workspace"]
end
[@@js.scope "vscode"]

include module type of struct
  include Vscode
end
