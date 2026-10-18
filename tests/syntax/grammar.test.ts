import { afterAll, test } from "bun:test";
import assert from "node:assert/strict";

import { INITIAL } from "vscode-textmate";

import { createTokenizer, registrations } from "./tokenizer.ts";

const tokenizer = createTokenizer();
afterAll(() => tokenizer.dispose());

test("Markdown fences preserve delimiter length, marker and multiline state", async () => {
  for (const language of ["ocaml", "reason"]) {
    const grammar = await tokenizer.loadGrammar(`markdown.${language}.codeblock`);
    assert.ok(grammar);
    for (const marker of ["`", "~"]) {
      const otherMarker = marker === "`" ? "~" : "`";
      for (let opening = 3; opening <= 9; opening++) {
        for (let closing = 2; closing <= 11; closing++) {
          for (const indent of ["", " ", "   "]) {
            for (const ending of ["same", "other", "mixed"]) {
              const fence =
                (ending === "other" ? otherMarker : marker).repeat(closing) +
                (ending === "mixed" ? otherMarker : "");
              let state = INITIAL;
              let result: ReturnType<typeof grammar.tokenizeLine> | undefined;
              for (const line of [
                indent + marker.repeat(opening) + language,
                'let x = "unterminated',
                indent + fence,
                "AFTER",
              ]) {
                result = grammar.tokenizeLine(line, state);
                assert.equal(result.stoppedEarly, false);
                state = result.ruleStack;
              }
              assert.ok(result);
              const remainsInside = result.tokens.some((token) =>
                token.scopes.includes("markup.fenced_code.block.markdown"),
              );
              assert.equal(
                remainsInside,
                ending !== "same" || closing < opening,
                JSON.stringify({ language, marker, opening, closing, indent, ending }),
              );
            }
          }
        }
      }
    }
  }
});

for (const entry of registrations) {
  test(`loads ${entry.scopeName}`, async () => {
    const grammar = await tokenizer.loadGrammar(entry.scopeName);
    assert.ok(grammar);
    assert.ok(grammar.tokenizeLine("", INITIAL).tokens.length);
  });
}
