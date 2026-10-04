import { afterAll, expect, test } from "bun:test";

import { createTokenizer } from "./tokenizer.ts";

const tokenizer = createTokenizer();
afterAll(() => tokenizer.dispose());

// https://dune.readthedocs.io/en/stable/reference/lexical-conventions.html
test("Dune stanza atoms have complete boundaries", async () => {
  const source = `(library-extra (name foo))
(library (name foo))`;
  expect(await tokenizer.render("source.dune", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:15 "library-extra "
    1:15:16 "("
    1:16:24 "name foo"
    1:24:25 ")"
    1:25:26 ")"
    2:0:1 "("
    2:1:8 "library" keyword.language.dune
    2:9:10 "("
    2:10:14 "name" keyword.language.dune
    2:14:18 " foo" variable.other.declaration.dune
    2:18:19 ")"
    2:19:20 ")""
  `);
});

// https://dune.readthedocs.io/en/stable/reference/lexical-conventions.html
test("Dune constants do not split user atoms", async () => {
  const source = "(rule (action (echo true-value foo.1.2 path/to :standard-extra)))";
  expect(await tokenizer.render("source.dune", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:5 "rule" keyword.language.dune
    1:6:7 "("
    1:7:13 "action" keyword.language.dune
    1:14:15 "("
    1:15:19 "echo" entity.name.function.action.dune
    1:19:47 " true-value foo.1.2 path/to "
    1:47:62 ":standard-extra" entity.name.function.action.dune
    1:62:63 ")"
    1:63:64 ")"
    1:64:65 ")""
  `);
});

// https://dune.readthedocs.io/en/stable/reference/lexical-conventions.html
test("Dune quoted interpolation and literal percent escape", async () => {
  const source = '(rule (action (echo "%{profile} \\%{literal} \\%")))';
  expect(await tokenizer.render("source.dune", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:5 "rule" keyword.language.dune
    1:6:7 "("
    1:7:13 "action" keyword.language.dune
    1:14:15 "("
    1:15:19 "echo" entity.name.function.action.dune
    1:20:21 "\\"" string.quoted.double.dune
    1:21:23 "%{" string.quoted.double.dune keyword.operator.dune
    1:23:30 "profile" string.quoted.double.dune constant.language.variable.dune
    1:30:31 "}" string.quoted.double.dune keyword.operator.dune
    1:31:32 " " string.quoted.double.dune
    1:32:34 "\\\\%" string.quoted.double.dune constant.character.escape.dune
    1:34:44 "{literal} " string.quoted.double.dune
    1:44:46 "\\\\%" string.quoted.double.dune constant.character.escape.dune
    1:46:47 "\\"" string.quoted.double.dune
    1:47:48 ")"
    1:48:49 ")"
    1:49:50 ")""
  `);
});

// https://dune.readthedocs.io/en/stable/reference/lexical-conventions.html
test("Dune multiline strings distinguish raw and escaped text", async () => {
  const source = `(rule (action (echo
  "\\| %{profile} \\n
  "\\> %{profile} \\n
)))
(library (name next))`;
  expect(await tokenizer.render("source.dune", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:5 "rule" keyword.language.dune
    1:6:7 "("
    1:7:13 "action" keyword.language.dune
    1:14:15 "("
    1:15:19 "echo" entity.name.function.action.dune
    2:2:5 "\\"\\\\|" string.quoted.line.dune
    2:5:6 " " string.quoted.line.dune
    2:6:8 "%{" string.quoted.line.dune keyword.operator.dune
    2:8:15 "profile" string.quoted.line.dune constant.language.variable.dune
    2:15:16 "}" string.quoted.line.dune keyword.operator.dune
    2:16:17 " " string.quoted.line.dune
    2:17:19 "\\\\n" string.quoted.line.dune constant.character.escape.dune
    3:2:5 "\\"\\\\>" string.quoted.line.dune
    3:5:19 " %{profile} \\\\n" string.quoted.line.dune
    4:0:1 ")"
    4:1:2 ")"
    4:2:3 ")"
    5:0:1 "("
    5:1:8 "library" keyword.language.dune
    5:9:10 "("
    5:10:14 "name" keyword.language.dune
    5:14:19 " next" variable.other.declaration.dune
    5:19:20 ")"
    5:20:21 ")""
  `);
});

// https://dune.readthedocs.io/en/stable/reference/actions/index.html
test("Dune ordered sets use backslash subtraction", async () => {
  const source = "(library (modules (:standard \\ Main)))";
  expect(await tokenizer.render("source.dune", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:8 "library" keyword.language.dune
    1:9:10 "("
    1:10:17 "modules" keyword.language.dune
    1:18:19 "("
    1:19:28 ":standard" entity.name.function.action.dune
    1:29:30 "\\\\" keyword.operator.dune
    1:30:35 " Main"
    1:35:36 ")"
    1:36:37 ")"
    1:37:38 ")""
  `);
});

// https://dune.readthedocs.io/en/stable/reference/actions/index.html
test("Dune punctuated actions remain complete tokens", async () => {
  const source = "(rule (action (progn (copy# a b) (diff? a b))))";
  expect(await tokenizer.render("source.dune", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:5 "rule" keyword.language.dune
    1:6:7 "("
    1:7:13 "action" keyword.language.dune
    1:14:15 "("
    1:15:20 "progn" entity.name.function.action.dune
    1:21:22 "("
    1:22:27 "copy#" entity.name.function.action.dune
    1:27:31 " a b"
    1:31:32 ")"
    1:33:34 "("
    1:34:39 "diff?" entity.name.function.action.dune
    1:39:43 " a b"
    1:43:44 ")"
    1:44:45 ")"
    1:45:46 ")"
    1:46:47 ")""
  `);
});

// https://dune.readthedocs.io/en/stable/reference/actions/index.html
test("Dune supported action names", async () => {
  const source =
    "(rule (action (concurrent (ignore-stderr (dynamic-run ./a.exe)) (format-dune-file a b))))";
  expect(await tokenizer.render("source.dune", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:5 "rule" keyword.language.dune
    1:6:7 "("
    1:7:13 "action" keyword.language.dune
    1:14:15 "("
    1:15:25 "concurrent" entity.name.function.action.dune
    1:26:27 "("
    1:27:40 "ignore-stderr" entity.name.function.action.dune
    1:41:42 "("
    1:42:53 "dynamic-run" entity.name.function.action.dune
    1:53:61 " ./a.exe"
    1:61:62 ")"
    1:62:63 ")"
    1:64:65 "("
    1:65:81 "format-dune-file" entity.name.function.action.dune
    1:81:85 " a b"
    1:85:86 ")"
    1:86:87 ")"
    1:87:88 ")"
    1:88:89 ")""
  `);
});

// https://dune.readthedocs.io/en/stable/reference/dune/files.html
test("Dune files stanza introduced in 3.21", async () => {
  const source = "(files :standard \\ *.cm*)";
  expect(await tokenizer.render("source.dune", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:6 "files" keyword.language.dune
    1:7:16 ":standard" entity.name.function.action.dune
    1:17:18 "\\\\" keyword.operator.dune
    1:18:24 " *.cm*"
    1:24:25 ")""
  `);
});

// https://dune.readthedocs.io/en/stable/reference/lexical-conventions.html
test("Dune project fields respect atom boundaries", async () => {
  const source = `(name-extra foo)
(name foo)
(version 12.34)`;
  expect(await tokenizer.render("source.dune-project", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:15 "name-extra foo"
    1:15:16 ")"
    2:0:1 "("
    2:1:5 "name" keyword.language.dune-project
    2:5:9 " foo" variable.other.declaration.dune-project
    2:9:10 ")"
    3:0:1 "("
    3:1:8 "version" keyword.language.dune-project
    3:8:9 " " constant.language.dune-project
    3:9:14 "12.34" constant.language.dune-project constant.numeric.dune
    3:14:15 ")""
  `);
});

// https://dune.readthedocs.io/en/stable/reference/dune-workspace/pkg.html
test("Dune workspace pkg toggle introduced in 3.20", async () => {
  const source = `(pkg enabled)
(profile-extra dev)
(profile dev)`;
  expect(await tokenizer.render("source.dune-workspace", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:4 "pkg" keyword.language.dune-workspace
    1:5:12 "enabled" constant.language.dune-workspace
    1:12:13 ")"
    2:0:1 "("
    2:1:18 "profile-extra dev"
    2:18:19 ")"
    3:0:1 "("
    3:1:8 "profile" keyword.language.dune-workspace
    3:8:12 " dev" variable.other.declaration.dune-project
    3:12:13 ")""
  `);
});

// https://dune.readthedocs.io/en/stable/reference/lexical-conventions.html
test("Dune comments and quoted delimiters retain lexical state", async () => {
  const source = `(library ; (fake) "
 (name "foo;bar"))
(library (name next))`;
  expect(await tokenizer.render("source.dune", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:8 "library" keyword.language.dune
    1:9:10 ";" comment.line.dune
    1:10:19 " (fake) \\"" comment.line.dune
    2:1:2 "("
    2:2:6 "name" keyword.language.dune
    2:6:7 " " variable.other.declaration.dune
    2:7:8 "\\"" variable.other.declaration.dune string.quoted.double.dune
    2:8:15 "foo;bar" variable.other.declaration.dune string.quoted.double.dune
    2:15:16 "\\"" variable.other.declaration.dune string.quoted.double.dune
    2:16:17 ")"
    2:17:18 ")"
    3:0:1 "("
    3:1:8 "library" keyword.language.dune
    3:9:10 "("
    3:10:14 "name" keyword.language.dune
    3:14:19 " next" variable.other.declaration.dune
    3:19:20 ")"
    3:20:21 ")""
  `);
});

// https://github.com/ocaml/dune/blob/3.24.2/src/dune_sexp/lexer.mll
test("Dune workspace shared quoted interpolation", async () => {
  const source = '(env (_ (flags "%{profile}")))';
  expect(await tokenizer.render("source.dune-workspace", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:4 "env" keyword.language.dune-workspace
    1:5:6 "("
    1:6:8 "_ "
    1:8:9 "("
    1:9:15 "flags "
    1:15:16 "\\"" string.quoted.double.dune
    1:16:18 "%{" string.quoted.double.dune keyword.operator.dune
    1:18:25 "profile" string.quoted.double.dune constant.language.variable.dune
    1:25:26 "}" string.quoted.double.dune keyword.operator.dune
    1:26:27 "\\"" string.quoted.double.dune
    1:27:28 ")"
    1:28:29 ")"
    1:29:30 ")""
  `);
});

// https://dune.readthedocs.io/en/stable/reference/boolean-language.html
test("Dune exact boolean and numeric atoms remain highlighted", async () => {
  const source = "(library (enabled_if true) (flags 12.34))";
  expect(await tokenizer.render("source.dune", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:8 "library" keyword.language.dune
    1:9:10 "("
    1:10:20 "enabled_if" keyword.language.dune
    1:21:25 "true" constant.language.dune
    1:25:26 ")"
    1:27:28 "("
    1:28:33 "flags" keyword.language.dune
    1:34:39 "12.34" constant.numeric.dune
    1:39:40 ")"
    1:40:41 ")""
  `);
});

// https://dune.readthedocs.io/en/stable/reference/dune-workspace/pkg.html
test("Dune new stanza and value names require complete atoms", async () => {
  const source = `(pkg-extra enabled)
(pkg enabled-extra)`;
  expect(await tokenizer.render("source.dune-workspace", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:18 "pkg-extra enabled"
    1:18:19 ")"
    2:0:1 "("
    2:1:4 "pkg" keyword.language.dune-workspace
    2:4:18 " enabled-extra"
    2:18:19 ")""
  `);
});

// https://dune.readthedocs.io/en/stable/reference/dune/files.html
test("Dune files stanza does not match longer atoms", async () => {
  const source = "(files-extra :standard)";
  expect(await tokenizer.render("source.dune", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:13 "files-extra "
    1:13:22 ":standard" entity.name.function.action.dune
    1:22:23 ")""
  `);
});

// https://github.com/ocaml/dune/blob/3.24.2/src/dune_sexp/lexer.mll
test("Dune atom boundaries do not treat Unicode spaces as delimiters", async () => {
  const source = `(library\u00a0(name a))
(library (name a))
(rule (action (echo true\u00a0value 1.2\u00a0suffix)))`;
  expect(await tokenizer.render("source.dune", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:9 "library "
    1:9:10 "("
    1:10:16 "name a"
    1:16:17 ")"
    1:17:18 ")"
    2:0:1 "("
    2:1:9 "library "
    2:9:10 "("
    2:10:16 "name a"
    2:16:17 ")"
    2:17:18 ")"
    3:0:1 "("
    3:1:5 "rule" keyword.language.dune
    3:6:7 "("
    3:7:13 "action" keyword.language.dune
    3:14:15 "("
    3:15:19 "echo" entity.name.function.action.dune
    3:19:41 " true value 1.2 suffix"
    3:41:42 ")"
    3:42:43 ")"
    3:43:44 ")""
  `);
});

// https://github.com/ocaml/dune/blob/3.24.2/src/dune_sexp/lexer.mll
test("Dune atom boundaries retain tab and form-feed separators", async () => {
  const source = `(library\t(name a))
(library\f(name b))`;
  expect(await tokenizer.render("source.dune", source)).toMatchInlineSnapshot(`
    "1:0:1 "("
    1:1:8 "library" keyword.language.dune
    1:9:10 "("
    1:10:14 "name" keyword.language.dune
    1:14:16 " a" variable.other.declaration.dune
    1:16:17 ")"
    1:17:18 ")"
    2:0:1 "("
    2:1:8 "library" keyword.language.dune
    2:9:10 "("
    2:10:14 "name" keyword.language.dune
    2:14:16 " b" variable.other.declaration.dune
    2:16:17 ")"
    2:17:18 ")""
  `);
});

// https://github.com/ocaml/dune/blob/3.24.2/src/dune_sexp/lexer.mll
test("Dune structural separators use ASCII whitespace in every grammar", async () => {
  const output = [];
  for (const { scope, stanza, field } of [
    { scope: "source.dune", stanza: "library", field: "name" },
    { scope: "source.dune-project", stanza: "package", field: "name" },
    { scope: "source.dune-workspace", stanza: "context", field: "default" },
  ]) {
    const sources = ["\u00a0", "\v", "\t", "\f"].flatMap((separator) => [
      `(${separator}${stanza})`,
      `(${stanza}${separator})`,
      `(${stanza} (${separator}${field}))`,
      `(${separator}and true)`,
      `(${separator}= a b)`,
      `"${separator}and"`,
    ]);
    output.push({
      scope,
      tokens: await Promise.all(
        sources.map(async (source) =>
          (await tokenizer.render(scope, source)).replaceAll("\n", "; "),
        ),
      ),
    });
  }
  expect(output).toMatchInlineSnapshot(`
    [
      {
        "scope": "source.dune",
        "tokens": [
          "1:0:1 "("; 1:1:9 " library"; 1:9:10 ")"",
          "1:0:1 "("; 1:1:9 "library "; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "library" keyword.language.dune; 1:9:10 "("; 1:10:15 " name"; 1:15:16 ")"; 1:16:17 ")"",
          "1:0:1 "("; 1:1:6 " and "; 1:6:10 "true" constant.language.dune; 1:10:11 ")"",
          "1:0:1 "("; 1:1:7 " = a b"; 1:7:8 ")"",
          "1:0:1 "\\"" string.quoted.double.dune; 1:1:5 " and" string.quoted.double.dune; 1:5:6 "\\"" string.quoted.double.dune",
          "1:0:1 "("; 1:1:9 "\\u000blibrary"; 1:9:10 ")"",
          "1:0:1 "("; 1:1:9 "library\\u000b"; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "library" keyword.language.dune; 1:9:10 "("; 1:10:15 "\\u000bname"; 1:15:16 ")"; 1:16:17 ")"",
          "1:0:1 "("; 1:1:6 "\\u000band "; 1:6:10 "true" constant.language.dune; 1:10:11 ")"",
          "1:0:1 "("; 1:1:7 "\\u000b= a b"; 1:7:8 ")"",
          "1:0:1 "\\"" string.quoted.double.dune; 1:1:5 "\\u000band" string.quoted.double.dune; 1:5:6 "\\"" string.quoted.double.dune",
          "1:0:2 "(\\t"; 1:2:9 "library" keyword.language.dune; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "library" keyword.language.dune; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "library" keyword.language.dune; 1:9:11 "(\\t"; 1:11:15 "name" keyword.language.dune; 1:15:16 ")"; 1:16:17 ")"",
          "1:0:2 "(\\t"; 1:2:5 "and" entity.name.function.action.dune; 1:6:10 "true" constant.language.dune; 1:10:11 ")"",
          "1:0:2 "(\\t"; 1:2:3 "=" keyword.operator.dune; 1:3:7 " a b"; 1:7:8 ")"",
          "1:0:1 "\\"" string.quoted.double.dune; 1:1:5 "\\tand" string.quoted.double.dune; 1:5:6 "\\"" string.quoted.double.dune",
          "1:0:2 "(\\f"; 1:2:9 "library" keyword.language.dune; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "library" keyword.language.dune; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "library" keyword.language.dune; 1:9:11 "(\\f"; 1:11:15 "name" keyword.language.dune; 1:15:16 ")"; 1:16:17 ")"",
          "1:0:2 "(\\f"; 1:2:5 "and" entity.name.function.action.dune; 1:6:10 "true" constant.language.dune; 1:10:11 ")"",
          "1:0:2 "(\\f"; 1:2:3 "=" keyword.operator.dune; 1:3:7 " a b"; 1:7:8 ")"",
          "1:0:1 "\\"" string.quoted.double.dune; 1:1:5 "\\fand" string.quoted.double.dune; 1:5:6 "\\"" string.quoted.double.dune",
        ],
      },
      {
        "scope": "source.dune-project",
        "tokens": [
          "1:0:1 "("; 1:1:9 " package"; 1:9:10 ")"",
          "1:0:1 "("; 1:1:9 "package "; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "package" keyword.language.dune-project; 1:9:10 "("; 1:10:15 " name"; 1:15:16 ")"; 1:16:17 ")"",
          "1:0:1 "("; 1:1:6 " and "; 1:6:10 "true" constant.language.dune; 1:10:11 ")"",
          "1:0:1 "("; 1:1:7 " = a b"; 1:7:8 ")"",
          "1:0:1 "\\"" string.quoted.double.dune; 1:1:5 " and" string.quoted.double.dune; 1:5:6 "\\"" string.quoted.double.dune",
          "1:0:1 "("; 1:1:9 "\\u000bpackage"; 1:9:10 ")"",
          "1:0:1 "("; 1:1:9 "package\\u000b"; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "package" keyword.language.dune-project; 1:9:10 "("; 1:10:15 "\\u000bname"; 1:15:16 ")"; 1:16:17 ")"",
          "1:0:1 "("; 1:1:6 "\\u000band "; 1:6:10 "true" constant.language.dune; 1:10:11 ")"",
          "1:0:1 "("; 1:1:7 "\\u000b= a b"; 1:7:8 ")"",
          "1:0:1 "\\"" string.quoted.double.dune; 1:1:5 "\\u000band" string.quoted.double.dune; 1:5:6 "\\"" string.quoted.double.dune",
          "1:0:2 "(\\t"; 1:2:9 "package" keyword.language.dune-project; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "package" keyword.language.dune-project; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "package" keyword.language.dune-project; 1:9:11 "(\\t"; 1:11:15 "name" keyword.language.dune-project; 1:15:16 ")"; 1:16:17 ")"",
          "1:0:2 "(\\t"; 1:2:5 "and" entity.name.function.action.dune; 1:6:10 "true" constant.language.dune; 1:10:11 ")"",
          "1:0:2 "(\\t"; 1:2:3 "=" keyword.operator.dune; 1:3:7 " a b"; 1:7:8 ")"",
          "1:0:1 "\\"" string.quoted.double.dune; 1:1:5 "\\tand" string.quoted.double.dune; 1:5:6 "\\"" string.quoted.double.dune",
          "1:0:2 "(\\f"; 1:2:9 "package" keyword.language.dune-project; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "package" keyword.language.dune-project; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "package" keyword.language.dune-project; 1:9:11 "(\\f"; 1:11:15 "name" keyword.language.dune-project; 1:15:16 ")"; 1:16:17 ")"",
          "1:0:2 "(\\f"; 1:2:5 "and" entity.name.function.action.dune; 1:6:10 "true" constant.language.dune; 1:10:11 ")"",
          "1:0:2 "(\\f"; 1:2:3 "=" keyword.operator.dune; 1:3:7 " a b"; 1:7:8 ")"",
          "1:0:1 "\\"" string.quoted.double.dune; 1:1:5 "\\fand" string.quoted.double.dune; 1:5:6 "\\"" string.quoted.double.dune",
        ],
      },
      {
        "scope": "source.dune-workspace",
        "tokens": [
          "1:0:1 "("; 1:1:9 " context"; 1:9:10 ")"",
          "1:0:1 "("; 1:1:9 "context "; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "context" keyword.language.dune-workspace; 1:9:10 "("; 1:10:18 " default"; 1:18:19 ")"; 1:19:20 ")"",
          "1:0:1 "("; 1:1:6 " and "; 1:6:10 "true" constant.language.dune; 1:10:11 ")"",
          "1:0:1 "("; 1:1:7 " = a b"; 1:7:8 ")"",
          "1:0:1 "\\"" string.quoted.double.dune; 1:1:5 " and" string.quoted.double.dune; 1:5:6 "\\"" string.quoted.double.dune",
          "1:0:1 "("; 1:1:9 "\\u000bcontext"; 1:9:10 ")"",
          "1:0:1 "("; 1:1:9 "context\\u000b"; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "context" keyword.language.dune-workspace; 1:9:10 "("; 1:10:18 "\\u000bdefault"; 1:18:19 ")"; 1:19:20 ")"",
          "1:0:1 "("; 1:1:6 "\\u000band "; 1:6:10 "true" constant.language.dune; 1:10:11 ")"",
          "1:0:1 "("; 1:1:7 "\\u000b= a b"; 1:7:8 ")"",
          "1:0:1 "\\"" string.quoted.double.dune; 1:1:5 "\\u000band" string.quoted.double.dune; 1:5:6 "\\"" string.quoted.double.dune",
          "1:0:2 "(\\t"; 1:2:9 "context" keyword.language.dune-workspace; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "context" keyword.language.dune-workspace; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "context" keyword.language.dune-workspace; 1:9:11 "(\\t"; 1:11:18 "default" keyword.language.dune-workspace; 1:18:19 ")"; 1:19:20 ")"",
          "1:0:2 "(\\t"; 1:2:5 "and" entity.name.function.action.dune; 1:6:10 "true" constant.language.dune; 1:10:11 ")"",
          "1:0:2 "(\\t"; 1:2:3 "=" keyword.operator.dune; 1:3:7 " a b"; 1:7:8 ")"",
          "1:0:1 "\\"" string.quoted.double.dune; 1:1:5 "\\tand" string.quoted.double.dune; 1:5:6 "\\"" string.quoted.double.dune",
          "1:0:2 "(\\f"; 1:2:9 "context" keyword.language.dune-workspace; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "context" keyword.language.dune-workspace; 1:9:10 ")"",
          "1:0:1 "("; 1:1:8 "context" keyword.language.dune-workspace; 1:9:11 "(\\f"; 1:11:18 "default" keyword.language.dune-workspace; 1:18:19 ")"; 1:19:20 ")"",
          "1:0:2 "(\\f"; 1:2:5 "and" entity.name.function.action.dune; 1:6:10 "true" constant.language.dune; 1:10:11 ")"",
          "1:0:2 "(\\f"; 1:2:3 "=" keyword.operator.dune; 1:3:7 " a b"; 1:7:8 ")"",
          "1:0:1 "\\"" string.quoted.double.dune; 1:1:5 "\\fand" string.quoted.double.dune; 1:5:6 "\\"" string.quoted.double.dune",
        ],
      },
    ]
  `);
});

// https://github.com/ocaml/dune/blob/3.24.2/src/dune_sexp/lexer.mll
test("Dune compound forms require ASCII separators", async () => {
  const output = [];
  for (const scope of ["source.dune-project", "source.dune-workspace"]) {
    const sources = ["\u00a0", "\v", "\t", "\f"].flatMap((separator) => [
      `(lang${separator}dune 3.0)`,
      ...(scope === "source.dune-project"
        ? [`(using${separator}menhir 3.0)`, `(explicit_js_mode${separator})`]
        : []),
    ]);
    output.push({
      scope,
      tokens: await Promise.all(
        sources.map(async (source) =>
          (await tokenizer.render(scope, source)).replaceAll("\n", "; "),
        ),
      ),
    });
  }
  expect(output).toMatchInlineSnapshot(`
    [
      {
        "scope": "source.dune-project",
        "tokens": [
          "1:0:1 "("; 1:1:11 "lang dune "; 1:11:14 "3.0" constant.numeric.dune; 1:14:15 ")"",
          "1:0:1 "("; 1:1:14 "using menhir "; 1:14:17 "3.0" constant.numeric.dune; 1:17:18 ")"",
          "1:0:1 "("; 1:1:18 "explicit_js_mode "; 1:18:19 ")"",
          "1:0:1 "("; 1:1:11 "lang\\u000bdune "; 1:11:14 "3.0" constant.numeric.dune; 1:14:15 ")"",
          "1:0:1 "("; 1:1:14 "using\\u000bmenhir "; 1:14:17 "3.0" constant.numeric.dune; 1:17:18 ")"",
          "1:0:1 "("; 1:1:18 "explicit_js_mode\\u000b"; 1:18:19 ")"",
          "1:0:1 "("; 1:1:5 "lang" keyword.language.dune-project; 1:6:10 "dune" keyword.language.dune-project; 1:11:14 "3.0" constant.numeric.dune; 1:14:15 ")"",
          "1:0:1 "("; 1:1:6 "using" keyword.language.dune-project; 1:6:13 "\\tmenhir" variable.other.declaration.dune-project; 1:14:17 "3.0" constant.numeric.dune; 1:17:18 ")"",
          "1:0:1 "("; 1:1:17 "explicit_js_mode" keyword.language.dune-project; 1:17:19 "\\t)"",
          "1:0:1 "("; 1:1:5 "lang" keyword.language.dune-project; 1:6:10 "dune" keyword.language.dune-project; 1:11:14 "3.0" constant.numeric.dune; 1:14:15 ")"",
          "1:0:1 "("; 1:1:6 "using" keyword.language.dune-project; 1:6:13 "\\fmenhir" variable.other.declaration.dune-project; 1:14:17 "3.0" constant.numeric.dune; 1:17:18 ")"",
          "1:0:1 "("; 1:1:17 "explicit_js_mode" keyword.language.dune-project; 1:17:19 "\\f)"",
        ],
      },
      {
        "scope": "source.dune-workspace",
        "tokens": [
          "1:0:1 "("; 1:1:11 "lang dune "; 1:11:14 "3.0" constant.numeric.dune; 1:14:15 ")"",
          "1:0:1 "("; 1:1:11 "lang\\u000bdune "; 1:11:14 "3.0" constant.numeric.dune; 1:14:15 ")"",
          "1:0:1 "("; 1:1:5 "lang" keyword.language.dune-workspace; 1:6:10 "dune" keyword.language.dune-workspace; 1:11:14 "3.0" constant.numeric.dune; 1:14:15 ")"",
          "1:0:1 "("; 1:1:5 "lang" keyword.language.dune-workspace; 1:6:10 "dune" keyword.language.dune-workspace; 1:11:14 "3.0" constant.numeric.dune; 1:14:15 ")"",
        ],
      },
    ]
  `);
});
