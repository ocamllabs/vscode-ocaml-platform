import { afterAll, expect, test } from "bun:test";

import { createTokenizer } from "./tokenizer.ts";

const tokenizer = createTokenizer();
afterAll(() => tokenizer.dispose());

// https://gallium.inria.fr/~fpottier/menhir/manual.html
test("Menhir declarations rules and semantic action injection", async () => {
  const source = `%token <int> INT
%start <int> main
%%
main: x = INT { $startpos(x), x }
let other == INT; < Fun.id >`;
  expect(await tokenizer.render("source.ocaml.menhir", source)).toMatchInlineSnapshot(`
    "1:0:6 "%token" keyword.other.menhir
    1:7:8 "<" keyword.other.menhir
    1:8:11 "int" source.ocaml
    1:11:12 ">" keyword.other.menhir
    1:13:16 "INT" constant.other.token.menhir
    2:0:6 "%start" keyword.other.menhir
    2:7:8 "<" keyword.other.menhir
    2:8:11 "int" source.ocaml
    2:11:12 ">" keyword.other.menhir
    2:13:17 "main" entity.name.function.rule.menhir
    3:0:2 "%%" keyword.other.menhir
    4:0:4 "main" entity.name.function.rule.menhir
    4:4:5 ":" keyword.other.menhir
    4:6:7 "x" variable.parameter.value.menhir
    4:8:9 "=" keyword.other.menhir
    4:10:13 "INT" constant.other.token.menhir
    4:14:15 "{" keyword.other.menhir
    4:15:16 " " source.embedded-action.menhir
    4:16:25 "$startpos" source.embedded-action.menhir keyword.other.menhir
    4:25:26 "(" source.embedded-action.menhir
    4:26:27 "x" source.embedded-action.menhir entity.name.function.rule.menhir
    4:27:28 ")" source.embedded-action.menhir
    4:28:29 "," source.embedded-action.menhir keyword.other.ocaml punctuation.comma punctuation.separator.comma
    4:29:30 " " source.embedded-action.menhir
    4:30:31 "x" source.embedded-action.menhir source.ocaml
    4:31:32 " " source.embedded-action.menhir
    4:32:33 "}" keyword.other.menhir
    5:0:3 "let" keyword.other.menhir
    5:4:9 "other" entity.name.function.rule.menhir
    5:10:12 "==" keyword.other.menhir
    5:13:16 "INT" constant.other.token.menhir
    5:16:17 ";" keyword.other.menhir punctuation.separator.terminator punctuation.separator.semicolon
    5:18:19 "<" keyword.other.menhir
    5:20:23 "Fun" constant.language.capital-identifier.ocaml
    5:23:24 "." keyword.other.ocaml punctuation.other.period punctuation.separator.period
    5:24:26 "id" source.ocaml
    5:27:28 ">" keyword.other.menhir"
  `);
});

// https://gallium.inria.fr/~fpottier/menhir/manual.html
test("Menhir position keyword variants", async () => {
  const source = "$symbolstartpos $sloc $startofs($1) $endpos(token)";
  expect(await tokenizer.render("source.action.menhir", source)).toMatchInlineSnapshot(`
    "1:0:15 "$symbolstartpos" keyword.other.menhir
    1:16:21 "$sloc" keyword.other.menhir
    1:22:31 "$startofs" keyword.other.menhir
    1:31:32 "("
    1:32:34 "$1" keyword.other.menhir
    1:34:35 ")"
    1:36:43 "$endpos" keyword.other.menhir
    1:43:44 "("
    1:44:49 "token" entity.name.function.rule.menhir
    1:49:50 ")""
  `);
});

