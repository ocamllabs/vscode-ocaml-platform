(* ocamlgrep: project-wide search for OCaml expression patterns. *)

open Import
open Printf
open Promise.Syntax

let extension_name = "OCamlgrep"

let is_valid_text_doc textdoc =
  match TextDocument.languageId textdoc with
  | "ocaml"
  | "ocaml.interface"
  | "ocaml.ocamllex"
  | "ocaml.mlx"
  | "reason" -> true
  | _ -> false

let input_box =
  InputBox.set
    (Window.createInputBox ())
    ~title:"OCamlgrep: Search OCaml Expressions"
    ~ignoreFocusOut:false
    ~placeholder:"List.filter __ __"
    ~prompt:
      "Enter an OCaml expression pattern. Use __ as a wildcard, __1/__2 for \
       metavariables, and (e : t) to constrain types."
    ()

let log_to_output lines =
  let channel = Lazy.force Output.extension_output_channel in
  List.iter lines ~f:(fun line -> OutputChannel.appendLine channel ~value:line);
  OutputChannel.show channel ~preserveFocus:true ()

(*
   Show findings in VS Code's built-in References panel.

   It stays open while the user navigates between files, unlike a QuickPick
   which closes on focus loss.
*)
let display_results
    query text_editor (response : Custom_requests.Ocamlgrep.response) =
  let { Custom_requests.Ocamlgrep.findings; warnings; errors } = response in
  log_to_output
    (sprintf "ocamlgrep %S: %d finding(s)" query (List.length findings)
     :: List.map warnings ~f:(fun w -> "  " ^ w)
     @ List.map errors ~f:(fun e -> "  Error: " ^ e));
  match errors, findings with
  | first_error :: _, _ ->
    (* User-facing errors (e.g. project root not found) — shown as a plain
       warning, not a scary error popup. Full text is in the output channel. *)
    show_message `Warn "ocamlgrep: %s (see output panel for details)"
      first_error
  | [], [] ->
    let hint =
      match warnings with
      | [] -> ""
      | _ -> " (see 'OCaml Platform Extension' output for coverage details)"
    in
    show_message `Info "ocamlgrep: no matches found%s." hint
  | _ ->
    let anchor_uri = TextEditor.document text_editor |> TextDocument.uri in
    let anchor_pos = TextEditor.selection text_editor |> Selection.active in
    let locations =
      Array.of_list
        (List.map findings ~f:(fun (f : Custom_requests.Ocamlgrep.finding) ->
           Location.make ~uri:f.uri ~rangeOrPosition:(`Range f.range)))
    in
    ignore
      (Commands.executeCommand
         ~command:"editor.action.showReferences"
         ~args:
           [ [%js.of: Uri.t] anchor_uri
           ; [%js.of: Position.t] anchor_pos
           ; [%js.of: Location.t array] locations
           ])

let scan_folder query (scan_root : Path.t)
  : Custom_requests.Ocamlgrep.response Promise.t =
  let cmd =
    Cmd.(
      Spawn
        { bin = Path.of_string "ocamlgrep"
        ; args = [ "--format"; "json"; query ]
        })
  in
  let+ result : ChildProcess.return = Cmd.run ~cwd:scan_root cmd in
  (* Exit code 1 ("no matches") is not an error. *)
  match result.exitCode with
  | 0 | 1 ->
    let resolve_path path =
      (if Path.is_absolute path then path
       else Path.join scan_root path)
      |> Path.to_string
      |> Uri.file
    in
    (match
       Jsonoo.try_parse_opt result.stdout
       |> Option.map
         ~f:(Custom_requests.Ocamlgrep.decode_response ~resolve_path)
     with
     | Some r -> r
     | None ->
         { findings = []
         ; warnings = []
         ; errors =
             [ sprintf
                 "unexpected output from workspace root '%s'"
                 (Path.to_string scan_root)
             ]
         })
  | exit_code ->
      { findings = []
      ; warnings = []
      ; errors =
          [ sprintf
              "ocamlgrep failed in %s with exit code %d: %s"
              (Path.to_string scan_root)
              exit_code
              (String.strip result.stderr)
          ]
      }

(*
   TODO: derive the scan root from the current file,
   using 'Dune_root.find_nearest_dune_project' - instead of using each
   workspace folder as a root (because they may not be within a Dune
   workspace).
*)
let show_query_input =
  let previous : Disposable.t option ref = ref None in
  fun scan_root text_editor ->
    log_to_output
      [sprintf "ocamlgrep scan root: %s" (Path.to_string scan_root)];
    let () =
      match !previous with
      | None -> ()
      | Some d -> Disposable.dispose d
    in
    let disposable =
      InputBox.onDidAccept
        input_box
        ~listener:(fun () ->
          match InputBox.value input_box with
          | Some query when String.length query > 0 ->
            InputBox.hide input_box;
            ignore
              (let+ response =
                 scan_folder query scan_root
                 |> Promise.catch ~rejected:(fun e ->
                      let msg =
                        if Ojs.has_property e "message"
                        then [%js.to: string] (Ojs.get_prop_ascii e "message")
                        else [%js.to: string] e
                      in
                      show_message `Error "ocamlgrep: %s" msg;
                      Promise.return Custom_requests.Ocamlgrep.empty_response)
               in
               display_results query text_editor response)
          | _ -> ())
        ()
    in
    previous := Some disposable;
    InputBox.show input_box

let with_check_for_ocamlgrep func =
  (* Check for the presence of the ocamlgrep command.

     It would be nicer if we didn't have to do this probing first
     and simply could catch ENOENT ourselves.
  *)
  let cmd = Cmd.(Spawn { bin = Path.of_string "ocamlgrep"; args = [] }) in
  let* check_result = Cmd.check cmd in
  match check_result with
  | Error _ ->
      show_message
        `Error
        "ocamlgrep is not installed. \
         Please install it with: opam install ocamlgrep";
      Promise.return ()
  | Ok _ ->
      func ()

(* This ignores VSCode workspace boundaries and may return a root folder
   that is an ancestor of one of the VSCode workspaces. *)
let get_scan_root (text_editor : TextEditor.t) =
   let active_file_path =
     text_editor
     |> TextEditor.document
     |> TextDocument.uri
     |> Uri.path
     |> Path.of_string
   in
   Dune_root.find active_file_path

let with_scan_root (text_editor : TextEditor.t) func =
  let+ opt_root = get_scan_root text_editor in
  match opt_root with
  | Error msg -> show_message `Error "%s" msg
  | Ok path -> func path

let callback (_instance : Extension_instance.t) () =
  match Window.activeTextEditor () with
  | None ->
      Command_api.Command_errors.text_editor_must_be_active
        extension_name
        ~expl:"An OCaml file must be open to determine the project root."
      |> show_message `Error "%s"
  | Some text_editor
    when not (is_valid_text_doc (TextEditor.document text_editor)) ->
      show_message
        `Error
        "Invalid file type. This command only works in OCaml source files."
  | Some text_editor ->
      with_check_for_ocamlgrep (fun () ->
        with_scan_root text_editor
          (fun root -> show_query_input root text_editor)
      )
      |> ignore
