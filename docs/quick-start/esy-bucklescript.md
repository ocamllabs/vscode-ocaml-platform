# esy / BuckleScript

ReasonML, as an alternative syntax for OCaml, is supported out-of-the-box, as
long as `reason` is installed in your environment.

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
