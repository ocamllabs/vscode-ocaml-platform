// eslint-disable-next-line import/no-unresolved
import { commands, ExtensionContext, workspace } from "vscode";
import {
  LanguageClient,
  LanguageClientOptions,
  ServerOptions,
} from "vscode-languageclient";

let client: LanguageClient;

export async function activate(context: ExtensionContext) {
  // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
  const command = workspace.getConfiguration().get<string>("ocaml.lsp.path")!;
  const args: Array<string> = [];

  const commonOptions = {
    command,
    args,
    options: { env: { ...process.env, OCAMLRUNPARAM: "b", MERLIN_LOG: "-" } },
  };

  const serverOptions: ServerOptions = {
    run: commonOptions,
    debug: commonOptions,
  };

  const clientOptions: LanguageClientOptions = {
    documentSelector: [
      { scheme: "file", language: "ocaml" },
      { scheme: "file", language: "reason" },
      { scheme: "file", language: "ocamllex" },
    ],
  };

  const createClient = () => {
    return new LanguageClient(
      "ocaml-language-server",
      "OCaml Language Server",
      serverOptions,
      clientOptions
    );
  };

  client = createClient();

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
