const { afterAll, expect, test } = require("bun:test");
const { createTokenizer } = require("./tokenizer");

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
