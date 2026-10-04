import { afterAll, expect, test } from "bun:test";

import { createTokenizer } from "./tokenizer.ts";

const tokenizer = createTokenizer();
afterAll(() => tokenizer.dispose());

// https://opam.ocaml.org/doc/Manual.html
test("opam triple strings protect quotes and comment markers", async () => {
  const source = `description: """
Use "quotes" and # text
"""
synopsis: "done"`;
  expect(await tokenizer.render("source.ocaml.opam", source)).toMatchInlineSnapshot(`
    "1:0:11 "description" entity.name.tag.opam
    1:11:12 ":" keyword.operator.opam
    1:13:16 "\\"\\"\\"" string.quoted.triple-double.opam
    2:0:24 "Use \\"quotes\\" and # text" string.quoted.triple-double.opam
    3:0:3 "\\"\\"\\"" string.quoted.triple-double.opam
    4:0:8 "synopsis" entity.name.tag.opam
    4:8:9 ":" keyword.operator.opam
    4:10:11 "\\"" string.quoted.double.opam
    4:11:15 "done" string.quoted.double.opam
    4:15:16 "\\"" string.quoted.double.opam"
  `);
});

// https://opam.ocaml.org/doc/Manual.html
test("opam indented fields and strings", async () => {
  const source = `url {
  src: "https://example.org/archive"
}
x+field: -42`;
  expect(await tokenizer.render("source.ocaml.opam", source)).toMatchInlineSnapshot(`
    "1:0:3 "url" variable.parameter.opam
    1:3:6 " {"
    2:2:5 "src" entity.name.tag.opam
    2:5:6 ":" keyword.operator.opam
    2:7:8 "\\"" string.quoted.double.opam
    2:8:35 "https://example.org/archive" string.quoted.double.opam
    2:35:36 "\\"" string.quoted.double.opam
    3:0:2 "}"
    4:0:7 "x+field" entity.name.tag.opam
    4:7:8 ":" keyword.operator.opam
    4:9:12 "-42" constant.numeric.decimal.opam"
  `);
});

// https://opam.ocaml.org/doc/Manual.html
test("opam install escaped quote protects comment marker", async () => {
  const source = `lib: ["a\\"#b"] # end
bin: ["tool"]`;
  expect(await tokenizer.render("source.ocaml.opam-install", source)).toMatchInlineSnapshot(`
    "1:0:3 "lib" entity.name.tag.opam-install
    1:3:4 ":" keyword.operator.opam-install
    1:4:6 " ["
    1:6:7 "\\"" string.quoted.double.opam-install
    1:7:8 "a" string.quoted.double.opam-install
    1:8:10 "\\\\\\"" string.quoted.double.opam-install constant.character.escape.opam
    1:10:12 "#b" string.quoted.double.opam-install
    1:12:13 "\\"" string.quoted.double.opam-install
    1:13:15 "] "
    1:15:16 "#" comment.line.opam-install
    1:16:20 " end" comment.line.opam-install
    2:0:3 "bin" entity.name.tag.opam-install
    2:3:4 ":" keyword.operator.opam-install
    2:4:6 " ["
    2:6:7 "\\"" string.quoted.double.opam-install
    2:7:11 "tool" string.quoted.double.opam-install
    2:11:12 "\\"" string.quoted.double.opam-install
    2:12:14 "]""
  `);
});

// https://github.com/ocaml/opam-file-format/blob/2.2.0/src/opamLexer.mll
test("opam identifiers do not split at literal prefixes", async () => {
  const source = "available: [true-value false+pkg 123pkg 123-pkg -123pkg pkg:true true:installed]";
  expect(await tokenizer.render("source.ocaml.opam", source)).toMatchInlineSnapshot(`
    "1:0:9 "available" entity.name.tag.opam
    1:9:10 ":" keyword.operator.opam
    1:10:12 " ["
    1:12:22 "true-value" variable.parameter.opam
    1:23:32 "false+pkg" variable.parameter.opam
    1:33:39 "123pkg" variable.parameter.opam
    1:40:47 "123-pkg" variable.parameter.opam
    1:48:55 "-123pkg" variable.parameter.opam
    1:56:64 "pkg:true" variable.parameter.opam
    1:65:79 "true:installed" variable.parameter.opam
    1:79:81 "]""
  `);
});

