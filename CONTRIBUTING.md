# Developing

## Quick Start

FIRST, install the OCaml dependencies and generate the OCaml -> Javascript
artifacts:

```bash
opam install . --deps-only --with-test
make build
```

SECOND, press F5 in VS Code to launch the "Extension Development Host".

## Code Hygiene

```bash
esy
yarn
opam install ocamlformat
make fmt
make test
```
