open Import
open Interop

module Cm_document : sig
  include module type of CustomDocument

  val content : t -> (string, string) result Promise.t

  val create : uri:Uri.t -> dispose:(unit -> unit) -> t

  val onDidChange : t -> Js.Unit.t Event.t
end = struct
  include CustomDocument
  module OnDidChange = Event.Make (Js.Unit)

  include
    [%js:
    val onDidChange : t -> OnDidChange.t [@@js.get]

    val create :
         uri:Uri.t
      -> ?onDidChange:OnDidChange.t
      -> dispose:(unit -> unit)
      -> unit
      -> t
      [@@js.builder]]

  let content t =
    let uri = uri t in
    let file_path = Uri.fsPath uri in
    let bin = Path.of_string "ocamlobjinfo" in
    Cmd.(output (Spawn { bin; args = [ file_path ] }))

  let create ~(uri : Uri.t) ~dispose =
    let module EventEmitter = EventEmitter.Make (Js.Unit) in
    let onDidChange_event_emitter = EventEmitter.make () in
    let onDidChange_event = EventEmitter.event onDidChange_event_emitter in
    let watcher =
      Workspace.createFileSystemWatcher
        (`String (Uri.fsPath uri))
        ~ignoreCreateEvents:true ~ignoreDeleteEvents:true ()
    in
    let disposable =
      FileSystemWatcher.onDidChange watcher
        ~listener:(fun _ -> EventEmitter.fire onDidChange_event_emitter ())
        ()
    in
    create ~uri ~onDidChange:onDidChange_event
      ~dispose:(fun () ->
        Disposable.dispose disposable;
        dispose ())
      ()
end

let resolveCustomEditor _instance ~document ~webviewPanel ~token:_ :
    unit Promise.t =
  let open Promise.Syntax in
  let update_content document =
    let+ content = Cm_document.content document in
    match content with
    | Ok file_content ->
      let webview = WebviewPanel.webview webviewPanel in
      WebView.set_html webview (Printf.sprintf "<pre>%s</pre>" file_content)
    | Error e ->
      let uri = Cm_document.uri document in
      let () = log "Error while trying to read content from file: %s" e in
      let path = Uri.path uri in
      let (_ : 'a option Promise.t) =
        Window.showErrorMessage
          ~message:
            (Printf.sprintf "Error while trying to read content from %s."
               (Node.Path.basename path))
          ()
      in
      ()
  in
  let disposable =
    Cm_document.onDidChange document
      ~listener:(fun () ->
        let (_ : unit Promise.t) = update_content document in
        ())
      ()
  in
  let (_ : Disposable.t) =
    WebviewPanel.onDidDispose webviewPanel
      ~listener:(fun () -> Disposable.dispose disposable)
      ()
  in
  update_content document

let openCustomDocument _instance ~(uri : Uri.t) ~openContext:_ ~token:_ :
    Cm_document.t Promise.t =
  let document = Cm_document.create ~uri ~dispose:(fun () -> ()) in
  Promise.resolve document

let register (extension : ExtensionContext.t) (instance : Extension_instance.t)
    =
  let module CustomReadonlyEditorProvider =
    CustomReadonlyEditorProvider.Make (Cm_document) in
  let editorProvider =
    CustomReadonlyEditorProvider.create
      ~resolveCustomEditor:(resolveCustomEditor instance)
      ~openCustomDocument:(openCustomDocument instance)
  in
  let disposable =
    Vscode.Window.registerCustomReadonlyEditorProvider
      (module Cm_document)
      ~viewType:"cm-files-editor" ~provider:editorProvider
      ~options:
        (Vscode.RegisterCustomEditorProviderOptions.create
           ~supportsMultipleEditorsPerDocument:true ())
      ()
  in
  Vscode.ExtensionContext.subscribe extension ~disposable
