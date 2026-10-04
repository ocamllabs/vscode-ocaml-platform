const { afterAll, expect, test } = require("bun:test");
const { createTokenizer } = require("./tokenizer");

const tokenizer = createTokenizer();
afterAll(() => tokenizer.dispose());

// https://ocaml.org/manual/5.5/lexyacc.html
test("OCamllex identifiers wildcard and nested actions", async () => {
  const source = `let _digit = ['0'-'9']
rule _token = parse
| _digit { { value = "}" } }
| eof' { 0 }
| _ { 1 }`;
  expect(await tokenizer.render("source.ocaml.ocamllex", source)).toMatchInlineSnapshot(`
    "1:0:3 "let" keyword.other.ocamllex
    1:4:10 "_digit" entity.name.type.reference.ocamllex
    1:11:12 "=" keyword.operator.symbol.ocamllex
    1:13:14 "[" punctuation.character-set.ocamllex
    1:14:17 "'0'" string.quoted.single.ocaml
    1:17:18 "-" keyword.operator.ocamllex
    1:18:21 "'9'" string.quoted.single.ocaml
    1:21:22 "]" punctuation.character-set.ocamllex
    2:0:4 "rule" keyword.other.ocamllex
    2:5:11 "_token" entity.name.function.rule.ocamllex
    2:12:13 "=" keyword.operator.symbol.ocamllex
    2:14:19 "parse" keyword.other.ocamllex
    3:0:1 "|" keyword.operator.ocamllex
    3:2:8 "_digit" entity.name.type.reference.ocamllex
    3:9:10 "{" keyword.other.ocamllex
    3:11:12 "{"
    3:13:18 "value" source.ocaml
    3:19:20 "=" keyword.operator.ocaml
    3:21:22 "\\"" string.quoted.double.ocaml
    3:22:23 "}" string.quoted.double.ocaml
    3:23:24 "\\"" string.quoted.double.ocaml
    3:25:26 "}"
    3:27:28 "}" keyword.other.ocamllex
    4:0:1 "|" keyword.operator.ocamllex
    4:2:6 "eof'" entity.name.type.reference.ocamllex
    4:7:8 "{" keyword.other.ocamllex
    4:9:10 "0" constant.numeric.decimal.integer.ocaml
    4:11:12 "}" keyword.other.ocamllex
    5:0:1 "|" keyword.operator.ocamllex
    5:2:3 "_" constant.language.wildcard.ocamllex
    5:4:5 "{" keyword.other.ocamllex
    5:6:7 "1" constant.numeric.decimal.integer.ocaml
    5:8:9 "}" keyword.other.ocamllex"
  `);
});
