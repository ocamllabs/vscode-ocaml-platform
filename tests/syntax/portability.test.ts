import { test } from "bun:test";
import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";

import { grammarRoot, isRecord, registrations } from "./manifest.ts";

const grammars = new Map<string, Record<string, unknown>>(
  registrations.map((entry) => {
    const grammar: unknown = JSON.parse(
      fs.readFileSync(path.join(grammarRoot, entry.path), "utf8"),
    );
    assert.ok(isRecord(grammar), entry.scopeName);
    return [entry.scopeName, grammar];
  }),
);
const externalScopes = new Set(["source.js", "text.html.basic", "text.tex.latex"]);
const captureKeys = new Set(["captures", "beginCaptures", "endCaptures", "whileCaptures"]);

for (const [scope, grammar] of grammars) {
  test(`portable structure and includes: ${scope}`, () => {
    assert.equal(grammar["scopeName"], scope);
    function visit(value: unknown, inherited: ReadonlySet<string>, location: string): void {
      if (Array.isArray(value)) {
        const items: unknown[] = value;
        for (const [index, item] of items.entries()) visit(item, inherited, `${location}/${index}`);
        return;
      }
      if (!isRecord(value)) return;
      const repository = new Set(inherited);
      const local = value["repository"];
      if (local !== undefined) {
        assert.ok(isRecord(local), `${scope}${location}/repository`);
        for (const name of Object.keys(local)) repository.add(name);
      }
      for (const [key, child] of Object.entries(value)) {
        const context = `${scope}${location}/${key}`;
        if (captureKeys.has(key)) {
          assert.ok(isRecord(child), context);
          for (const [capture, attributes] of Object.entries(child)) {
            assert.match(capture, /^\d+$/, context);
            assert.ok(isRecord(attributes), context);
          }
        }
        if (key === "include") {
          assert.ok(typeof child === "string", context);
          if (child === "$self" || child === "$base") continue;
          const [target, fragment] = child.split("#");
          if (!target) {
            assert.ok(fragment && repository.has(fragment), `${context}: unresolved ${child}`);
          } else if (!externalScopes.has(target)) {
            const targetGrammar = grammars.get(target);
            assert.ok(targetGrammar, `${context}: unknown grammar ${target}`);
            if (fragment) {
              const targetRepository = targetGrammar["repository"];
              assert.ok(
                isRecord(targetRepository) && Object.hasOwn(targetRepository, fragment),
                `${context}: unresolved ${child}`,
              );
            }
          }
        }
        visit(child, repository, `${location}/${key}`);
      }
    }
    visit(grammar, new Set(), "");
  });
}
