# Change Log

## 1.5.1

- Improve highlighting of type parameters and `module type of` (#461)
- Fix highlighting of escaped character literals (#467)
- Fix highlighting of comments that contain strings with escaped quotes (#469)
- Initialize extension even if language server fails to start (#471)

## 1.5.0

- Highlight `rec` keyword in OCaml mli files for recursive modules (#434)
- Highlight `cram` stanza in dune-project files (#441)
- Fix reason highlighting of let extensions (#447)
- Improve highlighting of Menhir new syntax (#450)
- Improve Menhir syntax highlighting (#455)
- Add `Alt + P` keyboard shortcut for infer interface code action (#448)
- Infer interface when switching to a non-existing interface file (#437)

## 1.4.0

- Stop highlighting ocaml unit/array/list literals with bold (#416)
- Add a snippet `struct end` with prefix `struct` (#420)
- Only restart the language server for the `ocaml.server.restart` command (#426)
- Use highlighting for character literals which is consistent with other
  languages in VS Code (#428)
- Allow using `${workspaceFolder:folder_name}` placeholder variables in sandbox
  configurations for portable settings.json files (#424)
- Fix OCaml problem matcher for warning codes and error messages without
  characters (#429)

## 1.3.3

- Fix sandbox functionality when a folder is not opened (#409)
- Remove duplicate esy sandboxes from package manager selection (#412)

## 1.3.2

- Fix incomplete error message for missing commands (#400)
- Fix highlighting of quoted string literals that contain quotes (#403)
- Fix path handling for global sandboxes on Windows (#401)

## 1.3.1

- Fix bug that prevented the extension from initializing properly when installed
  from the marketplace (#398)

## 1.3.0

- Replace "Switch implementation/interface" navigator button with a custom icon
  (#383)
- Add `Alt + D` keyboard shortcut for destruct code action (#384)

## 1.2.0

- Consistent binding operator highlighting in OCaml files (#365)
- Switch between implementation and interface files using `Alt + O`. This
  requires updating ocamllsp (#328)

## 1.1.2

- Highlight dashes in PKG names for .merlin files (#349)
- Make .ocamlformat syntax highlighting more distinct (#350)
- Improve highlighting of path elements and strings in .merlin files (#355)
- Fix highlighting of comments that contain quoted string literals (#363)
- Fix highlighting of rec keyword in type-annotated functions (#364)

## 1.1.1

- Fix interaction between character literals and comments/escaped quotes in
  OCaml files (#348)

## 1.1.0

- Highlight method keyword in ocaml interface (#340)
- Add support for opam template file (#342)
- Improve highlighting of labels and attributes/extensions in OCaml files (#343)
- Add esy.json schema validation (#344)

## 1.0.0

- Add the option to use a custom sandbox with a configurable command template
  (#322)
- Fix Reason syntax highlighting of module extension (#335)

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
