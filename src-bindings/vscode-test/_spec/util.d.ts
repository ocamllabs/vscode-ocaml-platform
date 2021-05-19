/// <reference types="node" />
import * as https from "https";
import { DownloadPlatform } from "./download";
export declare let systemDefaultPlatform: string;
export declare function getVSCodeDownloadUrl(
  version: string,
  platform?: DownloadPlatform
): string;
export declare function urlToOptions(url: string): https.RequestOptions;
export declare function downloadDirToExecutablePath(dir: string): string;
export declare function insidersDownloadDirToExecutablePath(
  dir: string
): string;
export declare function insidersDownloadDirMetadata(
  dir: string
): {
  version: any;
  date: any;
};
export interface IUpdateMetadata {
  url: string;
  name: string;
  version: string;
  productVersion: string;
  hash: string;
  timestamp: number;
  sha256hash: string;
  supportsFastUpdate: boolean;
}
export declare function getLatestInsidersMetadata(
  platform: string
): Promise<IUpdateMetadata>;
/**
 * Resolve the VS Code cli path from executable path returned from `downloadAndUnzipVSCode`.
 * You can use this path to spawn processes for extension management. For example:
 *
 * ```ts
 * const cp = require('child_process');
 * const { downloadAndUnzipVSCode, resolveCliPathFromExecutablePath } = require('vscode-test')
 * const vscodeExecutablePath = await downloadAndUnzipVSCode('1.36.0');
 * const cliPath = resolveCliPathFromExecutablePath(vscodeExecutablePath);
 *
 * cp.spawnSync(cliPath, ['--install-extension', '<EXTENSION-ID-OR-PATH-TO-VSIX>'], {
 *   encoding: 'utf-8',
 *   stdio: 'inherit'
 * });
 * ```
 *
 * @param vscodeExecutablePath The `vscodeExecutablePath` from `downloadAndUnzipVSCode`.
 */
export declare function resolveCliPathFromVSCodeExecutablePath(
  vscodeExecutablePath: string
): string;
