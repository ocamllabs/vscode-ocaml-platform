// eslint-disable-next-line import/no-unresolved
import { commands, ExtensionContext, workspace } from "vscode";
import {
  LanguageClient,
  LanguageClientOptions,
  ServerOptions
} from "vscode-languageclient";

let client: LanguageClient;

export async function activate(context: ExtensionContext) {
  // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
  const command = workspace.getConfiguration().get<string>("ocaml.lsp.path")!;
  const args: Array<string> = [];

  const commonOptions = {
    command,
    args,
    options: {
      env: {
        ...process.env,
        OCAMLRUNPARAM: "b",
        MERLIN_LOG: "-"
      }
    }
  };

  // If the extension is launched in debug mode then the debug server options are used
  // Otherwise the run options are used
  const serverOptions: ServerOptions = {
    run: commonOptions,
    debug: commonOptions
  };

  // Options to control the language client
  const clientOptions: LanguageClientOptions = {
    // Register the server for plain text documents
    documentSelector: [
      { scheme: "file", language: "ocaml" },
      { scheme: "file", language: "reason" },
      { scheme: "file", language: "ocamllex" }
    ],
    synchronize: {
      // Notify the server about file changes to '.clientrc files contained in the workspace
      fileEvents: workspace.createFileSystemWatcher("**/.clientrc")
    }
  };

  const createClient = () => {
    return new LanguageClient(
      "ocaml-language-server",
      "OCaml Language Server",
      serverOptions,
      clientOptions
    );
  };

  // Create the language client and start the client.
  client = createClient();

  // Start the client. This will also launch the server
  client.start();

  commands.registerCommand("ocaml-language-server.restart", () => {
    if (client) {
      client.stop();
    }
    activate(context);
  });
}

export function deactivate() {
  if (!client) {
    return undefined;
  }
  return client.stop();
}
