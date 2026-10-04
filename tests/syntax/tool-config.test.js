const { afterAll, expect, test } = require("bun:test");
const { createTokenizer } = require("./tokenizer");

const tokenizer = createTokenizer();
afterAll(() => tokenizer.dispose());

// https://raw.githubusercontent.com/ocaml/ocamlfind/master/src/findlib/fl_meta.mll
test("META consecutive and multiline assignments", async () => {
  const source = `version = "1" description = "line one
line two \\"quoted\\" # text"
archive(byte) = "a.cma" # done`;
  expect(await tokenizer.render("source.ocaml.META", source)).toMatchInlineSnapshot(`
    "1:0:7 "version" entity.name.tag.META
    1:8:9 "=" keyword.operator.META
    1:10:11 "\\"" string.quoted.double.META
    1:11:12 "1" string.quoted.double.META
    1:12:13 "\\"" string.quoted.double.META
    1:14:25 "description" entity.name.tag.META
    1:26:27 "=" keyword.operator.META
    1:28:29 "\\"" string.quoted.double.META
    1:29:38 "line one" string.quoted.double.META
    2:0:9 "line two " string.quoted.double.META
    2:9:11 "\\\\\\"" string.quoted.double.META constant.character.escape.META
    2:11:17 "quoted" string.quoted.double.META
    2:17:19 "\\\\\\"" string.quoted.double.META constant.character.escape.META
    2:19:26 " # text" string.quoted.double.META
    2:26:27 "\\"" string.quoted.double.META
    3:0:7 "archive" entity.name.tag.META
    3:7:8 "("
    3:8:12 "byte" constant.language.META
    3:12:13 ")"
    3:14:15 "=" keyword.operator.META
    3:16:17 "\\"" string.quoted.double.META
    3:17:22 "a.cma" string.quoted.double.META
    3:22:23 "\\"" string.quoted.double.META
    3:24:25 "#" comment.line.META
    3:25:30 " done" comment.line.META"
  `);
});

// https://github.com/ocaml/merlin/wiki/Project-configuration
test("Merlin hidden dependency and index paths", async () => {
  const source = `SH src/**
BH _build/default
INDEX _build/**/*.ocaml-index
PKG lwt.unix`;
  expect(await tokenizer.render("source.ocaml.merlin", source)).toMatchInlineSnapshot(`
    "1:0:2 "SH" string.other.merlin keyword.other.merlin
    1:2:3 " " string.other.merlin keyword.other.path.merlin
    1:3:6 "src" string.other.merlin
    1:6:7 "/" string.other.merlin keyword.other.path.merlin
    1:7:8 "*" string.other.merlin keyword.other.glob.merlin
    1:8:9 "*" string.other.merlin keyword.other.glob.merlin
    2:0:2 "BH" string.other.merlin keyword.other.merlin
    2:2:3 " " string.other.merlin keyword.other.path.merlin
    2:3:9 "_build" string.other.merlin
    2:9:10 "/" string.other.merlin keyword.other.path.merlin
    2:10:17 "default" string.other.merlin
    3:0:5 "INDEX" string.other.merlin keyword.other.merlin
    3:5:6 " " string.other.merlin keyword.other.path.merlin
    3:6:12 "_build" string.other.merlin
    3:12:13 "/" string.other.merlin keyword.other.path.merlin
    3:13:14 "*" string.other.merlin keyword.other.glob.merlin
    3:14:15 "*" string.other.merlin keyword.other.glob.merlin
    3:15:16 "/" string.other.merlin keyword.other.path.merlin
    3:16:17 "*" string.other.merlin keyword.other.glob.merlin
    3:17:18 "." string.other.merlin keyword.other.path.merlin
    3:18:29 "ocaml-index" string.other.merlin
    4:0:3 "PKG" storage.type.merlin
    4:4:7 "lwt" entity.name.class.merlin
    4:7:8 "." keyword.other.merlin
    4:8:12 "unix" entity.name.class.merlin"
  `);
});

// https://ocaml.org/p/ocamlformat/latest/doc/getting_started.html
test("OCamlFormat basic config", async () => {
  const source = `profile = conventional
margin = 90 # width`;
  expect(await tokenizer.render("source.ocaml.ocamlformat", source)).toMatchInlineSnapshot(`
    "1:0:7 "profile" keyword.other.ocamlformat
    1:8:9 "=" punctuation.separator.key-value.ocamlformat
    1:10:22 "conventional" string.other.ocamlformat
    2:0:6 "margin" keyword.other.ocamlformat
    2:7:8 "=" punctuation.separator.key-value.ocamlformat
    2:9:11 "90" constant.numeric.decimal.ocamlformat
    2:12:13 "#" comment.line.ocamlformat
    2:13:19 " width" comment.line.ocamlformat"
  `);
});

// https://raw.githubusercontent.com/ocaml/oasis/master/doc/MANUAL.mkd
test("OASIS sections and fields", async () => {
  const source = `Library core
  Path: src
  if flag(debug)
    Build$: true`;
  expect(await tokenizer.render("source.ocaml.oasis", source)).toMatchInlineSnapshot(`
    "1:0:7 "Library" keyword.other.oasis
    1:7:12 " core" string.other.oasis
    2:2:6 "Path" entity.name.tag.oasis
    2:6:7 ":" keyword.operator.oasis
    2:7:12 " src"
    3:2:4 "if" keyword.other.oasis
    3:5:9 "flag" entity.name.function.oasis
    3:9:10 "("
    3:10:15 "debug"
    3:15:16 ")"
    4:4:9 "Build" entity.name.tag.oasis
    4:9:11 "$:" keyword.operator.oasis
    4:12:16 "true" constant.language.oasis"
  `);
});

