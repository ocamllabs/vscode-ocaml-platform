# VSCode OCaml Platform

[![Main workflow](https://img.shields.io/github/workflow/status/ocamllabs/vscode-ocaml-platform/Main%20workflow?branch=master)](https://github.com/ocamllabs/vscode-ocaml-platform/actions?query=workflow%3A%22Main+workflow%22+branch%3Amaster)

Visual Studio Code extension for OCaml and relevant tools.

_This plugin is alpha quality. Use at your own risk and please report any bugs
you encounter._

## Quick start

1. Install this extension from
   [the VSCode Marketplace](https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform)
   (or by entering `ext install ocamllabs.ocaml-platform` at the command palette
   <kbd>Ctrl</kbd>+<kbd>P</kbd>)
2. Open a OCaml/ReasonML project (`File > Add Folder to Workspace...`)
3. Install [OCaml-LSP](https://github.com/ocaml/ocaml-lsp) with
   [opam](https://github.com/ocaml/opam) or [esy](https://github.com/esy/esy).

### BuckleScript

There is currently no way of installing
[OCaml-LSP](https://github.com/ocaml/ocaml-lsp) _natively_ for BuckleScript
projects. As a fast workaround, you can use [esy](https://github.com/esy/esy):

1. Install esy

```bash
npm install esy --global
```

2. Add `esy.json` to the project root with following content:

```json
{
  "dependencies": {
    "@opam/ocaml-lsp-server": "ocaml/ocaml-lsp:ocaml-lsp-server.opam",
    "@opam/reason": "*",
    "ocaml": "4.6.x"
  }
}
```

3. Install and build packages

```bash
esy
```

## Features

- Syntax highlighting
  - ATD
  - Cram tests
  - Dune
  - Menhir
  - Merlin
  - META
  - OCaml
  - OCamlbuild
  - OCamlFormat
  - OCamllex
  - opam
  - ReasonML
- Indentation rules
- Snippets
  - Dune
  - OCaml
  - OCamllex

## Configuration

This extension provides options in VSCode's configuration settings. You can find
the settings under `File > Preferences > Settings`.

| Name            | Description                                              | Default |
| --------------- | -------------------------------------------------------- | ------- |
| `ocaml.sandbox` | Determines where to find the sandbox for a given project | `null`  |

## Commands

You can execute it by entering the following command at the command palette
<kbd>Ctrl</kbd>+<kbd>P</kbd>.

| Name                   | Description                       | Keyboard Shortcuts | Menu Contents |
| ---------------------- | --------------------------------- | ------------------ | ------------- |
| `ocaml.select-sandbox` | Select sandbox for this workspace |                    |               |

## Requirements

- [ocaml/ocaml-lsp](https://github.com/ocaml/ocaml-lsp)
