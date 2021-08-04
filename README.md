# VSCode OCaml Platform

[![Main workflow](https://img.shields.io/github/workflow/status/ocamllabs/vscode-ocaml-platform/Main%20workflow?branch=master)](https://github.com/ocamllabs/vscode-ocaml-platform/actions?query=workflow%3A%22Main+workflow%22+branch%3Amaster)

Visual Studio Code extension for OCaml and relevant tools.

> You are strongly encouraged to read the "Getting Started" section below
> because the rest of the document assumes you have read it.

> If you have read "Getting Started" section in full and have issues, please
> read FAQ at the end of this document.

## Getting started

### Installation

1. Installing "OCaml Language Server" (also called OCaml-LSP):

   Install [ocaml-lsp-server](https://github.com/ocaml/ocaml-lsp) package as
   usual with a package manager of your choice:
   [OPAM](https://github.com/ocaml/opam) or [esy](https://github.com/esy/esy).
   Installation instructions by package manager are available
   [here](https://github.com/ocaml/ocaml-lsp#installation).

   > Make sure to install the packages in the sandbox (OPAM
   > [switch](https://opam.ocaml.org/doc/Usage.html#opam-switch) or esy
   > [sandbox](https://esy.sh/docs/en/getting-started.html)) you use for
   > compiling your project.

   Optionally:

   - When you hover the cursor over OCaml code, the extension shows you the type
     of the code. To get nicely formatted types, install
     [ocamlformat-rpc](https://opam.ocaml.org/packages/ocamlformat-rpc/)
     package.
   - Install
     [ocamlformat](https://github.com/ocaml-ppx/ocamlformat#installation)
     package if you want source code formatting support.

     Note: Formatting support also requires having `.ocamlformat` file in your
     project root directory.

2. Install this extension from the VSCode
   [Marketplace](https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform).
   VSCode extension installations instructions are available
   [here](https://code.visualstudio.com/docs/editor/extension-marketplace).

Now you should have everything necessary installed. Let's get started with
writing code.

### Setting up the extension for your project

1. Open your OCaml/ReasonML project (`File > Add Folder to Workspace...`).

2. Configure the extension to use the desired sandbox (OPAM switch or esy
   sandbox). You can pick it by

   - either calling VSCode command "OCaml: Select a Sandbox for this Workspace"
     (one can do this from VSCode Command Palette - <kbd>Ctrl</kbd>+<kbd>P</kbd>
     or on MacOS <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>)
   - or clicking on the package icon at the bottom of VSCode window and picking
     your sandbox from the menu

     ![pick sandbox](./doc/pick_sandbox.png)

   > _What's a sandbox?_ A sandbox is like an isolated environment for your
   > project, so everything you install is just installed inside this
   > environment and not globally on your system.

3. Build your project with [Dune](https://github.com/ocaml/dune) to get
   go-to-definition, auto-completion, etc.

   > Important note: OCaml Language Server has its information about the files
   > from the last time your built your project.

   _Caveat 1:_ Because of the note above, during active development of your
   project, we advise building your project with dune in a polling mode using
   the option `--watch`. This rebuilds your project whenever a file is changed
   in your project. For example, run
   `dune build --watch --terminal-persistence=clear-on-rebuild` in your VSCode
   [integrated terminal](https://code.visualstudio.com/docs/editor/integrated-terminal).

   _Caveat 2:_ Save the currently open file to get latest diagnostics (error and
   warning squiggly underlining). For example, if you created a module `A` in
   some file, and you still get an error that it's "unbound" (i.e., not found)
   in the current file, save the file to get up-to-date diagnostics, assuming
   you built your project after adding `A` or are running build in a polling
   mode, and make sure that error isn't a stale error.

By this point, you should have a working OCaml development editor ready. If
you're on Windows or use ReasonML/ReScript/BuckleScript, see subsections below.

_In case of problems:_ Look at FAQ at the end of the document. If that doesn't
help:

- if you don't understand how to the extension works or how to make it work
  correctly, create a new discussion in the repository Discussions
  [tab](https://github.com/ocamllabs/vscode-ocaml-platform/discussions).
- if the extension seems to misbehave, file an issue in the repository Issues
  [tab](https://github.com/ocamllabs/vscode-ocaml-platform/issues).

### Windows

Install [OCaml for Windows](https://fdopen.github.io/opam-repository-mingw/) and
make sure the `ocaml-env` program is accessible on the PATH (`ocaml-env` is in
the `usr/local/bin` folder relative to the installation directory).

### ReasonML / ReScript / BuckleScript

ReasonML, as an alternative syntax for OCaml, is supported out-of-the-box, as
long as `reason` is installed in your environment.

The new ReScript syntax (`res` and `resi` files) is not supported, you should
use [rescript-vscode](https://github.com/rescript-lang/rescript-vscode) instead.

If you're looking for a way to use OCaml or ReasonML syntax in a ReScript
project, you'll need to install `ocaml-lsp` in your environment. We recommend
using Esy for this:

1. Install esy

```bash
npm install esy --global
```

2. Add `esy.json` to the project root with following content:

```json
{
  "dependencies": {
    "@opam/ocaml-lsp-server": "*",
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

An easy way to see what commands are offered by the extension in the currently
open file, you can invoke VSCode Command Palette and search for commands with
prefix `OCaml:`:

![commands](./doc/commands.png)

| Name                         | Description                                 | Keyboard Shortcuts |
| ---------------------------- | ------------------------------------------- | ------------------ |
| `ocaml.select-sandbox`       | Select sandbox for this workspace           |                    |
| `ocaml.server.restart`       | Restart language server                     |                    |
| `ocaml.open-terminal`        | Open a terminal (current sandbox)           |                    |
| `ocaml.open-terminal-select` | Open a terminal (select a sandbox)          |                    |
| `ocaml.current-dune-file`    | Open Dune File (located in the same folder) |                    |
| `ocaml.switch-impl-intf`     | Switch implementation/interface             | `Alt+O`            |
| `ocaml.open-repl`            | Open REPL                                   |                    |
| `ocaml.evaluate-expression`  | Evaluate Expression in REPL                 | `Shift+Enter`      |

Note: `ocaml.evaluate-expression` was previously named
`ocaml.evaluate-selection`.

## FAQ

<details>
<summary>I installed <code>ocaml-lsp-server</code>, but the extension still cannot find it.</summary>

Make sure you installed the the language server in the sandbox used by the
extension.

_OPAM_: If you're using opam, make sure that you're using correct switch when
installing the extension by running `opam switch` to see the current switch and
check the sandbox set for the current VSCode workspace (see "Setting up the
extension for your project" section to learn more about picking a sandbox for
the extension).

</details>

<details>
<summary> I am getting <code>Unbound module ...</code> error. What should I do? </summary>

1. Make sure the module _should_ be visible, e.g., there is no typo in the
   module name, you added the module to `libraries` stanza in your `dune` file,
   etc.

2. Make sure you have up-to-date diagnostics (error and warning squiggly
   underlining). Diagnostics are sent when the file open, when file is edited,
   and when it is saved. Save the file containing the error to make sure the
   error isn't stale.

3. Make sure you have built your project after adding that module to your
   environment. We suggest adhering to _Caveat 1_ in "Setting up the extension
   for your project" section. If you haven't built it, build it and go to
   step 2.

4. If you are sure there must be a problem with the extension, file an issue.

</details>

If this section doesn't contain the problem you managed to resolve, and you
think this may help others, consider adding the problem and its solution here by
creating a Pull Request.
