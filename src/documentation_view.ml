open Import

type location =
  { path : string
  ; fragment : string
  ; scroll : int option
  }

type t =
  { panel : WebviewPanel.t
  ; root : string
  ; real_root : string Promise.t Lazy.t
  ; assets : Uri.t
  ; mutable disposed : bool
  ; mutable revision : int
  ; mutable nonce : string
  ; mutable current : location option
  ; mutable back : location list
  ; mutable forward : location list
  }

let root t = t.root
let is_disposed t = t.disposed
let dispose t = if not t.disposed then WebviewPanel.dispose t.panel

let resource webview uri =
  (* Keep URI encoding enabled for interpolation into HTML attributes. *)
  Uri.toString (WebView.asWebviewUri webview ~localResource:uri) ~skipEncoding:false ()
;;

let inside root file =
  let relative = Node.Path.relative root file in
  not
    (Node.Path.isAbsolute relative
     || String.equal relative ".."
     || String.is_prefix relative ~prefix:(".." ^ String.of_char Node.Path.sep))
;;

module Error = [%js: val create : string -> Node.JsError.t [@@js.new "Error"]]

let require condition message =
  if condition then Promise.return () else Promise.reject (Error.create message)
;;

let read_page t path =
  let open Promise.Syntax in
  let* root = Lazy.force t.real_root in
  let* file = Node.Fs.realpath (Node.Path.join [ root; path ]) in
  let* () =
    require (inside root file) "The link is outside the documentation directory"
  in
  let* stats = Node.Fs.stat file in
  let* file =
    if Node.Fs.Stats.isDirectory stats
    then Node.Fs.realpath (Node.Path.join [ file; "index.html" ])
    else Promise.return file
  in
  let* () =
    require (inside root file) "The link is outside the documentation directory"
  in
  let* () =
    require
      (List.mem [ ".html"; ".htm" ] (Node.Path.extname file) ~equal:String.equal)
      "This link does not point to an HTML document"
  in
  let* html = Node.Fs.readFile file in
  let+ () =
    require
      (String.is_substring html ~substring:"<head>")
      "This file is not a generated documentation page"
  in
  root, file, html
;;

let render t location root file html =
  let webview = WebviewPanel.webview t.panel in
  let nonce = Node.Crypto.randomUUID () in
  t.nonce <- nonce;
  let base = Uri.file (Node.Path.dirname file ^ String.of_char Node.Path.sep) in
  WebView.set_options
    webview
    (WebviewOptions.create
       ~enableScripts:true
       ~enableForms:false
       ~localResourceRoots:[ Uri.file root; t.assets ]
       ());
  let root = Uri.file (root ^ String.of_char Node.Path.sep) in
  let config =
    let open Jsonoo.Encode in
    object_
      [ "nonce", string nonce
      ; "root", string (resource webview root)
      ; "fragment", string location.fragment
      ; ( "scroll"
        , match location.scroll with
          | Some scroll -> int scroll
          | None -> null )
      ; "back", bool (not (List.is_empty t.back))
      ; "forward", bool (not (List.is_empty t.forward))
      ]
    |> Jsonoo.stringify
    |> fun value -> String.substr_replace_all value ~pattern:"<" ~with_:"\\u003c"
  in
  let csp =
    Printf.sprintf
      "default-src 'none'; base-uri %s; img-src %s data:; font-src %s; style-src %s \
       'unsafe-inline'; script-src 'nonce-%s' %s; connect-src %s; worker-src blob:; \
       form-action 'none';"
      (WebView.cspSource webview)
      (WebView.cspSource webview)
      (WebView.cspSource webview)
      (WebView.cspSource webview)
      nonce
      (WebView.cspSource webview)
      (WebView.cspSource webview)
  in
  let asset name = resource webview (Uri.joinPath t.assets ~pathSegments:[ name ]) in
  let head =
    Printf.sprintf
      "<head><meta http-equiv=\"Content-Security-Policy\" content=\"%s\"><base \
       href=\"%s\"><script id=\"ocaml-documentation-config\" type=\"application/json\" \
       nonce=\"%s\">%s</script><link rel=\"stylesheet\" href=\"%s\"><script nonce=\"%s\" \
       src=\"%s\" defer></script>"
      csp
      (resource webview base)
      nonce
      config
      (asset "documentation.css")
      nonce
      (asset "documentation.js")
  in
  let html =
    html
    |> String.substr_replace_all
         ~pattern:"<script"
         ~with_:(Printf.sprintf "<script nonce=\"%s\"" nonce)
    |> String.substr_replace_first ~pattern:"<head>" ~with_:head
  in
  WebView.set_html webview html;
  WebviewPanel.set_title
    t.panel
    (Printf.sprintf
       "OCaml Documentation — %s"
       (Node.Path.basename (Node.Path.dirname file)))
