import * as assert from "node:assert";
import * as child_process from "node:child_process";
import * as os from "node:os";
import * as path from "node:path";
import * as process from "node:process";
import * as util from "node:util";

import * as fs from "fs-extra";
import * as vscode from "vscode";

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
    vscode.Uri.file(projectPath),
  );
});

teardown(async () => {
  await fs.remove(projectPath);
});

suite("opam", () => {
  if (process.platform === "win32") return;

  test("languageId", async () => {
    const ocamlDocument1 = await vscode.workspace.openTextDocument(
      vscode.Uri.file(path.join(projectPath, "foo.ml")),
    );
    const ocamlDocument2 = await vscode.workspace.openTextDocument(
      vscode.Uri.file(path.join(projectPath, "main.ml")),
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
