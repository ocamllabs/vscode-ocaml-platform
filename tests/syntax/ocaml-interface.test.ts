import { afterAll, expect, test } from "bun:test";

import { createTokenizer } from "./tokenizer.ts";

const tokenizer = createTokenizer();
afterAll(() => tokenizer.dispose());

// https://ocaml.org/manual/5.5/typedecl.html
test("Multiline type groups", async () => {
  const source = `type first = int
(* declaration comment *)
and second = string
and ('a, +'b) third = 'a * 'b
val value : int`;
  expect(await tokenizer.render("source.ocaml.interface", source)).toMatchInlineSnapshot(`
    "1:0:4 "type" keyword.ocaml
    1:5:10 "first" entity.name.type.ocaml
    1:11:12 "=" keyword.operator.ocaml
    1:13:16 "int" support.type.ocaml
    2:0:2 "(*" comment.block.ocaml
    2:2:23 " declaration comment " comment.block.ocaml
    2:23:25 "*)" comment.block.ocaml
    3:0:3 "and" keyword.ocaml
    3:4:10 "second" entity.name.type.ocaml
    3:11:12 "=" keyword.operator.ocaml
    3:13:19 "string" support.type.ocaml
    4:0:3 "and" keyword.ocaml
    4:4:5 "("
    4:5:7 "'a" storage.type.ocaml
    4:7:8 "," keyword.other.ocaml punctuation.comma punctuation.separator.comma
    4:9:10 "+" keyword.operator.ocaml
    4:10:12 "'b" storage.type.ocaml
    4:12:13 ")"
    4:14:19 "third" entity.name.type.ocaml
    4:20:21 "=" keyword.operator.ocaml
    4:22:24 "'a" storage.type.ocaml
    4:25:26 "*" keyword.operator.ocaml
    4:27:29 "'b" storage.type.ocaml
    5:0:3 "val" keyword.ocaml
    5:4:9 "value" entity.name.binding.ocaml
    5:10:11 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    5:12:15 "int" support.type.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/typedecl.html
test("Type headers tolerate comments attributes and raw names", async () => {
  const source = `type[@warning "-34"] (* header *)
  \\#type = int
and (* continuation *) [@warning "-34"]
  \\#and = string`;
  expect(await tokenizer.render("source.ocaml.interface", source)).toMatchInlineSnapshot(`
    "1:0:4 "type" keyword.ocaml
    1:4:5 "["
    1:5:6 "@" keyword.operator.attribute.ocaml
    1:6:13 "warning" keyword.other.attribute.ocaml
    1:14:15 "\\"" string.quoted.double.ocaml
    1:15:18 "-34" string.quoted.double.ocaml
    1:18:19 "\\"" string.quoted.double.ocaml
    1:19:20 "]"
    1:21:23 "(*" comment.block.ocaml
    1:23:31 " header " comment.block.ocaml
    1:31:33 "*)" comment.block.ocaml
    2:2:8 "\\\\#type" entity.name.type.ocaml
    2:9:10 "=" keyword.operator.ocaml
    2:11:14 "int" support.type.ocaml
    3:0:3 "and" keyword.ocaml
    3:4:6 "(*" comment.block.ocaml
    3:6:20 " continuation " comment.block.ocaml
    3:20:22 "*)" comment.block.ocaml
    3:23:24 "["
    3:24:25 "@" keyword.operator.attribute.ocaml
    3:25:32 "warning" keyword.other.attribute.ocaml
    3:33:34 "\\"" string.quoted.double.ocaml
    3:34:37 "-34" string.quoted.double.ocaml
    3:37:38 "\\"" string.quoted.double.ocaml
    3:38:39 "]"
    4:2:7 "\\\\#and" entity.name.type.ocaml
    4:8:9 "=" keyword.operator.ocaml
    4:10:16 "string" support.type.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/typedecl.html
test("Type bodies isolate nested constraints and attribute values", async () => {
  const source = `type first = (module S with type inner = int and type another = string)
and second = A of { field : int }
[@@example let payload = 1 and sibling = 2]
and third = string`;
  expect(await tokenizer.render("source.ocaml.interface", source)).toMatchInlineSnapshot(`
    "1:0:4 "type" keyword.ocaml
    1:5:10 "first" entity.name.type.ocaml
    1:11:12 "=" keyword.operator.ocaml
    1:13:14 "("
    1:14:20 "module" keyword.other.ocaml
    1:21:22 "S" constant.language.capital-identifier.ocaml
    1:23:27 "with" keyword.other.ocaml
    1:28:32 "type" keyword.ocaml
    1:33:38 "inner" entity.name.type.ocaml
    1:39:40 "=" keyword.operator.ocaml
    1:41:44 "int" support.type.ocaml
    1:45:48 "and" keyword.ocaml
    1:49:53 "type" keyword.ocaml
    1:54:61 "another" entity.name.type.ocaml
    1:62:63 "=" keyword.operator.ocaml
    1:64:70 "string" support.type.ocaml
    1:70:71 ")"
    2:0:3 "and" keyword.ocaml
    2:4:10 "second" entity.name.type.ocaml
    2:11:12 "=" keyword.operator.ocaml
    2:13:14 "A" constant.language.capital-identifier.ocaml
    2:15:17 "of" keyword.other.ocaml
    2:18:19 "{"
    2:20:25 "field" source.ocaml
    2:26:27 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    2:28:31 "int" support.type.ocaml
    2:32:33 "}"
    3:0:1 "["
    3:1:3 "@@" keyword.operator.attribute.ocaml
    3:3:10 "example" keyword.other.attribute.ocaml
    3:11:14 "let" keyword.ocaml
    3:15:22 "payload" entity.name.binding.ocaml
    3:23:24 "=" keyword.operator.ocaml
    3:25:26 "1" constant.numeric.decimal.integer.ocaml
    3:27:30 "and" keyword.ocaml
    3:31:38 "sibling" entity.name.binding.ocaml
    3:39:40 "=" keyword.operator.ocaml
    3:41:42 "2" constant.numeric.decimal.integer.ocaml
    3:42:43 "]"
    4:0:3 "and" keyword.ocaml
    4:4:9 "third" entity.name.type.ocaml
    4:10:11 "=" keyword.operator.ocaml
    4:12:18 "string" support.type.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/typedecl.html
test("Explicit module type constraints retain type roles", async () => {
  const source = `module type T = S with type first = int
and type second = string
and module N = M
module type U = sig type inner = int and other = string end`;
  expect(await tokenizer.render("source.ocaml.interface", source)).toMatchInlineSnapshot(`
    "1:0:6 "module" keyword.other.ocaml.interface
    1:7:11 "type" keyword.ocaml
    1:12:13 "T" constant.language.capital-identifier.ocaml
    1:14:15 "=" keyword.operator.ocaml
    1:16:17 "S" constant.language.capital-identifier.ocaml
    1:18:22 "with" keyword.other.ocaml
    1:23:27 "type" keyword.ocaml
    1:28:33 "first" entity.name.type.ocaml
    1:34:35 "=" keyword.operator.ocaml
    1:36:39 "int" support.type.ocaml
    2:0:3 "and" keyword.ocaml
    2:4:8 "type" keyword.ocaml
    2:9:15 "second" entity.name.type.ocaml
    2:16:17 "=" keyword.operator.ocaml
    2:18:24 "string" support.type.ocaml
    3:0:3 "and" keyword.other.ocaml.interface
    3:4:10 "module" keyword.other.ocaml.interface
    3:11:12 "N" constant.language.capital-identifier.ocaml
    3:13:14 "=" keyword.operator.ocaml
    3:15:16 "M" constant.language.capital-identifier.ocaml
    4:0:6 "module" keyword.other.ocaml.interface
    4:7:11 "type" keyword.ocaml
    4:12:13 "U" constant.language.capital-identifier.ocaml
    4:14:15 "=" keyword.operator.ocaml
    4:16:19 "sig" keyword.ocaml
    4:20:24 "type" keyword.ocaml
    4:25:30 "inner" entity.name.type.ocaml
    4:31:32 "=" keyword.operator.ocaml
    4:33:36 "int" support.type.ocaml
    4:37:40 "and" keyword.ocaml
    4:41:46 "other" entity.name.type.ocaml
    4:47:48 "=" keyword.operator.ocaml
    4:49:55 "string" support.type.ocaml
    4:56:59 "end" keyword.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/classes.html
test("Class and class type multiline groups", async () => {
  const source = `class first : object method read : int end
and second : object method read : int end
class type initial = object method get : int end
and subsequent = object method get : int end
val value : int`;
  expect(await tokenizer.render("source.ocaml.interface", source)).toMatchInlineSnapshot(`
    "1:0:5 "class" keyword.ocaml
    1:6:11 "first" entity.name.type.class.ocaml
    1:12:13 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    1:14:20 "object" keyword.ocaml
    1:21:27 "method" keyword.ocaml
    1:28:32 "read" entity.name.function.method.ocaml
    1:33:34 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    1:35:38 "int" source.ocaml
    1:39:42 "end" keyword.ocaml
    2:0:3 "and" keyword.ocaml
    2:4:10 "second" entity.name.type.class.ocaml
    2:11:12 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    2:13:19 "object" keyword.ocaml
    2:20:26 "method" keyword.ocaml
    2:27:31 "read" entity.name.function.method.ocaml
    2:32:33 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    2:34:37 "int" source.ocaml
    2:38:41 "end" keyword.ocaml
    3:0:5 "class" keyword.ocaml
    3:6:10 "type" keyword.ocaml
    3:11:18 "initial" entity.name.type.class.ocaml
    3:19:20 "=" keyword.operator.ocaml
    3:21:27 "object" keyword.ocaml
    3:28:34 "method" keyword.ocaml
    3:35:38 "get" entity.name.function.method.ocaml
    3:39:40 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    3:41:44 "int" source.ocaml
    3:45:48 "end" keyword.ocaml
    4:0:3 "and" keyword.ocaml
    4:4:14 "subsequent" entity.name.type.class.ocaml
    4:15:16 "=" keyword.operator.ocaml
    4:17:23 "object" keyword.ocaml
    4:24:30 "method" keyword.ocaml
    4:31:34 "get" entity.name.function.method.ocaml
    4:35:36 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    4:37:40 "int" source.ocaml
    4:41:44 "end" keyword.ocaml
    5:0:3 "val" keyword.ocaml
    5:4:9 "value" entity.name.binding.ocaml
    5:10:11 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    5:12:15 "int" support.type.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/classes.html
test("Class headers carry type parameters and attributes", async () => {
  const source = `class type [@warning "-34"] virtual ['a] first = object method get : 'a end
and (* next *) virtual ['a] \\#class = object method get : 'a end`;
  expect(await tokenizer.render("source.ocaml.interface", source)).toMatchInlineSnapshot(`
    "1:0:5 "class" keyword.ocaml
    1:6:10 "type" keyword.ocaml
    1:11:12 "["
    1:12:13 "@" keyword.operator.attribute.ocaml
    1:13:20 "warning" keyword.other.attribute.ocaml
    1:21:22 "\\"" string.quoted.double.ocaml
    1:22:25 "-34" string.quoted.double.ocaml
    1:25:26 "\\"" string.quoted.double.ocaml
    1:26:27 "]"
    1:28:35 "virtual" keyword.ocaml
    1:36:37 "["
    1:37:39 "'a" storage.type.ocaml
    1:39:40 "]"
    1:41:46 "first" entity.name.type.class.ocaml
    1:47:48 "=" keyword.operator.ocaml
    1:49:55 "object" keyword.ocaml
    1:56:62 "method" keyword.ocaml
    1:63:66 "get" entity.name.function.method.ocaml
    1:67:68 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    1:69:71 "'a" storage.type.ocaml
    1:72:75 "end" keyword.ocaml
    2:0:3 "and" keyword.ocaml
    2:4:6 "(*" comment.block.ocaml
    2:6:12 " next " comment.block.ocaml
    2:12:14 "*)" comment.block.ocaml
    2:15:22 "virtual" keyword.ocaml
    2:23:24 "["
    2:24:26 "'a" storage.type.ocaml
    2:26:27 "]"
    2:28:35 "\\\\#class" entity.name.type.class.ocaml
    2:36:37 "=" keyword.operator.ocaml
    2:38:44 "object" keyword.ocaml
    2:45:51 "method" keyword.ocaml
    2:52:55 "get" entity.name.function.method.ocaml
    2:56:57 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    2:58:60 "'a" storage.type.ocaml
    2:61:64 "end" keyword.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/extensionnodes.html
test("Keyword extensions keep extension identifiers", async () => {
  const source = `type%foo first = int and second = string
class type%bar first_class = object end and second_class = object end`;
  expect(await tokenizer.render("source.ocaml.interface", source)).toMatchInlineSnapshot(`
    "1:0:4 "type" keyword.ocaml
    1:4:5 "%" keyword.operator.extension.ocaml
    1:5:8 "foo" keyword.other.extension.ocaml
    1:9:14 "first" entity.name.type.ocaml
    1:15:16 "=" keyword.operator.ocaml
    1:17:20 "int" support.type.ocaml
    1:21:24 "and" keyword.ocaml
    1:25:31 "second" entity.name.type.ocaml
    1:32:33 "=" keyword.operator.ocaml
    1:34:40 "string" support.type.ocaml
    2:0:5 "class" keyword.ocaml
    2:6:10 "type" keyword.ocaml
    2:10:11 "%" keyword.operator.extension.ocaml
    2:11:14 "bar" keyword.other.extension.ocaml
    2:15:26 "first_class" entity.name.type.class.ocaml
    2:27:28 "=" keyword.operator.ocaml
    2:29:35 "object" keyword.ocaml
    2:36:39 "end" keyword.ocaml
    2:40:43 "and" keyword.ocaml
    2:44:56 "second_class" entity.name.type.class.ocaml
    2:57:58 "=" keyword.operator.ocaml
    2:59:65 "object" keyword.ocaml
    2:66:69 "end" keyword.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/typedecl.html
test("Type parameter variance keeps operator scopes", async () => {
  const source = "type +'a first = 'a list and -'b second = 'b -> unit";
  expect(await tokenizer.render("source.ocaml.interface", source)).toMatchInlineSnapshot(`
    "1:0:4 "type" keyword.ocaml
    1:5:6 "+" keyword.operator.ocaml
    1:6:8 "'a" storage.type.ocaml
    1:9:14 "first" entity.name.type.ocaml
    1:15:16 "=" keyword.operator.ocaml
    1:17:19 "'a" storage.type.ocaml
    1:20:24 "list" source.ocaml
    1:25:28 "and" keyword.ocaml
    1:29:30 "-" keyword.operator.ocaml
    1:30:32 "'b" storage.type.ocaml
    1:33:39 "second" entity.name.type.ocaml
    1:40:41 "=" keyword.operator.ocaml
    1:42:44 "'b" storage.type.ocaml
    1:45:47 "->" keyword.operator.ocaml
    1:48:52 "unit" support.type.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/generalizedopens.html
test("Class local opens keep keyword scopes", async () => {
  const source = `class type first = let open M in base and second = object end
class type third = let open! M in base and fourth = object end
class type fifth = let (* comment *) open! M in base and sixth = object end`;
  expect(await tokenizer.render("source.ocaml.interface", source)).toMatchInlineSnapshot(`
    "1:0:5 "class" keyword.ocaml
    1:6:10 "type" keyword.ocaml
    1:11:16 "first" entity.name.type.class.ocaml
    1:17:18 "=" keyword.operator.ocaml
    1:19:22 "let" keyword.ocaml
    1:23:27 "open" keyword.other.ocaml
    1:28:29 "M" constant.language.capital-identifier.ocaml
    1:30:32 "in" keyword.ocaml
    1:33:37 "base" source.ocaml
    1:38:41 "and" keyword.ocaml
    1:42:48 "second" entity.name.type.class.ocaml
    1:49:50 "=" keyword.operator.ocaml
    1:51:57 "object" keyword.ocaml
    1:58:61 "end" keyword.ocaml
    2:0:5 "class" keyword.ocaml
    2:6:10 "type" keyword.ocaml
    2:11:16 "third" entity.name.type.class.ocaml
    2:17:18 "=" keyword.operator.ocaml
    2:19:22 "let" keyword.ocaml
    2:23:27 "open" keyword.other.ocaml
    2:27:28 "!" keyword.operator.ocaml
    2:29:30 "M" constant.language.capital-identifier.ocaml
    2:31:33 "in" keyword.ocaml
    2:34:38 "base" source.ocaml
    2:39:42 "and" keyword.ocaml
    2:43:49 "fourth" entity.name.type.class.ocaml
    2:50:51 "=" keyword.operator.ocaml
    2:52:58 "object" keyword.ocaml
    2:59:62 "end" keyword.ocaml
    3:0:5 "class" keyword.ocaml
    3:6:10 "type" keyword.ocaml
    3:11:16 "fifth" entity.name.type.class.ocaml
    3:17:18 "=" keyword.operator.ocaml
    3:19:22 "let" keyword.ocaml
    3:23:25 "(*" comment.block.ocaml
    3:25:34 " comment " comment.block.ocaml
    3:34:36 "*)" comment.block.ocaml
    3:37:41 "open" keyword.other.ocaml
    3:41:42 "!" keyword.operator.ocaml
    3:43:44 "M" constant.language.capital-identifier.ocaml
    3:45:47 "in" keyword.ocaml
    3:48:52 "base" source.ocaml
    3:53:56 "and" keyword.ocaml
    3:57:62 "sixth" entity.name.type.class.ocaml
    3:63:64 "=" keyword.operator.ocaml
    3:65:71 "object" keyword.ocaml
    3:72:75 "end" keyword.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/lex.html
test("Interface raw identifiers and attribute payload", async () => {
  const source = `val \\#effect : int
[@@@foo2 "hello" 42]`;
  expect(await tokenizer.render("source.ocaml.interface", source)).toMatchInlineSnapshot(`
    "1:0:3 "val" keyword.ocaml
    1:4:12 "\\\\#effect" entity.name.binding.ocaml
    1:13:14 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    1:15:18 "int" support.type.ocaml
    2:0:1 "["
    2:1:4 "@@@" keyword.operator.attribute.ocaml
    2:4:8 "foo2" keyword.other.attribute.ocaml
    2:9:10 "\\"" string.quoted.double.ocaml
    2:10:15 "hello" string.quoted.double.ocaml
    2:15:16 "\\"" string.quoted.double.ocaml
    2:17:19 "42" constant.numeric.decimal.integer.ocaml
    2:19:20 "]""
  `);
});

// https://ocaml.org/manual/5.5/types.html
test("Type names remain identifiers", async () => {
  const source = `val int : int
val value : int
val f : 'ab' -> '_weak'`;
  expect(await tokenizer.render("source.ocaml.interface", source)).toMatchInlineSnapshot(`
    "1:0:3 "val" keyword.ocaml
    1:4:7 "int" entity.name.binding.ocaml
    1:8:9 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    1:10:13 "int" support.type.ocaml
    2:0:3 "val" keyword.ocaml
    2:4:9 "value" entity.name.binding.ocaml
    2:10:11 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    2:12:15 "int" support.type.ocaml
    3:0:3 "val" keyword.ocaml
    3:4:5 "f" entity.name.function.binding.ocaml
    3:6:7 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    3:8:12 "'ab'" storage.type.ocaml
    3:13:15 "->" keyword.operator.ocaml
    3:16:23 "'_weak'" storage.type.weak.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/external.html
test("Operator external declarations preserve primitive strings in interfaces", async () => {
  const source = `external ( + ) : int -> int -> int = "%addint"
val value : int`;
  expect(await tokenizer.render("source.ocaml.interface", source)).toMatchInlineSnapshot(`
    "1:0:8 "external" keyword.ocaml
    1:9:11 "( "
    1:11:12 "+" keyword.operator.ocaml
    1:12:15 " ) "
    1:15:16 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    1:17:20 "int" support.type.ocaml
    1:21:23 "->" keyword.operator.ocaml
    1:24:27 "int" support.type.ocaml
    1:28:30 "->" keyword.operator.ocaml
    1:31:34 "int" support.type.ocaml
    1:35:36 "=" keyword.operator.ocaml
    1:37:38 "\\"" string.quoted.double.ocaml
    1:38:45 "%addint" string.quoted.double.ocaml
    1:45:46 "\\"" string.quoted.double.ocaml
    2:0:3 "val" keyword.ocaml
    2:4:9 "value" entity.name.binding.ocaml
    2:10:11 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    2:12:15 "int" support.type.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/typedecl.html
test("Declaration roles", async () => {
  const source = `type \\#type = int
class c : object method m : int end
class type ct = object method m : int end
val value : int
external primitive : int -> int = "primitive"
type first = int and second = string`;
  expect(await tokenizer.render("source.ocaml.interface", source)).toMatchInlineSnapshot(`
    "1:0:4 "type" keyword.ocaml
    1:5:11 "\\\\#type" entity.name.type.ocaml
    1:12:13 "=" keyword.operator.ocaml
    1:14:17 "int" support.type.ocaml
    2:0:5 "class" keyword.ocaml
    2:6:7 "c" entity.name.type.class.ocaml
    2:8:9 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    2:10:16 "object" keyword.ocaml
    2:17:23 "method" keyword.ocaml
    2:24:25 "m" entity.name.function.method.ocaml
    2:26:27 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    2:28:31 "int" source.ocaml
    2:32:35 "end" keyword.ocaml
    3:0:5 "class" keyword.ocaml
    3:6:10 "type" keyword.ocaml
    3:11:13 "ct" entity.name.type.class.ocaml
    3:14:15 "=" keyword.operator.ocaml
    3:16:22 "object" keyword.ocaml
    3:23:29 "method" keyword.ocaml
    3:30:31 "m" entity.name.function.method.ocaml
    3:32:33 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    3:34:37 "int" source.ocaml
    3:38:41 "end" keyword.ocaml
    4:0:3 "val" keyword.ocaml
    4:4:9 "value" entity.name.binding.ocaml
    4:10:11 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    4:12:15 "int" support.type.ocaml
    5:0:8 "external" keyword.ocaml
    5:9:18 "primitive" entity.name.function.binding.ocaml
    5:19:20 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    5:21:24 "int" support.type.ocaml
    5:25:27 "->" keyword.operator.ocaml
    5:28:31 "int" support.type.ocaml
    5:32:33 "=" keyword.operator.ocaml
    5:34:35 "\\"" string.quoted.double.ocaml
    5:35:44 "primitive" string.quoted.double.ocaml
    5:44:45 "\\"" string.quoted.double.ocaml
    6:0:4 "type" keyword.ocaml
    6:5:10 "first" entity.name.type.ocaml
    6:11:12 "=" keyword.operator.ocaml
    6:13:16 "int" support.type.ocaml
    6:17:20 "and" keyword.ocaml
    6:21:27 "second" entity.name.type.ocaml
    6:28:29 "=" keyword.operator.ocaml
    6:30:36 "string" support.type.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/ocamldoc.html
test("Doc comment class examples use OCaml scopes", async () => {
  const source = `(** {[
class c = object method m = if x then 1 else 2 end
]} *)
val x : int`;
  expect(await tokenizer.render("source.ocaml.interface", source)).toMatchInlineSnapshot(`
    "1:0:3 "(**" comment.doc.ocaml
    1:3:4 " " comment.doc.ocaml
    1:4:6 "{[" comment.doc.ocaml markup.inline.raw.ocamldoc
    2:0:5 "class" comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.ocaml
    2:5:6 " " comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:6:7 "c" comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc entity.name.type.class.ocaml
    2:7:8 " " comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:8:9 "=" comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.operator.ocaml
    2:9:10 " " comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:10:16 "object" comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.ocaml
    2:16:17 " " comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:17:23 "method" comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.ocaml
    2:23:24 " " comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:24:25 "m" comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc entity.name.function.method.ocaml
    2:25:26 " " comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:26:27 "=" comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.operator.ocaml
    2:27:28 " " comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:28:30 "if" comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.other.ocaml
    2:30:31 " " comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:31:32 "x" comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc source.ocaml
    2:32:33 " " comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:33:37 "then" comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.other.ocaml
    2:37:38 " " comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:38:39 "1" comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc constant.numeric.decimal.integer.ocaml
    2:39:40 " " comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:40:44 "else" comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.other.ocaml
    2:44:45 " " comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:45:46 "2" comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc constant.numeric.decimal.integer.ocaml
    2:46:47 " " comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:47:50 "end" comment.doc.ocaml markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.ocaml
    3:0:2 "]}" comment.doc.ocaml markup.inline.raw.ocamldoc
    3:2:3 " " comment.doc.ocaml
    3:3:5 "*)" comment.doc.ocaml
    4:0:3 "val" keyword.ocaml
    4:4:5 "x" entity.name.binding.ocaml
    4:6:7 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    4:8:11 "int" support.type.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/modtypes.html
test("Value specifications use function scopes for arrow types", async () => {
  const source = `val f : int -> string
val g : string:int -> ?y:bytes -> unit
val v : int
val s : M.string list
val l :
  int -> int
external e : float -> float = "e"`;
  expect(await tokenizer.render("source.ocaml.interface", source)).toMatchInlineSnapshot(`
    "1:0:3 "val" keyword.ocaml
    1:4:5 "f" entity.name.function.binding.ocaml
    1:6:7 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    1:8:11 "int" support.type.ocaml
    1:12:14 "->" keyword.operator.ocaml
    1:15:21 "string" support.type.ocaml
    2:0:3 "val" keyword.ocaml
    2:4:5 "g" entity.name.function.binding.ocaml
    2:6:7 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    2:8:14 "string" source.ocaml
    2:14:15 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    2:15:18 "int" support.type.ocaml
    2:19:21 "->" keyword.operator.ocaml
    2:22:24 "?y" variable.parameter.optional.ocaml
    2:24:25 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    2:25:30 "bytes" support.type.ocaml
    2:31:33 "->" keyword.operator.ocaml
    2:34:38 "unit" support.type.ocaml
    3:0:3 "val" keyword.ocaml
    3:4:5 "v" entity.name.binding.ocaml
    3:6:7 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    3:8:11 "int" support.type.ocaml
    4:0:3 "val" keyword.ocaml
    4:4:5 "s" entity.name.binding.ocaml
    4:6:7 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    4:8:9 "M" constant.language.capital-identifier.ocaml
    4:9:10 "." keyword.other.ocaml punctuation.other.period punctuation.separator.period
    4:10:16 "string" source.ocaml
    4:17:21 "list" source.ocaml
    5:0:3 "val" keyword.ocaml
    5:4:5 "l" entity.name.binding.ocaml
    5:6:7 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    6:2:5 "int" support.type.ocaml
    6:6:8 "->" keyword.operator.ocaml
    6:9:12 "int" support.type.ocaml
    7:0:8 "external" keyword.ocaml
    7:9:10 "e" entity.name.function.binding.ocaml
    7:11:12 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    7:13:18 "float" support.type.ocaml
    7:19:21 "->" keyword.operator.ocaml
    7:22:27 "float" support.type.ocaml
    7:28:29 "=" keyword.operator.ocaml
    7:30:31 "\\"" string.quoted.double.ocaml
    7:31:32 "e" string.quoted.double.ocaml
    7:32:33 "\\"" string.quoted.double.ocaml"
  `);
});
