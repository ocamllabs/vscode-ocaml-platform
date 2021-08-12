open Import

(** This module's interface is private to [Ast_editor.t]. It is in a separate
    module to avoid circular dependencies with [Extension_instance.t] *)

type t

val make : unit -> t

val find_original_doc_by_pp_uri : t -> Uri.t -> string option

val find_webview_by_doc : t -> Vscode.Uri.t -> WebView.t option

val set_changes_tracking : t -> TextDocument.t -> TextDocument.t -> unit

val get_original_mode : t -> bool

val set_original_mode : t -> bool -> unit

val get_hover_disposable : t -> Disposable.t option

val set_hover_disposable : t -> Disposable.t option -> unit

val set_origin_changed : t -> uri:Uri.t -> unit

val entry_exists : t -> origin_doc:Uri.t -> pp_doc:Uri.t -> bool

val on_origin_update_content : t -> Uri.t -> unit

val pp_status : t -> Uri.t -> [ `Absent_or_pped | `Original ]

val remove_doc_entries : t -> TextDocument.t -> unit

val set_webview : t -> Uri.t -> WebView.t -> unit
