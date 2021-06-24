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

include Base

type ('a, 'b) result = ('a, 'b) Result.t

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

let log_json msg (json : Jsonoo.t) =
  let json_str = Jsonoo.stringify ~spaces:2 json in
  let (lazy output_channel) = Output.extension_output_channel in
  OutputChannel.appendLine output_channel ~value:(msg ^ " " ^ json_str ^ "\n")

let log_fields msg (fields : (string * Jsonoo.t) list) =
  log_json msg (Jsonoo.Encode.object_ fields)

let log_value msg (js_val : Ojs.t) = log_json msg (Jsonoo.t_of_js js_val)

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

(** Builds application-specific functionality around [Vscode.Position] *)
module Position = struct
  let compare p1 p2 =
    let r = Position.compareTo p1 ~other:p2 in
    if r < 0 then
      Ordering.Less
    else if r = 0 then
      Equal
    else
      Greater

  let t_of_json json =
    let line = Jsonoo.Decode.(field "line" int) json in
    let character = Jsonoo.Decode.(field "character" int) json in
    Position.make ~line ~character

  let json_of_t t =
    let line = Position.line t in
    let character = Position.character t in
    Jsonoo.Encode.(object_ [ ("line", int line); ("character", int character) ])

  include Vscode.Position
end

(** Build application-specific functionality around [Vscode.Range] *)
module Range = struct
  let compare r1 r2 =
    match Position.compare (Range.start r1) (Range.start r2) with
    | (Ordering.Less | Greater) as r -> r
    | Equal -> Position.compare (Range.end_ r1) (Range.end_ r2)

  let t_of_json json =
    let start = Jsonoo.Decode.field "start" Position.t_of_json json in
    let end_ = Jsonoo.Decode.field "end" Position.t_of_json json in
    Range.makePositions ~start ~end_

  let json_of_t t =
    let start = Range.start t |> Position.json_of_t in
    let end_ = Range.end_ t |> Position.json_of_t in
    Jsonoo.Encode.(object_ [ ("start", start); ("end", end_) ])

  include Vscode.Range
end
