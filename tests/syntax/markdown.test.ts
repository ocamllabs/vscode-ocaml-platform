import { afterAll, expect, test } from "bun:test";

import { createTokenizer } from "./tokenizer.ts";

const tokenizer = createTokenizer();
afterAll(() => tokenizer.dispose());

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("Reason Markdown fence embeds source", async () => {
  const source = `\`\`\`reason
let next = 42;
\`\`\`
after`;
  expect(await tokenizer.render("markdown.reason.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:9 "reason" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.reason storage.type
    2:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:4:8 "next" markup.fenced_code.block.markdown meta.embedded.block.reason entity.name.function
    2:8:9 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:9:10 "=" markup.fenced_code.block.markdown meta.embedded.block.reason keyword.control.less
    2:10:11 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:11:13 "42" markup.fenced_code.block.markdown meta.embedded.block.reason constant.numeric
    2:13:14 ";" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    3:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    4:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("Reason longer Markdown closing fence", async () => {
  const source = `\`\`\`reason
let x = 1;
\`\`\`\`
after`;
  expect(await tokenizer.render("markdown.reason.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:9 "reason" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.reason storage.type
    2:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:4:5 "x" markup.fenced_code.block.markdown meta.embedded.block.reason entity.name.function
    2:5:6 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:6:7 "=" markup.fenced_code.block.markdown meta.embedded.block.reason keyword.control.less
    2:7:8 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:8:9 "1" markup.fenced_code.block.markdown meta.embedded.block.reason constant.numeric
    2:9:10 ";" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    3:0:4 "\`\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    4:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("Reason Markdown rejects short and wrong closing fences", async () => {
  const source = `\`\`\`\`reason attrs
let x = 1;
\`\`\`
let y = 2;
~~~~
let z = 3;
\`\`\`\`\`
after`;
  expect(await tokenizer.render("markdown.reason.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:4 "\`\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:4:10 "reason" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    1:10:17 " attrs" markup.fenced_code.block.markdown fenced_code.block.language.attributes.markdown
    2:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.reason storage.type
    2:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:4:5 "x" markup.fenced_code.block.markdown meta.embedded.block.reason entity.name.function
    2:5:6 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:6:7 "=" markup.fenced_code.block.markdown meta.embedded.block.reason keyword.control.less
    2:7:8 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:8:9 "1" markup.fenced_code.block.markdown meta.embedded.block.reason constant.numeric
    2:9:10 ";" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    3:0:3 "\`\`\`" markup.fenced_code.block.markdown
    4:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.reason storage.type
    4:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    4:4:5 "y" markup.fenced_code.block.markdown meta.embedded.block.reason entity.name.function
    4:5:6 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    4:6:7 "=" markup.fenced_code.block.markdown meta.embedded.block.reason keyword.control.less
    4:7:8 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    4:8:9 "2" markup.fenced_code.block.markdown meta.embedded.block.reason constant.numeric
    4:9:10 ";" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    5:0:4 "~~~~" markup.fenced_code.block.markdown
    6:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.reason storage.type
    6:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    6:4:5 "z" markup.fenced_code.block.markdown meta.embedded.block.reason entity.name.function
    6:5:6 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    6:6:7 "=" markup.fenced_code.block.markdown meta.embedded.block.reason keyword.control.less
    6:7:8 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    6:8:9 "3" markup.fenced_code.block.markdown meta.embedded.block.reason constant.numeric
    6:9:10 ";" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    7:0:5 "\`\`\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    8:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("ocaml fence permits 0 leading spaces", async () => {
  const source = `\`\`\`ocaml
let value = 42;
\`\`\`
after`;
  expect(await tokenizer.render("markdown.ocaml.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:8 "ocaml" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.ocaml
    2:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:4:9 "value" markup.fenced_code.block.markdown meta.embedded.block.ocaml entity.name.binding.ocaml
    2:9:10 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:10:11 "=" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    2:11:12 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:12:14 "42" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.numeric.decimal.integer.ocaml
    2:14:15 ";" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.other.ocaml punctuation.separator.terminator punctuation.separator.semicolon
    3:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    4:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("ocaml fence permits 1 leading spaces", async () => {
  const source = ` \`\`\`ocaml
let value = 42;
 \`\`\`
after`;
  expect(await tokenizer.render("markdown.ocaml.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:1 " " markup.fenced_code.block.markdown
    1:1:4 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:4:9 "ocaml" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.ocaml
    2:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:4:9 "value" markup.fenced_code.block.markdown meta.embedded.block.ocaml entity.name.binding.ocaml
    2:9:10 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:10:11 "=" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    2:11:12 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:12:14 "42" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.numeric.decimal.integer.ocaml
    2:14:15 ";" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.other.ocaml punctuation.separator.terminator punctuation.separator.semicolon
    3:0:1 " " markup.fenced_code.block.markdown
    3:1:4 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    4:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("ocaml fence permits 2 leading spaces", async () => {
  const source = `  \`\`\`ocaml
let value = 42;
  \`\`\`
after`;
  expect(await tokenizer.render("markdown.ocaml.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:2 "  " markup.fenced_code.block.markdown
    1:2:5 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:5:10 "ocaml" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.ocaml
    2:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:4:9 "value" markup.fenced_code.block.markdown meta.embedded.block.ocaml entity.name.binding.ocaml
    2:9:10 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:10:11 "=" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    2:11:12 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:12:14 "42" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.numeric.decimal.integer.ocaml
    2:14:15 ";" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.other.ocaml punctuation.separator.terminator punctuation.separator.semicolon
    3:0:2 "  " markup.fenced_code.block.markdown
    3:2:5 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    4:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("ocaml fence permits 3 leading spaces", async () => {
  const source = `   \`\`\`ocaml
let value = 42;
   \`\`\`
after`;
  expect(await tokenizer.render("markdown.ocaml.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "   " markup.fenced_code.block.markdown
    1:3:6 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:6:11 "ocaml" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.ocaml
    2:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:4:9 "value" markup.fenced_code.block.markdown meta.embedded.block.ocaml entity.name.binding.ocaml
    2:9:10 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:10:11 "=" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    2:11:12 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:12:14 "42" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.numeric.decimal.integer.ocaml
    2:14:15 ";" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.other.ocaml punctuation.separator.terminator punctuation.separator.semicolon
    3:0:3 "   " markup.fenced_code.block.markdown
    3:3:6 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    4:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#tabs
test("ocaml fence rejects opener indented by four spaces", async () => {
  const source = `    \`\`\`ocaml
    let value = 42;
    \`\`\``;
  expect(await tokenizer.render("markdown.ocaml.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:13 "    \`\`\`ocaml"
    2:0:20 "    let value = 42;"
    3:0:8 "    \`\`\`""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("ocaml fence retains closer indented by four spaces as code", async () => {
  const source = `\`\`\`ocaml
    \`\`\`
let value = 42;
\`\`\`
after`;
  expect(await tokenizer.render("markdown.ocaml.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:8 "ocaml" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:8 "    \`\`\`" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.ocaml
    3:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:4:9 "value" markup.fenced_code.block.markdown meta.embedded.block.ocaml entity.name.binding.ocaml
    3:9:10 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:10:11 "=" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    3:11:12 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:12:14 "42" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.numeric.decimal.integer.ocaml
    3:14:15 ";" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.other.ocaml punctuation.separator.terminator punctuation.separator.semicolon
    4:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    5:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#tabs
test("ocaml fence rejects opener indented by a tab", async () => {
  const source = `\t\`\`\`ocaml
\tlet value = 42;
\t\`\`\``;
  expect(await tokenizer.render("markdown.ocaml.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:10 "\\t\`\`\`ocaml"
    2:0:17 "\\tlet value = 42;"
    3:0:5 "\\t\`\`\`""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("ocaml fence retains closer indented by a tab as code", async () => {
  const source = `\`\`\`ocaml
\t\`\`\`
let value = 42;
\`\`\`
after`;
  expect(await tokenizer.render("markdown.ocaml.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:8 "ocaml" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:5 "\\t\`\`\`" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.ocaml
    3:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:4:9 "value" markup.fenced_code.block.markdown meta.embedded.block.ocaml entity.name.binding.ocaml
    3:9:10 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:10:11 "=" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    3:11:12 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:12:14 "42" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.numeric.decimal.integer.ocaml
    3:14:15 ";" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.other.ocaml punctuation.separator.terminator punctuation.separator.semicolon
    4:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    5:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#tabs
test("ocaml fence rejects opener indented by space then tab", async () => {
  const source = ` \t\`\`\`ocaml
 \tlet value = 42;
 \t\`\`\``;
  expect(await tokenizer.render("markdown.ocaml.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:11 " \\t\`\`\`ocaml"
    2:0:18 " \\tlet value = 42;"
    3:0:6 " \\t\`\`\`""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("ocaml fence retains closer indented by space then tab as code", async () => {
  const source = `\`\`\`ocaml
 \t\`\`\`
let value = 42;
\`\`\`
after`;
  expect(await tokenizer.render("markdown.ocaml.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:8 "ocaml" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:6 " \\t\`\`\`" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.ocaml
    3:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:4:9 "value" markup.fenced_code.block.markdown meta.embedded.block.ocaml entity.name.binding.ocaml
    3:9:10 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:10:11 "=" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    3:11:12 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:12:14 "42" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.numeric.decimal.integer.ocaml
    3:14:15 ";" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.other.ocaml punctuation.separator.terminator punctuation.separator.semicolon
    4:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    5:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("reason fence permits 0 leading spaces", async () => {
  const source = `~~~reason
let value = 42;
~~~
after`;
  expect(await tokenizer.render("markdown.reason.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:9 "reason" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.reason storage.type
    2:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:4:9 "value" markup.fenced_code.block.markdown meta.embedded.block.reason entity.name.function
    2:9:10 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:10:11 "=" markup.fenced_code.block.markdown meta.embedded.block.reason keyword.control.less
    2:11:12 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:12:14 "42" markup.fenced_code.block.markdown meta.embedded.block.reason constant.numeric
    2:14:15 ";" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    3:0:3 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    4:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("reason fence permits 1 leading spaces", async () => {
  const source = ` ~~~reason
let value = 42;
 ~~~
after`;
  expect(await tokenizer.render("markdown.reason.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:1 " " markup.fenced_code.block.markdown
    1:1:4 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:4:10 "reason" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.reason storage.type
    2:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:4:9 "value" markup.fenced_code.block.markdown meta.embedded.block.reason entity.name.function
    2:9:10 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:10:11 "=" markup.fenced_code.block.markdown meta.embedded.block.reason keyword.control.less
    2:11:12 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:12:14 "42" markup.fenced_code.block.markdown meta.embedded.block.reason constant.numeric
    2:14:15 ";" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    3:0:1 " " markup.fenced_code.block.markdown
    3:1:4 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    4:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("reason fence permits 2 leading spaces", async () => {
  const source = `  ~~~reason
let value = 42;
  ~~~
after`;
  expect(await tokenizer.render("markdown.reason.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:2 "  " markup.fenced_code.block.markdown
    1:2:5 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:5:11 "reason" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.reason storage.type
    2:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:4:9 "value" markup.fenced_code.block.markdown meta.embedded.block.reason entity.name.function
    2:9:10 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:10:11 "=" markup.fenced_code.block.markdown meta.embedded.block.reason keyword.control.less
    2:11:12 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:12:14 "42" markup.fenced_code.block.markdown meta.embedded.block.reason constant.numeric
    2:14:15 ";" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    3:0:2 "  " markup.fenced_code.block.markdown
    3:2:5 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    4:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("reason fence permits 3 leading spaces", async () => {
  const source = `   ~~~reason
let value = 42;
   ~~~
after`;
  expect(await tokenizer.render("markdown.reason.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "   " markup.fenced_code.block.markdown
    1:3:6 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:6:12 "reason" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.reason storage.type
    2:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:4:9 "value" markup.fenced_code.block.markdown meta.embedded.block.reason entity.name.function
    2:9:10 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:10:11 "=" markup.fenced_code.block.markdown meta.embedded.block.reason keyword.control.less
    2:11:12 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:12:14 "42" markup.fenced_code.block.markdown meta.embedded.block.reason constant.numeric
    2:14:15 ";" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    3:0:3 "   " markup.fenced_code.block.markdown
    3:3:6 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    4:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#tabs
test("reason fence rejects opener indented by four spaces", async () => {
  const source = `    ~~~reason
    let value = 42;
    ~~~`;
  expect(await tokenizer.render("markdown.reason.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:14 "    ~~~reason"
    2:0:20 "    let value = 42;"
    3:0:8 "    ~~~""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("reason fence retains closer indented by four spaces as code", async () => {
  const source = `~~~reason
    ~~~
let value = 42;
~~~
after`;
  expect(await tokenizer.render("markdown.reason.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:9 "reason" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:4 "    " markup.fenced_code.block.markdown meta.embedded.block.reason
    2:4:7 "~~~" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    3:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.reason storage.type
    3:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    3:4:9 "value" markup.fenced_code.block.markdown meta.embedded.block.reason entity.name.function
    3:9:10 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    3:10:11 "=" markup.fenced_code.block.markdown meta.embedded.block.reason keyword.control.less
    3:11:12 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    3:12:14 "42" markup.fenced_code.block.markdown meta.embedded.block.reason constant.numeric
    3:14:15 ";" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    4:0:3 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    5:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#tabs
test("reason fence rejects opener indented by a tab", async () => {
  const source = `\t~~~reason
\tlet value = 42;
\t~~~`;
  expect(await tokenizer.render("markdown.reason.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:11 "\\t~~~reason"
    2:0:17 "\\tlet value = 42;"
    3:0:5 "\\t~~~""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("reason fence retains closer indented by a tab as code", async () => {
  const source = `~~~reason
\t~~~
let value = 42;
~~~
after`;
  expect(await tokenizer.render("markdown.reason.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:9 "reason" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:1 "\\t" markup.fenced_code.block.markdown meta.embedded.block.reason
    2:1:4 "~~~" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    3:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.reason storage.type
    3:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    3:4:9 "value" markup.fenced_code.block.markdown meta.embedded.block.reason entity.name.function
    3:9:10 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    3:10:11 "=" markup.fenced_code.block.markdown meta.embedded.block.reason keyword.control.less
    3:11:12 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    3:12:14 "42" markup.fenced_code.block.markdown meta.embedded.block.reason constant.numeric
    3:14:15 ";" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    4:0:3 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    5:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#tabs
test("reason fence rejects opener indented by space then tab", async () => {
  const source = ` \t~~~reason
 \tlet value = 42;
 \t~~~`;
  expect(await tokenizer.render("markdown.reason.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:12 " \\t~~~reason"
    2:0:18 " \\tlet value = 42;"
    3:0:6 " \\t~~~""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("reason fence retains closer indented by space then tab as code", async () => {
  const source = `~~~reason
 \t~~~
let value = 42;
~~~
after`;
  expect(await tokenizer.render("markdown.reason.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:9 "reason" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:2 " \\t" markup.fenced_code.block.markdown meta.embedded.block.reason
    2:2:5 "~~~" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    3:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.reason storage.type
    3:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    3:4:9 "value" markup.fenced_code.block.markdown meta.embedded.block.reason entity.name.function
    3:9:10 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    3:10:11 "=" markup.fenced_code.block.markdown meta.embedded.block.reason keyword.control.less
    3:11:12 " " markup.fenced_code.block.markdown meta.embedded.block.reason
    3:12:14 "42" markup.fenced_code.block.markdown meta.embedded.block.reason constant.numeric
    3:14:15 ";" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    4:0:3 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    5:0:6 "after""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("OCaml Markdown first line and longer closer", async () => {
  const source = `\`\`\`ocaml
let x = 1
\`\`\`\`
let outside = 2`;
  expect(await tokenizer.render("markdown.ocaml.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:8 "ocaml" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.ocaml
    2:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:4:5 "x" markup.fenced_code.block.markdown meta.embedded.block.ocaml entity.name.binding.ocaml
    2:5:6 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:6:7 "=" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    2:7:8 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:8:9 "1" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.numeric.decimal.integer.ocaml
    3:0:4 "\`\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    4:0:16 "let outside = 2""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("OCaml Markdown mismatched and shorter fences", async () => {
  const source = `\`\`\`\`ocaml
~~~
let x = 1
\`\`\`
let y = 2
\`\`\`\`\`
plain`;
  expect(await tokenizer.render("markdown.ocaml.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:4 "\`\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:4:9 "ocaml" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:3 "~~~" markup.fenced_code.block.markdown
    3:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.ocaml
    3:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:4:5 "x" markup.fenced_code.block.markdown meta.embedded.block.ocaml entity.name.binding.ocaml
    3:5:6 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:6:7 "=" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    3:7:8 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:8:9 "1" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.numeric.decimal.integer.ocaml
    4:0:3 "\`\`\`" markup.fenced_code.block.markdown
    5:0:3 "let" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.ocaml
    5:3:4 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    5:4:5 "y" markup.fenced_code.block.markdown meta.embedded.block.ocaml entity.name.binding.ocaml
    5:5:6 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    5:6:7 "=" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    5:7:8 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    5:8:9 "2" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.numeric.decimal.integer.ocaml
    6:0:5 "\`\`\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    7:0:6 "plain""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("ocaml backtick closing fences require ASCII whitespace", async () => {
  const source = [
    "```\u00a0ocaml\u00a0attrs",
    "Before",
    "```\u00a0",
    "AfterNbsp",
    "```\u2003",
    "AfterEmSpace",
    "```\u0085",
    "AfterNel",
    "``` \t",
    "Outside",
  ].join("\r\n");
  expect(await tokenizer.render("markdown.ocaml.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:4 " " markup.fenced_code.block.markdown
    1:4:9 "ocaml" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    1:9:17 " attrs\\r" markup.fenced_code.block.markdown fenced_code.block.language.attributes.markdown
    2:0:6 "Before" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.language.capital-identifier.ocaml
    2:6:8 "\\r" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:0:6 "\`\`\` \\r" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    4:0:9 "AfterNbsp" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.language.capital-identifier.ocaml
    4:9:11 "\\r" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    5:0:6 "\`\`\` \\r" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    6:0:12 "AfterEmSpace" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.language.capital-identifier.ocaml
    6:12:14 "\\r" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    7:0:6 "\`\`\`\\r" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    8:0:8 "AfterNel" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.language.capital-identifier.ocaml
    8:8:10 "\\r" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    9:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    9:3:6 " \\t\\r" markup.fenced_code.block.markdown
    10:0:8 "Outside""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("ocaml tilde closing fences require ASCII whitespace", async () => {
  const source = [
    "~~~\u00a0ocaml\u00a0attrs",
    "Before",
    "~~~\u00a0",
    "AfterNbsp",
    "~~~\u2003",
    "AfterEmSpace",
    "~~~\u0085",
    "AfterNel",
    "~~~ \t",
    "Outside",
  ].join("\r\n");
  expect(await tokenizer.render("markdown.ocaml.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:4 " " markup.fenced_code.block.markdown
    1:4:9 "ocaml" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    1:9:17 " attrs\\r" markup.fenced_code.block.markdown fenced_code.block.language.attributes.markdown
    2:0:6 "Before" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.language.capital-identifier.ocaml
    2:6:8 "\\r" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:0:3 "~~~" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    3:3:6 " \\r" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    4:0:9 "AfterNbsp" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.language.capital-identifier.ocaml
    4:9:11 "\\r" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    5:0:3 "~~~" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    5:3:6 " \\r" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    6:0:12 "AfterEmSpace" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.language.capital-identifier.ocaml
    6:12:14 "\\r" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    7:0:3 "~~~" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    7:3:6 "\\r" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    8:0:8 "AfterNel" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.language.capital-identifier.ocaml
    8:8:10 "\\r" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    9:0:3 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    9:3:6 " \\t\\r" markup.fenced_code.block.markdown
    10:0:8 "Outside""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("reason backtick closing fences require ASCII whitespace", async () => {
  const source = [
    "```\u00a0reason\u00a0attrs",
    "Before",
    "```\u00a0",
    "AfterNbsp",
    "```\u2003",
    "AfterEmSpace",
    "```\u0085",
    "AfterNel",
    "``` \t",
    "Outside",
  ].join("\r\n");
  expect(await tokenizer.render("markdown.reason.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:4 " " markup.fenced_code.block.markdown
    1:4:10 "reason" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    1:10:18 " attrs\\r" markup.fenced_code.block.markdown fenced_code.block.language.attributes.markdown
    2:0:6 "Before" markup.fenced_code.block.markdown meta.embedded.block.reason entity.other.attribute-name.css constant.language constant.numeric
    2:6:8 "\\r" markup.fenced_code.block.markdown meta.embedded.block.reason
    3:0:6 "\`\`\` \\r" markup.fenced_code.block.markdown meta.embedded.block.reason
    4:0:9 "AfterNbsp" markup.fenced_code.block.markdown meta.embedded.block.reason entity.other.attribute-name.css constant.language constant.numeric
    4:9:11 "\\r" markup.fenced_code.block.markdown meta.embedded.block.reason
    5:0:6 "\`\`\` \\r" markup.fenced_code.block.markdown meta.embedded.block.reason
    6:0:12 "AfterEmSpace" markup.fenced_code.block.markdown meta.embedded.block.reason entity.other.attribute-name.css constant.language constant.numeric
    6:12:14 "\\r" markup.fenced_code.block.markdown meta.embedded.block.reason
    7:0:6 "\`\`\`\\r" markup.fenced_code.block.markdown meta.embedded.block.reason
    8:0:8 "AfterNel" markup.fenced_code.block.markdown meta.embedded.block.reason entity.other.attribute-name.css constant.language constant.numeric
    8:8:10 "\\r" markup.fenced_code.block.markdown meta.embedded.block.reason
    9:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    9:3:6 " \\t\\r" markup.fenced_code.block.markdown
    10:0:8 "Outside""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("reason tilde closing fences require ASCII whitespace", async () => {
  const source = [
    "~~~\u00a0reason\u00a0attrs",
    "Before",
    "~~~\u00a0",
    "AfterNbsp",
    "~~~\u2003",
    "AfterEmSpace",
    "~~~\u0085",
    "AfterNel",
    "~~~ \t",
    "Outside",
  ].join("\r\n");
  expect(await tokenizer.render("markdown.reason.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:4 " " markup.fenced_code.block.markdown
    1:4:10 "reason" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    1:10:18 " attrs\\r" markup.fenced_code.block.markdown fenced_code.block.language.attributes.markdown
    2:0:6 "Before" markup.fenced_code.block.markdown meta.embedded.block.reason entity.other.attribute-name.css constant.language constant.numeric
    2:6:8 "\\r" markup.fenced_code.block.markdown meta.embedded.block.reason
    3:0:3 "~~~" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    3:3:6 " \\r" markup.fenced_code.block.markdown meta.embedded.block.reason
    4:0:9 "AfterNbsp" markup.fenced_code.block.markdown meta.embedded.block.reason entity.other.attribute-name.css constant.language constant.numeric
    4:9:11 "\\r" markup.fenced_code.block.markdown meta.embedded.block.reason
    5:0:3 "~~~" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    5:3:6 " \\r" markup.fenced_code.block.markdown meta.embedded.block.reason
    6:0:12 "AfterEmSpace" markup.fenced_code.block.markdown meta.embedded.block.reason entity.other.attribute-name.css constant.language constant.numeric
    6:12:14 "\\r" markup.fenced_code.block.markdown meta.embedded.block.reason
    7:0:3 "~~~" markup.fenced_code.block.markdown meta.embedded.block.reason variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    7:3:6 "\\r" markup.fenced_code.block.markdown meta.embedded.block.reason
    8:0:8 "AfterNel" markup.fenced_code.block.markdown meta.embedded.block.reason entity.other.attribute-name.css constant.language constant.numeric
    8:8:10 "\\r" markup.fenced_code.block.markdown meta.embedded.block.reason
    9:0:3 "~~~" markup.fenced_code.block.markdown punctuation.definition.markdown
    9:3:6 " \\t\\r" markup.fenced_code.block.markdown
    10:0:8 "Outside""
  `);
});

// https://spec.commonmark.org/0.31.2/#fenced-code-blocks
test("OCaml Markdown declaration bodies keep OCaml scopes", async () => {
  const source = `\`\`\`ocaml
type t = A of int | B of { x : int }
class c x = object method m = x + 1 end
\`\`\``;
  expect(await tokenizer.render("markdown.ocaml.codeblock", source)).toMatchInlineSnapshot(`
    "1:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown
    1:3:8 "ocaml" markup.fenced_code.block.markdown fenced_code.block.language.markdown
    2:0:4 "type" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.ocaml
    2:4:5 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:5:6 "t" markup.fenced_code.block.markdown meta.embedded.block.ocaml entity.name.type.ocaml
    2:6:7 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:7:8 "=" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    2:8:9 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:9:10 "A" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.language.capital-identifier.ocaml
    2:10:11 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:11:13 "of" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.other.ocaml
    2:13:14 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:14:17 "int" markup.fenced_code.block.markdown meta.embedded.block.ocaml support.type.ocaml
    2:17:18 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:18:19 "|" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.other.ocaml
    2:19:20 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:20:21 "B" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.language.capital-identifier.ocaml
    2:21:22 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:22:24 "of" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.other.ocaml
    2:24:25 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:25:26 "{" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:26:27 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:27:28 "x" markup.fenced_code.block.markdown meta.embedded.block.ocaml source.ocaml
    2:28:29 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:29:30 ":" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.other.ocaml punctuation.other.colon punctuation.colon
    2:30:31 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:31:34 "int" markup.fenced_code.block.markdown meta.embedded.block.ocaml support.type.ocaml
    2:34:35 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    2:35:36 "}" markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:0:5 "class" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.ocaml
    3:5:6 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:6:7 "c" markup.fenced_code.block.markdown meta.embedded.block.ocaml entity.name.type.class.ocaml
    3:7:8 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:8:9 "x" markup.fenced_code.block.markdown meta.embedded.block.ocaml source.ocaml
    3:9:10 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:10:11 "=" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    3:11:12 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:12:18 "object" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.ocaml
    3:18:19 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:19:25 "method" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.ocaml
    3:25:26 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:26:27 "m" markup.fenced_code.block.markdown meta.embedded.block.ocaml entity.name.function.method.ocaml
    3:27:28 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:28:29 "=" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    3:29:30 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:30:31 "x" markup.fenced_code.block.markdown meta.embedded.block.ocaml source.ocaml
    3:31:32 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:32:33 "+" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.operator.ocaml
    3:33:34 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:34:35 "1" markup.fenced_code.block.markdown meta.embedded.block.ocaml constant.numeric.decimal.integer.ocaml
    3:35:36 " " markup.fenced_code.block.markdown meta.embedded.block.ocaml
    3:36:39 "end" markup.fenced_code.block.markdown meta.embedded.block.ocaml keyword.ocaml
    4:0:3 "\`\`\`" markup.fenced_code.block.markdown punctuation.definition.markdown"
  `);
});
