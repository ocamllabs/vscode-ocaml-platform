const assert = require("assert");
const cp = require("child_process");
const fs = require("fs-extra");
const os = require("os");
const path = require("path");
const process = require("process");
const vscode = require("vscode");
const { Uri } = vscode;

const root = path.dirname(path.dirname(__dirname));
const fixtureSrcDir = path.join(root, "fixtures");

suite("Basic tests", () => {
  test("Opam tests", async () => {
    if (process.platform === "win32" || process.platform === "win64") {
      return;
    }

    const sampleOpamSrc = path.join(fixtureSrcDir, "sample-opam");
    const projectPath = path.join(os.tmpdir(), "sample-opam");
    const opamRoot = path.join(os.tmpdir(), "opam-root");
    fs.copySync(sampleOpamSrc, projectPath);
    cp.execSync(`mkdir -p ${opamRoot}`);
    cp.execSync(`sh -c 'opam install . --deps-only --yes > /dev/null'`, {
      cwd: projectPath,
    }).toString();
    const projectUri = Uri.file(projectPath);
    await vscode.commands.executeCommand("vscode.openFolder", projectUri);
    const ocamlDocument1 = await vscode.workspace.openTextDocument(
      Uri.file(path.join(projectPath, "foo.ml"))
    );

    const ocamlDocument2 = await vscode.workspace.openTextDocument(
      Uri.file(path.join(projectPath, "main.ml"))
    );

    assert.strictEqual(
      ocamlDocument1.languageId,
      "ocaml",
      "Must be identified as an OCaml document"
    );
    assert.strictEqual(
      ocamlDocument2.languageId,
      "ocaml",
      "Must be identified as an OCaml document"
    );
    console.log("Cleaning up (opam)...");
    try {
      console.log("  Removing switch");
      console.log(cp.execSync("opam switch remove e2e --yes").toString());
      console.log("  Removing test project");
      fs.removeSync(projectPath);
    } catch (e) {}
  }).timeout(100000000000);
});
