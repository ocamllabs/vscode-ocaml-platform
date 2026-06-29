const assert = require("node:assert/strict");
const path = require("node:path");
const vscode = require("vscode");

const root = path.resolve(__dirname, "../../../");
const lspFixture = path.join(root, "tests", "fixtures", "lsp");

async function waitFor(assertion, timeoutMs = 15000) {
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

  throw lastError;
}

function hoverText(hover) {
  return hover.contents
    .map((content) => (typeof content === "string" ? content : content.value))
    .join("\n");
}

suite("extension", () => {
  test("activates and serves OCaml LSP requests", async () => {
    const extension = vscode.extensions.getExtension("ocamllabs.ocaml-platform");
    assert.ok(extension, "OCaml Platform extension should be installed for tests");

    await extension.activate();
    assert.equal(extension.isActive, true, "Extension should activate successfully");

    const uri = vscode.Uri.file(path.join(lspFixture, "main.ml"));
    const document = await vscode.workspace.openTextDocument(uri);
    await vscode.window.showTextDocument(document);

    await waitFor(async () => {
      const hovers = await vscode.commands.executeCommand(
        "vscode.executeHoverProvider",
        uri,
        new vscode.Position(0, 4),
      );

      assert.ok(hovers?.length > 0, "Expected at least one LSP hover result");
      assert.match(
        hovers.map(hoverText).join("\n"),
        /int/,
        "Expected hover text to include the inferred int type",
      );
    });
  });
});
