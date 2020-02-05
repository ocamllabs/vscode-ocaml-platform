import fs from "fs-extra";
import os from "os";
import path from "path";
// eslint-disable-next-line import/no-unresolved
import vscode from "vscode";

suite("Basic tests", () => {
  const fixtureSrcDir = path.join(__dirname, "fixtures");
  const sampleOpamSrc = path.join(fixtureSrcDir, "sample-opam");
  const projectPath = path.join(os.tmpdir(), "sample-opam");
  const opamRoot = path.join(os.tmpdir(), "opam-root");
  const projectUri = vscode.Uri.file(projectPath);

  suiteSetup(() => async () => {
    fs.copySync(sampleOpamSrc, projectPath);
    if (!fs.existsSync(opamRoot)) {
      fs.mkdir(opamRoot);
    }
    await vscode.commands.executeCommand("vscode.openFolder", projectUri);
  });

  test("Trivial", async function() {
    this.skip();
    // const ocamlDocument = await vscode.workspace.openTextDocument(
    //   Uri.file(path.join(projectPath, "main.ml"))
    // );
    // assert.ok(extensions.getExtension("ocamllabs.ocaml-platform").isActive);
    // assert.equal(
    //   ocamlDocument.languageId,
    //   "ocaml",
    //   "Must be identified as an OCaml document"
    // );
  }).timeout(2 * 60 * 1000);

  suiteTeardown(async () => {
    try {
      fs.removeSync(projectPath);
    } catch (err) {
      console.error(err);
    }
  });
});
