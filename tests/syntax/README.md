# Syntax regression tests

`bun run test:syntax` runs the grammars through VS Code's TextMate and Oniguruma
engines. The registry uses the grammar paths and injection registrations from
`package.json`. `bun run test` also runs the extension tests in VS Code, including
editor token capture for OCaml implementations, interfaces, Menhir actions, opam
and install files, and OCaml and Reason blocks inside the built-in Markdown grammar.

Each JSON file in `cases/` contains source snippets and scope assertions. Lines
and occurrences are one-based. Every token overlapping the selected text must
have each required scope and none of the excluded scopes. A scope matches itself
and its dot-separated descendants. `singleToken` also requires exact token
boundaries. State passes between lines, so the cases check comment and string
termination as well as individual tokens.

The `reference` field records the specification behind each case. `SYNTAX_ROOT`
selects another checkout's grammars, registrations, and cases for comparison
with a baseline. The runner itself and its dependencies come from this checkout.

## Portability checks

The syntax suite checks numeric capture dictionaries and resolves local and
cross-grammar includes. It also checks 2,520 Markdown fence combinations with
unterminated embedded strings, including marker, length, and indentation changes.

An optional comparison runs expressions changed since a Git revision against
the fixture lines using both VS Code's Oniguruma and a supplied Ruby executable.
It requires Ruby with its standard JSON library. For example:

```sh
node tests/syntax/compare-engines.js origin/master /usr/bin/ruby
```

The comparison checks match positions and captured text. It normalises unmatched
captures, which the APIs represent differently. Parent-dependent end expressions
are reported separately because TextMate must substitute their begin captures
before compilation. The syntax suite exercises those expressions with real state.

Validation during this change found no remaining differences across 67,881
expression/input pairs with Ruby 2.6.10, Ruby 4.0.7, and native Oniguruma 6.9.10
against vscode-oniguruma 2.0.1. The native comparison checked capture byte offsets
under both Ruby syntax and the default Oniguruma syntax. Dune atom boundaries use
explicit ASCII whitespace because engines disagree about Unicode `\s`.

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
record fields. These names no longer receive a built-in type scope everywhere.
Type and class declarations receive type scopes, and methods receive method
scopes. Other bindings use a neutral binding scope where the declaration does
not establish that the value is a function. Syntactic type parameters retain
their type-variable scopes.

These tests cover the reported lexical distinctions and state boundaries. They
do not establish complete parser conformance, exact Unicode identifier
validation, or correctness of the external JavaScript, HTML, and LaTeX grammars.
Consumers must provide `source.js`, `text.html.basic`, and `text.tex.latex` for
those embedded languages. Menhir actions and Markdown blocks also require host
support for grammar injections. Scope colours remain theme-dependent.
