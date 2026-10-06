import { afterAll, expect, test } from "bun:test";

import { createTokenizer } from "./tokenizer.ts";

const tokenizer = createTokenizer();
afterAll(() => tokenizer.dispose());

// https://ocaml.org/manual/5.5/ocamldoc.html
test("Ocamldoc escaped tags and alignment", async () => {
  const source = `Escaped \\@param name
@param x description
{C centred {b bold} text}`;
  expect(await tokenizer.render("source.ocaml.ocamldoc", source)).toMatchInlineSnapshot(`
    "1:0:21 "Escaped \\\\@param name"
    2:0:6 "@param" keyword.doc-tag.ocamldoc
    2:7:8 "x" markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:8:21 " description"
    3:0:3 "{C " meta.alignment.ocamldoc
    3:3:11 "centred " meta.alignment.ocamldoc
    3:11:14 "{b " meta.alignment.ocamldoc markup.bold.ocamldoc
    3:14:18 "bold" meta.alignment.ocamldoc markup.bold.ocamldoc
    3:18:19 "}" meta.alignment.ocamldoc markup.bold.ocamldoc
    3:19:24 " text" meta.alignment.ocamldoc
    3:24:25 "}" meta.alignment.ocamldoc"
  `);
});

// https://ocaml.org/manual/5.5/ocamldoc.html
test("Odoc code blocks keep declaration bodies as OCaml", async () => {
  const source = `{[
type vec = {v : float array}
class point = object val v = {v = [||]} end
]}

{1 Next section}`;
  expect(await tokenizer.render("source.ocaml.ocamldoc", source)).toMatchInlineSnapshot(`
    "1:0:2 "{[" markup.inline.raw.ocamldoc
    2:0:4 "type" markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.ocaml
    2:4:5 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:5:8 "vec" markup.inline.raw.ocamldoc source.embedded.ocamldoc entity.name.type.ocaml
    2:8:9 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:9:10 "=" markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.operator.ocaml
    2:10:11 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:11:12 "{" markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:12:13 "v" markup.inline.raw.ocamldoc source.embedded.ocamldoc source.ocaml
    2:13:14 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:14:15 ":" markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.other.ocaml punctuation.other.colon punctuation.colon
    2:15:16 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:16:21 "float" markup.inline.raw.ocamldoc source.embedded.ocamldoc source.ocaml
    2:21:22 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    2:22:27 "array" markup.inline.raw.ocamldoc source.embedded.ocamldoc source.ocaml
    2:27:28 "}" markup.inline.raw.ocamldoc source.embedded.ocamldoc
    3:0:5 "class" markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.ocaml
    3:5:6 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    3:6:11 "point" markup.inline.raw.ocamldoc source.embedded.ocamldoc entity.name.type.class.ocaml
    3:11:12 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    3:12:13 "=" markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.operator.ocaml
    3:13:14 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    3:14:20 "object" markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.ocaml
    3:20:21 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    3:21:24 "val" markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.ocaml
    3:24:25 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    3:25:26 "v" markup.inline.raw.ocamldoc source.embedded.ocamldoc entity.name.binding.ocaml
    3:26:27 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    3:27:28 "=" markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.operator.ocaml
    3:28:29 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    3:29:30 "{" markup.inline.raw.ocamldoc source.embedded.ocamldoc
    3:30:31 "v" markup.inline.raw.ocamldoc source.embedded.ocamldoc source.ocaml
    3:31:32 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    3:32:33 "=" markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.operator.ocaml
    3:33:34 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    3:34:38 "[||]" markup.inline.raw.ocamldoc source.embedded.ocamldoc constant.language.array.ocaml
    3:38:39 "}" markup.inline.raw.ocamldoc source.embedded.ocamldoc
    3:39:40 " " markup.inline.raw.ocamldoc source.embedded.ocamldoc
    3:40:43 "end" markup.inline.raw.ocamldoc source.embedded.ocamldoc keyword.ocaml
    4:0:2 "]}" markup.inline.raw.ocamldoc
    5:0:1 ""
    6:0:3 "{1 " markup.heading.ocamldoc
    6:3:15 "Next section" markup.heading.ocamldoc
    6:15:16 "}" markup.heading.ocamldoc"
  `);
});
