# Change Log

# Unreleased

- Add `ocaml.copy-type-under-cursor` to copy, in the clipboard the type of
  the expression under the cursor (#1582)

- Add `ocaml.search-by-type` to search for values using their type signature (#1626)

## 1.20.1

- This was a version bump only, there were no changes
  - Update runtime dependencies

## 1.20.0

- Fix syntax for `dune-project.package.(depends|conflicts|depopts)` (#1543)
- Add syntax for `dune-project.package.allow_empty` (#1542)

## 1.19.2

- Fix `variable.other.declaration.dune-project` to allow wider range of characters
  (#1517)

## 1.19.1

- This was a version bump only, there were no changes

## 1.19.0

- Add new syntax patterns for dune(-project) files (#1391)
- Add syntax color to odoc tables, odoc headings with labels, and odoc code
  blocks with attributes (#1465)

## 1.18.1

- Fix `sideEffects` field in `astexplorer/package.json` (#1427)

## 1.18.0

- Fallback to `ocaml.org` package documentation page if there is no doc field in
  the package's opam file (#1331)

## 1.17.3

- Republish 1.17.2 (#1405)

## 1.17.2

- Fix opening a new REPL terminal after first one was terminated (issue #935,
  #1398)

## 1.17.1

- Set the VSCode lower bound to 1.86.0 (#1379)

## 1.17.0

- Add syntax color to ocamldoc and odoc markup (#1365)
- Remove comment color from mld files (but keep markup color) (issue #1014,
  #1365)

## 1.16.2

- Fix non-ocaml markdown code block syntax highlighting being influenced (issue
  #1288, #1369)

## 1.16.1

- No longer color comments starting three stars or more as ocamldoc comments
  (#1355)

## 1.16.0

- Add syntax documentation option (#1313)

- Update syntax for ocamlformat (#1343)

- Add snippet for dune alias stanza (#1347)

## 1.15.0

- Fix direnv compatibility by loading the process.env on every command (#1322)

- Fix server settings missing on LSP startup (#1321)

- Fix broken syntax highlighting for a wildcard in the env stanza (#1334)

- Add config to disabling dune diagnostics (#1320)

## 1.14.2

- Add `1.17.0` to the list of known versions of ocamllsp (#1326)

## 1.14.1

- Fix incorrect esy sandbox docs (#1297)

## 1.14.0

- Support switching between impl and intf in reason (#1274)

## 1.13.4

- Fix extension crashing after restarting the language server (#1262)

## 1.13.3

- Set the VSCode lower bound to 1.82.0 and set the build target to es2022 to get
  better runtime performance (#1245)

## 1.13.2

- Indentation level is increased more reliably for `let`, `and`, and their
  binding operator equivalents (#1237)

- Disable semantic highlight in reason files to fix highlighting when opening
  them over ssh (#1231)

## 1.13.1

- Fix highlighting of flags stanza in dune files (#1182)

- Fix extension crashing when overriding global exception handler (#1212)

## 1.13.0

- Add experimental
  [earlybird bytecode debugger](https://github.com/hackwaly/ocamlearlybird)
  integration (#1148)

- Trim whitespace when running `Evaluate Selection` command (#1100)

- Encode URI when sending the `switchImplIntf` request (#983)

- Support LSP server settings (#1157)

- Maintain focus on editor when sending code to REPL (#1161)

- Add more patterns to `opam-metadata.source` (#1165)

## 1.12.2

- Add more known versions of ocamllsp

## 1.12.1

- Update known ocamllsp versions (#1072)

## 1.12.0

- Add `ocaml.server.args` configuration option to pass extra arguments to the
  language server, i.e. ocamllsp (#1042)

- Fix AST Explorer not displaying anything with error "Blocked script execution"
  (#1050)

- Change the `ocaml.useOcamlEnv` setting to only enable `ocaml-env` usage for
  opam commands if it is available on the system (#978)

## 1.11.0

- Fix syntax highlighting for let bindings with type annotations (#991)

- Add support for `${firstWorkspaceFolder}` as a placeholder variable in
  configuration files (#1004)

## 1.10.8

- Add more known versions of ocamllsp

## 1.10.7

- Upgrade to `vscode-languageclient` v8.0.1. This may fix some stability
  problems

- Revert "Add minimal support as a Web Extension (#962)" because of regressions

## 1.10.6

- Update known ocamllsp versions (#972)

## 1.10.5

- "Reveal AST Node" command now does not fail if the AST Explorer is not open
  but opens it and then reveals the node (#964)

- Fix reading `ocaml.repl.useUtop` setting (#957)

- Add minimal support as a Web Extension (#962)

## 1.10.4

- Correctly handle empty switches (#940)

## 1.10.3

- Add arrays to auto closing pairs (#946)

## 1.10.2

- Add indentation rules for comments (#928)

## 1.10.1

- Fix external syntax highlighting for embedded ocaml source in comments (#906)

- Add `ocaml.repl.useUtop` setting to control whether to use Utop for the REPL
  (#911)

## 1.10.0

- Add the possibility to generate and show the documentation of an installed
  package right into VSCode. (#771)

## 1.9.5

- Fix automatic closing of files without an extension (#887)

## 1.9.4

- Restore compatibility with opam 2.0.x (#884)

## 1.9.3

- Fix dune subdir stanza syntax highlighting (#870)

## 1.9.2

- Improve dune variable syntax highlighting. Add highlighting for `env` and
  `bin-available` variables. (#872)

## 1.9.1

- Make the check for out of date ocamllsp more conservative. It will no longer
  alert the user unless the extension is certain an upgrade is possible (#859)

## 1.9.0

- Dune syntax highlighting fix (#742)

  The syntax for dune files has been re-written from scratch for a more correct
  implementation. Every dune stanza documented by Dune is now supported, and
  only the correct fields in each stanza are recognized.

- Fix the detection of opam's root directory when no switch is detected (#831)

- Add support for opening compilation artifacts in human-readable form in the
  editor (#798)

  Currently supported artifacts include `.cmi`, `.cmt(i)`, `.cmo`, `.cma`,
  `.cmx(a/s)`, and `.bc` files.

  To learn more about these files, see: https://ocaml.org/manual/comp.html

- Warn if the extension sees not the latest OCaml-LSP version compatible with
  the OCaml distribution installed in the current sandbox.

- Highlighted the UNREACHABLE element in cram .t files (#754)

- Activate extension on cram files, or when the workspace contains
  dune-workspace or dune files. (#750)

- Add commands `Jump to Next Typed Hole` (shortcut: `Alt + L`) and
  `Jump to Previous Typed Hole` (shortcut: `Alt + Shift + L`)

  _What typed holes are_

  Merlin has a concept of "typed holes" that are syntactically represented as
  `_`. Files that incorporate typed holes are not considered valid OCaml, but
  Merlin and OCaml-LSP support them. One example when such typed holes can occur
  is when one "destructs" a value, e.g., destructing `(Some 1)` will generate
  code `match Some 1 with Some _ -> _ | None -> _`. While the first underscore
  is a valid "match-all"/wildcard pattern, the rest of underscores are typed
  holes that one needs to replace with valid OCaml code. These new commands help
  to navigate easily from one hole to another (#643)

- Rename the extension's section in VS Code Settings from `OCaml configuration`
  to `OCaml Platform` (#674)

- Add `ocaml.server.extraEnv` configuration option to pass extra environment
  variables to the language server, i.e., OCaml-LSP (#674)

- Parsetree exploration and development tools. It is now possible to explore the
  structure of the parsetree in a custom editor. Additionally, it is possible to
  view preprocessed source of any OCaml source file (when applicable). Full
  functionality is available only for dune projects. (#666)

- Add commands `Show OCaml Language Server Output`,
  `Show OCaml Platform Extension Output`, and `Show OCaml Commands Output`.
  (#745)

- Fix highlighting of escaped odoc source code braces (#690)

- `opam exec` is now called with `--set-switch` flag; this is useful when we
  launch a terminal within a certain sandbox set in the extension (#744, fixes
  #655)

- The currently active OPAM switch in the workspace folder (project root) is
  shown first in the list of sandboxes when selecting a sandbox. (#751)

- Show a different icon for the currently active OPAM switch in the "OPAM
  Switches" tree view (#751)

## 1.8.4

- Fix inclusion of files in extension package

## 1.8.3

- Fix showing error message if ocaml-lsp is missing (#586)

## 1.8.2

- Fix switching between implementation/interface (#561)

- Stop automatically highlighting suffixed META files (#565)

## 1.8.1

- Revert automatic installation of platform tools

  The feature is not flexible enough and caused issues with multiple users. We
  will work on making it more flexible and fit more workflows before releasing
  it.

## 1.8.0

- Highlight OCaml source code inside Cinaps comments (#547)

- Show the output of shell commands in an output channel. The output channel is
  automatically focused when running a package management command from the OCaml
  activity tab (#541)

- Fix highlighting of float literals with a trailing decimal point (#548)

- Ask for confirmation when removing opam packages or switches (#551)

## 1.7.0

- Fixed an issue when uninstalled Opam packages still appear in the `roots`
  field of Opam's `switch-state` file (#517)

- Fixed detection of local Opam switch on Windows (#518)

- `vscode-ocaml-platform` now depends on `ocaml-lsp-server.1.3.0`

- Add a command to open a Utop REPL in the current sandbox (#504)

- Add a code evaluation command that sends selected expressions to the REPL
  (#504)

- Install OCaml Platform tools automatically (#463)

  The platform tools (a.k.a toolchain) are installed in a private opam switch
  that should only be used by `vscode-ocaml-platform`.

## 1.6.0

- Highlight token aliases in Menhir associativity declarations (#473)

- Activate the extension when workspace contains OCaml, Reason sources or
  project marker files. (#482)

- Add `ocaml.useOcamlEnv` setting to determine whether to use `ocaml-env` for
  opam commands from OCaml for Windows (#481)

- Fix terminal creation when using default shell and arguments (#484)

- Add an OCaml activity tab (#486)

  The activity tab provides three views: the available switches, the build
  commands and an Help and Feedback section with links to community channels.

- Support `eliom` and `eliomi` file extensions (#487)

- Fix ocaml/ocaml-lsp#358: automatic insertion of an inferred interface was
  inserting code incorrectly on the second switch to the newly created (unsaved)
  `mli` file. If the new `mli` file isn't empty, we don't insert inferred
  interface (#498)

- Add a new command "Dune: open current dune file", which is available in the
  command palette if there is an open file. The command opens the dune file that
  is located in the same folder as the open file or creates the dune file in a
  draft mode (not yet saved on the disk). (#499)

## 1.5.1

- Improve highlighting of type parameters and `module type of` (#461)
- Fix highlighting of escaped character literals (#467)
- Fix highlighting of comments that contain strings with escaped quotes (#469)
- Initialize extension even if language server fails to start (#471)
- Detection of local Opam and Esy sandboxes (#445)

  The detection will prioritize Opam local switches, then Esy sandboxes (that
  are detected with the directory `_esy`), and will fallback to the global
  environment sandbox if none of these are found.

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
