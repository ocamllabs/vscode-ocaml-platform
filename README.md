# VSCode OCaml Platform

Visual Studio Code extension for OCaml and relevant tools

_This plugin is alpha quality. Use at your own risk and please report any bugs
you encounter._

## Features

- Syntax highlighting for OCaml, ReasonML, dune, merlin, ocamlbuild, ocamllex,
  opam files.

- Indentation rules and snippets for OCaml

## Extension Settings

For now, it's required to either have `ocamllsp` (from ocaml-lsp) in `PATH` or
configure it with the `ocaml.lsp.path` variable

## Installation

### Requirements

This VSCode extension works in conjunction with
[ocaml-lsp-server](https://github.com/ocaml/ocaml-lsp).

### Install from the Marketplace (Recommended)

<https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform>

### Download a pre-built extension installer from GitHub Actions artifacts

- Select a build you want to try from the Actions tab.

  - <https://github.com/ocamllabs/vscode-ocaml-platform/actions>

- Download the artifact for your platform in your preferred way.

- Unzip the downloaded file

- Install to VSCode using the code command

```
code --install-extension <Path to unzipped vsix file>
```

## Release Notes

### Unreleased
