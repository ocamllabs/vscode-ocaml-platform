const assert = require("assert");
const path = require("path");
const vscode = require("vscode");
const os = require("os");
const cp = require("child_process");
const fs = require("fs-extra");
const { Uri } = vscode;

let root = path.dirname(path.dirname(__dirname));
let fixtureSrcDir = path.join(root, "fixtures");

suite("Basic tests", () => {
  test("Bsb", async () => {
    let sampleEsySrc = path.join(fixtureSrcDir, "sample-bsb");
    let projectPath = path.join(os.tmpdir(), "sample-bsb");
    let projectUri = Uri.file(projectPath);

    fs.copySync(sampleEsySrc, projectPath);
    cp.execSync("npm i", { cwd: projectPath });

    await vscode.commands.executeCommand("vscode.openFolder", projectUri);
    let reasonDocument = await vscode.workspace.openTextDocument(
      Uri.file(path.join(projectPath, "src", "Lib.re"))
    );

    let ocamlDocument = await vscode.workspace.openTextDocument(
      Uri.file(path.join(projectPath, "src", "main.ml"))
    );

    assert.equal(
      reasonDocument.languageId,
      "reason",
      "Must be identified as a Reason document"
    );

    assert.equal(
      ocamlDocument.languageId,
      "ocaml",
      "Must be identified as an OCaml document"
    );

    function delay(timeout) {
      return new Promise(resolve => {
        setTimeout(resolve, timeout);
      });
    }

    await delay(500);
    let diagnostics = await vscode.languages.getDiagnostics(
      Uri.file(path.join(projectPath, "lib", "Lib.re"))
    );

    assert.equal(diagnostics.length, 0, "There should only be one diagnostic");

    // TODO: the plugin could support build related tasks
    // const expected = [
    //   { subcommand: "build", group: vscode.TaskGroup.Build },
    //   { subcommand: "run", group: undefined }
    // ];
    // const tasks = await vscode.tasks.fetchTasks();

    console.log("Cleaning up...");
    try {
      fs.removeSync(projectPath);
    } catch (e) {}
  }).timeout(100000000000); // Ridiculous I know. Sorry!
});
