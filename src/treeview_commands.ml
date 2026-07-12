let select_sandbox_item extension =
  let icon =
    `LightDark
      (Extension_assets.light_dark_icon
         ~extension
         ~light:"collection-light.svg"
         ~dark:"collection-dark.svg")
  in
  let label = `TreeItemLabel (Vscode.TreeItemLabel.create ~label:"Select a Sandbox" ()) in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create ~title:"Select a Sandbox" ~command:"ocaml.select-sandbox" ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item
;;

let terminal_item extension =
  let icon =
    `LightDark
      (Extension_assets.light_dark_icon
         ~extension
         ~light:"terminal-light.svg"
         ~dark:"terminal-dark.svg")
  in
  let label =
    `TreeItemLabel (Vscode.TreeItemLabel.create ~label:"Open a sandboxed terminal" ())
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
;;

let construct_item () =
  let icon = `ThemeIcon (Vscode.ThemeIcon.make ~id:"tools" ()) in
  let label =
    `TreeItemLabel
      (Vscode.TreeItemLabel.create
         ~label:"List values that can fill the selected typed-hole"
         ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command = Vscode.Command.create ~title:"Construct" ~command:"ocaml.construct" () in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item
;;

let jump_item () =
  let icon = `ThemeIcon (Vscode.ThemeIcon.make ~id:"fold-up" ()) in
  let label =
    `TreeItemLabel (Vscode.TreeItemLabel.create ~label:"Jump to a specific target" ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command = Vscode.Command.create ~title:"MerlinJump" ~command:"ocaml.jump" () in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item
;;

let type_search_item () =
  let icon = `ThemeIcon (Vscode.ThemeIcon.make ~id:"search-view-icon" ()) in
  let label =
    `TreeItemLabel
      (Vscode.TreeItemLabel.create ~label:"Search a value by type or polarity" ())
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
;;

let navigate_holes_item () =
  let icon = `ThemeIcon (Vscode.ThemeIcon.make ~id:"breakpoints-activate" ()) in
  let label =
    `TreeItemLabel (Vscode.TreeItemLabel.create ~label:"Navigate between typed holes" ())
  in
  let item = Vscode.TreeItem.make_label ~label () in
  let command =
    Vscode.Command.create
      ~title:"Navigate typed holes"
      ~command:"ocaml.navigate-typed-holes"
      ()
  in
  Vscode.TreeItem.set_iconPath item icon;
  Vscode.TreeItem.set_command item command;
  item
;;

let items extension =
  [ select_sandbox_item extension
  ; terminal_item extension
  ; construct_item ()
  ; jump_item ()
  ; type_search_item ()
  ; navigate_holes_item ()
  ]
;;

let getTreeItem ~element = `Value element

let getChildren items ?element () =
  match element with
  | None -> `Value (Some items)
  | Some _ -> `Value (Some [])
;;

let register extension =
  let items = items extension in
  let getChildren = getChildren items in
  let module TreeDataProvider = Vscode.TreeDataProvider.Make (Vscode.TreeItem) in
  let treeDataProvider = TreeDataProvider.create ~getTreeItem ~getChildren () in
  let disposable =
    Vscode.Window.registerTreeDataProvider
      (module Vscode.TreeItem)
      ~viewId:"ocaml-commands"
      ~treeDataProvider
  in
  Vscode.ExtensionContext.subscribe extension ~disposable
;;
