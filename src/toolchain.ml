open Import

let get_opamroot () =
  let open Promise.Syntax in
  let+ home =
    if not (Ocaml_windows.use_ocaml_env ()) then
      Promise.return @@ Node.Os.homedir ()
    else
      let+ output = Ocaml_windows.cygwin_home () in
      match output with
      | Ok cygwin_home -> cygwin_home
      | Error e ->
        show_message `Warn
          "Could not determine Cygwin home directory, defaulting to Windows \
           home directory: %s"
          e;
        Node.Os.homedir ()
  in
  Path.(of_string home / ".vscode-ocaml" / "opam")

type t =
  { project_sandbox : Sandbox.t option
  ; opam : Opam.t * Opam.Switch.t
  ; version : string
  ; is_new : bool
  }

module Tool = struct
  type t =
    { opam_package : string
    ; cmd : Cmd.t
    }

  let opam_package t = t.opam_package

  let cmd t = t.cmd

  let make ?(args = []) ~opam_package
      { opam = opam, switch; project_sandbox; _ } bin =
    match project_sandbox with
    | Some sandbox ->
      let open Promise.Syntax in
      let+ has_command = Sandbox.has_command sandbox bin in
      if has_command then
        { opam_package; cmd = Sandbox.get_command sandbox bin args }
      else
        { opam_package; cmd = Opam.exec opam switch ~args:(bin :: args) }
    | _ ->
      Promise.return
        { opam_package; cmd = Opam.exec opam switch ~args:(bin :: args) }

  let lsp ?args toolchain =
    make ~opam_package:"ocaml-lsp-server" toolchain "ocamllsp" ?args

  let dune ?args toolchain = make ~opam_package:"dune" toolchain "dune" ?args

  let ocamlformat ?args toolchain =
    make ~opam_package:"ocamlformat" toolchain "ocamlformat" ?args

  let all toolchain =
    Promise.all_list
      [ lsp toolchain ~args:[ "--version" ]
      ; ocamlformat toolchain ~args:[ "--version" ]
      ]

  let detect_missing toolchain =
    let open Promise.Syntax in
    let missing_command_opt t =
      let cmd = t.cmd in
      let+ output =
        let open Promise.Result.Syntax in
        let* command = Cmd.check cmd in
        Cmd.output command
      in
      match output with
      | Ok _ -> None
      | Error _ -> Some t
    in
    let* all = all toolchain in
    Promise.List.filter_map missing_command_opt all
end

let compiler_of_version v =
  match (Platform.t, Platform.arch) with
  | Win32, X32 -> "ocaml-variants." ^ v ^ "+mingw32c"
  | Win32, _ -> "ocaml-variants." ^ v ^ "+mingw64c"
  | _ -> "ocaml-base-compiler." ^ v

let switch_of_version v = "vscode-ocaml-toolchain." ^ v

let compiler_version project_sandbox =
  let default = "4.11.1" in
  match project_sandbox with
  | None -> Promise.return default
  | Some sandbox -> (
    let open Promise.Syntax in
    let+ result = Sandbox.ocaml_version sandbox in
    match result with
    | Error _ -> default
    | Ok version -> version )

let is_sandbox_installed opam switch =
  let open Promise.Syntax in
  let cmd = Opam.exec opam switch ~args:[ "true" ] in
  let+ result = Cmd.output cmd in
  match result with
  | Ok _ -> true
  | Error _ -> false

let setup_toolchain_sandbox project_sandbox opamroot =
  let open Promise.Syntax in
  let* opam_opt = Opam.make ~root:opamroot () in
  match opam_opt with
  | None -> Promise.return (Error "Opam is not available")
  | Some opam ->
    let* compiler_version = compiler_version project_sandbox in
    let compiler_name = compiler_of_version compiler_version in
    let sandbox_name = switch_of_version compiler_version in
    let open Promise.Result.Syntax in
    let+ _ =
      Opam.switch_create opam ~name:sandbox_name ~args:[ compiler_name ]
      |> Cmd.output
    in
    ()

let get_install_command { opam = opam, switch; _ } tools =
  let opam_packages = List.map tools ~f:Tool.opam_package in
  Opam.install opam switch ~packages:opam_packages

let with_progress ~msg f =
  let open Promise.Syntax in
  let progress_options =
    ProgressOptions.create ~location:(`ProgressLocation Window) ~title:msg
      ~cancellable:false ()
  in
  let task ~progress:_ ~token:_ =
    let+ result = f () in
    match result with
    | Ok _ -> Ok ()
    | Error err ->
      show_message `Error "%s" err;
      Error err
  in
  Window.withProgress
    Interop.Js.((module Result (Unit) (String)))
    ~options:progress_options ~task

let opam_init opam opamroot =
  let open Promise.Syntax in
  let* exists = Fs.exists (opamroot |> Path.to_string) in
  if exists then
    Promise.Result.return ()
  else
    with_progress
      ~msg:"Initializing Platform Tools (this might take a few minutes)"
      (fun () ->
        let+ result = Opam.init opam |> Cmd.output in
        Result.map_error result ~f:(fun err ->
            Printf.sprintf
              "The creation of the toolchain Opam switch failed: %s" err))

let install_missing_tools t tools opamroot =
  let open Promise.Syntax in
  match tools with
  | [] -> Promise.Result.return ()
  | tools ->
    with_progress
      ~msg:"Installing Platform Tools (this might take a few minutes)"
      (fun () ->
        let opam, switch = t.opam in
        let* is_installed = is_sandbox_installed opam switch in
        let* _ =
          match is_installed with
          | false -> setup_toolchain_sandbox t.project_sandbox opamroot
          | true -> Promise.Result.return ()
        in
        let cmd = get_install_command t tools in
        let+ result = Cmd.output cmd in
        Result.map_error result ~f:(fun err ->
            Printf.sprintf "The installation of the Platform tools failed: %s"
              err))

let upgrade t =
  if t.is_new then (
    log "Is new, won't upgrade";
    Promise.Result.return ()
  ) else
    let opam, switch = t.opam in
    with_progress ~msg:"Checking for Platform Tools updates" (fun () ->
        let open Promise.Syntax in
        let* _ = Opam.update opam switch |> Cmd.output in
        let+ result = Opam.upgrade opam switch |> Cmd.output in
        Result.map_error result ~f:(fun err ->
            Printf.sprintf "The upgrade of the Platform tools failed: %s" err))

let setup ?project_sandbox () =
  let open Promise.Syntax in
  let* compiler_version = compiler_version project_sandbox in
  let sandbox_name = switch_of_version compiler_version in
  let* opamroot = get_opamroot () in
  let* opam_opt =
    let open Promise.Option.Syntax in
    let* opam = Opam.make ~root:opamroot () in
    let+ switch = Opam.Switch.of_string sandbox_name |> Promise.return in
    (opam, switch)
  in
  match opam_opt with
  | None ->
    let msg =
      "Opam is required to install the toolchain. Install it manually to use \
       the extension."
    in
    show_message `Error "%s" msg;
    Promise.return (Error msg)
  | Some ((opam, switch) as opam_switch) ->
    let open Promise.Result.Syntax in
    let* () = opam_init opam opamroot in
    let open Promise.Syntax in
    let* is_installed = is_sandbox_installed opam switch in
    let t =
      { opam = opam_switch
      ; project_sandbox
      ; version = compiler_version
      ; is_new = not is_installed
      }
    in
    let* missing_tools =
      if is_installed then
        Tool.detect_missing t
      else
        Tool.all t
    in
    let open Promise.Result.Syntax in
    let+ () = install_missing_tools t missing_tools opamroot in
    t

let to_pretty_string { version; _ } = "OCaml " ^ version

let get_lsp_command ?args t = Tool.lsp ?args t |> Promise.map Tool.cmd

let get_dune_command ?args t = Tool.dune ?args t |> Promise.map Tool.cmd

let get_ocamlformat_command ?args t =
  Tool.ocamlformat ?args t |> Promise.map Tool.cmd
