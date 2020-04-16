# VSCode OCaml Platform

Visual Studio Code extension for OCaml and relevant tools.

_This plugin is alpha quality. Use at your own risk and please report any bugs
you encounter._

## Quick start

1. Install [opam](https://opam.ocaml.org) (OCaml Package Manager)
2. Install this extension from
   [the VSCode Marketplace](https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform)
   (or by entering `ext install ocamllabs.ocaml-platform` at the command palette
   <kbd>Ctrl</kbd>+<kbd>P</kbd>)
3. Install [ocaml-lsp](https://github.com/ocaml/ocaml-lsp)
4. Open a OCaml/ReasonML project (`File > Add Folder to Workspace...`)

## Features

- Syntax highlighting
  - OCaml
  - ReasonML
  - dune
  - menhir
  - merlin
  - ocamlbuild
  - OCamlFormat
  - ocamllex
  - opam
- Indentation rules
- Snippets

## Configurations

This extension provides options in VSCode's configuration settings. You can find
the settings under `File > Preferences > Settings`.

| Name             | Description                                              | Default    |
| ---------------- | -------------------------------------------------------- | ---------- |
| `ocaml.sandbox`  | Determines where to find the sandbox for a given project | `null`     |
| `ocaml.lsp.path` | Path to the LSP binary                                   | `ocamllsp` |

## Commands

You can execute it by entering the following command at the command palette
<kbd>Ctrl</kbd>+<kbd>P</kbd>.

| Name                   | Description                       | Keyboard Shortcuts | Menu Contents |
| ---------------------- | --------------------------------- | ------------------ | ------------- |
| `ocaml.select-sandbox` | Select sandbox for this workspace |                    |               |

## Requirements

- [ocaml-lsp](https://github.com/ocaml/ocaml-lsp)
