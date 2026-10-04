import { afterAll, expect, test } from "bun:test";

import { createTokenizer } from "./tokenizer.ts";

const tokenizer = createTokenizer();
afterAll(() => tokenizer.dispose());

// https://raw.githubusercontent.com/reasonml/reason/master/src/reason-parser/reason_declarative_lexer.mll
test("Reason nested comments raw strings and recovery", async () => {
  const source = `/* outer /* inner */ still outer */
let text = {tag|" /* raw */ |other} |tag};
let next = 42;`;
  expect(await tokenizer.render("source.reason", source)).toMatchInlineSnapshot(`
    "1:0:2 "/*" comment.block
    1:2:9 " outer " comment.block
    1:9:11 "/*" comment.block comment.block
    1:11:18 " inner " comment.block comment.block
    1:18:20 "*/" comment.block comment.block
    1:20:33 " still outer " comment.block
    1:33:35 "*/" comment.block
    2:0:3 "let" storage.type
    2:4:8 "text" entity.name.function
    2:9:10 "=" keyword.control.less
    2:11:12 "{" string.double string.regexp keyword.control.flow message.error
    2:12:15 "tag" string.double string.regexp entity.other.attribute-name.css constant.language constant.numeric
    2:15:16 "|" string.double string.regexp keyword.control.flow message.error
    2:16:36 "\\" /* raw */ |other} " string.double string.regexp
    2:36:37 "|" string.double string.regexp keyword.control.flow message.error
    2:37:40 "tag" string.double string.regexp entity.other.attribute-name.css constant.language constant.numeric
    2:40:41 "}" string.double string.regexp keyword.control.flow message.error
    2:41:42 ";" variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    3:0:3 "let" storage.type
    3:4:8 "next" entity.name.function
    3:9:10 "=" keyword.control.less
    3:11:13 "42" constant.numeric
    3:13:14 ";" variable.other.class.js variable.interpolation keyword.operator keyword.control message.error"
  `);
});

// https://raw.githubusercontent.com/reasonml/reason/master/src/reason-parser/reason_declarative_lexer.mll
test("Reason external string escapes", async () => {
  const source = `external f: string => string = "a\\"#b";
let next = 42;`;
  expect(await tokenizer.render("source.reason", source)).toMatchInlineSnapshot(`
    "1:0:8 "external" storage.type
    1:9:10 "f" entity.name.function
    1:10:11 ":" variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    1:12:18 "string" support.type string.regexp
    1:19:21 "=>" markup.inserted keyword.control.less
    1:22:28 "string" support.type string.regexp
    1:29:30 "=" keyword.control.less
    1:31:32 "\\"" string.double string.regexp
    1:32:33 "a" string.double string.regexp
    1:33:35 "\\\\\\"" string.double string.regexp constant.character
    1:35:37 "#b" string.double string.regexp
    1:37:38 "\\"" string.double string.regexp
    1:38:39 ";" variable.other.class.js variable.interpolation keyword.operator keyword.control message.error
    2:0:3 "let" storage.type
    2:4:8 "next" entity.name.function
    2:9:10 "=" keyword.control.less
    2:11:13 "42" constant.numeric
    2:13:14 ";" variable.other.class.js variable.interpolation keyword.operator keyword.control message.error"
  `);
});

// https://raw.githubusercontent.com/reasonml/reason/master/src/reason-parser/reason_declarative_lexer.mll
test("Reason strings inside comments protect closing delimiters", async () => {
  const source = `/* "*/" still comment {tag| */ |tag} remains */
/** "*/" documentation */
let next = 42;`;
  expect(await tokenizer.render("source.reason", source)).toMatchInlineSnapshot(`
    "1:0:2 "/*" comment.block
    1:2:3 " " comment.block
    1:3:4 "\\"" comment.block
    1:4:6 "*/" comment.block
    1:6:7 "\\"" comment.block
    1:7:22 " still comment " comment.block
    1:22:27 "{tag|" comment.block
    1:27:31 " */ " comment.block
    1:31:36 "|tag}" comment.block
    1:36:45 " remains " comment.block
    1:45:47 "*/" comment.block
    2:0:3 "/**" comment.block.documentation
    2:3:4 " " comment.block.documentation
    2:4:5 "\\"" comment.block.documentation
    2:5:7 "*/" comment.block.documentation
    2:7:8 "\\"" comment.block.documentation
    2:8:23 " documentation " comment.block.documentation
    2:23:25 "*/" comment.block.documentation
    3:0:3 "let" storage.type
    3:4:8 "next" entity.name.function
    3:9:10 "=" keyword.control.less
    3:11:13 "42" constant.numeric
    3:13:14 ";" variable.other.class.js variable.interpolation keyword.operator keyword.control message.error"
  `);
});

// https://raw.githubusercontent.com/reasonml/reason/master/src/reason-parser/reason_declarative_lexer.mll
test("Reason Unicode escape", async () => {
  const source = 'let x = "\\u{1F42B}";';
  expect(await tokenizer.render("source.reason", source)).toMatchInlineSnapshot(`
    "1:0:3 "let" storage.type
    1:4:5 "x" entity.name.function
    1:6:7 "=" keyword.control.less
    1:8:9 "\\"" string.double string.regexp
    1:9:18 "\\\\u{1F42B}" string.double string.regexp constant.character
    1:18:19 "\\"" string.double string.regexp
    1:19:20 ";" variable.other.class.js variable.interpolation keyword.operator keyword.control message.error"
  `);
});

// https://raw.githubusercontent.com/reasonml/reason/master/src/reason-parser/reason_declarative_lexer.mll
test("Reason comment character quote", async () => {
  const source = `/* a quote character: '"' */
let next = 42;`;
  expect(await tokenizer.render("source.reason", source)).toMatchInlineSnapshot(`
    "1:0:2 "/*" comment.block
    1:2:22 " a quote character: " comment.block
    1:22:25 "'\\"'" comment.block
    1:25:26 " " comment.block
    1:26:28 "*/" comment.block
    2:0:3 "let" storage.type
    2:4:8 "next" entity.name.function
    2:9:10 "=" keyword.control.less
    2:11:13 "42" constant.numeric
    2:13:14 ";" variable.other.class.js variable.interpolation keyword.operator keyword.control message.error"
  `);
});
