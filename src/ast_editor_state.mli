open Import

(** This module's interface is private to [Ast_editor.t]. It is in a separate
    module to avoid circular dependencies with [Extension_instance.t] *)

type t

val make : unit -> t

val find_original_doc_by_pp_uri : t -> uri:string -> string option

val find_webview_by_doc : t -> document:TextDocument.t -> WebView.t option

val set_changes_tracking : t -> TextDocument.t -> TextDocument.t -> unit

val get_original_mode : t -> bool

val set_original_mode : t -> bool -> unit

val get_hover_disposable : t -> Disposable.t option

val set_hover_disposable : t -> Disposable.t option -> unit

val set_origin_changed : t -> data:bool -> key:string -> unit

val entry_exists : t -> origin_doc:string -> pp_doc:string -> bool

val on_origin_update_content : t -> TextDocument.t -> unit

val pp_status : t -> uri:string -> [ `Absent_or_pped | `Original ]

val remove_doc_entries : t -> TextDocument.t -> unit

val set_webview : t -> uri:string -> WebView.t -> unit
