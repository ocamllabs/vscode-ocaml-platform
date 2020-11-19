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

let select_sandbox_command_id = "ocaml.select-sandbox"
