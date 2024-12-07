open Import

(** This module's interface is private to [Ast_editor.t]. It is in a separate
    module to avoid circular dependencies with [Extension_instance.t] *)

type t

type ast_mode =
  | Original_ast
  | Preprocessed_ast

val make : unit -> t
val find_original_doc_by_pp_uri : t -> Uri.t -> string option
val find_webview_by_doc : t -> Uri.t -> WebView.t option
val associate_origin_and_pp : t -> origin_uri:Uri.t -> pp_doc_uri:Uri.t -> unit
val get_current_ast_mode : t -> ast_mode
val set_current_ast_mode : t -> ast_mode -> unit
val get_hover_disposable : t -> Disposable.t option
val set_hover_disposable : t -> Disposable.t option -> unit
val entry_exists : t -> origin_doc:Uri.t -> pp_doc:Uri.t -> bool
val on_origin_update_content : t -> Uri.t -> unit
val pp_status : t -> Uri.t -> [ `Absent_or_pped | `Original ]
val remove_doc_entries : t -> Uri.t -> unit
val set_webview : t -> Uri.t -> WebView.t -> unit
val remove_dirty_original_doc : t -> pp_uri:Uri.t -> unit
val remove_webview : t -> Uri.t -> unit
