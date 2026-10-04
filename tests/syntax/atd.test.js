const { afterAll, expect, test } = require("bun:test");
const { createTokenizer } = require("./tokenizer");

const tokenizer = createTokenizer();
afterAll(() => tokenizer.dispose());

// https://atd.readthedocs.io/en/latest/atd-language.html
test("ATD single quoted annotation string and type parameter", async () => {
  const source = `type 'a item = 'a list <doc text='a > b \\' c'>
type next = int`;
  expect(await tokenizer.render("source.atd", source)).toMatchInlineSnapshot(`
    "1:0:4 "type" keyword.other.atd
    1:5:7 "'a" storage.type.ocaml.atd
    1:8:12 "item" entity.name.type.atd
    1:13:14 "=" keyword.operator.ocaml
    1:15:17 "'a" storage.type.ocaml.atd
    1:18:22 "list" source.ocaml
    1:23:24 "<" keyword.other.atd
    1:24:27 "doc" keyword.other.atd
    1:28:32 "text" source.ocaml
    1:32:33 "=" keyword.operator.ocaml
    1:33:34 "'" string.quoted.single.atd
    1:34:40 "a > b " string.quoted.single.atd
    1:40:42 "\\\\'" string.quoted.single.atd constant.character.escape.atd
    1:42:44 " c" string.quoted.single.atd
    1:44:45 "'" string.quoted.single.atd
    1:45:46 ">" keyword.other.atd
    2:0:4 "type" keyword.other.atd
    2:5:9 "next" entity.name.type.atd
    2:10:11 "=" keyword.operator.ocaml
    2:12:15 "int" source.ocaml"
  `);
});

// https://atd.readthedocs.io/en/latest/atd-language.html
test("ATD import declarations", async () => {
  const source = `from mylib.common as c import date, timestamp
type event = c.date`;
  expect(await tokenizer.render("source.atd", source)).toMatchInlineSnapshot(`
    "1:0:4 "from" keyword.other.atd
    1:5:10 "mylib" source.ocaml
    1:10:11 "." keyword.other.ocaml punctuation.other.period punctuation.separator.period
    1:11:17 "common" source.ocaml
    1:18:20 "as" keyword.other.atd
    1:21:22 "c" source.ocaml
    1:23:29 "import" keyword.other.atd
    1:30:34 "date" source.ocaml
    1:34:35 "," keyword.other.ocaml punctuation.comma punctuation.separator.comma
    1:36:45 "timestamp" source.ocaml
    2:0:4 "type" keyword.other.atd
    2:5:10 "event" entity.name.type.atd
    2:11:12 "=" keyword.operator.ocaml
    2:13:14 "c" source.ocaml
    2:14:15 "." keyword.other.ocaml punctuation.other.period punctuation.separator.period
    2:15:19 "date" source.ocaml"
  `);
});

// https://github.com/ahrefs/atd/blob/4.2.0/atd/src/lexer.mll#L112
test("ATD type names and fields remain identifiers", async () => {
  const source = `type list' = int
type foo = list'
type item = { list: int; string: string }
type 'ab' wrap_value = 'ab' list`;
  expect(await tokenizer.render("source.atd", source)).toMatchInlineSnapshot(`
    "1:0:4 "type" keyword.other.atd
    1:5:10 "list'" entity.name.type.atd
    1:11:12 "=" keyword.operator.ocaml
    1:13:16 "int" source.ocaml
    2:0:4 "type" keyword.other.atd
    2:5:8 "foo" entity.name.type.atd
    2:9:10 "=" keyword.operator.ocaml
    2:11:16 "list'" source.ocaml
    3:0:4 "type" keyword.other.atd
    3:5:9 "item" entity.name.type.atd
    3:10:11 "=" keyword.operator.ocaml
    3:11:14 " { "
    3:14:18 "list" source.ocaml
    3:18:19 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    3:20:23 "int" source.ocaml
    3:23:24 ";" keyword.other.ocaml punctuation.separator.terminator punctuation.separator.semicolon
    3:25:31 "string" source.ocaml
    3:31:32 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    3:33:39 "string" source.ocaml
    3:39:42 " }"
    4:0:4 "type" keyword.other.atd
    4:5:9 "'ab'" storage.type.ocaml.atd
    4:10:20 "wrap_value" entity.name.type.atd
    4:21:22 "=" keyword.operator.ocaml
    4:23:27 "'ab'" storage.type.ocaml.atd
    4:28:32 "list" source.ocaml"
  `);
});

// https://atd.readthedocs.io/en/latest/atd-language.html
test("Declaration roles", async () => {
  const source = `type item = int
type 'a wrapper = 'a list`;
  expect(await tokenizer.render("source.atd", source)).toMatchInlineSnapshot(`
    "1:0:4 "type" keyword.other.atd
    1:5:9 "item" entity.name.type.atd
    1:10:11 "=" keyword.operator.ocaml
    1:12:15 "int" source.ocaml
    2:0:4 "type" keyword.other.atd
    2:5:7 "'a" storage.type.ocaml.atd
    2:8:15 "wrapper" entity.name.type.atd
    2:16:17 "=" keyword.operator.ocaml
    2:18:20 "'a" storage.type.ocaml.atd
    2:21:25 "list" source.ocaml"
  `);
});
