# Syntax regression tests

`bun run test:syntax` runs the grammars through VS Code's TextMate and Oniguruma
engines. The registry uses the grammar paths and injection registrations from
`package.json`, and like VS Code it applies an `injectTo` scope to its dotted
descendants. `bun run test` also runs the extension tests in VS Code, including
editor token capture for OCaml implementations, interfaces, Menhir actions, opam
and install files, and OCaml and Reason blocks inside the built-in Markdown grammar.

`bun run typecheck:syntax` checks all syntax tests and helpers with the scoped
strict TypeScript configuration. CI runs this gate before the OCaml build.
The extension and its VS Code/Mocha runner remain CommonJS JavaScript.

The language test files keep each source example beside its native Bun inline
snapshot. Each output row is `line:start:end "text" scopes`: the line is one-based,
columns are the original zero-based UTF-16 TextMate boundaries, and `text` is JSON
encoded. The scope list omits only its first entry when that entry is the requested
root scope. Scope order and repeated scopes remain significant.

The renderer keeps empty tokens and scoped whitespace. It omits only nonempty
whitespace tokens whose entire scope stack is the root. Token boundaries are not
merged or clipped, including TextMate's synthetic line-end position. State passes
between lines, so snapshots show comment and string continuation and recovery.

Specification links sit above the corresponding tests. `SYNTAX_ROOT` selects
another checkout's grammars and registrations. Relative paths, including `.`, are
resolved against the invoking working directory. Tests, expectations and
dependencies always come from this checkout. The engine comparator forwards the
resolved absolute path when it starts Bun from the test checkout, so grammar
reads, Git operations and child tests use the same root.

To update expectations after an intentional change:

```sh
bun test ./tests/syntax --update-snapshots
```

Review the changed snapshots before committing. Ordinary runs compare existing
expectations, but Bun may create missing snapshots locally. `CI=true` makes missing
snapshots fail without writing them. Each test file owns and disposes its TextMate
registry; the files share Oniguruma's WebAssembly initialisation.

## Portability checks

The syntax suite checks numeric capture dictionaries and resolves local and
cross-grammar includes. It also checks 2,520 Markdown fence combinations with
unterminated embedded strings, including marker, length, and indentation changes.

An optional comparison runs expressions changed since a Git revision against
the same source lines using both VS Code's Oniguruma and a supplied Ruby executable.
It requires Bun and Ruby with its standard JSON library. The comparator first runs
the snapshot tests with `CI=true`, collecting their actual inputs in a temporary
file. It reads the corpus only after that run succeeds, then removes the temporary
file. Test inputs are neither duplicated nor extracted from test source code. For example:

```sh
bun tests/syntax/compare-engines.ts origin/master /usr/bin/ruby
```

The comparison checks match positions and captured text. It normalises unmatched
captures, which the APIs represent differently. Parent-dependent end expressions
are reported separately because TextMate must substitute their begin captures
before compilation. The syntax suite exercises those expressions with real state.

Validation during this change found no remaining differences across 140,336
expression/input pairs with Ruby 2.6.10, Ruby 4.0.7, and native Oniguruma 6.9.10
against vscode-oniguruma 2.0.1. The native comparison checked capture byte offsets
under both Ruby syntax and the default Oniguruma syntax. Dune atom boundaries use
the same explicit ASCII separators at both ends of atoms and inside structural
forms because engines disagree about Unicode `\s`.

## Reference coverage

The audit checked all 22 registered grammars on 4 October 2026. The references
below supplement the links beside individual cases.

