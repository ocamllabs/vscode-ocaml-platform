# Change Log

## Unreleased

- Add the option to use a custom sandbox with a configurable command template
  (#322)
- Fix Reason syntax highlighting of module extension (#335)
- Highlight method keyword in ocaml interface (#340)
- Add support for opam template file (#342)

## 0.9.0

- Fix syntax highlighting of empty comments (#276)
- Fix syntax highlighting of floating attributes (#281)
- Improve highlighting of external declarations (#282)
- Highlight unprefixed opam files (#284)
- Fix syntax highlighting of `module type of` (#285)
- Fix syntax highlighting of module constraints (#286)
- Fix syntax highlighting of lazy bindings (#287)
- Add syntax highlighting for new ocamlformat values: `after-when-possible`,
  `before-except-val`, and `unset` (#288)
- Fix Reason syntax highlighting of binding operators (#291)
- Fix Reason syntax highlighting of type extensions (#292)
- Improve syntax highlighting of OCaml comments that contain strings (#289)
- Fix Reason syntax highlighting of recursive modules (#295)
- Improve automatic indentation of parentheses (#308)

## 0.8.0

- Add highlighting for locally abstract types in OCaml files
- Add highlighting for OASIS files
- Improve OCamlbuild highlighting
- Add dune task provider
- Add commands `ocaml.open-terminal` and `ocaml.open-terminal-select` to open a
  terminal in a sandbox
- Add `ocaml.trace.server` configuration option for the verbosity of the
  language server logs.
- Add command `ocaml.server.restart` to restart the language server
- Fix indentation rules for let-in expressions (#272)

## 0.7.0

- Fix faulty detection of esy sandboxes (#212)
- Add support for Dune formatting in sandboxes
- Add .mld syntax highlighting
- Add highlighting for Cppo directives in OCaml files
- Add highlighting for more toplevel and topfind directives in OCaml files
- OCaml problem matcher now understands multi line errors emitted by 4.09 (#229)
- Show statusbar item for current toolchain

## 0.6.1

- Fix Dune formatting for unsaved files

## 0.6.0

- Add Cram test syntax highlighting
- Add ATD syntax highlighting
- Add formatting for Dune files with format-dune-file
- Fix errors by the lsp server stealing focus from the editor to the output
  window.

## 0.5.0

- Improve ocamllex syntax highlighting
- Improve opam syntax highlighting
- Fix bugs in ocaml and ocamllex syntax highlighting
- Add OCamlFormat syntax highlighting
- Add dune-project syntax highlighting
- Add dune-workspace syntax highlighting
- Add dune snippets
- Add dune-project snippets
- Add META syntax highlighting
- Remove `ocaml.lsp.path` configuration option
- Introduce `ocaml.sandbox` configuration option to set the toolchain
- Introduce a `ocaml.select-sandbox` command for selecting the sandbox

## 0.4.0

- Add syntax highlighting and basic language support for ocamlyacc/menhir
  sources.
- Improve syntax highlighting of OCaml sources

## 0.3.1

- Remove auto closing for single quotes and angled brackets.

## 0.3.0

- Add OCaml indent rules
- Add auto-closing support for characters, object types
- Fix wonky auto-closing behavior of comments

## 0.2.0

- Add ocamllex syntax highlighting

## 0.1.0

- Add an OCaml problem matcher
- Add OCaml snippets
- Add Reason syntax highlighting

## 0.0.2

- Fix plugin icon URL

## 0.0.1

- Initial release
