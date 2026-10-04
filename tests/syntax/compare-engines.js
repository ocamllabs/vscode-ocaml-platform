const assert = require("node:assert/strict");
const { execFileSync } = require("node:child_process");
const fs = require("node:fs");
const path = require("node:path");
const os = require("node:os");
const { loadWASM, OnigScanner } = require("vscode-oniguruma");

const checkout = path.resolve(__dirname, "../..");
const root = path.resolve(process.env.SYNTAX_ROOT || checkout);
const base = process.argv[2] || "origin/master";
const ruby = process.argv[3] || "ruby";
const regexKeys = new Set(["match", "begin", "end", "while"]);

function* expressions(value, location = "") {
  if (!value || typeof value !== "object") return;
  for (const [key, child] of Object.entries(value)) {
    const childLocation = `${location}/${key}`;
    if (regexKeys.has(key) && typeof child === "string") {
      yield { path: childLocation, regex: child, kind: key };
    }
    yield* expressions(child, childLocation);
  }
}

async function compare() {
  const patterns = [];
  const dynamic = [];
  const seen = new Set();
  for (const filename of fs.readdirSync(path.join(root, "syntaxes")).sort()) {
    const file = `syntaxes/${filename}`;
    const previous = JSON.parse(
      execFileSync("git", ["show", `${base}:${file}`], { cwd: root, encoding: "utf8" }),
    );
    const current = JSON.parse(fs.readFileSync(path.join(root, file), "utf8"));
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

  const lines = new Set();
  const directory = fs.mkdtempSync(path.join(os.tmpdir(), "ocaml-syntax-corpus-"));
  try {
    const corpus = path.join(directory, "inputs.jsonl");
    execFileSync("bun", ["test", __dirname], {
      cwd: checkout,
      env: { ...process.env, SYNTAX_ROOT: root, CI: "true", SYNTAX_CORPUS: corpus },
      encoding: "utf8",
      stdio: ["ignore", "pipe", "pipe"],
      maxBuffer: 32 * 1024 * 1024,
    });
    for (const entry of fs.readFileSync(corpus, "utf8").trimEnd().split("\n")) {
      const { source } = JSON.parse(entry);
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
  assert.ok(patterns.length, `No changed standalone expressions against ${base}`);
  const other = JSON.parse(
    execFileSync(ruby, [path.join(__dirname, "ruby-match.rb")], {
      input: JSON.stringify(input),
      encoding: "utf8",
      maxBuffer: 32 * 1024 * 1024,
    }),
  );
  assert.equal(other.results.length, patterns.length);
  await loadWASM(fs.readFileSync(require.resolve("vscode-oniguruma/release/onig.wasm")));
  for (const [index, entry] of patterns.entries()) {
    const scanner = new OnigScanner([entry.regex]);
    try {
      const expected = input.lines.map((line) => {
        const match = scanner.findNextMatchSync(line, 0);
        if (!match) return null;
        return {
          start: match.captureIndices[0].start,
          end: match.captureIndices[0].end,
          captures: match.captureIndices.map((capture) => line.slice(capture.start, capture.end)),
        };
      });
      assert.deepEqual(
        other.results[index],
        expected,
        `${entry.file}${entry.path}: ${entry.regex}`,
      );
    } finally {
      scanner.dispose();
    }
  }
  console.log(
    `${patterns.length * lines.size} regex/input comparisons agree with Ruby ${other.version}.`,
  );
  for (const entry of dynamic) {
    console.log(`TextMate state tests cover parent-dependent ${entry.file}${entry.path}.`);
  }
}

compare().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
