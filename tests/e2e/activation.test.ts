import assert from "node:assert/strict";

import * as vscode from "vscode";

async function waitFor(assertion: () => void | PromiseLike<void>, timeoutMs = 20000) {
  const deadline = Date.now() + timeoutMs;
  let lastError: unknown;

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

function hoverText(hover: vscode.Hover) {
  return hover.contents
    .map((content) => (typeof content === "string" ? content : content.value))
    .join("\n");
}

suite("extension", () => {
  let extension: vscode.Extension<unknown>;
  let mainUri: vscode.Uri;

  suiteSetup(() => {
    const installedExtension = vscode.extensions.getExtension<unknown>("ocamllabs.ocaml-platform");
    assert.ok(installedExtension, "OCaml Platform extension should be installed for tests");
    extension = installedExtension;

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
      const hovers = await vscode.commands.executeCommand<vscode.Hover[] | undefined>(
        "vscode.executeHoverProvider",
        mainUri,
        new vscode.Position(0, 4),
      );

      assert.ok(hovers && hovers.length > 0, "Expected at least one LSP hover result");
      assert.match(
        hovers.map(hoverText).join("\n"),
        /\bint\b/,
        "Expected hover text to include the inferred int type",
      );
    });
  });
});