// https://github.com/ocaml/opam-file-format/blob/2.2.0/src/opamLexer.mll
test("opam complete boolean and integer literals", async () => {
  const source = `available: [true false 123 -123 1_000]
x-enabled:true
x-count:-123`;
  expect(await tokenizer.render("source.ocaml.opam", source)).toMatchInlineSnapshot(`
    "1:0:9 "available" entity.name.tag.opam
    1:9:10 ":" keyword.operator.opam
    1:10:12 " ["
    1:12:16 "true" constant.language.opam
    1:17:22 "false" constant.language.opam
    1:23:26 "123" constant.numeric.decimal.opam
    1:27:31 "-123" constant.numeric.decimal.opam
    1:32:37 "1_000" constant.numeric.decimal.opam
    1:37:39 "]"
    2:0:9 "x-enabled" entity.name.tag.opam
    2:9:10 ":" keyword.operator.opam
    2:10:14 "true" constant.language.opam
    3:0:7 "x-count" entity.name.tag.opam
    3:7:8 ":" keyword.operator.opam
    3:8:12 "-123" constant.numeric.decimal.opam"
  `);
});

// https://github.com/ocaml/opam-file-format/blob/2.2.0/src/opamLexer.mll
test("opam nested block comments recover after outer closer", async () => {
  const source = `(* outer (* inner *) true
still outer *) false`;
  expect(await tokenizer.render("source.ocaml.opam", source)).toMatchInlineSnapshot(`
    "1:0:2 "(*" comment.block.opam
    1:2:9 " outer " comment.block.opam
    1:9:11 "(*" comment.block.opam comment.block.opam
    1:11:18 " inner " comment.block.opam comment.block.opam
    1:18:20 "*)" comment.block.opam comment.block.opam
    1:20:26 " true" comment.block.opam
    2:0:12 "still outer " comment.block.opam
    2:12:14 "*)" comment.block.opam
    2:15:20 "false" constant.language.opam"
  `);
});

// https://github.com/ocaml/opam-file-format/blob/2.2.0/src/opamLexer.mll
test("opam hashes and quotes do not shield block comment closers", async () => {
  const source = `(* # *) true
(* " *) false
# ordinary line comment`;
  expect(await tokenizer.render("source.ocaml.opam", source)).toMatchInlineSnapshot(`
    "1:0:2 "(*" comment.block.opam
    1:2:5 " # " comment.block.opam
    1:5:7 "*)" comment.block.opam
    1:8:12 "true" constant.language.opam
    2:0:2 "(*" comment.block.opam
    2:2:5 " \\" " comment.block.opam
    2:5:7 "*)" comment.block.opam
    2:8:13 "false" constant.language.opam
    3:0:1 "#" comment.line.opam
    3:1:23 " ordinary line comment" comment.line.opam"
  `);
});

// https://github.com/ocaml/opam/blob/2.4.1/src/format/opamFile.ml
test("opam install uses common nested block comment syntax", async () => {
  const source = `(* outer (* inner *) bin: ["hidden"]
still outer *)
lib: ["visible"]
(* # *) bin: ["tool"]
(* " *) doc: ["readme"]`;
  expect(await tokenizer.render("source.ocaml.opam-install", source)).toMatchInlineSnapshot(`
    "1:0:2 "(*" comment.block.opam
    1:2:9 " outer " comment.block.opam
    1:9:11 "(*" comment.block.opam comment.block.opam
    1:11:18 " inner " comment.block.opam comment.block.opam
    1:18:20 "*)" comment.block.opam comment.block.opam
    1:20:37 " bin: [\\"hidden\\"]" comment.block.opam
    2:0:12 "still outer " comment.block.opam
    2:12:14 "*)" comment.block.opam
    3:0:3 "lib" entity.name.tag.opam-install
    3:3:4 ":" keyword.operator.opam-install
    3:4:6 " ["
    3:6:7 "\\"" string.quoted.double.opam-install
    3:7:14 "visible" string.quoted.double.opam-install
    3:14:15 "\\"" string.quoted.double.opam-install
    3:15:17 "]"
    4:0:2 "(*" comment.block.opam
    4:2:5 " # " comment.block.opam
    4:5:7 "*)" comment.block.opam
    4:7:14 " bin: ["
    4:14:15 "\\"" string.quoted.double.opam-install
    4:15:19 "tool" string.quoted.double.opam-install
    4:19:20 "\\"" string.quoted.double.opam-install
    4:20:22 "]"
    5:0:2 "(*" comment.block.opam
    5:2:5 " \\" " comment.block.opam
    5:5:7 "*)" comment.block.opam
    5:7:14 " doc: ["
    5:14:15 "\\"" string.quoted.double.opam-install
    5:15:21 "readme" string.quoted.double.opam-install
    5:21:22 "\\"" string.quoted.double.opam-install
    5:22:24 "]""
  `);
});

