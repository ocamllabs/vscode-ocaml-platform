open Import 

type t =
  { mutable webview_map : (string, WebView.t, String.comparator_witness) Map.t
  ; mutable original_mode : bool
  ; mutable hover_disposable_ref : Disposable.t option
  ; mutable pp_doc_to_changed_origin_map :
      (string, bool, String.comparator_witness) Map.t
  ; mutable origin_to_pp_doc_map :
      (string, string, String.comparator_witness) Map.t
  }