open Import
module Uri = Vscode.Uri

type t =
  { (* The webview store that maps string value of Uri.t of the document to the
       related webview. *)
    mutable webview_map : (string, WebView.t, String.comparator_witness) Map.t
        (* Indicates current mode inside AST explorer (true = Original, false =
           Prerocessed) *)
  ; mutable original_mode : bool
        (* Contains Some value when hover mode is enabled, None otherwise *)
  ; mutable hover_disposable : Disposable.t option
        (* Mapping between string value of Uri.t of the original (non
           preprocessed) document to boolean, indicating that the document has
           changed since opening its Preprocessed Document *)
  ; mutable pp_doc_to_changed_origin_set :
      (string, String.comparator_witness) Set.t
        (* Mapping beween the original and Preprocessed Document used to
           simultaneously communicate with a common webview. *)
  ; mutable origin_to_pp_doc_map :
      (string, string, String.comparator_witness) Map.t
  }

let make () =
  let webview_map = Map.empty (module String) in
  let original_mode = true in
  let hover_disposable = None in
  let pp_doc_to_changed_origin_set = Set.empty (module String) in
  let origin_to_pp_doc_map = Map.empty (module String) in
  { webview_map
  ; original_mode
  ; hover_disposable
  ; pp_doc_to_changed_origin_set
  ; origin_to_pp_doc_map
  }

let find_original_doc_by_pp_uri t uri =
  let r =
    Map.filter
      ~f:(fun data -> String.equal (Uri.toString uri ()) data)
      t.origin_to_pp_doc_map
    |> Map.keys
  in
  match r with
  | k :: _ -> Some k
  | _ -> None

let find_webview_by_doc t doc_uri =
  if t.original_mode then
    Map.find t.webview_map (Uri.toString doc_uri ())
  else
    let open Option.O in
    let* key = find_original_doc_by_pp_uri t doc_uri in
    Map.find t.webview_map key

let set_changes_tracking t origin pp_doc =
  let origin_uri = Uri.toString (TextDocument.uri origin) () in
  let pp_doc_uri = Uri.toString (TextDocument.uri pp_doc) () in
  t.origin_to_pp_doc_map <-
    Map.set t.origin_to_pp_doc_map ~key:origin_uri ~data:pp_doc_uri

let get_original_mode t = t.original_mode

let set_original_mode t value = t.original_mode <- value

let get_hover_disposable t = t.hover_disposable

let set_hover_disposable t hover_disposable =
  t.hover_disposable <- hover_disposable

let set_origin_changed t ~uri =
  let uri = Uri.toString uri () in
  t.pp_doc_to_changed_origin_set <- Set.add t.pp_doc_to_changed_origin_set uri

let entry_exists t ~origin_doc ~pp_doc =
  let pp_doc = Uri.toString pp_doc () in
  let origin_doc = Uri.toString origin_doc () in
  Map.existsi t.origin_to_pp_doc_map ~f:(fun ~key ~data ->
      String.equal pp_doc data && String.equal origin_doc key)

let on_origin_update_content t changed_document =
  match Map.find t.origin_to_pp_doc_map (Uri.toString changed_document ()) with
  | None -> ()
  | Some uri ->
    t.pp_doc_to_changed_origin_set <- Set.add t.pp_doc_to_changed_origin_set uri

let remove_doc_entries (t : t) uri =
  let pp_doc_to_changed_origin_set, origin_to_pp_doc_map =
    let origin_uri = Uri.toString (TextDocument.uri uri) () in
    match Map.find t.origin_to_pp_doc_map origin_uri with
    | Some uri ->
      ( Set.remove t.pp_doc_to_changed_origin_set uri
      , Map.remove t.origin_to_pp_doc_map origin_uri )
    | None ->
      ( Set.remove t.pp_doc_to_changed_origin_set origin_uri
      , Map.filteri t.origin_to_pp_doc_map ~f:(fun ~key:_ ~data ->
            not (String.equal data origin_uri)) )
  in
  t.pp_doc_to_changed_origin_set <- pp_doc_to_changed_origin_set;
  t.origin_to_pp_doc_map <- origin_to_pp_doc_map

let set_webview t uri webview =
  let key = Uri.toString uri () in
  t.webview_map <- Map.set ~key ~data:webview t.webview_map

let pp_status t uri =
  if
    Set.exists t.pp_doc_to_changed_origin_set ~f:(fun e ->
        String.equal e (Uri.toString uri ()))
  then
    `Original
  else
    `Absent_or_pped
