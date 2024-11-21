let select_sandbox_item =
  let icon =
    `LightDark
      Vscode.TreeItem.LightDarkIcon.
        { light = `String (Path.asset "collection-light.svg" |> Path.to_string)
        ; dark = `String (Path.asset "collection-dark.svg" |> Path.to_string)
        }
  in
  let label =
    `TreeItemLabel (Vscode.TreeItemLabel.create ~label:"Select a Sandbox" ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create
      ~title:"Select a Sandbox"
      ~command:"ocaml.select-sandbox"
      ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item

let terminal_item =
  let icon =
    `LightDark
      Vscode.TreeItem.LightDarkIcon.
        { light = `String (Path.asset "terminal-light.svg" |> Path.to_string)
        ; dark = `String (Path.asset "terminal-dark.svg" |> Path.to_string)
        }
  in
  let label =
    `TreeItemLabel
      (Vscode.TreeItemLabel.create ~label:"Open a sandboxed terminal" ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create
      ~title:"Open a sandboxed terminal"
      ~command:"ocaml.open-terminal"
      ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item

let construct_item =
  let icon = `ThemeIcon (Vscode.ThemeIcon.make ~id:"tools" ()) in
  let label =
    `TreeItemLabel
      (Vscode.TreeItemLabel.create
         ~label:"List values that can fill the selected typed-hole"
         ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create ~title:"Construct" ~command:"ocaml.construct" ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item

let jump_item =
  let icon = `ThemeIcon (Vscode.ThemeIcon.make ~id:"tools" ()) in
  let label =
    `TreeItemLabel
      (Vscode.TreeItemLabel.create ~label:"Jump to a specific target" ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create ~title:"MerlinJump" ~command:"ocaml.jump" ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item

let items = [ select_sandbox_item; terminal_item; construct_item; jump_item ]

let getTreeItem ~element = `Value element

let getChildren ?element () =
  match element with
  | None -> `Value (Some items)
  | Some _ -> `Value (Some [])

let register extension =
  let module TreeDataProvider = Vscode.TreeDataProvider.Make (Vscode.TreeItem) in
  let treeDataProvider = TreeDataProvider.create ~getTreeItem ~getChildren () in
  let disposable =
    Vscode.Window.registerTreeDataProvider
      (module Vscode.TreeItem)
      ~viewId:"ocaml-commands"
      ~treeDataProvider
  in
  Vscode.ExtensionContext.subscribe extension ~disposable
