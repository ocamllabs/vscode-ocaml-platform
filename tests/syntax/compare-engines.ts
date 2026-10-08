import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";

import { loadWASM, OnigScanner } from "vscode-oniguruma";

import { checkout, grammarRoot, isRecord } from "./manifest.ts";

const base = process.argv[2] || "origin/master";
const ruby = process.argv[3] || "ruby";
const regexKeys = new Set(["match", "begin", "end", "while"]);

type RegexExpression = { path: string; regex: string; kind: string };

function* expressions(value: unknown, location = ""): Generator<RegexExpression, void, unknown> {
  if (Array.isArray(value)) {
    const items: unknown[] = value;
    for (const [index, item] of items.entries()) yield* expressions(item, `${location}/${index}`);
    return;
  }
  if (!isRecord(value)) return;
  for (const [key, child] of Object.entries(value)) {
    const childLocation = `${location}/${key}`;
    if (regexKeys.has(key) && typeof child === "string") {
      yield { path: childLocation, regex: child, kind: key };
    }
    yield* expressions(child, childLocation);
  }
}

async function compare() {
  const patterns: (RegexExpression & { file: string })[] = [];
  const dynamic: (RegexExpression & { file: string })[] = [];
  const seen = new Set<string>();
  const baseFiles = new Set(
    execFileSync("git", ["ls-tree", "--name-only", base, "syntaxes/"], {
      cwd: grammarRoot,
      encoding: "utf8",
    }).split("\n"),
  );
  for (const filename of fs.readdirSync(path.join(grammarRoot, "syntaxes")).sort()) {
    if (!filename.endsWith(".json")) continue;
    const file = `syntaxes/${filename}`;
    const previous: unknown = baseFiles.has(file)
      ? JSON.parse(
          execFileSync("git", ["show", `${base}:${file}`], { cwd: grammarRoot, encoding: "utf8" }),
        )
      : {};
    const current: unknown = JSON.parse(fs.readFileSync(path.join(grammarRoot, file), "utf8"));
    const oldExpressions = new Set([...expressions(previous)].map((entry) => entry.regex));
    for (const entry of expressions(current)) {
      if (oldExpressions.has(entry.regex) || seen.has(entry.regex)) continue;
      seen.add(entry.regex);
      if (["end", "while"].includes(entry.kind) && /(?<!\\)\\[1-9]\d*/.test(entry.regex)) {
        dynamic.push({ file, ...entry });
      } else {
        patterns.push({ file, ...entry });
      }
    }
  }

  assert.ok(patterns.length, `No changed standalone expressions against ${base}`);
  const lines = new Set<string>();
  const directory = fs.mkdtempSync(path.join(os.tmpdir(), "ocaml-syntax-corpus-"));
  try {
    const corpus = path.join(directory, "inputs.jsonl");
    execFileSync(process.execPath, ["test", import.meta.dirname], {
      cwd: checkout,
      env: { ...process.env, SYNTAX_ROOT: grammarRoot, CI: "true", SYNTAX_CORPUS: corpus },
      encoding: "utf8",
      stdio: ["ignore", "pipe", "pipe"],
      maxBuffer: 32 * 1024 * 1024,
    });
    for (const entry of fs.readFileSync(corpus, "utf8").trimEnd().split("\n")) {
      const input: unknown = JSON.parse(entry);
      assert.ok(isRecord(input), "Expected a corpus entry");
      const source = input["source"];
      assert.ok(typeof input["scope"] === "string", "Expected a corpus scope");
      assert.ok(typeof source === "string", "Expected corpus source text");
      for (const line of source.split("\n")) lines.add(line);
    }
  } finally {
    fs.rmSync(directory, { recursive: true });
  }
  for (const line of [
    "é",
    "𐐀",
    "ŒœŠšŸÿẞß",
    "a\u0301",
    "let é = 1",
    "let 中文 = 1",
    "(library\u00a0(name a))",
    "(library\v(name a))",
    "~~~ocaml",
    "`````ocaml",
    "  ~~~reason attrs",
    "let*~ x",
    "let*! x",
    "\\#type",
    "##",
  ])
    lines.add(line);
  const input = { patterns, lines: [...lines].sort((left, right) => left.localeCompare(right)) };
  const other: unknown = JSON.parse(
    execFileSync(ruby, [path.join(import.meta.dirname, "ruby-match.rb")], {
      input: JSON.stringify(input),
      encoding: "utf8",
      maxBuffer: 32 * 1024 * 1024,
    }),
  );
  assert.ok(isRecord(other), "Expected a Ruby comparison response");
  const version = other["version"];
  const results = other["results"];
  assert.ok(typeof version === "string", "Expected the Ruby version");
  assert.ok(Array.isArray(results), "Expected Ruby match results");
  const rows: unknown[] = results;
  assert.equal(rows.length, patterns.length);
  await loadWASM(
    fs.readFileSync(new URL(import.meta.resolve("vscode-oniguruma/release/onig.wasm"))),
  );
  for (const [index, entry] of patterns.entries()) {
    const scanner = new OnigScanner([entry.regex]);
    try {
      const expected = input.lines.map((line) => {
        const match = scanner.findNextMatchSync(line, 0);
        if (!match) return null;
        const [fullMatch] = match.captureIndices;
        assert.ok(fullMatch);
        return {
          start: fullMatch.start,
          end: fullMatch.end,
          captures: match.captureIndices.map((capture) => line.slice(capture.start, capture.end)),
        };
      });
      assert.deepEqual(rows[index], expected, `${entry.file}${entry.path}: ${entry.regex}`);
    } finally {
      scanner.dispose();
    }
  }
  console.log(
    `${patterns.length * lines.size} regex/input comparisons agree with Ruby ${version}.`,
  );
  for (const entry of dynamic) {
    console.log(`TextMate state tests cover parent-dependent ${entry.file}${entry.path}.`);
  }
}

compare().catch((error: unknown) => {
  console.error(error);
  process.exitCode = 1;
});
