const assert = require("node:assert/strict");
const vscode = require("vscode");

async function waitFor(assertion, timeoutMs = 20000) {
  const deadline = Date.now() + timeoutMs;
  let lastError;

  while (Date.now() < deadline) {
    try {
      return await assertion();
    } catch (error) {
      lastError = error;
      await new Promise((resolve) => setTimeout(resolve, 250));
    }
  }

  throw new Error(`Condition was not met within ${timeoutMs}ms`, { cause: lastError });
}

function hoverText(hover) {
  return hover.contents
    .map((content) => (typeof content === "string" ? content : content.value))
    .join("\n");
}

suite("extension", () => {
  let extension;
  let mainUri;

  suiteSetup(() => {
    extension = vscode.extensions.getExtension("ocamllabs.ocaml-platform");
    assert.ok(extension, "OCaml Platform extension should be installed for tests");

    const workspaceFolder = vscode.workspace.workspaceFolders?.[0];
    assert.ok(workspaceFolder, "The OCaml fixture workspace should be open for tests");
    mainUri = vscode.Uri.joinPath(workspaceFolder.uri, "main.ml");
  });

  test("activates automatically for an OCaml workspace", async () => {
    await waitFor(() => {
      assert.equal(
        extension.isActive,
        true,
        "Extension should activate automatically for an OCaml workspace",
      );
    });
  });

  test("serves OCaml LSP hover requests", async () => {
    await waitFor(() => {
      assert.equal(
        extension.isActive,
        true,
        "Extension should be active before requesting a hover",
      );
    });

    const document = await vscode.workspace.openTextDocument(mainUri);
    await vscode.window.showTextDocument(document);

    await waitFor(async () => {
      const hovers = await vscode.commands.executeCommand(
        "vscode.executeHoverProvider",
        mainUri,
        new vscode.Position(0, 4),
      );

      assert.ok(hovers?.length > 0, "Expected at least one LSP hover result");
      assert.match(
        hovers.map(hoverText).join("\n"),
        /\bint\b/,
        "Expected hover text to include the inferred int type",
      );
    });
  });
});
