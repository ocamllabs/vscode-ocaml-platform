const assert = require("assert");
const path = require("path");
const vscode = require("vscode");
const os = require("os");
const { Uri } = vscode;

let projectPath = path.join(os.tmpdir(), "sample-esy");
let projectUri = Uri.file(projectPath);

suite("Basic tests", () => {
  test("Esy", async () => {
    await vscode.commands.executeCommand("vscode.openFolder", projectUri);
    let reasonDocument = await vscode.workspace.openTextDocument(
      Uri.file(path.join(projectPath, "bin", "SampleEsyApp.re"))
    );

    let ocamlDocument = await vscode.workspace.openTextDocument(
      Uri.file(path.join(projectPath, "bin", "CamlUtil.ml"))
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

    // TODO: the plugin could support build related tasks
    // const expected = [
    //   { subcommand: "build", group: vscode.TaskGroup.Build },
    //   { subcommand: "run", group: undefined }
    // ];
    // const tasks = await vscode.tasks.fetchTasks();
  }).timeout(100000000000); // Ridiculous I know. Sorry!
});
