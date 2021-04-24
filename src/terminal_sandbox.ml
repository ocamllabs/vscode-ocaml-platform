open Import

module ShellPath = struct
  type t = string option

  let of_json json =
    let open Jsonoo.Decode in
    nullable string json

  let to_json (t : t) =
    let open Jsonoo.Encode in
    nullable string t

  let key =
    let linux = "shell.linux" in
    let map =
      { Platform.Map.win32 = "shell.windows"
      ; darwin = "shell.osx"
      ; linux
      ; other = linux
      }
    in
    Platform.Map.find map Platform.t

  let t = Settings.create ~scope:Global ~key ~of_json ~to_json
end

module ShellArgs = struct
  type t = string list option

  let of_json json =
    let open Jsonoo.Decode in
    nullable (list string) json

  let to_json (t : t) =
    let open Jsonoo.Encode in
    nullable (list string) t

  let key =
    let linux = "shellArgs.linux" in
    let map =
      { Platform.Map.win32 = "shellArgs.windows"
      ; darwin = "shellArgs.osx"
      ; linux
      ; other = linux
      }
    in
    Platform.Map.find map Platform.t

  let t = Settings.create ~scope:Global ~key ~of_json ~to_json
end

let get_shell_path () =
  let shell_path =
    Option.join (Settings.get ~section:"ocaml.terminal" ShellPath.t)
  in
  match shell_path with
  | Some path -> path
  | None -> Env.shell ()

let get_shell_args () =
  let get_args section = Option.join (Settings.get ~section ShellArgs.t) in
  match get_args "ocaml.terminal" with
  | Some args -> args
  | None -> (
    match get_args "terminal.integrated" with
    | Some args -> args
    | None -> [])

type t = Terminal.t

let create ?name ?command sandbox =
  let shell_path = get_shell_path () in
  let shell_args = get_shell_args () in
  let ({ Cmd.bin; args } as command) =
    match command with
    | Some command -> command
    | None -> (
      match Sandbox.get_command sandbox shell_path shell_args with
      | Spawn spawn -> spawn
      | Shell command_line -> (
        match Platform.shell with
        | Sh bin -> { bin; args = [ "-c"; command_line ] }
        | PowerShell bin -> { bin; args = [ "-c"; "& " ^ command_line ] }))
  in
  Cmd.log (Spawn command);
  let name = Option.value name ~default:(Sandbox.to_pretty_string sandbox) in
  let shellPath = Path.to_string bin in
  let shellArgs = `Strings args in
  Window.createTerminal ~name ~shellPath ~shellArgs ()

let dispose = Terminal.dispose

let show t = Terminal.show t ()

let send t text =
  let addNewLine = not (String.is_suffix text ~suffix:"\n") in
  Terminal.sendText t ~text ~addNewLine ()
