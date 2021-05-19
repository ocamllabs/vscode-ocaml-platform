import { DownloadVersion, DownloadPlatform } from "./download";
export interface TestOptions {
  /**
   * The VS Code executable path used for testing.
   *
   * If not passed, will use `options.version` to download a copy of VS Code for testing.
   * If `version` is not specified either, will download and use latest stable release.
   */
  vscodeExecutablePath?: string;
  /**
   * The VS Code version to download. Valid versions are:
   * - `'stable'`
   * - `'insiders'`
   * - `'1.32.0'`, `'1.31.1'`, etc
   *
   * Defaults to `stable`, which is latest stable version.
   *
   * *If a local copy exists at `.vscode-test/vscode-<VERSION>`, skip download.*
   */
  version?: DownloadVersion;
  /**
   * The VS Code platform to download. If not specified, defaults to:
   * - Windows: `win32-archive`
   * - macOS: `darwin`
   * - Linux: `linux-x64`
   *
   * Possible values are: `win32-archive`, `win32-x64-archive`, `darwin` and `linux-x64`.
   */
  platform?: DownloadPlatform;
  /**
   * Absolute path to the extension root. Passed to `--extensionDevelopmentPath`.
   * Must include a `package.json` Extension Manifest.
   */
  extensionDevelopmentPath: string;
  /**
   * Absolute path to the extension tests runner. Passed to `--extensionTestsPath`.
   * Can be either a file path or a directory path that contains an `index.js`.
   * Must export a `run` function of the following signature:
   *
   * ```ts
   * function run(): Promise<void>;
   * ```
   *
   * When running the extension test, the Extension Development Host will call this function
   * that runs the test suite. This function should throws an error if any test fails.
   *
   */
  extensionTestsPath: string;
  /**
   * Environment variables being passed to the extension test script.
   */
  extensionTestsEnv?: {
    [key: string]: string | undefined;
  };
  /**
   * A list of launch arguments passed to VS Code executable, in addition to `--extensionDevelopmentPath`
   * and `--extensionTestsPath` which are provided by `extensionDevelopmentPath` and `extensionTestsPath`
   * options.
   *
   * If the first argument is a path to a file/folder/workspace, the launched VS Code instance
   * will open it.
   *
   * See `code --help` for possible arguments.
   */
  launchArgs?: string[];
}
/**
 * Run VS Code extension test
 *
 * @returns The exit code of the command to launch VS Code extension test
 */
export declare function runTests(options: TestOptions): Promise<number>;
