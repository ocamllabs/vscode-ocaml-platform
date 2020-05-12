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

    function delay(timeout) {
      return new Promise((resolve) => {
        setTimeout(resolve, timeout);
      });
    }

    await delay(1000);
    let reasonDiagnostics = await vscode.languages.getDiagnostics(
      Uri.file(path.join(projectPath, "bin", "SampleEsyApp.re"))
    );
    let ocamlDiagnostics = await vscode.languages.getDiagnostics(
      Uri.file(path.join(projectPath, "bin", "CamlUtil.ml"))
    );
    if (process.platform != "win32" && process.platform != "win64") {
      assert.equal(
        reasonDiagnostics.length,
        1,
        "There should only be one diagnostic in the Reason source file"
      );
      assert.equal(
        reasonDiagnostics[0].message,
        "Warning 26: unused variable foo."
      );
      assert.equal(
        reasonDiagnostics[0].severity,
        1,
        "Severity of this diagnostic should be 1 (Warning). It was " +
          reasonDiagnostics[0].severity
      );
      assert.equal(reasonDiagnostics[0].range.start.line, 3);
      assert.equal(reasonDiagnostics[0].range.start.character, 6);
      assert.equal(reasonDiagnostics[0].range.end.line, 3);
      assert.equal(reasonDiagnostics[0].range.end.character, 9);

      assert.equal(
        ocamlDiagnostics.length,
        1,
        "There should only be one diagnostic in the OCaml source file"
      );
      assert.equal(
        ocamlDiagnostics[0].message,
        "Warning 26: unused variable bar."
      );
      assert.equal(
        ocamlDiagnostics[0].severity,
        1,
        "Severity of this diagnostic should be 1 (Warning). It was " +
          ocamlDiagnostics[0].severity
      );
      assert.equal(ocamlDiagnostics[0].range.start.line, 1);
      assert.equal(ocamlDiagnostics[0].range.start.character, 6);
      assert.equal(ocamlDiagnostics[0].range.end.line, 1);
      assert.equal(ocamlDiagnostics[0].range.end.character, 9);
    }

    // TODO: the plugin could support build related tasks
    // const expected = [
    //   { subcommand: "build", group: vscode.TaskGroup.Build },
    //   { subcommand: "run", group: undefined }
    // ];
    // const tasks = await vscode.tasks.fetchTasks();
  }).timeout(100000000000); // Ridiculous I know. Sorry!
});
