open Import

module ShellPath = struct
  type t = string

  let of_json json =
    let open Jsonoo.Decode in
    match string json with
    | exception Jsonoo.Decode_error _ -> Env.shell ()
    | "" -> Env.shell ()
    | shell -> shell

  let to_json (t : t) =
    let open Jsonoo.Encode in
    string t

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
    try_optional (list string) json

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

let get_shell_path () = Settings.get ~section:"ocaml.terminal" ShellPath.t

let get_shell_args () =
  let args section = Option.join (Settings.get ~section ShellArgs.t) in
  match args "ocaml.terminal" with
  | Some _ as s -> s
  | None -> args "terminal.integrated"

type t = Terminal.t

let create toolchain =
  let open Option.O in
  let* shell_path = get_shell_path () in
  let+ shell_args = get_shell_args () in
  let ({ Cmd.bin; args } as command) =
    match Toolchain.get_command toolchain shell_path shell_args with
    | Spawn spawn -> spawn
    | Shell command_line -> (
      match Platform.shell with
      | Sh bin -> { bin; args = [ "-c"; command_line ] }
      | PowerShell bin -> { bin; args = [ "-c"; "& " ^ command_line ] } )
  in
  Cmd.log (Spawn command);
  let name = Toolchain.to_pretty_string toolchain in
  let shellPath = Path.to_string bin in
  let shellArgs = `Strings args in
  Window.createTerminal ~name ~shellPath ~shellArgs ()

let dispose = Terminal.dispose

let show t = Terminal.show t ()
