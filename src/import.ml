include Vscode
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
    | `Warn -> Vscode.Window.show_warning_message ~message ~choices:[] ()
    | `Info -> Vscode.Window.show_information_message ~message ~choices:[] ()
    | `Error -> Vscode.Window.show_error_message ~message ~choices:[] ()
  in
  Printf.ksprintf
    (fun x ->
      let (_ : _ option Promise.t) = k x in
      ())
    fmt

module Log : sig
  type field

  val field : _ -> field
end = struct
  type field

  external field : _ -> field = "%identity"
end

let log fmt =
  let (lazy outputChannel) = Output.extensionOutputChannel in
  let write line = OutputChannel.append_line outputChannel ~value:line in
  Printf.ksprintf write fmt

let logJson msg (fields : (string * Jsonoo.t) list) =
  let json = Jsonoo.Encode.object_ fields |> Jsonoo.stringify ~spaces:2 in
  let (lazy outputChannel) = Output.extensionOutputChannel in
  OutputChannel.append_line outputChannel ~value:(msg ^ " " ^ json ^ "\n")
