# VSCode OCaml Platform

[![Main workflow](https://github.com/ocamllabs/vscode-ocaml-platform/workflows/Main%20workflow/badge.svg?branch=master)](https://github.com/ocamllabs/vscode-ocaml-platform/actions)

Visual Studio Code extension for OCaml and relevant tools.

_This plugin is alpha quality. Use at your own risk and please report any bugs
you encounter._

## Quick start

1. Install this extension from
   [the VSCode Marketplace](https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform)
   (or by entering `ext install ocamllabs.ocaml-platform` at the command palette
   <kbd>Ctrl</kbd>+<kbd>P</kbd>)
2. Open a OCaml/ReasonML project (`File > Add Folder to Workspace...`)
3. Install `ocamllsp` with [`opam`](https://github.com/ocaml/ocaml-lsp#opam) or
   [`esy`](https://github.com/ocaml/ocaml-lsp#esy).

### Bucklescript

There is currently no way of installing `ocamlsp` "natively" for Bucklescript
projects. As a fast workaround, you can use `esy`:

1. Install esy

```
npm i -g esy
```

2. Add `esy.json` to the project root with following content:

```json
{
  "dependencies": {
    "@opam/merlin": "*",
    "@opam/ocaml-lsp-server": "ocaml/ocaml-lsp:ocaml-lsp-server.opam#7592d32",
    "@opam/ocamlformat": "0.13.0",
    "@opam/reason": "*",
    "ocaml": "4.6.x"
  },
  "resolutions": {
    "@opam/dune": "2.0.1",
    "@opam/dune-configurator": "2.0.1",
    "@opam/dune-private-libs": "2.0.1",
    "@opam/menhir": "20200123",
    "@opam/menhirLib": "20200123",
    "@opam/menhirSdk": "20200123"
  }
}
```

3. Install and build packages

```
esy
```

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

## Configuration

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