// https://raw.githubusercontent.com/ocaml/ocamlbuild/master/src/glob_lexer.mll
test("OCamlbuild glob expressions", async () => {
  const source = "<src/*.ml> or <test/?.ml>: debug, bin_annot # done";
  expect(await tokenizer.render("source.ocaml.ocamlbuild", source)).toMatchInlineSnapshot(`
    "1:0:1 "<" string.quoted.double.ocamlbuild keyword.operator.ocamlbuild
    1:1:5 "src/" string.quoted.double.ocamlbuild
    1:5:6 "*" string.quoted.double.ocamlbuild constant.language.ocamlbuild
    1:6:9 ".ml" string.quoted.double.ocamlbuild
    1:9:10 ">" string.quoted.double.ocamlbuild keyword.operator.ocamlbuild
    1:11:13 "or" keyword.operator.ocamlbuild
    1:14:15 "<" string.quoted.double.ocamlbuild keyword.operator.ocamlbuild
    1:15:20 "test/" string.quoted.double.ocamlbuild
    1:20:21 "?" string.quoted.double.ocamlbuild keyword.operator.ocamlbuild
    1:21:24 ".ml" string.quoted.double.ocamlbuild
    1:24:25 ">" string.quoted.double.ocamlbuild keyword.operator.ocamlbuild
    1:25:26 ":" keyword.operator.ocamlbuild
    1:26:32 " debug"
    1:32:33 "," keyword.other.ocamlbuild punctuation.comma punctuation.separator.comma
    1:33:44 " bin_annot "
    1:44:45 "#" comment.line.ocamlbuild
    1:45:50 " done" comment.line.ocamlbuild"
  `);
});

// https://raw.githubusercontent.com/ocaml/oasis/master/doc/MANUAL.mkd
test("OASIS hash in field value", async () => {
  const source = `Homepage: https://example.org/#section
# comment`;
  expect(await tokenizer.render("source.ocaml.oasis", source)).toMatchInlineSnapshot(`
    "1:0:8 "Homepage" entity.name.tag.oasis
    1:8:9 ":" keyword.operator.oasis
    1:9:39 " https://example.org/#section"
    2:0:1 "#" comment.line.oasis
    2:1:9 " comment" comment.line.oasis"
  `);
});

// https://raw.githubusercontent.com/ocaml/ocamlbuild/master/src/glob_lexer.mll
test("OCamlbuild escaped quote and boolean alternatives", async () => {
  const source = `"a\\"#b.ml" OR <*.ml> & NOT <test/*>: debug
1: bin_annot`;
  expect(await tokenizer.render("source.ocaml.ocamlbuild", source)).toMatchInlineSnapshot(`
    "1:0:1 "\\"" string.quoted.double.ocamlbuild
    1:1:2 "a" string.quoted.double.ocamlbuild
    1:2:4 "\\\\\\"" string.quoted.double.ocamlbuild constant.character.escape.ocamlbuild
    1:4:9 "#b.ml" string.quoted.double.ocamlbuild
    1:9:10 "\\"" string.quoted.double.ocamlbuild
    1:11:13 "OR" keyword.operator.ocamlbuild
    1:14:15 "<" string.quoted.double.ocamlbuild keyword.operator.ocamlbuild
    1:15:16 "*" string.quoted.double.ocamlbuild constant.language.ocamlbuild
    1:16:19 ".ml" string.quoted.double.ocamlbuild
    1:19:20 ">" string.quoted.double.ocamlbuild keyword.operator.ocamlbuild
    1:21:22 "&" keyword.operator.ocamlbuild
    1:23:26 "NOT" keyword.operator.ocamlbuild
    1:27:28 "<" string.quoted.double.ocamlbuild keyword.operator.ocamlbuild
    1:28:33 "test/" string.quoted.double.ocamlbuild
    1:33:34 "*" string.quoted.double.ocamlbuild constant.language.ocamlbuild
    1:34:35 ">" string.quoted.double.ocamlbuild keyword.operator.ocamlbuild
    1:35:36 ":" keyword.operator.ocamlbuild
    1:36:43 " debug"
    2:0:1 "1" constant.language.ocamlbuild
    2:1:2 ":" keyword.operator.ocamlbuild
    2:2:13 " bin_annot""
  `);
});

// https://raw.githubusercontent.com/ocaml/ocamlfind/master/src/findlib/fl_meta.mll
test("META nested package entry boundaries", async () => {
  const source = 'package "one" (version = "1") package "two" (version = "2")';
  expect(await tokenizer.render("source.ocaml.META", source)).toMatchInlineSnapshot(`
    "1:0:7 "package" keyword.other.META
    1:8:13 "\\"one\\"" string.quoted.double.META
    1:13:15 " ("
    1:15:22 "version" entity.name.tag.META
    1:23:24 "=" keyword.operator.META
    1:25:26 "\\"" string.quoted.double.META
    1:26:27 "1" string.quoted.double.META
    1:27:28 "\\"" string.quoted.double.META
    1:28:29 ")"
    1:30:37 "package" keyword.other.META
    1:38:43 "\\"two\\"" string.quoted.double.META
    1:43:45 " ("
    1:45:52 "version" entity.name.tag.META
    1:53:54 "=" keyword.operator.META
    1:55:56 "\\"" string.quoted.double.META
    1:56:57 "2" string.quoted.double.META
    1:57:58 "\\"" string.quoted.double.META
    1:58:59 ")""
  `);
});
