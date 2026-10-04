const { afterAll, expect, test } = require("bun:test");
const { createTokenizer } = require("./tokenizer");

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
