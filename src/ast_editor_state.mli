open Import

(** This module's interface is private to [Ast_editor.t]. It is in a separate
    module to avoid circular dependencies with [Extension_instance.t] *)

type t

val make : unit -> t

val find_original_doc_by_pp_uri :
  uri_string:string -> ('a, string, 'b) Import.Map.t -> 'a option

val find_webview_by_doc : t -> document:TextDocument.t -> WebView.t option

val set_changes_tracking : t -> TextDocument.t -> TextDocument.t -> unit

val get_original_mode : t -> bool

val set_original_mode : t -> bool -> unit

val get_hover_disposable : t -> Disposable.t option

val set_hover_disposable : t -> Disposable.t option -> unit

val set_origin_changed : t -> data:bool -> key:string -> unit

val entry_exists : t -> origin_doc:string -> pp_doc:string -> bool

val get_origin_to_pp_doc_map :
  t -> (string, string, String.comparator_witness) Map.t

val on_origin_update_content : t -> TextDocument.t -> unit

val get_pp_doc_to_changed_origin_map :
  t -> (string, bool, String.comparator_witness) Map.t

val remove_doc_entries : t -> TextDocument.t -> unit

val get_webview_map : t -> (string, WebView.t, String.comparator_witness) Map.t

val set_webview_map :
  t -> (string, WebView.t, String.comparator_witness) Map.t -> unit
