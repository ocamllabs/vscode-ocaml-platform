# VSCode OCaml Platform

[![Main workflow](https://img.shields.io/github/workflow/status/ocamllabs/vscode-ocaml-platform/Main%20workflow?branch=master)](https://github.com/ocamllabs/vscode-ocaml-platform/actions?query=workflow%3A%22Main+workflow%22+branch%3Amaster)

Visual Studio Code extension for OCaml and relevant tools.

_Please report any bugs you encounter._

## Quick start

1. Install this extension from
   [the VSCode Marketplace](https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform)
   (or by entering `ext install ocamllabs.ocaml-platform` at the command palette
   <kbd>Ctrl</kbd>+<kbd>P</kbd> (<kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> on
   MacOS)
2. Open a OCaml/ReasonML project (`File > Add Folder to Workspace...`)
3. Install [OCaml-LSP](https://github.com/ocaml/ocaml-lsp) with
   [opam](https://github.com/ocaml/opam) or [esy](https://github.com/esy/esy).
   E.g. `opam install ocaml-lsp-server`

### Windows

If you are on Windows, there are two ways to use this extension:

1. Launch VSCode from Cygwin. This will let you choose a global or opam sandbox.

2. Use a custom sandbox with
   [ocaml-env](https://fdopen.github.io/opam-repository-mingw/ocaml-env/). If it
   is on your PATH you can input `ocaml-env exec -- $prog $args` for the custom
   command template, or manually edit the `ocaml.sandbox` setting so it is

```json
"ocaml.sandbox": {
  "kind": "custom",
  "template": "ocaml-env exec -- $prog $args"
}
```

We find the first option more reliable.

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
    "@opam/ocaml-lsp-server": "1.1.0",
    "@opam/ocamlfind-secondary": "*",
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
  - OASIS
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
- Task Provider
  - Dune

## Configuration

This extension provides options in VSCode's configuration settings. You can find
the settings under `File > Preferences > Settings`.

| Name                               | Description                                                                                             | Default |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------- | ------- |
| `ocaml.sandbox`                    | Determines where to find the sandbox for a given project                                                | `null`  |
| `ocaml.dune.autoDetect`            | Controls whether dune tasks should be automatically detected.                                           | `true`  |
| `ocaml.trace.server`               | Controls the logging output of the language server. Valid settings are `off`, `messages`, or `verbose`. | `off`   |
| `ocaml.terminal.shell.linux`       | The path of the shell that the sandbox terminal uses on Linux                                           | `null`  |
| `ocaml.terminal.shell.osx`         | The path of the shell that the sandbox terminal uses on macOS                                           | `null`  |
| `ocaml.terminal.shell.windows`     | The path of the shell that the sandbox terminal uses on Windows                                         | `null`  |
| `ocaml.terminal.shellArgs.linux`   | The command line arguments that the sandbox terminal uses on Linux                                      | `null`  |
| `ocaml.terminal.shellArgs.osx`     | The command line arguments that the sandbox terminal uses on macOS                                      | `null`  |
| `ocaml.terminal.shellArgs.windows` | The command line arguments that the sandbox terminal uses on Window                                     | `null`  |

If `ocaml.terminal.shell.*` or `ocaml.terminal.shellArgs.*` is `null`, the
configured VSCode shell and shell arguments will be used instead.

## Commands

You can execute it by entering the following command at the command palette
<kbd>Ctrl</kbd>+<kbd>P</kbd> (<kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> on
MacOS).

| Name                         | Description                        | Keyboard Shortcuts | Menu Contents |
| ---------------------------- | ---------------------------------- | ------------------ | ------------- |
| `ocaml.select-sandbox`       | Select sandbox for this workspace  |                    |               |
| `ocaml.server.restart`       | Restart language server            |                    |               |
| `ocaml.open-terminal`        | Open a terminal (current sandbox)  |                    |               |
| `ocaml.open-terminal-select` | Open a terminal (select a sandbox) |                    |               |

## Requirements

- [ocaml/ocaml-lsp](https://github.com/ocaml/ocaml-lsp)
