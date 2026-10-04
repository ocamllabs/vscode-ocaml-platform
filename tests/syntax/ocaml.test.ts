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
let value = 1 and peer = 2`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:4 "type" keyword.ocaml
    1:5:10 "first" entity.name.type.ocaml
    1:11:12 "=" keyword.operator.ocaml
    1:13:16 "int" source.ocaml
    2:0:2 "(*" comment.block.ocaml
    2:2:23 " declaration comment " comment.block.ocaml
    2:23:25 "*)" comment.block.ocaml
    3:0:3 "and" keyword.ocaml
    3:4:10 "second" entity.name.type.ocaml
    3:11:12 "=" keyword.operator.ocaml
    3:13:19 "string" source.ocaml
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
    5:0:3 "let" keyword.ocaml
    5:4:9 "value" entity.name.binding.ocaml
    5:10:11 "=" keyword.operator.ocaml
    5:12:13 "1" constant.numeric.decimal.integer.ocaml
    5:14:17 "and" keyword.ocaml
    5:18:22 "peer" entity.name.binding.ocaml
    5:23:24 "=" keyword.operator.ocaml
    5:25:26 "2" constant.numeric.decimal.integer.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/typedecl.html
test("Type headers tolerate comments attributes and raw names", async () => {
  const source = `type[@warning "-34"] (* header *)
  \\#type = int
and (* continuation *) [@warning "-34"]
  \\#and = string`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
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
    2:11:14 "int" source.ocaml
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
    4:10:16 "string" source.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/typedecl.html