// https://github.com/ocaml/opam/blob/2.4.1/src/client/opamAction.ml#L24
test("opam install percent markers remain literal filenames", async () => {
  const source = `lib: ["%{prefix}%/file" "%{unclosed"] # done
bin: ["tool"]`;
  expect(await tokenizer.render("source.ocaml.opam-install", source)).toMatchInlineSnapshot(`
    "1:0:3 "lib" entity.name.tag.opam-install
    1:3:4 ":" keyword.operator.opam-install
    1:4:6 " ["
    1:6:7 "\\"" string.quoted.double.opam-install
    1:7:22 "%{prefix}%/file" string.quoted.double.opam-install
    1:22:23 "\\"" string.quoted.double.opam-install
    1:24:25 "\\"" string.quoted.double.opam-install
    1:25:35 "%{unclosed" string.quoted.double.opam-install
    1:35:36 "\\"" string.quoted.double.opam-install
    1:36:38 "] "
    1:38:39 "#" comment.line.opam-install
    1:39:44 " done" comment.line.opam-install
    2:0:3 "bin" entity.name.tag.opam-install
    2:3:4 ":" keyword.operator.opam-install
    2:4:6 " ["
    2:6:7 "\\"" string.quoted.double.opam-install
    2:7:11 "tool" string.quoted.double.opam-install
    2:11:12 "\\"" string.quoted.double.opam-install
    2:12:14 "]""
  `);
});

// https://opam.ocaml.org/doc/Manual.html#Interpolation
test("opam string interpolation remains enabled", async () => {
  const source = 'build: [["echo" "%{prefix}%"]]';
  expect(await tokenizer.render("source.ocaml.opam", source)).toMatchInlineSnapshot(`
    "1:0:5 "build" entity.name.tag.opam
    1:5:6 ":" keyword.operator.opam
    1:6:9 " [["
    1:9:10 "\\"" string.quoted.double.opam
    1:10:14 "echo" string.quoted.double.opam
    1:14:15 "\\"" string.quoted.double.opam
    1:16:17 "\\"" string.quoted.double.opam
    1:17:19 "%{" string.quoted.double.opam constant.variable.opam
    1:19:25 "prefix" string.quoted.double.opam constant.variable.opam
    1:25:27 "}%" string.quoted.double.opam constant.variable.opam
    1:27:28 "\\"" string.quoted.double.opam
    1:28:31 "]]""
  `);
});

// https://github.com/ocaml/opam-file-format/blob/2.2.0/src/opamLexer.mll#L162
test("opam strings accept the complete simple escape alphabet", async () => {
  const source = String.raw`synopsis: "\ \'\\\"\n\r\t\b\x00\xAf\xff" # done
available: true`;
  expect(await tokenizer.render("source.ocaml.opam", source)).toMatchInlineSnapshot(`
    "1:0:8 "synopsis" entity.name.tag.opam
    1:8:9 ":" keyword.operator.opam
    1:10:11 "\\"" string.quoted.double.opam
    1:11:13 "\\\\ " string.quoted.double.opam constant.character.escape.opam
    1:13:15 "\\\\'" string.quoted.double.opam constant.character.escape.opam
    1:15:17 "\\\\\\\\" string.quoted.double.opam constant.character.escape.opam
    1:17:19 "\\\\\\"" string.quoted.double.opam constant.character.escape.opam
    1:19:21 "\\\\n" string.quoted.double.opam constant.character.escape.opam
    1:21:23 "\\\\r" string.quoted.double.opam constant.character.escape.opam
    1:23:25 "\\\\t" string.quoted.double.opam constant.character.escape.opam
    1:25:27 "\\\\b" string.quoted.double.opam constant.character.escape.opam
    1:27:31 "\\\\x00" string.quoted.double.opam constant.character.escape.opam
    1:31:35 "\\\\xAf" string.quoted.double.opam constant.character.escape.opam
    1:35:39 "\\\\xff" string.quoted.double.opam constant.character.escape.opam
    1:39:40 "\\"" string.quoted.double.opam
    1:41:42 "#" comment.line.opam
    1:42:47 " done" comment.line.opam
    2:0:9 "available" entity.name.tag.opam
    2:9:10 ":" keyword.operator.opam
    2:11:15 "true" constant.language.opam"
  `);
});

