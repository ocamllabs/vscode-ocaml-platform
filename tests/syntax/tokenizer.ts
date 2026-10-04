import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";

import { loadWASM, OnigScanner, OnigString } from "vscode-oniguruma";
import { Registry, INITIAL, parseRawGrammar, type IOnigLib } from "vscode-textmate";

import { grammarRoot, registrations } from "./manifest.ts";

const byScope = new Map(registrations.map((entry) => [entry.scopeName, entry]));
const onigLib = loadWASM(
  fs.readFileSync(new URL(import.meta.resolve("vscode-oniguruma/release/onig.wasm"))),
).then((): IOnigLib => ({
  createOnigScanner: (patterns) => new OnigScanner(patterns),
  createOnigString: (value) => new OnigString(value),
}));
const collected = new Set<string>();

export function createTokenizer() {
  const registry = new Registry({
    onigLib,
    loadGrammar: async (scope) => {
      const entry = byScope.get(scope);
      if (!entry) return null;
      const filename = path.join(grammarRoot, entry.path);
      return parseRawGrammar(fs.readFileSync(filename, "utf8"), filename);
    },
    getInjections: (scope) =>
      registrations
        .filter((entry) => entry.injectTo?.includes(scope))
        .map((entry) => entry.scopeName),
  });

  return {
    loadGrammar: (scope: string) => registry.loadGrammar(scope),
    dispose: () => registry.dispose(),
    async render(scope: string, source: string) {
      const grammar = await registry.loadGrammar(scope);
      assert.ok(grammar, `Unknown grammar ${scope}`);
      let state = INITIAL;
      const output = source.split("\n").flatMap((line, index) => {
        const result = grammar.tokenizeLine(line, state);
        assert.equal(result.stoppedEarly, false);
        state = result.ruleStack;
        return result.tokens.flatMap(({ startIndex, endIndex, scopes }) => {
          const text = line.slice(startIndex, endIndex);
          const rootOnly = scopes.length === 1 && scopes[0] === scope;
          if (rootOnly && text.length > 0 && /^\s+$/.test(text)) return [];
          const residual = scopes[0] === scope ? scopes.slice(1) : scopes;
          return [
            `${index + 1}:${startIndex}:${endIndex} ${JSON.stringify(text)}${residual.length ? ` ${residual.join(" ")}` : ""}`,
          ];
        });
      });
      const corpus = process.env["SYNTAX_CORPUS"];
      if (corpus) {
        const entry = JSON.stringify({ scope, source });
        if (!collected.has(entry)) {
          collected.add(entry);
          fs.appendFileSync(corpus, entry + "\n");
        }
      }
      return output.join("\n");
    },
  };
}

export { registrations };
