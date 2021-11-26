open Import
module Uri = Vscode.Uri

type t =
  { mutable webview_map : (string, WebView.t, String.comparator_witness) Map.t
        (** The webview store that maps string value of Uri.t of the document to
            the related webview. *)
  ; mutable original_mode : bool
        (** Indicates current mode inside AST explorer (true = Original, false =
            Prerocessed) *)
  ; mutable hover_disposable : Disposable.t option
        (** Contains Some value when hover mode is enabled, None otherwise *)
  ; mutable dirty_original_doc_set : (string, String.comparator_witness) Set.t
        (** A set containing original documents (as opposed to Preprocessed
            Document) that have been changed since last Preprocessed Document
            opening (or reload) *)
  ; mutable origin_to_pp_doc_map :
      (string, string, String.comparator_witness) Map.t
        (** Mapping beween the original and Preprocessed Document used to
            simultaneously communicate with a common webview. *)
  }

let make () =
  let webview_map = Map.empty (module String) in
  let original_mode = true in
  let hover_disposable = None in
  let dirty_original_doc_set = Set.empty (module String) in
  let origin_to_pp_doc_map = Map.empty (module String) in
  { webview_map
  ; original_mode
  ; hover_disposable
  ; dirty_original_doc_set
  ; origin_to_pp_doc_map
  }

let find_original_doc_by_pp_uri t uri =
  let uri_s = Uri.toString uri () in
  let exception Found of string in
  match
    Map.iteri t.origin_to_pp_doc_map ~f:(fun ~key ~data ->
        if String.equal uri_s data then raise (Found key))
  with
  | () -> None
  | exception Found k -> Some k

let find_webview_by_doc t doc_uri =
  if t.original_mode then
    Map.find t.webview_map (Uri.toString doc_uri ())
  else
    let open Option.O in
    let* key = find_original_doc_by_pp_uri t doc_uri in
    Map.find t.webview_map key

let associate_origin_and_pp t ~origin_uri ~pp_doc_uri =
  let origin_uri = Uri.toString origin_uri () in
  let pp_doc_uri = Uri.toString pp_doc_uri () in
  t.origin_to_pp_doc_map <-
    Map.set t.origin_to_pp_doc_map ~key:origin_uri ~data:pp_doc_uri

let get_original_mode t = t.original_mode

let set_original_mode t value = t.original_mode <- value

let get_hover_disposable t = t.hover_disposable

let set_hover_disposable t hover_disposable =
  t.hover_disposable <- hover_disposable

let entry_exists t ~origin_doc ~pp_doc =
  let pp_doc = Uri.toString pp_doc () in
  let origin_doc = Uri.toString origin_doc () in
  Map.existsi t.origin_to_pp_doc_map ~f:(fun ~key ~data ->
      String.equal pp_doc data && String.equal origin_doc key)

let on_origin_update_content t changed_document =
  let uri = Uri.toString changed_document () in
  match Map.find t.origin_to_pp_doc_map (Uri.toString changed_document ()) with
  | None -> ()
  | Some _ -> t.dirty_original_doc_set <- Set.add t.dirty_original_doc_set uri

let remove_doc_entries (t : t) uri =
  let dirty_original_doc_set, origin_to_pp_doc_map =
    let uri = Uri.toString uri () in
    match Map.find t.origin_to_pp_doc_map uri with
    | Some uri ->
      ( Set.remove t.dirty_original_doc_set uri
      , Map.remove t.origin_to_pp_doc_map uri )
    | None ->
      ( Set.remove t.dirty_original_doc_set uri
      , Map.filteri t.origin_to_pp_doc_map ~f:(fun ~key:_ ~data ->
            not (String.equal data uri)) )
  in
  t.dirty_original_doc_set <- dirty_original_doc_set;
  t.origin_to_pp_doc_map <- origin_to_pp_doc_map

let set_webview t uri webview =
  let key = Uri.toString uri () in
  t.webview_map <- Map.set ~key ~data:webview t.webview_map

let remove_webview t uri =
  let key = Uri.toString uri () in
  t.webview_map <- Map.remove t.webview_map key

let pp_status t uri =
  if
    Set.exists t.dirty_original_doc_set ~f:(fun el ->
        match find_original_doc_by_pp_uri t uri with
        | Some uri -> String.equal el uri
        | None -> false)
  then
    `Original
  else
    `Absent_or_pped

let remove_dirty_original_doc t ~pp_uri =
  match find_original_doc_by_pp_uri t pp_uri with
  | Some uri ->
    t.dirty_original_doc_set <- Set.remove t.dirty_original_doc_set uri
  | None -> ()