test("Type bodies isolate nested constraints and attribute values", async () => {
  const source = `type first = (module S with type inner = int and type another = string)
and second = A of { field : int }
[@@example let payload = 1 and sibling = 2]
and third = string`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
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
    1:41:44 "int" source.ocaml
    1:45:48 "and" keyword.ocaml
    1:49:53 "type" keyword.ocaml
    1:54:61 "another" entity.name.type.ocaml
    1:62:63 "=" keyword.operator.ocaml
    1:64:70 "string" source.ocaml
    1:70:71 ")"
    2:0:3 "and" keyword.ocaml
    2:4:10 "second" entity.name.type.ocaml
    2:11:12 "=" keyword.operator.ocaml
    2:13:14 "A" constant.language.capital-identifier.ocaml
    2:15:17 "of" keyword.other.ocaml
    2:18:19 "{"
    2:20:25 "field" source.ocaml
    2:26:27 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    2:28:31 "int" source.ocaml
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
    4:12:18 "string" source.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/typedecl.html
test("Explicit module type constraints retain type roles", async () => {
  const source = `module type T = S with type first = int
and type second = string
and module N = M
module type U = sig type inner = int and other = string end`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:6 "module" keyword.other.ocaml
    1:7:11 "type" keyword.ocaml
    1:12:13 "T" constant.language.capital-identifier.ocaml
    1:14:15 "=" keyword.operator.ocaml
    1:16:17 "S" constant.language.capital-identifier.ocaml
    1:18:22 "with" keyword.other.ocaml
    1:23:27 "type" keyword.ocaml
    1:28:33 "first" entity.name.type.ocaml
    1:34:35 "=" keyword.operator.ocaml
    1:36:39 "int" source.ocaml
    2:0:3 "and" keyword.ocaml
    2:4:8 "type" keyword.ocaml
    2:9:15 "second" entity.name.type.ocaml
    2:16:17 "=" keyword.operator.ocaml
    2:18:24 "string" source.ocaml
    3:0:3 "and" keyword.other.ocaml
    3:4:10 "module" keyword.other.ocaml
    3:11:12 "N" constant.language.capital-identifier.ocaml
    3:13:14 "=" keyword.operator.ocaml
    3:15:16 "M" constant.language.capital-identifier.ocaml
    4:0:6 "module" keyword.other.ocaml
    4:7:11 "type" keyword.ocaml
    4:12:13 "U" constant.language.capital-identifier.ocaml
    4:14:15 "=" keyword.operator.ocaml
    4:16:19 "sig" keyword.ocaml
    4:20:24 "type" keyword.ocaml
    4:25:30 "inner" entity.name.type.ocaml
    4:31:32 "=" keyword.operator.ocaml
    4:33:36 "int" source.ocaml
    4:37:40 "and" keyword.ocaml
    4:41:46 "other" entity.name.type.ocaml
    4:47:48 "=" keyword.operator.ocaml
    4:49:55 "string" source.ocaml
    4:56:59 "end" keyword.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/classes.html
test("Class and class type multiline groups", async () => {
  const source = `class first = object method read = 1 end
and second = object method read = 2 end
class type initial = object method get : int end
and subsequent = object method get : int end
let value = 1 and peer = 2`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:5 "class" keyword.ocaml
    1:6:11 "first" entity.name.type.class.ocaml
    1:12:13 "=" keyword.operator.ocaml
    1:14:20 "object" keyword.ocaml
    1:21:27 "method" keyword.ocaml
    1:28:32 "read" entity.name.function.method.ocaml
    1:33:34 "=" keyword.operator.ocaml
    1:35:36 "1" constant.numeric.decimal.integer.ocaml
    1:37:40 "end" keyword.ocaml
    2:0:3 "and" keyword.ocaml
    2:4:10 "second" entity.name.type.class.ocaml
    2:11:12 "=" keyword.operator.ocaml
    2:13:19 "object" keyword.ocaml
    2:20:26 "method" keyword.ocaml
    2:27:31 "read" entity.name.function.method.ocaml
    2:32:33 "=" keyword.operator.ocaml
    2:34:35 "2" constant.numeric.decimal.integer.ocaml
    2:36:39 "end" keyword.ocaml
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
    5:0:3 "let" keyword.ocaml
    5:4:9 "value" entity.name.binding.ocaml
    5:10:11 "=" keyword.operator.ocaml
    5:12:13 "1" constant.numeric.decimal.integer.ocaml
    5:14:17 "and" keyword.ocaml
    5:18:22 "peer" entity.name.binding.ocaml
    5:23:24 "=" keyword.operator.ocaml
    5:25:26 "2" constant.numeric.decimal.integer.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/classes.html
test("Class headers carry type parameters and attributes", async () => {
  const source = `class type [@warning "-34"] virtual ['a] first = object method get : 'a end
and (* next *) virtual ['a] \\#class = object method get : 'a end`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
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

// https://ocaml.org/manual/5.5/classes.html
test("Class local let bindings stay neutral", async () => {
  const source = `class first =
  let helper = 1 and sibling = 2 in
  object method read = helper end
and second = object end
let value = 1 and peer = 2`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:5 "class" keyword.ocaml
    1:6:11 "first" entity.name.type.class.ocaml
    1:12:13 "=" keyword.operator.ocaml
    2:2:5 "let" keyword.ocaml
    2:6:12 "helper" entity.name.binding.ocaml
    2:13:14 "=" keyword.operator.ocaml
    2:15:16 "1" constant.numeric.decimal.integer.ocaml
    2:17:20 "and" keyword.ocaml
    2:21:28 "sibling" entity.name.binding.ocaml
    2:29:30 "=" keyword.operator.ocaml
    2:31:32 "2" constant.numeric.decimal.integer.ocaml
    2:33:35 "in" keyword.ocaml
    3:2:8 "object" keyword.ocaml
    3:9:15 "method" keyword.ocaml
    3:16:20 "read" entity.name.function.method.ocaml
    3:21:22 "=" keyword.operator.ocaml
    3:23:29 "helper" source.ocaml
    3:30:33 "end" keyword.ocaml
    4:0:3 "and" keyword.ocaml
    4:4:10 "second" entity.name.type.class.ocaml
    4:11:12 "=" keyword.operator.ocaml
    4:13:19 "object" keyword.ocaml
    4:20:23 "end" keyword.ocaml
    5:0:3 "let" keyword.ocaml
    5:4:9 "value" entity.name.binding.ocaml
    5:10:11 "=" keyword.operator.ocaml
    5:12:13 "1" constant.numeric.decimal.integer.ocaml
    5:14:17 "and" keyword.ocaml
    5:18:22 "peer" entity.name.binding.ocaml
    5:23:24 "=" keyword.operator.ocaml
    5:25:26 "2" constant.numeric.decimal.integer.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/classes.html
test("Class nested let and object bodies suspend continuation roles", async () => {
  const source = `class first = let helper = (let value = 1 and local_peer = 2 in value)
and sibling = 2 in object
method read = let method_val = 1 and method_peer = 2 in method_val
end and second = object end`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:5 "class" keyword.ocaml
    1:6:11 "first" entity.name.type.class.ocaml
    1:12:13 "=" keyword.operator.ocaml
    1:14:17 "let" keyword.ocaml
    1:18:24 "helper" entity.name.binding.ocaml
    1:25:26 "=" keyword.operator.ocaml
    1:27:28 "("
    1:28:31 "let" keyword.ocaml
    1:32:37 "value" entity.name.binding.ocaml
    1:38:39 "=" keyword.operator.ocaml
    1:40:41 "1" constant.numeric.decimal.integer.ocaml
    1:42:45 "and" keyword.ocaml
    1:46:56 "local_peer" entity.name.binding.ocaml
    1:57:58 "=" keyword.operator.ocaml
    1:59:60 "2" constant.numeric.decimal.integer.ocaml
    1:61:63 "in" keyword.other.ocaml
    1:64:69 "value" source.ocaml
    1:69:70 ")"
    2:0:3 "and" keyword.ocaml
    2:4:11 "sibling" entity.name.binding.ocaml
    2:12:13 "=" keyword.operator.ocaml
    2:14:15 "2" constant.numeric.decimal.integer.ocaml
    2:16:18 "in" keyword.ocaml
    2:19:25 "object" keyword.ocaml
    3:0:6 "method" keyword.ocaml
    3:7:11 "read" entity.name.function.method.ocaml
    3:12:13 "=" keyword.operator.ocaml
    3:14:17 "let" keyword.ocaml
    3:18:28 "method_val" entity.name.binding.ocaml
    3:29:30 "=" keyword.operator.ocaml
    3:31:32 "1" constant.numeric.decimal.integer.ocaml
    3:33:36 "and" keyword.ocaml
    3:37:48 "method_peer" entity.name.binding.ocaml
    3:49:50 "=" keyword.operator.ocaml
    3:51:52 "2" constant.numeric.decimal.integer.ocaml
    3:53:55 "in" keyword.other.ocaml
    3:56:66 "method_val" source.ocaml
    4:0:3 "end" keyword.ocaml
    4:4:7 "and" keyword.ocaml
    4:8:14 "second" entity.name.type.class.ocaml
    4:15:16 "=" keyword.operator.ocaml
    4:17:23 "object" keyword.ocaml
    4:24:27 "end" keyword.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/typedecl.html
test("Class local modules isolate declaration groups", async () => {
  const source = `class first = let helper = (let module M = struct
type inner = int and another = string
let value = 1 and peer = 2
end in M.value) in object end
and second = object end`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:5 "class" keyword.ocaml
    1:6:11 "first" entity.name.type.class.ocaml
    1:12:13 "=" keyword.operator.ocaml
    1:14:17 "let" keyword.ocaml
    1:18:24 "helper" entity.name.binding.ocaml
    1:25:26 "=" keyword.operator.ocaml
    1:27:28 "("
    1:28:31 "let" keyword.ocaml
    1:32:38 "module" keyword.ocaml
    1:39:40 "M" constant.language.capital-identifier.ocaml
    1:41:42 "=" keyword.operator.ocaml
    1:43:49 "struct" keyword.other.ocaml
    2:0:4 "type" keyword.ocaml
    2:5:10 "inner" entity.name.type.ocaml
    2:11:12 "=" keyword.operator.ocaml
    2:13:16 "int" source.ocaml
    2:17:20 "and" keyword.ocaml
    2:21:28 "another" entity.name.type.ocaml
    2:29:30 "=" keyword.operator.ocaml
    2:31:37 "string" source.ocaml
    3:0:3 "let" keyword.ocaml
    3:4:9 "value" entity.name.binding.ocaml
    3:10:11 "=" keyword.operator.ocaml
    3:12:13 "1" constant.numeric.decimal.integer.ocaml
    3:14:17 "and" keyword.ocaml
    3:18:22 "peer" entity.name.binding.ocaml
    3:23:24 "=" keyword.operator.ocaml
    3:25:26 "2" constant.numeric.decimal.integer.ocaml
    4:0:3 "end" keyword.other.ocaml
    4:4:6 "in" keyword.other.ocaml
    4:7:8 "M" constant.language.capital-identifier.ocaml
    4:8:9 "." keyword.other.ocaml punctuation.other.period punctuation.separator.period
    4:9:14 "value" source.ocaml
    4:14:15 ")"
    4:16:18 "in" keyword.ocaml
    4:19:25 "object" keyword.ocaml
    4:26:29 "end" keyword.ocaml
    5:0:3 "and" keyword.ocaml
    5:4:10 "second" entity.name.type.class.ocaml
    5:11:12 "=" keyword.operator.ocaml
    5:13:19 "object" keyword.ocaml
    5:20:23 "end" keyword.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/typedecl.html
test("Class function prefixes isolate local bindings", async () => {
  const source = `class first = fun value -> let helper = value and sibling = value in object end
and second = object end
type next = int and following = string
let top = 1 and peer = 2`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:5 "class" keyword.ocaml
    1:6:11 "first" entity.name.type.class.ocaml
    1:12:13 "=" keyword.operator.ocaml
    1:14:17 "fun" keyword.ocaml
    1:18:23 "value" source.ocaml
    1:24:26 "->" keyword.operator.ocaml
    1:27:30 "let" keyword.ocaml
    1:31:37 "helper" entity.name.binding.ocaml
    1:38:39 "=" keyword.operator.ocaml
    1:40:45 "value" source.ocaml
    1:46:49 "and" keyword.ocaml
    1:50:57 "sibling" entity.name.binding.ocaml
    1:58:59 "=" keyword.operator.ocaml
    1:60:65 "value" source.ocaml
    1:66:68 "in" keyword.ocaml
    1:69:75 "object" keyword.ocaml
    1:76:79 "end" keyword.ocaml
    2:0:3 "and" keyword.ocaml
    2:4:10 "second" entity.name.type.class.ocaml
    2:11:12 "=" keyword.operator.ocaml
    2:13:19 "object" keyword.ocaml
    2:20:23 "end" keyword.ocaml
    3:0:4 "type" keyword.ocaml
    3:5:9 "next" entity.name.type.ocaml
    3:10:11 "=" keyword.operator.ocaml
    3:12:15 "int" source.ocaml
    3:16:19 "and" keyword.ocaml
    3:20:29 "following" entity.name.type.ocaml
    3:30:31 "=" keyword.operator.ocaml
    3:32:38 "string" source.ocaml
    4:0:3 "let" keyword.ocaml
    4:4:7 "top" entity.name.binding.ocaml
    4:8:9 "=" keyword.operator.ocaml
    4:10:11 "1" constant.numeric.decimal.integer.ocaml
    4:12:15 "and" keyword.ocaml
    4:16:20 "peer" entity.name.binding.ocaml
    4:21:22 "=" keyword.operator.ocaml
    4:23:24 "2" constant.numeric.decimal.integer.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/classes.html
test("Enclosing module end terminates declaration context", async () => {
  const source = `module M = struct
class first = object end and second = object end
end
let value = 1 and peer = 2`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:6 "module" keyword.other.ocaml
    1:7:8 "M" constant.language.capital-identifier.ocaml
    1:9:10 "=" keyword.operator.ocaml
    1:11:17 "struct" keyword.other.ocaml
    2:0:5 "class" keyword.ocaml
    2:6:11 "first" entity.name.type.class.ocaml
    2:12:13 "=" keyword.operator.ocaml
    2:14:20 "object" keyword.ocaml
    2:21:24 "end" keyword.ocaml
    2:25:28 "and" keyword.ocaml
    2:29:35 "second" entity.name.type.class.ocaml
    2:36:37 "=" keyword.operator.ocaml
    2:38:44 "object" keyword.ocaml
    2:45:48 "end" keyword.ocaml
    3:0:3 "end" keyword.other.ocaml
    4:0:3 "let" keyword.ocaml
    4:4:9 "value" entity.name.binding.ocaml
    4:10:11 "=" keyword.operator.ocaml
    4:12:13 "1" constant.numeric.decimal.integer.ocaml
    4:14:17 "and" keyword.ocaml
    4:18:22 "peer" entity.name.binding.ocaml
    4:23:24 "=" keyword.operator.ocaml
    4:25:26 "2" constant.numeric.decimal.integer.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/extensionnodes.html
test("Keyword extensions keep extension identifiers", async () => {
  const source = `type%foo first = int and second = string
class type%bar first_class = object end and second_class = object end`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:4 "type" keyword.ocaml
    1:4:5 "%" keyword.operator.extension.ocaml
    1:5:8 "foo" keyword.other.extension.ocaml
    1:9:14 "first" entity.name.type.ocaml
    1:15:16 "=" keyword.operator.ocaml
    1:17:20 "int" source.ocaml
    1:21:24 "and" keyword.ocaml
    1:25:31 "second" entity.name.type.ocaml
    1:32:33 "=" keyword.operator.ocaml
    1:34:40 "string" source.ocaml
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

// https://ocaml.org/manual/5.5/classes.html
test("Nested class lexical regions protect declaration keywords", async () => {
  const source = `class first = object
method text = {q|end and fake|q}
method value = ( (* end and ghost *) 1 [@example let payload = 1 and sibling = 2] )
method unit = ()
end and second = object end`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:5 "class" keyword.ocaml
    1:6:11 "first" entity.name.type.class.ocaml
    1:12:13 "=" keyword.operator.ocaml
    1:14:20 "object" keyword.ocaml
    2:0:6 "method" keyword.ocaml
    2:7:11 "text" entity.name.function.method.ocaml
    2:12:13 "=" keyword.operator.ocaml
    2:14:17 "{q|" string.quoted.braced.ocaml
    2:17:29 "end and fake" string.quoted.braced.ocaml
    2:29:32 "|q}" string.quoted.braced.ocaml
    3:0:6 "method" keyword.ocaml
    3:7:12 "value" entity.name.function.method.ocaml
    3:13:14 "=" keyword.operator.ocaml
    3:15:16 "("
    3:17:19 "(*" comment.block.ocaml
    3:19:34 " end and ghost " comment.block.ocaml
    3:34:36 "*)" comment.block.ocaml
    3:37:38 "1" constant.numeric.decimal.integer.ocaml
    3:39:40 "["
    3:40:41 "@" keyword.operator.attribute.ocaml
    3:41:48 "example" keyword.other.attribute.ocaml
    3:49:52 "let" keyword.ocaml
    3:53:60 "payload" entity.name.binding.ocaml
    3:61:62 "=" keyword.operator.ocaml
    3:63:64 "1" constant.numeric.decimal.integer.ocaml
    3:65:68 "and" keyword.ocaml
    3:69:76 "sibling" entity.name.binding.ocaml
    3:77:78 "=" keyword.operator.ocaml
    3:79:80 "2" constant.numeric.decimal.integer.ocaml
    3:80:81 "]"
    3:82:83 ")"
    4:0:6 "method" keyword.ocaml
    4:7:11 "unit" entity.name.function.method.ocaml
    4:12:13 "=" keyword.operator.ocaml
    4:14:16 "()" constant.language.unit.ocaml
    5:0:3 "end" keyword.ocaml
    5:4:7 "and" keyword.ocaml
    5:8:14 "second" entity.name.type.class.ocaml
    5:15:16 "=" keyword.operator.ocaml
    5:17:23 "object" keyword.ocaml
    5:24:27 "end" keyword.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/typedecl.html
test("Type parameter variance keeps operator scopes", async () => {
  const source = "type +'a first = 'a list and -'b second = 'b -> unit";
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
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
    1:48:52 "unit" source.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/generalizedopens.html
test("Class local opens keep keyword scopes", async () => {
  const source = `class type first = let open M in base and second = object end
class type third = let open! M in base and fourth = object end
class type fifth = let (* comment *) open! M in base and sixth = object end
class initial = let open M in base and subsequent = object end
class final = let (* comment *) open! M in base and following = object end`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
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
    3:72:75 "end" keyword.ocaml
    4:0:5 "class" keyword.ocaml
    4:6:13 "initial" entity.name.type.class.ocaml
    4:14:15 "=" keyword.operator.ocaml
    4:16:19 "let" keyword.ocaml
    4:20:24 "open" keyword.other.ocaml
    4:25:26 "M" constant.language.capital-identifier.ocaml
    4:27:29 "in" keyword.ocaml
    4:30:34 "base" source.ocaml
    4:35:38 "and" keyword.ocaml
    4:39:49 "subsequent" entity.name.type.class.ocaml
    4:50:51 "=" keyword.operator.ocaml
    4:52:58 "object" keyword.ocaml
    4:59:62 "end" keyword.ocaml
    5:0:5 "class" keyword.ocaml
    5:6:11 "final" entity.name.type.class.ocaml
    5:12:13 "=" keyword.operator.ocaml
    5:14:17 "let" keyword.ocaml
    5:18:20 "(*" comment.block.ocaml
    5:20:29 " comment " comment.block.ocaml
    5:29:31 "*)" comment.block.ocaml
    5:32:36 "open" keyword.other.ocaml
    5:36:37 "!" keyword.operator.ocaml
    5:38:39 "M" constant.language.capital-identifier.ocaml
    5:40:42 "in" keyword.ocaml
    5:43:47 "base" source.ocaml
    5:48:51 "and" keyword.ocaml
    5:52:61 "following" entity.name.type.class.ocaml
    5:62:63 "=" keyword.operator.ocaml
    5:64:70 "object" keyword.ocaml
    5:71:74 "end" keyword.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/lex.html
test("apostrophe identifiers", async () => {
  const source = "let x = true' mod' int'";
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:3 "let" keyword.ocaml
    1:4:5 "x" entity.name.binding.ocaml
    1:6:7 "=" keyword.operator.ocaml
    1:8:13 "true'" source.ocaml
    1:14:18 "mod'" source.ocaml
    1:19:23 "int'" source.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/lex.html
test("raw identifiers and effects", async () => {
  const source = `let \\#type = \\#match
match x with | effect E, k -> continue k ()`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:3 "let" keyword.ocaml
    1:4:10 "\\\\#type" entity.name.binding.ocaml
    1:11:12 "=" keyword.operator.ocaml
    1:13:20 "\\\\#match" variable.other.ocaml
    2:0:5 "match" keyword.other.ocaml
    2:6:7 "x" source.ocaml
    2:8:12 "with" keyword.other.ocaml
    2:13:14 "|" keyword.other.ocaml
    2:15:21 "effect" keyword.other.ocaml
    2:22:23 "E" constant.language.capital-identifier.ocaml
    2:23:24 "," keyword.other.ocaml punctuation.comma punctuation.separator.comma
    2:25:26 "k" source.ocaml
    2:27:29 "->" keyword.operator.ocaml
    2:30:38 "continue" source.ocaml
    2:39:40 "k" source.ocaml
    2:41:43 "()" constant.language.unit.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/attributes.html
test("attribute identifiers", async () => {
  const source = "let x = 1 [@foo2'] [%%bar3 2]";
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:3 "let" keyword.ocaml
    1:4:5 "x" entity.name.binding.ocaml
    1:6:7 "=" keyword.operator.ocaml
    1:8:9 "1" constant.numeric.decimal.integer.ocaml
    1:10:11 "["
    1:11:12 "@" keyword.operator.attribute.ocaml
    1:12:17 "foo2'" keyword.other.attribute.ocaml
    1:17:18 "]"
    1:19:20 "["
    1:20:22 "%%" keyword.operator.extension.ocaml
    1:22:26 "bar3" keyword.other.extension.ocaml
    1:27:28 "2" constant.numeric.decimal.integer.ocaml
    1:28:29 "]""
  `);
});

// https://ocaml.org/manual/5.5/lex.html
test("numbers and comments", async () => {
  const source = `let n = 0x1.fp+2 + 42G + 1.2g
(* outer {tag| *) |tag} (* nested *)
still comment *)
let s = {tag|"(* *)"|tag}`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:3 "let" keyword.ocaml
    1:4:5 "n" entity.name.binding.ocaml
    1:6:7 "=" keyword.operator.ocaml
    1:8:16 "0x1.fp+2" constant.numeric.hexadecimal.float.ocaml
    1:17:18 "+" keyword.operator.ocaml
    1:19:22 "42G" constant.numeric.decimal.integer.ocaml
    1:23:24 "+" keyword.operator.ocaml
    1:25:29 "1.2g" constant.numeric.decimal.float.ocaml
    2:0:2 "(*" comment.block.ocaml
    2:2:9 " outer " comment.block.ocaml
    2:9:14 "{tag|" comment.block.ocaml
    2:14:18 " *) " comment.block.ocaml
    2:18:23 "|tag}" comment.block.ocaml
    2:23:24 " " comment.block.ocaml
    2:24:26 "(*" comment.block.ocaml comment.block.ocaml
    2:26:34 " nested " comment.block.ocaml comment.block.ocaml
    2:34:36 "*)" comment.block.ocaml comment.block.ocaml
    3:0:14 "still comment " comment.block.ocaml
    3:14:16 "*)" comment.block.ocaml
    4:0:3 "let" keyword.ocaml
    4:4:5 "s" entity.name.binding.ocaml
    4:6:7 "=" keyword.operator.ocaml
    4:8:13 "{tag|" string.quoted.braced.ocaml
    4:13:20 "\\"(* *)\\"" string.quoted.braced.ocaml
    4:20:25 "|tag}" string.quoted.braced.ocaml"
  `);
});

// https://github.com/ocaml/ocaml/blob/5.5/parsing/lexer.mll
test("OCaml prefix and binding operators", async () => {
  const source = `let x = ??value + ~!value + !#value
let*! x = value in x
let x = a.%[i]
let*~ x
let*< x
let*. x
let x = a ## b`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:3 "let" keyword.ocaml
    1:4:5 "x" entity.name.binding.ocaml
    1:6:7 "=" keyword.operator.ocaml
    1:8:10 "??" keyword.operator.ocaml
    1:10:15 "value" source.ocaml
    1:16:17 "+" keyword.operator.ocaml
    1:18:20 "~!" keyword.operator.ocaml
    1:20:25 "value" source.ocaml
    1:26:27 "+" keyword.operator.ocaml
    1:28:30 "!#" keyword.operator.ocaml
    1:30:35 "value" source.ocaml
    2:0:3 "let" keyword.ocaml
    2:3:5 "*!" keyword.ocaml
    2:6:7 "x" entity.name.binding.ocaml
    2:8:9 "=" keyword.operator.ocaml
    2:10:15 "value" source.ocaml
    2:16:18 "in" keyword.other.ocaml
    2:19:20 "x" source.ocaml
    3:0:3 "let" keyword.ocaml
    3:4:5 "x" entity.name.binding.ocaml
    3:6:7 "=" keyword.operator.ocaml
    3:8:9 "a" source.ocaml
    3:9:11 ".%" keyword.operator.ocaml
    3:11:12 "["
    3:12:13 "i" source.ocaml
    3:13:14 "]"
    4:0:4 "let*" keyword.ocaml
    4:4:6 "~ "
    4:6:7 "x" source.ocaml
    5:0:4 "let*" keyword.ocaml
    5:4:5 "<" keyword.operator.ocaml
    5:6:7 "x" source.ocaml
    6:0:4 "let*" keyword.ocaml
    6:4:5 "." keyword.other.ocaml punctuation.other.period punctuation.separator.period
    6:6:7 "x" source.ocaml
    7:0:3 "let" keyword.ocaml
    7:4:5 "x" entity.name.binding.ocaml
    7:6:7 "=" keyword.operator.ocaml
    7:8:9 "a" source.ocaml
    7:10:12 "##" keyword.operator.ocaml
    7:13:14 "b" source.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/types.html
test("Type names remain identifiers", async () => {
  const source = `let int = 1
let value = int
let typed : int = 1
let f (x : 'ab') (y : '_weak') = x`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:3 "let" keyword.ocaml
    1:4:7 "int" entity.name.binding.ocaml
    1:8:9 "=" keyword.operator.ocaml
    1:10:11 "1" constant.numeric.decimal.integer.ocaml
    2:0:3 "let" keyword.ocaml
    2:4:9 "value" entity.name.binding.ocaml
    2:10:11 "=" keyword.operator.ocaml
    2:12:15 "int" source.ocaml
    3:0:3 "let" keyword.ocaml
    3:4:9 "typed" entity.name.binding.ocaml
    3:10:11 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    3:12:15 "int" source.ocaml
    3:16:17 "=" keyword.operator.ocaml
    3:18:19 "1" constant.numeric.decimal.integer.ocaml
    4:0:3 "let" keyword.ocaml
    4:4:5 "f" entity.name.binding.ocaml
    4:6:7 "("
    4:7:8 "x" source.ocaml
    4:9:10 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    4:11:15 "'ab'" storage.type.ocaml
    4:15:16 ")"
    4:17:18 "("
    4:18:19 "y" source.ocaml
    4:20:21 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    4:22:29 "'_weak'" storage.type.weak.ocaml
    4:29:30 ")"
    4:31:32 "=" keyword.operator.ocaml
    4:33:34 "x" source.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/lex.html
test("Keyword and directive identifier boundaries", async () => {
  const source = `let x = sig' struct' end'
#showcase
let next = 1`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:3 "let" keyword.ocaml
    1:4:5 "x" entity.name.binding.ocaml
    1:6:7 "=" keyword.operator.ocaml
    1:8:12 "sig'" source.ocaml
    1:13:20 "struct'" source.ocaml
    1:21:25 "end'" source.ocaml
    2:0:1 "#" keyword.other.ocaml
    2:1:9 "showcase" source.ocaml
    3:0:3 "let" keyword.ocaml
    3:4:8 "next" entity.name.binding.ocaml
    3:9:10 "=" keyword.operator.ocaml
    3:11:12 "1" constant.numeric.decimal.integer.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/lex.html
test("Raw labels keep parameter scopes", async () => {
  const source = "f ~\\#type:1 ?\\#effect:value";
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:1 "f" source.ocaml
    1:2:9 "~\\\\#type" variable.parameter.labeled.ocaml
    1:9:10 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    1:10:11 "1" constant.numeric.decimal.integer.ocaml
    1:12:21 "?\\\\#effect" variable.parameter.optional.ocaml
    1:21:22 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    1:22:27 "value" source.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/lex.html
test("Raw type declaration and keyword uses", async () => {
  const source = `type \\#type = int
let f ~\\#effect = \\#type`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:4 "type" keyword.ocaml
    1:5:11 "\\\\#type" entity.name.type.ocaml
    1:12:13 "=" keyword.operator.ocaml
    1:14:17 "int" source.ocaml
    2:0:3 "let" keyword.ocaml
    2:4:5 "f" entity.name.binding.ocaml
    2:6:15 "~\\\\#effect" variable.parameter.labeled.ocaml
    2:16:17 "=" keyword.operator.ocaml
    2:18:24 "\\\\#type" variable.other.ocaml"
  `);
});

// https://ocaml.org/manual/5.5/typedecl.html
test("Declaration roles", async () => {
  const source = `type \\#type = int
class c = object (self) method m = 1 end
class type ct = object method m : int end
class state = object val value = 1 end
external primitive : int -> int = "primitive"
type first = int and second = string
let \\#let = 1 and value = 2
for counter = 0 to 1 do () done
let f (type local) = ()`;
  expect(await tokenizer.render("source.ocaml", source)).toMatchInlineSnapshot(`
    "1:0:4 "type" keyword.ocaml
    1:5:11 "\\\\#type" entity.name.type.ocaml
    1:12:13 "=" keyword.operator.ocaml
    1:14:17 "int" source.ocaml
    2:0:5 "class" keyword.ocaml
    2:6:7 "c" entity.name.type.class.ocaml
    2:8:9 "=" keyword.operator.ocaml
    2:10:16 "object" keyword.ocaml
    2:16:18 " ("
    2:18:22 "self" variable.other.binding.ocaml
    2:22:24 ") "
    2:24:30 "method" keyword.ocaml
    2:31:32 "m" entity.name.function.method.ocaml
    2:33:34 "=" keyword.operator.ocaml
    2:35:36 "1" constant.numeric.decimal.integer.ocaml
    2:37:40 "end" keyword.ocaml
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
    4:0:5 "class" keyword.ocaml
    4:6:11 "state" entity.name.type.class.ocaml
    4:12:13 "=" keyword.operator.ocaml
    4:14:20 "object" keyword.ocaml
    4:21:24 "val" keyword.ocaml
    4:25:30 "value" entity.name.binding.ocaml
    4:31:32 "=" keyword.operator.ocaml
    4:33:34 "1" constant.numeric.decimal.integer.ocaml
    4:35:38 "end" keyword.ocaml
    5:0:8 "external" keyword.ocaml
    5:9:18 "primitive" entity.name.binding.ocaml
    5:19:20 ":" keyword.other.ocaml punctuation.other.colon punctuation.colon
    5:21:24 "int" source.ocaml
    5:25:27 "->" keyword.operator.ocaml
    5:28:31 "int" source.ocaml
    5:32:33 "=" keyword.operator.ocaml
    5:34:35 "\\"" string.quoted.double.ocaml
    5:35:44 "primitive" string.quoted.double.ocaml
    5:44:45 "\\"" string.quoted.double.ocaml
    6:0:4 "type" keyword.ocaml
    6:5:10 "first" entity.name.type.ocaml
    6:11:12 "=" keyword.operator.ocaml
    6:13:16 "int" source.ocaml
    6:17:20 "and" keyword.ocaml
    6:21:27 "second" entity.name.type.ocaml
    6:28:29 "=" keyword.operator.ocaml
    6:30:36 "string" source.ocaml
    7:0:3 "let" keyword.ocaml
    7:4:9 "\\\\#let" entity.name.binding.ocaml
    7:10:11 "=" keyword.operator.ocaml
    7:12:13 "1" constant.numeric.decimal.integer.ocaml
    7:14:17 "and" keyword.ocaml
    7:18:23 "value" entity.name.binding.ocaml
    7:24:25 "=" keyword.operator.ocaml
    7:26:27 "2" constant.numeric.decimal.integer.ocaml
    8:0:3 "for" keyword.ocaml
    8:4:11 "counter" variable.other.binding.ocaml
    8:12:13 "=" keyword.operator.ocaml
    8:14:15 "0" constant.numeric.decimal.integer.ocaml
    8:16:18 "to" keyword.other.ocaml
    8:19:20 "1" constant.numeric.decimal.integer.ocaml
    8:21:23 "do" keyword.other.ocaml
    8:24:26 "()" constant.language.unit.ocaml
    8:27:31 "done" keyword.other.ocaml
    9:0:3 "let" keyword.ocaml
    9:4:5 "f" entity.name.binding.ocaml
    9:6:7 "("
    9:7:11 "type" keyword.ocaml
    9:11:17 " local" entity.name.type.ocaml
    9:17:19 ") "
    9:19:20 "=" keyword.operator.ocaml
    9:21:23 "()" constant.language.unit.ocaml"
  `);
});
