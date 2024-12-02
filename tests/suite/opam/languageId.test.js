const assert = require("node:assert/strict");
const path = require("node:path");
const vscode = require("vscode");

const root = path.resolve(__dirname, "../../../");
const fixtureSrcDir = path.join(root, "tests", "fixtures");
const sampleOpamSrc = path.join(fixtureSrcDir, "sample-opam");

suite("opam", () => {
  test("languageId", async () => {
    const foo = await vscode.workspace.openTextDocument(
      vscode.Uri.file(path.join(sampleOpamSrc, "foo.ml")),
    );
    const main = await vscode.workspace.openTextDocument(
      vscode.Uri.file(path.join(sampleOpamSrc, "main.ml")),
    );

    assert.strictEqual(
      foo.languageId,
      "ocaml",
      "Must be identified as an OCaml document",
    );
    assert.strictEqual(
      main.languageId,
      "ocaml",
      "Must be identified as an OCaml document",
    );
  });
});
