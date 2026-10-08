import { afterAll, expect, test } from "bun:test";

import { createTokenizer } from "./tokenizer.ts";

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

// https://ocaml.org/manual/5.5/lexyacc.html
test("OCamllex header declarations use OCaml scopes", async () => {
  const source = `{
type t = A of int | B of { x : int }
class c = object method m = if x then 1 else A.f end
}
rule token = parse eof { () }`;
  expect(await tokenizer.render("source.ocaml.ocamllex", source)).toMatchInlineSnapshot(`
    "1:0:1 "{" keyword.other.ocamllex
    2:0:4 "type" keyword.ocaml
    2:5:6 "t" entity.name.type.ocaml
    2:7:8 "=" keyword.operator.ocaml
    2:9:10 "A" constant.language.capital-identifier.ocaml
    2:11:13 "of" keyword.other.ocaml
    2:14:17 "int" support.type.ocaml
    2:18:19 "|" keyword.other.ocaml
    2:20:21 "B" constant.language.capital-identifier.ocaml
    2:22:24 "of" keyword.other.ocaml
    2:25:26 "{"
    2:27:28 "x" source.ocaml
    2:29:30 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    2:31:34 "int" support.type.ocaml
    2:35:36 "}"
    3:0:5 "class" keyword.ocaml
    3:6:7 "c" entity.name.type.class.ocaml
    3:8:9 "=" keyword.operator.ocaml
    3:10:16 "object" keyword.ocaml
    3:17:23 "method" keyword.ocaml
    3:24:25 "m" entity.name.function.method.ocaml
    3:26:27 "=" keyword.operator.ocaml
    3:28:30 "if" keyword.other.ocaml
    3:31:32 "x" source.ocaml
    3:33:37 "then" keyword.other.ocaml
    3:38:39 "1" constant.numeric.decimal.integer.ocaml
    3:40:44 "else" keyword.other.ocaml
    3:45:46 "A" constant.language.capital-identifier.ocaml
    3:46:47 "." keyword.other.ocaml punctuation.other.period punctuation.separator.period
    3:47:48 "f" source.ocaml
    3:49:52 "end" keyword.ocaml
    4:0:1 "}" keyword.other.ocamllex
    5:0:4 "rule" keyword.other.ocamllex
    5:5:10 "token" entity.name.function.rule.ocamllex
    5:11:12 "=" keyword.operator.symbol.ocamllex
    5:13:18 "parse" keyword.other.ocamllex
    5:19:22 "eof" constant.language.eof.ocamllex
    5:23:24 "{" keyword.other.ocamllex
    5:25:27 "()" constant.language.unit.ocaml
    5:28:29 "}" keyword.other.ocamllex"
  `);
});