// https://gallium.inria.fr/~fpottier/menhir/manual.html
test("Menhir action injection excludes comments and strings", async () => {
  const source = `%token INT
%%
main: INT { ($startpos, $1); "$startpos"; {| $1 |}; (* $endpos *) $endpos }
%%
let plain = "$startpos"`;
  expect(await tokenizer.render("source.ocaml.menhir", source)).toMatchInlineSnapshot(`
    "1:0:6 "%token" keyword.other.menhir
    1:7:10 "INT" constant.other.token.menhir
    2:0:2 "%%" keyword.other.menhir
    3:0:4 "main" entity.name.function.rule.menhir
    3:4:5 ":" keyword.other.menhir
    3:6:9 "INT" constant.other.token.menhir
    3:10:11 "{" keyword.other.menhir
    3:11:12 " " source.embedded-action.menhir
    3:12:13 "(" source.embedded-action.menhir
    3:13:22 "$startpos" source.embedded-action.menhir keyword.other.menhir
    3:22:23 "," source.embedded-action.menhir keyword.other.ocaml punctuation.comma punctuation.separator.comma
    3:23:24 " " source.embedded-action.menhir
    3:24:26 "$1" source.embedded-action.menhir keyword.other.menhir
    3:26:27 ")" source.embedded-action.menhir
    3:27:28 ";" source.embedded-action.menhir keyword.other.ocaml punctuation.separator.terminator punctuation.separator.semicolon
    3:28:29 " " source.embedded-action.menhir
    3:29:30 "\\"" source.embedded-action.menhir string.quoted.double.ocaml
    3:30:39 "$startpos" source.embedded-action.menhir string.quoted.double.ocaml
    3:39:40 "\\"" source.embedded-action.menhir string.quoted.double.ocaml
    3:40:41 ";" source.embedded-action.menhir keyword.other.ocaml punctuation.separator.terminator punctuation.separator.semicolon
    3:41:42 " " source.embedded-action.menhir
    3:42:44 "{|" source.embedded-action.menhir string.quoted.braced.ocaml
    3:44:48 " $1 " source.embedded-action.menhir string.quoted.braced.ocaml
    3:48:50 "|}" source.embedded-action.menhir string.quoted.braced.ocaml
    3:50:51 ";" source.embedded-action.menhir keyword.other.ocaml punctuation.separator.terminator punctuation.separator.semicolon
    3:51:52 " " source.embedded-action.menhir
    3:52:54 "(*" source.embedded-action.menhir comment.block.ocaml
    3:54:63 " $endpos " source.embedded-action.menhir comment.block.ocaml
    3:63:65 "*)" source.embedded-action.menhir comment.block.ocaml
    3:65:66 " " source.embedded-action.menhir
    3:66:73 "$endpos" source.embedded-action.menhir keyword.other.menhir
    3:73:74 " " source.embedded-action.menhir
    3:74:75 "}" keyword.other.menhir
    4:0:2 "%%" keyword.other.menhir
    5:0:3 "let" keyword.ocaml
    5:4:9 "plain" entity.name.binding.ocaml
    5:10:11 "=" keyword.operator.ocaml
    5:12:13 "\\"" string.quoted.double.ocaml
    5:13:22 "$startpos" string.quoted.double.ocaml
    5:22:23 "\\"" string.quoted.double.ocaml"
  `);
});

