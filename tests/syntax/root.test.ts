import { test } from "bun:test";
import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { pathToFileURL } from "node:url";

import { isRecord } from "./manifest.ts";

const scope = "source.syntax-root-fixture";
const tokenizerPath = path.join(import.meta.dirname, "tokenizer.ts");
const portabilityPath = path.join(import.meta.dirname, "portability.test.ts");
const probe = `
  const { createTokenizer, registrations } = await import(${JSON.stringify(pathToFileURL(tokenizerPath).href)});
  const tokenizer = createTokenizer();
  try {
    console.log(JSON.stringify({
      scopes: registrations.map(entry => entry.scopeName),
      tokens: await tokenizer.render(${JSON.stringify(scope)}, "chosen"),
    }));
  } finally {
    tokenizer.dispose();
  }
`;

for (const form of ["dot", "sibling", "absolute"]) {
  test(`SYNTAX_ROOT selects alternate grammars with ${form} paths`, () => {
    const directory = fs.mkdtempSync(path.join(os.tmpdir(), "ocaml-syntax-root-"));
    try {
      const grammarRoot = path.join(directory, "grammar checkout");
      const caller = path.join(directory, "caller");
      fs.mkdirSync(path.join(grammarRoot, "syntaxes"), { recursive: true });
      fs.mkdirSync(caller);
      fs.writeFileSync(
        path.join(grammarRoot, "package.json"),
        JSON.stringify({
          contributes: { grammars: [{ scopeName: scope, path: "./syntaxes/fixture.json" }] },
        }),
      );
      fs.writeFileSync(
        path.join(grammarRoot, "syntaxes/fixture.json"),
        JSON.stringify({
          scopeName: scope,
          patterns: [{ match: "chosen", name: "keyword.other.selected-root" }],
        }),
      );
      const cwd = form === "dot" ? grammarRoot : caller;
      const selected =
        form === "dot"
          ? "."
          : form === "sibling"
            ? path.relative(caller, grammarRoot)
            : grammarRoot;
      const env: NodeJS.ProcessEnv = { ...process.env, SYNTAX_ROOT: selected };
      delete env["SYNTAX_CORPUS"];

      const tokenization = spawnSync(process.execPath, ["-e", probe], {
        cwd,
        env,
        encoding: "utf8",
      });
      assert.equal(tokenization.status, 0, tokenization.stderr);
      const actual: unknown = JSON.parse(tokenization.stdout);
      assert.deepEqual(actual, {
        scopes: [scope],
        tokens: '1:0:6 "chosen" keyword.other.selected-root',
      });

      const portability = spawnSync(process.execPath, ["test", portabilityPath], {
        cwd,
        env,
        encoding: "utf8",
      });
      assert.equal(portability.status, 0, portability.stderr);
      assert.match(
        portability.stderr,
        /portable structure and includes: source\.syntax-root-fixture/,
      );
      assert.match(portability.stderr, /1 pass/);
    } finally {
      fs.rmSync(directory, { recursive: true });
    }
  });
}

for (const form of ["unset", "empty"]) {
  test(`SYNTAX_ROOT uses checkout grammars when ${form}`, () => {
    const env: NodeJS.ProcessEnv = { ...process.env };
    delete env["SYNTAX_CORPUS"];
    if (form === "unset") delete env["SYNTAX_ROOT"];
    else env["SYNTAX_ROOT"] = "";
    const manifest: unknown = JSON.parse(
      fs.readFileSync(path.join(import.meta.dirname, "../../package.json"), "utf8"),
    );
    assert.ok(isRecord(manifest));
    const contributes = manifest["contributes"];
    assert.ok(isRecord(contributes));
    const expected = contributes["grammars"];
    const result = spawnSync(
      process.execPath,
      [
        "-e",
        `const { registrations } = await import(${JSON.stringify(pathToFileURL(tokenizerPath).href)});
         console.log(JSON.stringify(registrations));`,
      ],
      { cwd: os.tmpdir(), env, encoding: "utf8" },
    );
    assert.equal(result.status, 0, result.stderr);
    const actual: unknown = JSON.parse(result.stdout);
    assert.deepEqual(actual, expected);
  });
}