;;

let load t location ~back ~forward =
  t.revision <- t.revision + 1;
  let revision = t.revision in
  let open Promise.Syntax in
  let operation =
    let+ root, file, html = read_page t location.path in
    if (not t.disposed) && Int.equal revision t.revision
    then (
      t.back <- back;
      t.forward <- forward;
      t.current <- Some location;
      render t location root file html)
  in
  Promise.catch operation ~rejected:(fun error ->
    if t.disposed || not (Int.equal revision t.revision)
    then Promise.return ()
    else Promise.reject error)
;;

let show t ~path =
  if t.disposed
  then Promise.return ()
  else (
    WebviewPanel.reveal t.panel ();
    let back =
      match t.current with
      | Some current when not (String.equal current.path path) -> current :: t.back
      | _ -> t.back
    in
    load t { path; fragment = ""; scroll = None } ~back ~forward:[])
;;

let receive t message =
  let string key =
    let value = Ojs.get_prop_ascii message key in
    if String.equal (Ojs.type_of value) "string"
    then Some (Ojs.string_of_js value)
    else None
  in
  let scroll =
    let value = Ojs.get_prop_ascii message "scroll" in
    if String.equal (Ojs.type_of value) "number"
    then Some (Int.max 0 (Ojs.int_of_js value))
    else None
  in
  match string "nonce", string "type", t.current with
  | Some nonce, Some kind, Some current when String.equal nonce t.nonce && not t.disposed
    ->
    let current = { current with scroll } in
    t.current <- Some current;
    (match kind with
     | "navigate" ->
       (match string "path", string "fragment" with
        | Some path, Some fragment ->
          load t { path; fragment; scroll = None } ~back:(current :: t.back) ~forward:[]
        | _ -> Promise.return ())
     | "back" ->
       (match t.back with
        | location :: back -> load t location ~back ~forward:(current :: t.forward)
        | [] -> Promise.return ())
     | "forward" ->
       (match t.forward with
        | location :: forward -> load t location ~back:(current :: t.back) ~forward
        | [] -> Promise.return ())
     | "reload" -> load t current ~back:t.back ~forward:t.forward
     | "external" ->
       (match string "href" with
        | None -> Promise.return ()
        | Some href ->
          let uri = Uri.parse href () in
          if List.mem [ "https"; "http"; "mailto" ] (Uri.scheme uri) ~equal:String.equal
          then
            let open Promise.Syntax in
            let+ _ = Env.openExternal ~target:uri in
            ()
          else Promise.return ())
     | _ -> Promise.return ())
  | _ -> Promise.return ()
;;

let create ~panel ~root ~extension_uri =
  let assets = Uri.joinPath extension_uri ~pathSegments:[ "assets" ] in
  let t =
    { panel
    ; root
    ; real_root = lazy (Node.Fs.realpath root)
    ; assets
    ; disposed = false
    ; revision = 0
    ; nonce = ""
    ; current = None
    ; back = []
    ; forward = []
    }
  in
  let webview = WebviewPanel.webview panel in
  WebView.set_options
    webview
    (WebviewOptions.create
       ~enableScripts:true
       ~enableForms:false
       ~localResourceRoots:[ Uri.file root; assets ]
       ());
  let messages =
    WebView.onDidReceiveMessage
      webview
      ~listener:(fun message ->
        let open Promise.Syntax in
        let operation =
          let* () = Promise.return () in
          receive t message
        in
        let (_ : unit Promise.t) =
          Promise.catch operation ~rejected:(fun error ->
            if not t.disposed
            then
              show_message
                `Error
                "Could not open documentation: %s"
                (Node.JsError.message error);
            Promise.return ())
        in
        ())
      ()
  in
  let (_ : Disposable.t) =
    WebviewPanel.onDidDispose
      panel
      ~listener:(fun () ->
        t.disposed <- true;
        Disposable.dispose messages)
      ()
  in
  t
;;
