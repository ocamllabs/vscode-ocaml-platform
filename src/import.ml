(* Es2020 *)
module Reg_exp = Es2020.Reg_exp

(* Promise *)
module Promise = Promise

(* Json *)
module Json = Json

(* Vscode *)
include Vscode

(* Vscode_languageclient *)
module Language_client = struct
  include Vscode_languageclient
  include Vscode_languageclient.Language_client
end

(* Node *)
module Process = Node.Process

module Child_process = struct
  open Node
  include Node.Child_process

  type return =
    { exit_code : int
    ; stdout : string
    ; stderr : string
    }

  type event =
    | Spawned
    | Stdout of string
    | Stderr of string
    | Closed
    | ProcessError of Es2020.Error.t

  let append buf other = buf := Buffer.concat [ !buf; other ] ()

  let get_stdout cp =
    Node.Child_process.Child_process.get_stdout cp |> Option.get

  let get_stderr cp =
    Node.Child_process.Child_process.get_stderr cp |> Option.get

  let get_stdin cp = Node.Child_process.Child_process.get_stdin cp |> Option.get

  let handle_child_process ?logger ?stdin cp resolve =
    let log = Option.value logger ~default:ignore in

    log Spawned;

    let stdout_buf = ref (Buffer.create "" ()) in
    let on_stdout ~chunk =
      match chunk with
      | `String s ->
        append stdout_buf (Buffer.create s ());
        log @@ Stdout s
      | `Buffer b ->
        append stdout_buf b;
        log @@ Stdout (Buffer.to_string b ())
    in
    Stream.Readable.on (get_stdout cp) (`Data on_stdout);

    let stderr_buf = ref (Buffer.create "" ()) in
    let on_stderr ~chunk =
      match chunk with
      | `String s ->
        append stderr_buf (Buffer.create s ());
        log @@ Stderr s
      | `Buffer b ->
        append stderr_buf b;
        log @@ Stderr (Buffer.to_string b ())
    in
    Stream.Readable.on (get_stderr cp) (`Data on_stderr);

    let error ~err = log (ProcessError err) in
    Child_process.on cp (`Error error);

    let close : Child_process.Close_listener.t =
     fun ~code ~signal:_ ->
      log Closed;
      resolve
        { exit_code = Option.value code ~default:0
        ; stdout = Buffer.to_string !stdout_buf ()
        ; stderr = Buffer.to_string !stderr_buf ()
        }
    in
    Child_process.on cp (`Close close);

    match stdin with
    | Some text ->
      let _ = Stream.Writable.write (get_stdin cp) ~chunk:text () in
      Stream.Writable.end_ (get_stdin cp) ()
    | None -> ()

  let exec ?logger ?stdin ?options cmd =
    Promise.make @@ fun ~resolve ~reject:_ ->
    let cp = exec cmd ?options () in
    handle_child_process cp ?logger ?stdin resolve

  let spawn ?logger ?stdin ?options cmd args =
    Promise.make @@ fun ~resolve ~reject:_ ->
    let cp = spawn cmd ~args ?options () in
    handle_child_process cp ?logger ?stdin resolve
end

module Fs = struct
  include Node.Fs_promises

  let exists path =
    try
      let open Promise.Syntax in
      let+ () = access path () in
      true
    with
    | _ -> Promise.return false
end

module Dict = struct
  module StringMap = Map.Make (String)

  let t_of_js value_of_js js_obj =
    let ml_map = ref StringMap.empty in
    let iter key =
      let value = value_of_js (Ojs.get_prop_ascii js_obj key) in
      ml_map := StringMap.add key value !ml_map
    in
    Ojs.iter_properties js_obj iter;
    !ml_map

  let t_to_js value_to_js ml_map =
    let to_js (k, v) = (k, value_to_js v) in
    StringMap.to_seq ml_map |> Seq.map to_js |> Array.of_seq |> Ojs.obj

  let of_alist alist = StringMap.of_seq (List.to_seq alist)

  include StringMap
end

(* Base *)
include Base

(* Other *)

let property_exists json property =
  Ojs.has_property (Json.t_to_js json) property

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
    | `Warn -> Window.show_warning_message message ()
    | `Info -> Window.show_information_message message ()
    | `Error -> Window.show_error_message message ()
  in
  Printf.ksprintf
    (fun x ->
      let (_ : string option Promise.t) = k x in
      ())
    fmt

let log fmt =
  let (lazy output_channel) = Output.extension_output_channel in
  let write line = Output_channel.append_line output_channel ~value:line in
  Printf.ksprintf write fmt

let log_json msg (json : Json.t) =
  let json_str = Json.stringify ~spaces:2 json in
  let (lazy output_channel) = Output.extension_output_channel in
  Output_channel.append_line output_channel ~value:(msg ^ " " ^ json_str ^ "\n")

let log_fields msg (fields : (string * Json.t) list) =
  log_json msg (Json.Encode.object_ fields)

let log_value msg (js_val : Ojs.t) = log_json msg (Json.t_of_js js_val)

(** given a file uri, opens the file if it exists; otherwise, creates the file
    in "draft" mode (doesn't save it on disk)

    @return TextEditor.t in which the document was opened *)
let open_file_in_text_editor target_uri =
  let open Promise.Syntax in
  let uri = Uri.parse target_uri () in
  let* doc =
    Workspace.open_text_document (`Uri uri)
    |> Promise.catch ~rejected:(fun (_ : Promise.error) ->
           (* if file does not exist *)
           let change = Uri.With_change.create ~scheme:"untitled" () in
           let create_file_uri = Uri.with_ uri change in
           let+ doc = Workspace.open_text_document (`Uri create_file_uri) in
           doc)
  in
  let+ text_editor = Window.show_text_document doc () in
  text_editor

let with_confirmation message ~yes ?(no = "Cancel") f =
  let open Promise.Syntax in
  let* choice =
    Window.show_information_message message
      ~choices:[ (yes, true); (no, false) ]
      ()
  in
  match choice with
  | Some true -> f ()
  | _ -> Promise.return ()

let asset name = Path.of_string (Node.__filename () ^ "/../../assets/" ^ name)

let show_quick_pick_items choices ?options ?token () =
  let open Promise.Option.Syntax in
  let+ item =
    Window.show_quick_pick_items
      (Stdlib.List.map fst choices)
      ?options ?token ()
  in
  Stdlib.List.assoc item choices
