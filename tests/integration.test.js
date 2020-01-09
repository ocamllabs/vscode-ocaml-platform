const assert = require("assert");
const path = require("path");
const vscode = require("vscode");
const os = require("os");
const cp = require("child_process");
const fs = require("fs-extra");
const { Uri, extensions } = vscode;

let root = path.dirname(__dirname);
let fixtureSrcDir = path.join(__dirname, "fixtures");

suite("Basic tests", () => {
  let sampleOpamSrc = path.join(fixtureSrcDir, "sample-opam");
  let projectPath = path.join(os.tmpdir(), "sample-opam");
  let opamRoot = path.join(os.tmpdir(), "opam-root");
  let projectUri = Uri.file(projectPath);
  suiteSetup(() => async () => {
    fs.copySync(sampleOpamSrc, projectPath);
    if (!fs.existsSync(opamRoot)) {
      fs.mkdir(opamRoot);
    }
    await vscode.commands.executeCommand("vscode.openFolder", projectUri);
  });
  test("Trivial", async function() {
    this.skip();
    let ocamlDocument = await vscode.workspace.openTextDocument(
      Uri.file(path.join(projectPath, "main.ml"))
    );
    assert.ok(extensions.getExtension("ocamllabs.ocaml-platform").isActive);
    assert.equal(
      ocamlDocument.languageId,
      "ocaml",
      "Must be identified as an OCaml document"
    );
  }).timeout(2 * 60 * 1000);
  suiteTeardown(async () => {
    try {
      fs.removeSync(projectPath);
    } catch (e) {}
  });
});
