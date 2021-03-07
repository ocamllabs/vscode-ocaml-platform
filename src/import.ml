include Vscode

module LanguageClient = struct
  include Vscode_languageclient
  include Vscode_languageclient.LanguageClient
end

module Process = Node.Process
module ChildProcess = Node.ChildProcess
module Fs = Node.Fs

let property_exists json property =
  Ojs.has_property (Jsonoo.t_to_js json) property

include Core_kernel

module Option = struct
  include Option

  module O = struct
    let ( let* ) x f = bind ~f x

    let ( let+ ) x f = map ~f x
  end
end

module Or_error = struct
  type 'a t = ('a, string) result
end

let show_message kind fmt =
  let k message =
    match kind with
    | `Warn -> Window.showWarningMessage ~message ()
    | `Info -> Window.showInformationMessage ~message ()
    | `Error -> Window.showInformationMessage ~message ()
  in
  Printf.ksprintf
    (fun x ->
      let (_ : unit option Promise.t) = k x in
      ())
    fmt

let log fmt =
  let (lazy output_channel) = Output.extension_output_channel in
  let write line = OutputChannel.appendLine output_channel ~value:line in
  Printf.ksprintf write fmt

let log_json msg (fields : (string * Jsonoo.t) list) =
  let json = Jsonoo.Encode.object_ fields |> Jsonoo.stringify ~spaces:2 in
  let (lazy output_channel) = Output.extension_output_channel in
  OutputChannel.appendLine output_channel ~value:(msg ^ " " ^ json ^ "\n")

(** given a file uri, opens the file if it exists; otherwise, creates the file
    in "draft" mode (doesn't save it on disk)

    @return TextEditor.t in which the document was opened *)
let open_file_in_text_editor target_uri =
  let open Promise.Syntax in
  let uri = Uri.parse target_uri () in
  let* doc =
    Workspace.openTextDocument (`Uri uri)
    |> Promise.catch ~rejected:(fun (_ : Promise.error) ->
           (* if file does not exist *)
           let create_file_uri = Uri.with_ uri ~scheme:`Untitled () in
           let+ doc = Workspace.openTextDocument (`Uri create_file_uri) in
           doc)
  in
  let+ text_editor = Window.showTextDocument ~document:(`TextDocument doc) () in
  text_editor

let with_confirmation message ~yes ?(no = "Cancel") f =
  let open Promise.Syntax in
  let* choice =
    Vscode.Window.showInformationMessage ~message
      ~choices:[ (yes, true); (no, false) ]
      ()
  in
  match choice with
  | Some true -> f ()
  | _ -> Promise.return ()
