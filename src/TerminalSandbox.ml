open Import

let getTerminalSetting t = Settings.getSection ~section:"terminal.integrated" t

module ShellPath = struct
  type t = string

  let ofJson json =
    let open Json.Decode in
    string json

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

type t =
  { toolchain : Toolchain.resources
  ; mutable terminals : Window.Terminal.t list
  }

let create toolchain = { toolchain; terminals = [] }

let dispose t =
  List.iter Window.Terminal.dispose t.terminals;
  t.terminals <- []

let openTerminal t =
  let open Option in
  getTerminalSetting ShellPath.t >>= fun shellPath ->
  getTerminalSetting ShellArgs.t >>| fun shellArgs ->
  let shellPath, shellArgs =
    Toolchain.getCommand t.toolchain shellPath shellArgs
  in
  let name = Toolchain.toString t.toolchain in
  let shellPath = Path.toString shellPath in
  let terminal = Window.createTerminal ~name ~shellPath ~shellArgs () in
  Window.Terminal.show terminal ();
  t.terminals <- terminal :: t.terminals
