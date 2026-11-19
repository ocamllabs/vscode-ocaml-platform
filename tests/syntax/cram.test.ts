import { afterAll, expect, test } from "bun:test";

import { createTokenizer } from "./tokenizer.ts";

const tokenizer = createTokenizer();
afterAll(() => tokenizer.dispose());

// https://dune.readthedocs.io/en/stable/reference/cram.html
test("Cram nonzero status is a numeric result", async () => {
  const source = `  $ false
  [1]
  output [1]`;
  expect(await tokenizer.render("source.cram", source)).toMatchInlineSnapshot(`
    "1:2:3 "$" keyword.operator.cram
    1:4:9 "false" source.cram
    2:0:3 "  ["
    2:3:4 "1" constant.numeric.cram
    2:4:5 "]"
    3:2:12 "output [1]" string.other.cram"
  `);
});

// https://dune.readthedocs.io/en/stable/reference/cram.html
test("Cram single quotes preserve backslashes", async () => {
  const source = "  $ printf '%s' '\\n'";
  expect(await tokenizer.render("source.cram", source)).toMatchInlineSnapshot(`
    "1:2:3 "$" keyword.operator.cram
    1:4:11 "printf " source.cram
    1:11:12 "'" source.cram string.quoted.single.cram
    1:12:14 "%s" source.cram string.quoted.single.cram
    1:14:15 "'" source.cram string.quoted.single.cram
    1:15:16 " " source.cram
    1:16:17 "'" source.cram string.quoted.single.cram
    1:17:19 "\\\\n" source.cram string.quoted.single.cram
    1:19:20 "'" source.cram string.quoted.single.cram"
  `);
});