| Grammars                             | References                                                                                                                                                                                                                                                                          |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| OCaml, interfaces                    | [OCaml 5.5 lexical conventions](https://ocaml.org/manual/5.5/lex.html), [attributes](https://ocaml.org/manual/5.5/attributes.html), and [compiler lexer](https://github.com/ocaml/ocaml/blob/5.5/parsing/lexer.mll)                                                                 |
| MLX                                  | Shared OCaml rules and [MLX 0.11 parser](https://github.com/ocaml-mlx/mlx/blob/0.11/mlx/parser.mly)                                                                                                                                                                                 |
| OCamllex                             | [OCaml 5.5 lexer-generator reference](https://ocaml.org/manual/5.5/lexyacc.html)                                                                                                                                                                                                    |
| Ocamldoc                             | [OCaml 5.5 documentation reference](https://ocaml.org/manual/5.5/ocamldoc.html)                                                                                                                                                                                                     |
| Dune, dune-project, dune-workspace   | [Dune lexical conventions](https://dune.readthedocs.io/en/stable/reference/lexical-conventions.html), [3.24.2 lexer](https://github.com/ocaml/dune/blob/3.24.2/src/dune_sexp/lexer.mll), and [action reference](https://dune.readthedocs.io/en/stable/reference/actions/index.html) |
| Cram                                 | [Dune Cram reference](https://dune.readthedocs.io/en/stable/reference/cram.html) and [3.24.2 lexer](https://github.com/ocaml/dune/blob/3.24.2/src/dune_rules/cram/cram_lexer.mll)                                                                                                   |
| Reason                               | [Reason 3.18.0 lexer](https://github.com/reasonml/reason/blob/3.18.0/src/reason-parser/reason_declarative_lexer.mll)                                                                                                                                                                |
| OCaml and Reason Markdown injections | [CommonMark 0.31.2 fenced code blocks](https://spec.commonmark.org/0.31.2/#fenced-code-blocks)                                                                                                                                                                                      |
| Menhir, Menhir actions               | [Menhir manual](https://gallium.inria.fr/~fpottier/menhir/manual.html)                                                                                                                                                                                                              |
| ATD                                  | [ATD language reference](https://atd.readthedocs.io/en/latest/atd-language.html) and [released 4.2.0 parser](https://github.com/ahrefs/atd/blob/4.2.0/atd/src/parser.mly)                                                                                                           |
| opam, opam install files             | [opam manual](https://opam.ocaml.org/doc/Manual.html)                                                                                                                                                                                                                               |
| META                                 | [Findlib META reference](https://projects.camlcity.org/projects/dl/findlib-1.9.8/doc/ref-html/r759.html) and [lexer](https://github.com/ocaml/ocamlfind/blob/master/src/findlib/fl_meta.mll)                                                                                        |
| Merlin                               | [Project configuration](https://github.com/ocaml/merlin/wiki/Project-configuration)                                                                                                                                                                                                 |
| OCamlFormat                          | [Configuration reference](https://ocaml.org/p/ocamlformat/latest/doc/getting_started.html)                                                                                                                                                                                          |
| OASIS                                | [OASIS manual](https://github.com/ocaml/oasis/blob/master/doc/MANUAL.mkd)                                                                                                                                                                                                           |
| OCamlbuild                           | [Manual](https://github.com/ocaml/ocamlbuild/blob/master/manual/manual.adoc) and [glob lexer](https://github.com/ocaml/ocamlbuild/blob/master/src/glob_lexer.mll)                                                                                                                   |

## Scope limits

TextMate classifies syntax without name resolution or type checking. OCaml and
MLX names such as `int` and `string` can denote values or locally defined types.
ATD uses predefined type names in type expressions, but the same names can label
record fields. These names receive a built-in type scope only in type contexts
the grammars can delimit: type declaration bodies, interface and `sig` signatures,
`external` declarations, and ATD type expressions. Record labels and module paths
such as `M.int` are excluded. Implementation annotations such as `(x : int)` and
class bodies leave the names unscoped.

Type and class declarations retain their kind across `and` continuations, and
methods receive method scopes. A `let`, `and`, or `val` name receives
`entity.name.function.binding.ocaml` when the same line shows a function: a
parameter, `= fun`, `= function`, or an arrow type. `external` names always
receive it, because OCaml requires externals to have function types. Other names,
including declarations whose type starts on the next line, use the neutral
`entity.name.binding.ocaml` scope. Syntactic type parameters retain their
type-variable scopes.

These tests cover the reported lexical distinctions and state boundaries. They
do not establish complete parser conformance, exact Unicode identifier
validation, or correctness of the external JavaScript, HTML, and LaTeX grammars.
Consumers must provide `source.js`, `text.html.basic`, and `text.tex.latex` for
those embedded languages. Menhir actions and Markdown blocks also require host
support for grammar injections. Scope colours remain theme-dependent.

Markdown injections distinguish absolute line starts from the host grammar's
container-relative position. They reject top-level fences indented by four
spaces or a tab while preserving valid tabbed fences in quotes and lists. The
host still owns Markdown block classification and list indentation. These rules
do not correct the host's generic fenced-block or deeply indented list parsing.

Markdown language hints continue to accept NBSP before the language and its
attributes, matching VS Code's editor and preview. CommonMark does not prescribe
how renderers interpret these hints. Closing fences follow a separate rule and
accept only ASCII spaces or tabs after the marker, with an optional terminal CR
for callers that retain CRLF line endings.
