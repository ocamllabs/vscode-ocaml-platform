const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");
const { test } = require("node:test");

const root = process.env.SYNTAX_ROOT || path.resolve(__dirname, "../..");
const registrations = require(path.join(root, "package.json")).contributes.grammars;
const grammars = new Map(
  registrations.map((entry) => [
    entry.scopeName,
    JSON.parse(fs.readFileSync(path.join(root, entry.path), "utf8")),
  ]),
);
const externalScopes = new Set(["source.js", "text.html.basic", "text.tex.latex"]);
const captureKeys = new Set(["captures", "beginCaptures", "endCaptures", "whileCaptures"]);

for (const [scope, grammar] of grammars) {
  test(`portable structure and includes: ${scope}`, () => {
    assert.equal(grammar.scopeName, scope);
    function visit(rule, inherited, location) {
      const repository = { ...inherited, ...rule.repository };
      for (const [key, value] of Object.entries(rule)) {
        const context = `${scope}${location}/${key}`;
        if (captureKeys.has(key)) {
          assert.ok(value && typeof value === "object" && !Array.isArray(value), context);
          for (const [capture, attributes] of Object.entries(value)) {
            assert.match(capture, /^\d+$/, context);
            assert.ok(
              attributes && typeof attributes === "object" && !Array.isArray(attributes),
              context,
            );
          }
        }
        if (key === "include") {
          assert.equal(typeof value, "string", context);
          if (value === "$self" || value === "$base") continue;
          const [target, fragment] = value.split("#");
          if (!target) {
            assert.ok(Object.hasOwn(repository, fragment), `${context}: unresolved ${value}`);
          } else if (!externalScopes.has(target)) {
            assert.ok(grammars.has(target), `${context}: unknown grammar ${target}`);
            if (fragment) {
              assert.ok(
                Object.hasOwn(grammars.get(target).repository || {}, fragment),
                `${context}: unresolved ${value}`,
              );
            }
          }
        }
        if (value && typeof value === "object") {
          visit(value, repository, `${location}/${key}`);
        }
      }
    }
    visit(grammar, {}, "");
  });
}
