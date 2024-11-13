let select_sandbox_item =
  let icon =
    `LightDark
      Vscode.LightDarkIcon.
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
      Vscode.LightDarkIcon.
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

let perform_type_search =
  let icon =
    `LightDark
      Vscode.LightDarkIcon.
        { light =
            `String (Path.asset "document-search-light.svg" |> Path.to_string)
        ; dark =
            `String (Path.asset "document-search-dark.svg" |> Path.to_string)
        }
  in
  let label =
    `TreeItemLabel
      (Vscode.TreeItemLabel.create
         ~label:"Search a value by type or polarity"
         ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create
      ~title:"Search a value by type or polarity"
      ~command:"ocaml.search-by-type"
      ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item

let items = [ select_sandbox_item; terminal_item; perform_type_search ]

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
