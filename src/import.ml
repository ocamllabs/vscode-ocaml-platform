include Vscode

module LanguageClient = struct
  include Vscode_languageclient
  include Vscode_languageclient.LanguageClient
end

module Process = Node.Process
module ChildProcess = Node.ChildProcess
module Fs = Node.Fs

let envSep =
  match Sys.unix with
  | true -> ':'
  | false -> ';'

let propertyExists json property =
  Ojs.has_property (Jsonoo.t_to_js json) property

module Or_error = struct
  type 'a t = ('a, string) result
end

let message kind fmt =
  let k message =
    match kind with
    | `Warn -> Window.showWarningMessage ~message ()
    | `Info -> Window.showInformationMessage ~message ()
    | `Error -> Window.showInformationMessage ~message ()
  in
  Printf.ksprintf
    (fun x ->
      let (_ : _ option Promise.t) = k x in
      ())
    fmt

let log fmt =
  let (lazy outputChannel) = Output.extensionOutputChannel in
  let write line = OutputChannel.appendLine outputChannel ~value:line in
  Printf.ksprintf write fmt

let logJson msg (fields : (string * Jsonoo.t) list) =
  let json = Jsonoo.Encode.object_ fields |> Jsonoo.stringify ~spaces:2 in
  let (lazy outputChannel) = Output.extensionOutputChannel in
  OutputChannel.appendLine outputChannel ~value:(msg ^ " " ^ json ^ "\n")
