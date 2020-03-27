# vscode-ocaml-platform

Visual Studio Code extension for OCaml and relevants tools.

_This plugin is alpha quality. Use at your own risk and please report any bugs
you encounter._

## Features

- Syntax highlighting for menhir, dune, ocamlyacc files.

## Requirements

This vscode extension works in conjunction with
[ocaml-lsp-server](https://github.com/ocaml/ocaml-lsp).

## Extension Settings

The LSP server (ocamllsp) is not bundled with the extension
itself (but the extension can help you with it). The language server
itself can be installed via opam, esy or by any means (Nix, Duniverse
etc) that'll make it available globally on $PATH.

1. Via OPAM
If you have opam installed and as long as `opam exec ocamllsp` runs
okay in your project's directory, this plugin will not require any
special configuration

2. Via Esy

Esy users have to make sure `ocamllsp` is present in the sandbox -
ie. it must be present in your `devDependencies`

If you have both Esy and Opam installed, the extension will prompt for
the choice of package manager that would setup (or has already setup)
`ocamllsp`. This can be manually entered in settings if you wish by
updating `ocaml.packageManager`.

If you use neither OPAM nor Esy, please make sure `ocamllsp` is
globally available on `$PATH`. Alternatively, it can be specified with
the `ocaml.lsp.path` variable.


## Release Notes

### Unreleased
