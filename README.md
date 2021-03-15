# VSCode OCaml Platform

[![Main workflow](https://img.shields.io/github/workflow/status/ocamllabs/vscode-ocaml-platform/Main%20workflow?branch=master)](https://github.com/ocamllabs/vscode-ocaml-platform/actions?query=workflow%3A%22Main+workflow%22+branch%3Amaster)

Visual Studio Code extension for OCaml and relevant tools.

_Please report any bugs you encounter._

## Quick start

- Installation
  - [opam](docs/quick-start/opam.md)
  - [esy / BuckleScript](docs/quick-start/esy-bucklescript.md)
    - The new ReScript syntax (`res` and `resi` files) is not supported, you
      should use
      [rescript-vscode](https://github.com/rescript-lang/rescript-vscode)
      instead.
- [Important Notes for Windows Users](docs/quick-start/windows.md)

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
  - Eliom
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
| `ocaml.useOcamlEnv`                | Controls whether to use ocaml-env for opam commands from OCaml for Windows.                             | `true`  |
| `ocaml.terminal.shell.linux`       | The path of the shell that the sandbox terminal uses on Linux                                           | `null`  |
| `ocaml.terminal.shell.osx`         | The path of the shell that the sandbox terminal uses on macOS                                           | `null`  |
| `ocaml.terminal.shell.windows`     | The path of the shell that the sandbox terminal uses on Windows                                         | `null`  |
| `ocaml.terminal.shellArgs.linux`   | The command line arguments that the sandbox terminal uses on Linux                                      | `null`  |
| `ocaml.terminal.shellArgs.osx`     | The command line arguments that the sandbox terminal uses on macOS                                      | `null`  |
| `ocaml.terminal.shellArgs.windows` | The command line arguments that the sandbox terminal uses on Window                                     | `null`  |
| `ocaml.repl.path`                  | The path of the REPL that the extension uses                                                            | `null`  |
| `ocaml.repl.args`                  | The REPL arguments that the extension uses                                                              | `null`  |

If `ocaml.terminal.shell.*` or `ocaml.terminal.shellArgs.*` is `null`, the
configured VSCode shell and shell arguments will be used instead.

If `ocaml.repl.path` or `ocaml.repl.args` is `null`, the default REPL is used
instead. The default REPL used depends on the packages installed in your current
sandbox:

- If `dune build` passes and the current sandbox has `utop` installed, the REPL
  will be `dune utop`
- If `dune build` fails and the current sandbox has `utop` installed, the REPL
  will be `utop`
- Else, the REPL will be `ocaml`

If a REPL already exists, it will be used instead, so if you installed `utop`
after openning a REPL, or if you fixed your project compilation, you will need
to re-open the REPL to change it.

## Commands

You can execute it by entering the following command at the command palette
<kbd>Ctrl</kbd>+<kbd>P</kbd> (<kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> on
MacOS).

| Name                         | Description                                 | Keyboard Shortcuts | Menu Contents |
| ---------------------------- | ------------------------------------------- | ------------------ | ------------- |
| `ocaml.select-sandbox`       | Select sandbox for this workspace           |                    |               |
| `ocaml.server.restart`       | Restart language server                     |                    |               |
| `ocaml.open-terminal`        | Open a terminal (current sandbox)           |                    |               |
| `ocaml.open-terminal-select` | Open a terminal (select a sandbox)          |                    |               |
| `ocaml.current-dune-file`    | Open Dune File (located in the same folder) |                    |               |
| `ocaml.switch-impl-intf`     | Switch implementation/interface             | `Alt+O`            |               |
| `ocaml.open-repl`            | Open REPL                                   |                    |               |
| `ocaml.evaluate-selection`   | Evaluate Selection                          | `Shift+Enter`      |               |

## Requirements

- [ocaml/ocaml-lsp](https://github.com/ocaml/ocaml-lsp)
