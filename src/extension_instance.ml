open Import

type t =
  { mutable sandbox : Sandbox.t
  ; mutable repl : Terminal_sandbox.t option
  ; mutable ocaml_version : Ocaml_version.t option
        (** assumption: it must be set before initializing the language server;
            the lang server initialization needs the ocaml version *)
  ; mutable lsp_client : (LanguageClient.t * Ocaml_lsp.t) option
  ; mutable documentation_server : Documentation_server.t option
  ; documentation_server_info : StatusBarItem.t
  ; sandbox_info : StatusBarItem.t
  ; ast_editor_state : Ast_editor_state.t
  }

let sandbox t = t.sandbox

let language_client t = Option.map ~f:fst t.lsp_client

let ocaml_lsp t = Option.map ~f:snd t.lsp_client

let documentation_server t = t.documentation_server

let lsp_client t = t.lsp_client

let ocaml_version_exn t = Option.value_exn t.ocaml_version

let stop_server t =
  Option.iter t.lsp_client ~f:(fun (client, _) ->
      t.lsp_client <- None;
      LanguageClient.stop client)

module Language_server_init : sig
  val start_language_server : t -> unit Promise.t
end = struct
  let client_options () =
    let documentSelector =
      LanguageClient.DocumentSelector.
        [| language "ocaml"
         ; language "ocaml.interface"
         ; language "ocaml.ocamllex"
         ; language "ocaml.menhir"
         ; language "reason"
        |]
    in
    let (lazy outputChannel) = Output.language_server_output_channel in
    let revealOutputChannelOn = LanguageClient.RevealOutputChannelOn.Never in
    LanguageClient.ClientOptions.create ~outputChannel ~revealOutputChannelOn
      ~documentSelector ()

  let server_options sandbox =
    let command = Sandbox.get_command sandbox "ocamllsp" [] in
    Cmd.log command;
    let env =
      let extra_env_vars =
        Settings.server_extraEnv () |> Option.value ~default:Interop.Dict.empty
      in
      Interop.Dict.union
        (fun _k _v1 v2 -> Some v2)
        Process.Env.env extra_env_vars
    in
    match command with
    | Shell command ->
      let options =
        LanguageClient.ExecutableOptions.create ~env ~shell:true ()
      in
      LanguageClient.Executable.create ~command ~options ()
    | Spawn { bin; args } ->
      let command = Path.to_string bin in
      let options =
        LanguageClient.ExecutableOptions.create ~env ~shell:false ()
      in
      LanguageClient.Executable.create ~command ~args ~options ()

  let check_ocaml_lsp_available sandbox =
    let ocaml_lsp_version sandbox =
      Sandbox.get_command sandbox "ocamllsp" [ "--version" ]
    in
    Cmd.output (ocaml_lsp_version sandbox)
    |> Promise.Result.fold
         ~ok:(fun (_ : string) -> ())
         ~error:(fun (_ : string) ->
           "Sandbox initialization failed: `ocaml-lsp-server` is not installed \
            in the current sandbox.")

  let client_capabilities =
    let fillClientCapabilities ~capabilities =
      let experimental =
        Jsonoo.Encode.(object_ [ ("jumpToNextHole", bool true) ])
      in
      LanguageClient.ClientCapabilities.set_experimental capabilities
        (Some experimental)
    in
    let initialize ~capabilities:_ ~documentSelector:_ = () in
    let dispose () = () in
    LanguageClient.StaticFeature.make ~fillClientCapabilities ~initialize
      ~dispose ()

  let start_language_server t =
    stop_server t;
    let open Promise.Syntax in
    let+ res =
      let open Promise.Result.Syntax in
      let* () = check_ocaml_lsp_available t.sandbox in
      let client =
        let serverOptions = server_options t.sandbox in
        let clientOptions = client_options () in
        LanguageClient.make ~id:"ocaml" ~name:"OCaml Platform VS Code extension"
          ~serverOptions ~clientOptions ()
      in
      LanguageClient.registerFeature client ~feature:client_capabilities;
      LanguageClient.start client;
      let open Promise.Syntax in
      let+ initialize_result = LanguageClient.ready_initialize_result client in
      let ocaml_lsp = Ocaml_lsp.of_initialize_result initialize_result in
      t.lsp_client <- Some (client, ocaml_lsp);
      (match
         Ocaml_lsp.is_version_up_to_date ocaml_lsp (ocaml_version_exn t)
       with
      | Ok () -> ()
      | Error (`Msg m) -> show_message `Warn "%s" m);
      Ok ()
    in
    match res with
    | Ok () -> ()
    | Error s ->
      show_message `Error
        "An error occurred starting the language server `ocamllsp`. %s" s
end

include Language_server_init

module Documentation_server_info : sig
  val make : unit -> StatusBarItem.t

  val update : StatusBarItem.t -> port:int -> unit
end = struct
  let make () =
    let status_bar =
      Vscode.Window.createStatusBarItem ~alignment:StatusBarAlignment.Right
        ~priority:100 ()
    in
    let command =
      Command.create ~title:"Open Command Palette"
        ~command:"workbench.action.quickOpen"
        ~arguments:[ Ojs.string_to_js ">OCaml: Stop Documentation server" ]
        ()
    in
    StatusBarItem.set_command status_bar (`Command command);
    status_bar

  let update status_bar ~port =
    StatusBarItem.set_text status_bar
      (Printf.sprintf "$(radio-tower) Port: %i" port);
    StatusBarItem.show status_bar