// https://gallium.inria.fr/~fpottier/menhir/manual.html
test("Menhir header closes after type and class declarations", async () => {
  const source = `%{
type t = A | B
class c = object end
%}
%{ type u = int %}
%token EOF
%%
main: EOF { () }`;
  expect(await tokenizer.render("source.ocaml.menhir", source)).toMatchInlineSnapshot(`
    "1:0:2 "%{" keyword.other.menhir
    2:0:4 "type" keyword.ocaml
    2:5:6 "t" entity.name.type.ocaml
    2:7:8 "=" keyword.operator.ocaml
    2:9:10 "A" constant.language.capital-identifier.ocaml
    2:11:12 "|" keyword.other.ocaml
    2:13:14 "B" constant.language.capital-identifier.ocaml
    3:0:5 "class" keyword.ocaml
    3:6:7 "c" entity.name.type.class.ocaml
    3:8:9 "=" keyword.operator.ocaml
    3:10:16 "object" keyword.ocaml
    3:17:20 "end" keyword.ocaml
    4:0:2 "%}" keyword.other.menhir
    5:0:2 "%{" keyword.other.menhir
    5:3:7 "type" keyword.ocaml
    5:8:9 "u" entity.name.type.ocaml
    5:10:11 "=" keyword.operator.ocaml
    5:12:15 "int" source.ocaml
    5:16:18 "%}" keyword.other.menhir
    6:0:6 "%token" keyword.other.menhir
    6:7:10 "EOF" constant.other.token.menhir
    7:0:2 "%%" keyword.other.menhir
    8:0:4 "main" entity.name.function.rule.menhir
    8:4:5 ":" keyword.other.menhir
    8:6:9 "EOF" constant.other.token.menhir
    8:10:11 "{" keyword.other.menhir
    8:11:12 " " source.embedded-action.menhir
    8:12:14 "()" source.embedded-action.menhir constant.language.unit.ocaml
    8:14:15 " " source.embedded-action.menhir
    8:15:16 "}" keyword.other.menhir"
  `);
});

// https://gallium.inria.fr/~fpottier/menhir/manual.html
test("Menhir parameter annotations close after type constraints", async () => {
  const source = `%parameter <Ord : Map.OrderedType with type t = int>
%token <int> INT
%start <int> main
%%
main: INT { $1 }
%%
let max a b = if a > b then a else b`;
  expect(await tokenizer.render("source.ocaml.menhir", source)).toMatchInlineSnapshot(`
    "1:0:10 "%parameter" keyword.other.menhir
    1:11:12 "<" keyword.other.menhir
    1:12:15 "Ord" constant.language.capital-identifier.ocaml
    1:16:17 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    1:18:21 "Map" constant.language.capital-identifier.ocaml
    1:21:22 "." keyword.other.ocaml punctuation.other.period punctuation.separator.period
    1:22:33 "OrderedType" constant.language.capital-identifier.ocaml
    1:34:38 "with" keyword.other.ocaml
    1:39:43 "type" keyword.ocaml
    1:44:45 "t" entity.name.type.ocaml
    1:46:47 "=" keyword.operator.ocaml
    1:48:51 "int" source.ocaml
    1:51:52 ">" keyword.other.menhir
    2:0:6 "%token" keyword.other.menhir
    2:7:8 "<" keyword.other.menhir
    2:8:11 "int" source.ocaml
    2:11:12 ">" keyword.other.menhir
    2:13:16 "INT" constant.other.token.menhir
    3:0:6 "%start" keyword.other.menhir
    3:7:8 "<" keyword.other.menhir
    3:8:11 "int" source.ocaml
    3:11:12 ">" keyword.other.menhir
    3:13:17 "main" entity.name.function.rule.menhir
    4:0:2 "%%" keyword.other.menhir
    5:0:4 "main" entity.name.function.rule.menhir
    5:4:5 ":" keyword.other.menhir
    5:6:9 "INT" constant.other.token.menhir
    5:10:11 "{" keyword.other.menhir
    5:11:12 " " source.embedded-action.menhir
    5:12:14 "$1" source.embedded-action.menhir keyword.other.menhir
    5:14:15 " " source.embedded-action.menhir
    5:15:16 "}" keyword.other.menhir
    6:0:2 "%%" keyword.other.menhir
    7:0:3 "let" keyword.ocaml
    7:4:7 "max" entity.name.binding.ocaml
    7:8:9 "a" source.ocaml
    7:10:11 "b" source.ocaml
    7:12:13 "=" keyword.operator.ocaml
    7:14:16 "if" keyword.other.ocaml
    7:17:18 "a" source.ocaml
    7:19:20 ">" keyword.operator.ocaml
    7:21:22 "b" source.ocaml
    7:23:27 "then" keyword.other.ocaml
    7:28:29 "a" source.ocaml
    7:30:34 "else" keyword.other.ocaml
    7:35:36 "b" source.ocaml"
  `);
});
