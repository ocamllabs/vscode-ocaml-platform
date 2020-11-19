open Import

let suggest_to_setup_toolchain instance =
  let open Promise.Syntax in
  let+ selection =
    Window.showInformationMessage
      ~message:
        "Extension is unable to find ocamllsp automatically. Please select \
         package manager you used to install ocamllsp for this project."
      ~choices:[ ("Select package manager", ()) ]
      ()
  in
  match selection with
  | None -> ()
  | Some () -> Extension_commands.select_sandbox.handler instance ()

let activate (extension : ExtensionContext.t) =
  (* this env var update disables ocaml-lsp's logging to a file
     because we use vscode [output] pane for logs *)
  Process.Env.set "OCAML_LSP_SERVER_LOG" "-";
  let instance = Extension_instance.create () in
  Extension_commands.register_all_commands extension instance;
  ExtensionContext.subscribe extension
    ~disposable:(Extension_instance.disposable instance);
  let open Promise.Syntax in
  let* toolchain, is_fallback =
    let+ pm = Toolchain.of_settings () in
    let resources, is_fallback =
      match pm with
      | Some pm -> (pm, false)
      | None ->
        let (_ : unit Promise.t) = suggest_to_setup_toolchain instance in
        (Toolchain.Package_manager.Global, true)
    in
    (Toolchain.make resources, is_fallback)
  in
  Extension_instance.start instance toolchain
  |> Promise.Result.iter ~error:(fun e ->
         if not is_fallback then show_message `Error "%s" e)
  |> Promise.catch ~rejected:(fun e ->
         let error_message = Node.JsError.message e in
         show_message `Error "Error: %s" error_message;
         Promise.return ())

let () =
  let open Js_of_ocaml.Js in
  export "activate" (wrap_callback activate)
