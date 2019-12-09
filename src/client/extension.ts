/* --------------------------------------------------------------------------------------------
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for license information.
 * ------------------------------------------------------------------------------------------ */

import { workspace, ExtensionContext, commands } from "vscode";

import {
    LanguageClient,
    LanguageClientOptions,
    ServerOptions
} from "vscode-languageclient";

let client: LanguageClient;

export async function activate(context: ExtensionContext) {
    let command : string = workspace.getConfiguration().get<string>('ocaml.lsp.path')!;
    let args : Array<string> = [];

    let commonOptions = {
        command,
        args,
        options: {
            env: {
                ...process.env,
                OCAMLRUNPARAM: "b",
                MERLIN_LOG: "-"
            }
        }
    }

    // If the extension is launched in debug mode then the debug server options are used
    // Otherwise the run options are used
    let serverOptions: ServerOptions = {
        run: commonOptions,
        debug: commonOptions
    };

    // Options to control the language client
    let clientOptions: LanguageClientOptions = {
        // Register the server for plain text documents
        documentSelector: [
            { scheme: "file", language: "ocaml" }
        ],
        synchronize: {
            // Notify the server about file changes to '.clientrc files contained in the workspace
            fileEvents: workspace.createFileSystemWatcher("**/.clientrc")
        }
    };

    let createClient = () => {
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

    commands.registerCommand('ocaml-language-server.restart', () => {
        if (client) {
            client.stop();
        }
        activate(context);
    });
}

export function deactivate(): Thenable<void> | undefined {
    if (!client) {
        return undefined;
    }
    return client.stop();
}
