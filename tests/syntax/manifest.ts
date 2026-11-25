import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";

import type { IRawGrammar } from "vscode-textmate";

export type GrammarRegistration = {
  scopeName: IRawGrammar["scopeName"];
  path: string;
  injectTo?: string[];
};

export function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function registration(value: unknown): GrammarRegistration {
  assert.ok(isRecord(value), "Expected a grammar registration object");
  const scopeName = value["scopeName"];
  const filename = value["path"];
  const injectTo = value["injectTo"];
  assert.ok(typeof scopeName === "string", "Expected a grammar scopeName");
  assert.ok(typeof filename === "string", "Expected a grammar path");
  if (injectTo === undefined) return { ...value, scopeName, path: filename };
  assert.ok(Array.isArray(injectTo), "Expected an injectTo array");
  const targets = injectTo.map((target: unknown) => {
    assert.ok(typeof target === "string", "Expected an injection scope name");
    return target;
  });
  return { ...value, scopeName, path: filename, injectTo: targets };
}

function parseRegistrations(value: unknown): GrammarRegistration[] {
  assert.ok(isRecord(value), "Expected a package manifest object");
  const contributes = value["contributes"];
  assert.ok(isRecord(contributes), "Expected package contributions");
  const grammars = contributes["grammars"];
  assert.ok(Array.isArray(grammars), "Expected grammar registrations");
  return grammars.map(registration);
}

export const checkout = path.resolve(import.meta.dirname, "../..");
export const grammarRoot = path.resolve(process.env["SYNTAX_ROOT"] || checkout);
const manifest: unknown = JSON.parse(
  fs.readFileSync(path.join(grammarRoot, "package.json"), "utf8"),
);
export const registrations = parseRegistrations(manifest);
