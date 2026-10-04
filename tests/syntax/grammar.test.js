const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");
const { after, before, test } = require("node:test");
const { Registry, INITIAL, parseRawGrammar } = require("vscode-textmate");
const { loadWASM, OnigScanner, OnigString } = require("vscode-oniguruma");

const root = process.env.SYNTAX_ROOT || path.resolve(__dirname, "../..");
const { grammars } = require(path.join(root, "package.json")).contributes;
const byScope = new Map(grammars.map((grammar) => [grammar.scopeName, grammar]));
const registry = new Registry({
  onigLib: loadWASM(fs.readFileSync(require.resolve("vscode-oniguruma/release/onig.wasm"))).then(
    () => ({
      createOnigScanner: (patterns) => new OnigScanner(patterns),
      createOnigString: (value) => new OnigString(value),
    }),
  ),
  loadGrammar: async (scope) => {
    const entry = byScope.get(scope);
    if (!entry) return null;
    const filename = path.join(root, entry.path);
    return parseRawGrammar(fs.readFileSync(filename, "utf8"), filename);
  },
  getInjections: (scope) =>
    grammars.filter((entry) => entry.injectTo?.includes(scope)).map((entry) => entry.scopeName),
});

before(async () => {
  await Promise.all(grammars.map((entry) => registry.loadGrammar(entry.scopeName)));
});
after(() => registry.dispose());

test("Markdown fences preserve delimiter length, marker and multiline state", async () => {
  for (const language of ["ocaml", "reason"]) {
    const grammar = await registry.loadGrammar(`markdown.${language}.codeblock`);
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
              let result;
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

for (const entry of grammars) {
  test(`loads ${entry.scopeName}`, async () => {
    const grammar = await registry.loadGrammar(entry.scopeName);
    assert.ok(grammar);
    assert.ok(grammar.tokenizeLine("", INITIAL).tokens.length);
  });
}

const casesDirectory = path.join(root, "tests/syntax/cases");
for (const filename of fs.readdirSync(casesDirectory).filter((file) => file.endsWith(".json"))) {
  const cases = JSON.parse(fs.readFileSync(path.join(casesDirectory, filename), "utf8"));
  for (const fixture of cases) {
    test(`${fixture.scope}: ${fixture.name}`, async () => {
      const grammar = await registry.loadGrammar(fixture.scope);
      assert.ok(grammar, `Unknown grammar ${fixture.scope}`);
      const lines = fixture.source.split("\n");
      let state = INITIAL;
      const tokenLines = lines.map((line) => {
        const result = grammar.tokenizeLine(line, state);
        assert.equal(result.stoppedEarly, false);
        state = result.ruleStack;
        return result.tokens;
      });
      assert.ok(fixture.assertions.length, "A fixture must assert token scopes");
      for (const expected of fixture.assertions) {
        assert.ok(
          expected.scopes?.length || expected.notScopes?.length,
          "A token assertion must require or exclude a scope",
        );
        const line = lines[expected.line - 1];
        assert.notEqual(line, undefined, `Missing line ${expected.line}`);
        assert.ok(expected.text.length, "A token assertion must select nonempty text");
        let start = -1;
        for (let occurrence = 0; occurrence < (expected.occurrence || 1); occurrence++) {
          start = line.indexOf(expected.text, start + 1);
          assert.notEqual(
            start,
            -1,
            `Missing ${JSON.stringify(expected.text)} on line ${expected.line}`,
          );
        }
        const end = start + expected.text.length;
        const tokens = tokenLines[expected.line - 1].filter(
          (token) => token.startIndex < end && token.endIndex > start,
        );
        assert.ok(tokens.length);
        if (expected.singleToken) {
          assert.equal(tokens.length, 1, `Expected one token for ${expected.text}`);
          assert.equal(tokens[0].startIndex, start);
          assert.equal(tokens[0].endIndex, end);
        }
        for (const token of tokens) {
          const actual = token.scopes;
          const matches = (scope) =>
            actual.some((value) => value === scope || value.startsWith(`${scope}.`));
          const context = `${filename}, line ${expected.line}, ${JSON.stringify(line.slice(token.startIndex, token.endIndex))}: ${actual.join(" ")}`;
          for (const scope of expected.scopes || []) {
            assert.ok(matches(scope), `${context}; missing ${scope}`);
          }
          for (const scope of expected.notScopes || []) {
            assert.ok(!matches(scope), `${context}; unexpected ${scope}`);
          }
        }
      }
    });
  }
}