end

module Sandbox_info : sig
  val make : Sandbox.t -> StatusBarItem.t

  val update : StatusBarItem.t -> new_sandbox:Sandbox.t -> unit
end = struct
  let make_status_bar_item_text sandbox =
    Printf.sprintf "$(package) %s" @@ Sandbox.to_pretty_string sandbox

  let make sandbox =
    let status_bar_item =
      Window.createStatusBarItem ~alignment:StatusBarAlignment.Left ()
    in
    let status_bar_item_text = make_status_bar_item_text sandbox in
    StatusBarItem.set_text status_bar_item status_bar_item_text;
    StatusBarItem.set_command status_bar_item
      (`String Extension_consts.Commands.select_sandbox);
    StatusBarItem.show status_bar_item;
    status_bar_item

  let update sandbox_info ~new_sandbox =
    let status_bar_item_text = make_status_bar_item_text new_sandbox in
    StatusBarItem.set_text sandbox_info status_bar_item_text
end

let make () =
  let sandbox = Sandbox.Global in
  let sandbox_info = Sandbox_info.make sandbox in
  let documentation_server_info = Documentation_server_info.make () in
  let ast_editor_state = Ast_editor_state.make () in
  { sandbox
  ; lsp_client = None
  ; sandbox_info
  ; documentation_server_info
  ; repl = None
  ; ocaml_version = None
  ; ast_editor_state
  ; documentation_server = None
  }

let stop_documentation_server t =
  Option.iter t.documentation_server ~f:(fun server ->
      t.documentation_server <- None;
      Documentation_server.stop server);
  StatusBarItem.hide t.documentation_server_info

let set_sandbox t new_sandbox =
  Sandbox_info.update t.sandbox_info ~new_sandbox;
  t.sandbox <- new_sandbox;
  (* Makes sure that a new instance of the documentation server is created next
     time we show documentation for a package. It avoids reusing an existing
     server instance that serves the old sandbox packages folder.*)
  stop_documentation_server t;
  let (_ : Ojs.t option Promise.t) =
    Vscode.Commands.executeCommand
      ~command:Extension_consts.Commands.refresh_sandbox ~args:[]
  and (_ : Ojs.t option Promise.t) =
    Vscode.Commands.executeCommand
      ~command:Extension_consts.Commands.refresh_switches ~args:[]
  in
  ()

let start_documentation_server t ~path =
  stop_documentation_server t;
  let open Promise.Syntax in
  let+ server = Documentation_server.start ~path () in
  match server with
  | Ok server ->
    t.documentation_server <- Some server;
    let port = Documentation_server.port server in
    Documentation_server_info.update t.documentation_server_info ~port;
    Documentation_server.on_close server ~f:(fun () ->
        stop_documentation_server t);
    Ok server
  | Error e ->
    t.documentation_server <- None;
    Error e

let repl t = t.repl

let set_repl t repl = t.repl <- Some repl

let close_repl t = t.repl <- None

let update_ocaml_info t =
  let open Promise.Syntax in
  let+ ocaml_version =
    let+ r =
      Sandbox.get_command t.sandbox "ocamlc" [ "--version" ] |> Cmd.output
    in
    match r with
    | Ok v ->
      Ocaml_version.of_string v
      |> Result.map_error ~f:(function m ->
             `Unable_to_parse_version (`Version v, m))
    | Error e ->
      log_chan ~section:"Ocaml.version_semver" `Warn
        "Error running `ocamlc --version`: %s" e;
      Error `Ocamlc_missing
  in
  match ocaml_version with
  | Ok ocaml_version -> t.ocaml_version <- Some ocaml_version
  | Error e -> (
    (* [t.ocaml_version <- None] because we don't want [t.ocaml_version] to be
       left over from a previous sandbox, which successfully set it *)
    t.ocaml_version <- None;
    match e with
    | `Unable_to_parse_version (`Version v, `Msg msg) ->
      show_message `Error
        "OCaml bytecode compiler `ocamlc` version could not be parsed. \
         Version: %s. Error %s"
        v msg
    | `Ocamlc_missing ->
      let (_ : unit Promise.t) =
        let+ maybe_choice =
          Window.showErrorMessage
            ~message:
              "OCaml bytecode compiler `ocamlc` was not found in the current \
               sandbox. Do you have OCaml installed in the current sandbox?"
            ~choices:
              [ ( "Pick another sandbox"
                , fun () ->
                    let (_ : Ojs.t option Promise.t) =
                      Vscode.Commands.executeCommand
                        ~command:Extension_consts.Commands.select_sandbox
                        ~args:[]
                    in
                    () )
              ]
            ()
        in
        Option.iter maybe_choice ~f:(fun f -> f ())
      in
      ())

let open_terminal sandbox =
  let terminal = Terminal_sandbox.create sandbox in
  Terminal_sandbox.show terminal

let ast_editor_state t = t.ast_editor_state

let disposable t =
  Disposable.make ~dispose:(fun () ->
      StatusBarItem.dispose t.sandbox_info;
      stop_server t;
      stop_documentation_server t)
