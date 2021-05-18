const assert = require("assert");
const path = require("path");
const vscode = require("vscode");
const os = require("os");
const { Uri } = vscode;

const projectPath = path.join(os.tmpdir(), "sample-esy");
const projectUri = Uri.file(projectPath);

suite("Basic tests", () => {
  test("Esy", async () => {
    await vscode.commands.executeCommand("vscode.openFolder", projectUri);
    const ocamlDocument1 = await vscode.workspace.openTextDocument(
      Uri.file(path.join(projectPath, "bin", "SampleEsyApp.ml"))
    );

    const ocamlDocument2 = await vscode.workspace.openTextDocument(
      Uri.file(path.join(projectPath, "bin", "CamlUtil.ml"))
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

    // TODO: the plugin could support build related tasks
    // const expected = [
    //   { subcommand: "build", group: vscode.TaskGroup.Build },
    //   { subcommand: "run", group: undefined }
    // ];
    // const tasks = await vscode.tasks.fetchTasks();
  }).timeout(100000000000); // Ridiculous I know. Sorry!
});
