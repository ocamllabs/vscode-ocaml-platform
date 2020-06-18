open Import

module ShellPath = struct
  type t = string

  let ofJson json =
    let open Json.Decode in
    withDefault (Env.shell ()) string json

  let toJson (t : t) =
    let open Json.Encode in
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

  let t = Settings.create ~scope:Global ~key ~ofJson ~toJson
end

module ShellArgs = struct
  type t = string list

  let ofJson json =
    let open Json.Decode in
    list string json

  let toJson (t : t) =
    let open Json.Encode in
    list string t

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

  let t = Settings.create ~scope:Global ~key ~ofJson ~toJson
end

let getShellPath () = Settings.get ~section:"ocaml.terminal" ShellPath.t

let getShellArgs () =
  (* extension configuration has priority over vscode settings *)
  match Settings.get ~section:"ocaml.terminal" ShellArgs.t with
  | None
  | Some [] ->
    Settings.get ~section:"terminal.integrated" ShellArgs.t
  | args -> args

type t = Window.Terminal.t

let create toolchain =
  let open Option in
  getShellPath () >>= fun shellPath ->
  getShellArgs () >>| fun shellArgs ->
  let shellPath, shellArgs =
    Toolchain.getCommand toolchain shellPath shellArgs
  in
  let name = Toolchain.toString toolchain in
  let shellPath = Path.toString shellPath in
  Window.createTerminal ~name ~shellPath ~shellArgs ()

let dispose = Window.Terminal.dispose

let show t = Window.Terminal.show t ()
