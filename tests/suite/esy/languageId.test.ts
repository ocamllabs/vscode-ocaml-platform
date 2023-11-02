import * as assert from "node:assert";
import * as child_process from "node:child_process";
import * as os from "node:os";
import * as path from "node:path";
import * as util from "node:util";

import * as fs from "fs-extra";
import * as vscode from "vscode";

const exec = util.promisify(child_process.exec);

const root = path.resolve(__dirname, "../../../");
const fixtureSrcDir = path.join(root, "tests", "fixtures");
const sampleEsySrc = path.join(fixtureSrcDir, "sample-opam");
const projectPath = path.join(os.tmpdir(), "sample-opam");

setup(async () => {
  await fs.copy(sampleEsySrc, projectPath);

  await exec("esy", { cwd: projectPath });

  await fs.writeFile(
    path.join(projectPath, ".vscode", "settings.json"),
    JSON.stringify({ "ocaml.sandbox": { root: projectPath, kind: "esy" } }),
  );

  await vscode.commands.executeCommand(
    "vscode.openFolder",
    vscode.Uri.file(projectPath),
  );
});

teardown(async () => {
  await fs.remove(projectPath);
});

suite("esy", () => {
  test("languageId", async () => {
    const ocamlDocument1 = await vscode.workspace.openTextDocument(
      vscode.Uri.file(path.join(projectPath, "bin", "SampleEsyApp.ml")),
    );
    const ocamlDocument2 = await vscode.workspace.openTextDocument(
      vscode.Uri.file(path.join(projectPath, "bin", "CamlUtil.ml")),
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