// https://github.com/ocaml/opam-file-format/blob/2.2.0/src/opamLexer.mll#L62
test("opam triple strings restrict decimal escapes to ASCII bytes", async () => {
  const source = `description: """\\ \\'\\000\\199\\249\\250\\255 \\256 \\999 \\１２３ \\١٢٣ \\q""" # done\navailable: true`;
  expect(await tokenizer.render("source.ocaml.opam", source)).toMatchInlineSnapshot(`
    "1:0:11 "description" entity.name.tag.opam
    1:11:12 ":" keyword.operator.opam
    1:13:16 "\\"\\"\\"" string.quoted.triple-double.opam
    1:16:18 "\\\\ " string.quoted.triple-double.opam constant.character.escape.opam
    1:18:20 "\\\\'" string.quoted.triple-double.opam constant.character.escape.opam
    1:20:24 "\\\\000" string.quoted.triple-double.opam constant.character.escape.opam
    1:24:28 "\\\\199" string.quoted.triple-double.opam constant.character.escape.opam
    1:28:32 "\\\\249" string.quoted.triple-double.opam constant.character.escape.opam
    1:32:36 "\\\\250" string.quoted.triple-double.opam constant.character.escape.opam
    1:36:40 "\\\\255" string.quoted.triple-double.opam constant.character.escape.opam
    1:40:41 " " string.quoted.triple-double.opam
    1:41:43 "\\\\2" string.quoted.triple-double.opam invalid.illegal.unknown-escape.opam
    1:43:46 "56 " string.quoted.triple-double.opam
    1:46:48 "\\\\9" string.quoted.triple-double.opam invalid.illegal.unknown-escape.opam
    1:48:51 "99 " string.quoted.triple-double.opam
    1:51:53 "\\\\１" string.quoted.triple-double.opam invalid.illegal.unknown-escape.opam
    1:53:56 "２３ " string.quoted.triple-double.opam
    1:56:58 "\\\\١" string.quoted.triple-double.opam invalid.illegal.unknown-escape.opam
    1:58:61 "٢٣ " string.quoted.triple-double.opam
    1:61:63 "\\\\q" string.quoted.triple-double.opam invalid.illegal.unknown-escape.opam
    1:63:66 "\\"\\"\\"" string.quoted.triple-double.opam
    1:67:68 "#" comment.line.opam
    1:68:73 " done" comment.line.opam
    2:0:9 "available" entity.name.tag.opam
    2:9:10 ":" keyword.operator.opam
    2:11:15 "true" constant.language.opam"
  `);
});

// https://github.com/ocaml/opam-file-format/blob/2.2.0/src/opamLexer.mll#L162
test("opam install filenames share valid and invalid escape scopes", async () => {
  const source = 'lib: ["a\\ b\\\'c\\255 \\256 \\１２３ \\q"] # done\nbin: ["tool"]';
  expect(await tokenizer.render("source.ocaml.opam-install", source)).toMatchInlineSnapshot(`
    "1:0:3 "lib" entity.name.tag.opam-install
    1:3:4 ":" keyword.operator.opam-install
    1:4:6 " ["
    1:6:7 "\\"" string.quoted.double.opam-install
    1:7:8 "a" string.quoted.double.opam-install
    1:8:10 "\\\\ " string.quoted.double.opam-install constant.character.escape.opam
    1:10:11 "b" string.quoted.double.opam-install
    1:11:13 "\\\\'" string.quoted.double.opam-install constant.character.escape.opam
    1:13:14 "c" string.quoted.double.opam-install
    1:14:18 "\\\\255" string.quoted.double.opam-install constant.character.escape.opam
    1:18:19 " " string.quoted.double.opam-install
    1:19:21 "\\\\2" string.quoted.double.opam-install invalid.illegal.unknown-escape.opam
    1:21:24 "56 " string.quoted.double.opam-install
    1:24:26 "\\\\１" string.quoted.double.opam-install invalid.illegal.unknown-escape.opam
    1:26:29 "２３ " string.quoted.double.opam-install
    1:29:31 "\\\\q" string.quoted.double.opam-install invalid.illegal.unknown-escape.opam
    1:31:32 "\\"" string.quoted.double.opam-install
    1:32:34 "] "
    1:34:35 "#" comment.line.opam-install
    1:35:40 " done" comment.line.opam-install
    2:0:3 "bin" entity.name.tag.opam-install
    2:3:4 ":" keyword.operator.opam-install
    2:4:6 " ["
    2:6:7 "\\"" string.quoted.double.opam-install
    2:7:11 "tool" string.quoted.double.opam-install
    2:11:12 "\\"" string.quoted.double.opam-install
    2:12:14 "]""
  `);
});

