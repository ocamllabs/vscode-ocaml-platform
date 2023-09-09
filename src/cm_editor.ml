open Import
open Interop

module Cm_document : sig
  include CustomDocument.T

  val content :
    t -> instance:Extension_instance.t -> (string, string) result Promise.t

  val onDidChange : t -> Js.Unit.t Event.t

  val create : uri:Uri.t -> t
end = struct
  include CustomDocument
  module OnDidChange = Event.Make (Js.Unit)

  include
    [%js:
    val onDidChange : t -> OnDidChange.t [@@js.get]

    val create :
      uri:Uri.t -> onDidChange:OnDidChange.t -> dispose:(unit -> unit) -> t
    [@@js.builder]]

  let content t ~instance =
    let uri = uri t in
    let file_path = Uri.fsPath uri in
    let command =
      let sandbox = Extension_instance.sandbox instance in
      Sandbox.get_command sandbox "ocamlobjinfo" [ file_path ]
    in
    Cmd.output command

  let create ~(uri : Uri.t) =
    let module EventEmitter = EventEmitter.Make (Js.Unit) in
    let onDidChange_event_emitter = EventEmitter.make () in
    let onDidChange_event = EventEmitter.event onDidChange_event_emitter in
    let watcher =
      Workspace.createFileSystemWatcher
        (`String (Uri.fsPath uri))
        ~ignoreCreateEvents:true
        ~ignoreDeleteEvents:true
        ()
    in
    let disposable =
      FileSystemWatcher.onDidChange
        watcher
        ~listener:(fun _ -> EventEmitter.fire onDidChange_event_emitter ())
        ()
    in
    create ~uri ~onDidChange:onDidChange_event ~dispose:(fun () ->
        Disposable.dispose disposable)
end

let resolveCustomEditor instance ~document ~webviewPanel ~token:_ :
    unit Promise.t =
  let open Promise.Syntax in
  let disposables = Stack.create () in
  let update_content document =
    let+ content = Cm_document.content document ~instance in
    match content with
    | Ok file_content ->
      let webview = WebviewPanel.webview webviewPanel in
      WebView.set_html webview (Printf.sprintf "<pre>%s</pre>" file_content)
    | Error e ->
      let uri = Cm_document.uri document in
      let path = Uri.path uri in
      let file_name = Node.Path.basename path in
      let (_ : 'a option Promise.t) =
        Window.showErrorMessage
          ~message:
            (Printf.sprintf
               "Error while trying to read content from %s file. %s"
               file_name
               e)
          ()
      in
      ()
  in
  let (_ : unit) =
    Cm_document.onDidChange
      document
      ~listener:(fun () ->
        let (_ : unit Promise.t) = update_content document in
        ())
      ()
    |> Stack.push disposables
  in
  let (_ : unit) =
    WebviewPanel.onDidDispose
      webviewPanel
      ~listener:(fun () ->
        Disposable.from (Stack.to_list disposables) |> Disposable.dispose)
      ()
    |> Stack.push disposables
  in
  update_content document

let openCustomDocument ~(uri : Uri.t) ~openContext:_ ~token:_ :
    Cm_document.t Promise.t =
  let document = Cm_document.create ~uri in
  Promise.resolve document

let register (extension : ExtensionContext.t) (instance : Extension_instance.t)
    =
  let module CustomReadonlyEditorProvider =
    CustomReadonlyEditorProvider.Make (Cm_document) in
  let editorProvider =
    CustomReadonlyEditorProvider.create
      ~resolveCustomEditor:(resolveCustomEditor instance)
      ~openCustomDocument
  in
  let disposable =
    Vscode.Window.registerCustomReadonlyEditorProvider
      (module Cm_document)
      ~viewType:"cm-files-editor"
      ~provider:editorProvider
      ~options:
        (Vscode.RegisterCustomEditorProviderOptions.create
           ~supportsMultipleEditorsPerDocument:true
           ())
      ()
  in
  Vscode.ExtensionContext.subscribe extension ~disposable
