# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

VS Code extension for OCaml, written in OCaml and compiled to JavaScript via js_of_ocaml. Provides language support (via ocaml-lsp-server), syntax highlighting, sandbox management (OPAM/Esy/Dune Package Management), debugging (earlybird), REPL integration, and AST exploration.

## Build Commands

```bash
make build   # Build extension (dune + esbuild + astexplorer)
make test    # Run OCaml tests (@runtest) and JavaScript tests
make fmt     # Format OCaml (ocamlformat) and JS (biome)
make pkg     # Clean, build, and package to VSIX
make install # Package and install extension via `code` CLI
make watch   # Watch mode for development
```

### First-time Setup

This project uses Dune Package Management (DPM). Requires nightly dune from <https://nightly.dune.build>.

```bash
# Install nightly dune (if not already installed)
curl -fsSL https://get.dune.build/install | sh

# Install npm dependencies
yarn install

# Build (automatically fetches OCaml dependencies from dune.lock)
dune build
```

To update the dependency lock file:

```bash
dune pkg lock
```

To install development tools:

```bash
dune tools install ocamllsp    # Install LSP server
dune tools install ocamlformat # Install formatter
```

### Linting

```bash
yarn check # Run biome linter checks
yarn lint  # Biome linting
yarn fix   # Auto-fix with biome
```

## Architecture

### Entry Point

`src/vscode_ocaml_platform.ml` - Main extension entry point, exports `activate()` to VS Code.

### Core Components

- **Extension Instance** (`src/extension_instance.ml`) - Central state management holding sandbox, REPL, LSP client, and configuration
- **Sandbox** (`src/sandbox.ml`) - Abstracts package managers (Global, OPAM switches, Esy sandboxes, Dune Package Management)
- **OCaml LSP** (`src/ocaml_lsp.ml`) - Language server integration and custom request handling
- **Commands** (`src/extension_commands.ml`) - 60+ VS Code commands for OCaml development

### Key Directories

- `src/` - Main OCaml extension source
- `src-bindings/` - JavaScript bindings via gen_js_api (vscode, vscode-languageclient, node APIs)
- `astexplorer/` - Separate React workspace for AST explorer feature
- `syntaxes/` - TextMate grammar definitions (24 languages including OCaml, Dune, Menhir, opam)

### Compilation Pipeline

OCaml source → js_of_ocaml (produces `.bc.js`) → esbuild (bundles to `dist/`)

## Code Patterns

### JavaScript Interop

Uses `gen_js_api` PPX for OCaml-JavaScript bindings. Bindings in `src-bindings/` expose VS Code APIs, Node.js APIs, and language client.

### Async Code

Uses `promise_jsoo` for Promise handling. Extension state is mutable with Promise-based async operations.

### Feature Registration

Each feature (AST explorer, REPL, debugger, tree views) registers itself during activation. Commands defined in `extension_commands.ml` follow VS Code command pattern.

## PR Requirements

- Run `make fmt` before committing
- Run `make build` to ensure compilation succeeds
- Run `make test` to verify tests pass
- User-visible changes require changelog entry (skip with "no changelog" label)
