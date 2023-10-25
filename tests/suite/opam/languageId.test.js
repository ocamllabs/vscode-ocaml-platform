const assert = require("node:assert");
const child_process = require("node:child_process");
const os = require("node:os");
const path = require("node:path");
const process = require("node:process");
const util = require("node:util");

const fs = require("fs-extra");
const vscode = require("vscode");
const { Uri } = require("vscode");

const exec = util.promisify(child_process.exec);

const root = path.resolve(__dirname, "../../../");
const fixtureSrcDir = path.join(root, "tests", "fixtures");
const sampleOpamSrc = path.join(fixtureSrcDir, "sample-opam");
const projectPath = path.join(os.tmpdir(), "sample-opam");

setup(async () => {
  await fs.copy(sampleOpamSrc, projectPath);

  await exec("opam install . --deps-only --yes", {
    cwd: projectPath,
    env: { ...process.env, PATH: process.env.PATH, OPAMSWITCH: root },
  });

  await vscode.commands.executeCommand(
    "vscode.openFolder",
    Uri.file(projectPath),
  );
});

teardown(async () => {
  await fs.remove(projectPath);
});

suite("opam", () => {
  if (process.platform === "win32") return;

  test("languageId", async () => {
    const ocamlDocument1 = await vscode.workspace.openTextDocument(
      Uri.file(path.join(projectPath, "foo.ml")),
    );
    const ocamlDocument2 = await vscode.workspace.openTextDocument(
      Uri.file(path.join(projectPath, "main.ml")),
    );

    assert.strictEqual(
      ocamlDocument1.languageId,
      "ocaml",
      "Must be identified as an OCaml document",
    );
    assert.strictEqual(
      ocamlDocument2.languageId,
      "ocaml",
      "Must be identified as an OCaml document",
    );
  });
});