// https://github.com/ocaml/opam-file-format/blob/2.2.0/src/opamLexer.mll#L163
test("opam strings continue across LF and CRLF", async () => {
  const source = 'synopsis: "a\\\n \tb\\\r\n  c" # done\navailable: true';
  expect(await tokenizer.render("source.ocaml.opam", source)).toMatchInlineSnapshot(`
    "1:0:8 "synopsis" entity.name.tag.opam
    1:8:9 ":" keyword.operator.opam
    1:10:11 "\\"" string.quoted.double.opam
    1:11:12 "a" string.quoted.double.opam
    1:12:14 "\\\\" string.quoted.double.opam constant.character.escape.opam
    2:0:3 " \\tb" string.quoted.double.opam
    2:3:6 "\\\\\\r" string.quoted.double.opam constant.character.escape.opam
    3:0:3 "  c" string.quoted.double.opam
    3:3:4 "\\"" string.quoted.double.opam
    3:5:6 "#" comment.line.opam
    3:6:11 " done" comment.line.opam
    4:0:9 "available" entity.name.tag.opam
    4:9:10 ":" keyword.operator.opam
    4:11:15 "true" constant.language.opam"
  `);
});

// https://github.com/ocaml/opam-file-format/blob/2.2.0/src/opamLexer.mll#L163
test("opam triple strings continue across LF and CRLF", async () => {
  const source = 'description: """a\\\n \tb\\\r\n  c""" # done\navailable: true';
  expect(await tokenizer.render("source.ocaml.opam", source)).toMatchInlineSnapshot(`
    "1:0:11 "description" entity.name.tag.opam
    1:11:12 ":" keyword.operator.opam
    1:13:16 "\\"\\"\\"" string.quoted.triple-double.opam
    1:16:17 "a" string.quoted.triple-double.opam
    1:17:19 "\\\\" string.quoted.triple-double.opam constant.character.escape.opam
    2:0:3 " \\tb" string.quoted.triple-double.opam
    2:3:6 "\\\\\\r" string.quoted.triple-double.opam constant.character.escape.opam
    3:0:3 "  c" string.quoted.triple-double.opam
    3:3:6 "\\"\\"\\"" string.quoted.triple-double.opam
    3:7:8 "#" comment.line.opam
    3:8:13 " done" comment.line.opam
    4:0:9 "available" entity.name.tag.opam
    4:9:10 ":" keyword.operator.opam
    4:11:15 "true" constant.language.opam"
  `);
});

// https://github.com/ocaml/opam-file-format/blob/2.2.0/src/opamLexer.mll#L163
test("opam install strings continue across LF and CRLF", async () => {
  const source = 'lib: ["a\\\n \tb\\\r\n  c"] # done\nbin: ["tool"]';
  expect(await tokenizer.render("source.ocaml.opam-install", source)).toMatchInlineSnapshot(`
    "1:0:3 "lib" entity.name.tag.opam-install
    1:3:4 ":" keyword.operator.opam-install
    1:4:6 " ["
    1:6:7 "\\"" string.quoted.double.opam-install
    1:7:8 "a" string.quoted.double.opam-install
    1:8:10 "\\\\" string.quoted.double.opam-install constant.character.escape.opam
    2:0:3 " \\tb" string.quoted.double.opam-install
    2:3:6 "\\\\\\r" string.quoted.double.opam-install constant.character.escape.opam
    3:0:3 "  c" string.quoted.double.opam-install
    3:3:4 "\\"" string.quoted.double.opam-install
    3:4:6 "] "
    3:6:7 "#" comment.line.opam-install
    3:7:12 " done" comment.line.opam-install
    4:0:3 "bin" entity.name.tag.opam-install
    4:3:4 ":" keyword.operator.opam-install
    4:4:6 " ["
    4:6:7 "\\"" string.quoted.double.opam-install
    4:7:11 "tool" string.quoted.double.opam-install
    4:11:12 "\\"" string.quoted.double.opam-install
    4:12:14 "]""
  `);
});
