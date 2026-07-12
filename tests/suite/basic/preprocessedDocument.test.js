const assert = require("node:assert/strict");
const { execFile } = require("node:child_process");
const fs = require("node:fs/promises");
const os = require("node:os");
const path = require("node:path");
const { setTimeout } = require("node:timers/promises");
const { promisify } = require("node:util");
const vscode = require("vscode");

const root = path.resolve(__dirname, "../../../");

const duneEnvVars = ["DUNE_BUILD_DIR", "DUNE_ROOT", "DUNE_WORKSPACE", "DUNE_CROSS_TARGET"];
const duneShimEnvVars = [
  "OCAML_PLATFORM_TEST_DUNE_PATH",
  "OCAML_PLATFORM_TEST_DUNE_BUILD_DIR",
  "OCAML_PLATFORM_TEST_DUNE_FAIL_CONTEXTS",
];
const execFilePromise = promisify(execFile);
// Resolved eagerly at load time, before extension activation can start a dune
// build that locks the repository's build directory. When the resolution
// fails, runDune falls back to the inherited PATH (as in opam environments).
const compilerBinPromise = findCompilerBin().catch(() => undefined);

function saveEnvironment(names) {
  return Object.fromEntries(names.map((name) => [name, process.env[name]]));
}

function restoreEnvironment(saved) {
  for (const [name, value] of Object.entries(saved)) {
    if (value === undefined) delete process.env[name];
    else process.env[name] = value;
  }
}

async function activateExtension() {
  const extension = vscode.extensions.getExtension("ocamllabs.ocaml-platform");
  assert.notStrictEqual(extension, undefined, "The OCaml Platform extension must be installed");
  await extension.activate();
}

async function duneVersionAtLeast(major, minor) {
  const version = await new Promise((resolve) => {
    execFile("dune", ["--version"], (error, stdout) => resolve(error ? undefined : stdout.trim()));
  });
  if (version === undefined) return false;
  const release = version.match(/^(\d+)\.(\d+)/);
  // Nightly builds report a description instead of a release number and
  // support everything the extension version-gates on.
  if (release === null) return true;
  const [, currentMajor, currentMinor] = release.map(Number);
  return currentMajor > major || (currentMajor === major && currentMinor >= minor);
}

async function findCompilerBin() {
  const toolEnv = { ...process.env };
  for (const name of duneEnvVars) delete toolEnv[name];
  delete toolEnv.DUNE_RPC;
  delete toolEnv.INSIDE_DUNE;
  const { stdout } = await execFilePromise("dune", ["exec", "--", "ocamlc", "-where"], {
    cwd: root,
    env: toolEnv,
  });
  return path.resolve(stdout.trim(), "..", "..", "bin");
}

async function runDune(cwd, args) {
  const env = { ...process.env };
  delete env.DUNE_RPC;
  delete env.INSIDE_DUNE;
  const compilerBin = await compilerBinPromise;
  if (compilerBin !== undefined) env.PATH = `${compilerBin}${path.delimiter}${env.PATH ?? ""}`;
  await execFilePromise("dune", args, { cwd, env });
}

async function createDuneBuildDirShim(buildDir) {
  const compilerBin = await compilerBinPromise;
  if (process.platform === "win32" || compilerBin === undefined) return undefined;

  const inheritedPath = process.env.PATH ?? "";
  const toolPath = `${compilerBin}${path.delimiter}${inheritedPath}`;
  const shimDir = await fs.mkdtemp(path.join(os.tmpdir(), "ocaml-platform-dune-shim-"));
  const shim = path.join(shimDir, "dune");
  const source = `#!/usr/bin/env node
const { spawnSync } = require("node:child_process");

const environment = {
  ...process.env,
  PATH: process.env.OCAML_PLATFORM_TEST_DUNE_PATH,
  DUNE_BUILD_DIR: process.env.OCAML_PLATFORM_TEST_DUNE_BUILD_DIR,
};
delete environment.OCAML_PLATFORM_TEST_DUNE_PATH;
delete environment.OCAML_PLATFORM_TEST_DUNE_BUILD_DIR;
delete environment.OCAML_PLATFORM_TEST_DUNE_FAIL_CONTEXTS;

if (
  process.env.OCAML_PLATFORM_TEST_DUNE_FAIL_CONTEXTS === "1" &&
  process.argv[2] === "describe" &&
  process.argv[3] === "contexts"
) {
  process.exit(1);
}

const result = spawnSync("dune", process.argv.slice(2), {
  env: environment,
  stdio: "inherit",
});
if (result.error !== undefined) {
  console.error(result.error.message);
  process.exit(1);
}
process.exit(result.status ?? 1);
`;
  await fs.writeFile(shim, source, { mode: 0o755 });
  await fs.chmod(shim, 0o755);
  process.env.OCAML_PLATFORM_TEST_DUNE_PATH = toolPath;
  process.env.OCAML_PLATFORM_TEST_DUNE_BUILD_DIR = buildDir;
  process.env.PATH = `${shimDir}${path.delimiter}${toolPath}`;
  return shimDir;
}

async function showPreprocessedDocument(source) {
  const document = await vscode.workspace.openTextDocument(vscode.Uri.file(source));
  const preprocessedUri = vscode.Uri.parse(`post-ppx: ${source}?`).toString();
  await vscode.window.showTextDocument(document);
  await vscode.commands.executeCommand("ocaml.show-preprocessed-document");

  for (let attempt = 0; attempt < 300; attempt++) {
    const document = vscode.workspace.textDocuments.find(
      (candidate) => candidate.uri.toString() === preprocessedUri && candidate.getText().length > 0,
    );
    if (document !== undefined) return document;
    await setTimeout(100);
  }
  assert.fail("Timed out waiting for the preprocessed document");
}

suite("preprocessed document", () => {
  let savedDuneEnv;
  let cleanupDirs;

  setup(async () => {
    savedDuneEnv = saveEnvironment(duneEnvVars);
    for (const name of duneEnvVars) delete process.env[name];
    cleanupDirs = [];
    await activateExtension();
  });

  teardown(async () => {
    restoreEnvironment(savedDuneEnv);
    await vscode.commands.executeCommand("workbench.action.closeAllEditors");
    await Promise.all(cleanupDirs.map((dir) => fs.rm(dir, { recursive: true, force: true })));
  });

  test("uses Dune's default build context", async function () {
    this.timeout(60_000);

    const source = path.join(root, "src", "path.ml");
    const preprocessed = await showPreprocessedDocument(source);
    assert.match(preprocessed.getText(), /let relative_from/);
  });

  test("uses the build directory reported by Dune when contexts are unavailable", async function () {
    this.timeout(60_000);

    const project = await fs.mkdtemp(path.join(os.tmpdir(), "ocaml-platform-described-layout-"));
    cleanupDirs.push(project);
    const reportedBuildDir = await fs.mkdtemp(
      path.join(os.tmpdir(), "ocaml-platform-reported-build-"),
    );
    cleanupDirs.push(reportedBuildDir);
    const source = path.join(project, "reported_layout.ml");
    const expectedSource = path.join(root, "_build", "default", "src", "ast_editor.pp.ml");
    const decoySource = path.join(root, "_build", "default", "src", "path.pp.ml");
    const expectedPreprocessed = path.join(reportedBuildDir, "default", "reported_layout.pp.ml");
    const fallbackPreprocessed = path.join(project, "_build", "default", "reported_layout.pp.ml");

    await Promise.all([
      fs.writeFile(path.join(project, "dune-project"), "(lang dune 3.20)\n"),
      fs.writeFile(path.join(project, "dune-workspace"), "(lang dune 3.20)\n"),
      fs.writeFile(source, "let reported_layout = ()\n"),
      fs.mkdir(path.dirname(expectedPreprocessed), { recursive: true }),
      fs.mkdir(path.dirname(fallbackPreprocessed), { recursive: true }),
    ]);
    await Promise.all([
      fs.copyFile(expectedSource, expectedPreprocessed),
      fs.copyFile(decoySource, fallbackPreprocessed),
    ]);

    const savedShimEnv = saveEnvironment(["PATH", ...duneShimEnvVars]);
    try {
      process.env.OCAML_PLATFORM_TEST_DUNE_FAIL_CONTEXTS = "1";
      const shimDir = await createDuneBuildDirShim(reportedBuildDir);
      if (shimDir === undefined) this.skip();
      cleanupDirs.push(shimDir);

      const preprocessed = await showPreprocessedDocument(source);
      assert.match(preprocessed.getText(), /let get_nonce/);
      assert.doesNotMatch(preprocessed.getText(), /let relative_from/);
    } finally {
      restoreEnvironment(savedShimEnv);
    }
  });

  test("uses a named context declared by dune-workspace", async function () {
    this.timeout(60_000);

    const project = await fs.mkdtemp(path.join(os.tmpdir(), "ocaml-platform-workspace-"));
    cleanupDirs.push(project);
    const source = path.join(project, "named_context.ml");
    const builtPreprocessedSource = path.join(root, "_build", "default", "src", "path.pp.ml");
    const namedPreprocessedSource = path.join(
      project,
      "_build",
      "editor_test",
      "named_context.pp.ml",
    );

    await Promise.all([
      fs.writeFile(path.join(project, "dune-project"), "(lang dune 3.0)\n"),
      fs.writeFile(
        path.join(project, "dune-workspace"),
        "(lang dune 3.0)\n(context (default (name editor_test)))\n",
      ),
      fs.writeFile(source, "let named_context = ()\n"),
      fs.mkdir(path.dirname(namedPreprocessedSource), { recursive: true }),
    ]);
    await fs.copyFile(builtPreprocessedSource, namedPreprocessedSource);

    const preprocessed = await showPreprocessedDocument(source);
    assert.match(preprocessed.getText(), /let relative_from/);
  });

  test("uses the context selected for Merlin", async function () {
    this.timeout(180_000);
    if (!(await duneVersionAtLeast(3, 20))) this.skip();

    const project = await fs.mkdtemp(path.join(os.tmpdir(), "ocaml-platform-merlin-"));
    cleanupDirs.push(project);
    const context = "editor_test";
    const workspace = path.join(project, "dune-workspace");
    const source = path.join(project, "editor_context.ml");
    // The Merlin-selected context holds a different module's artifact, so
    // falling back to the default context cannot produce the expected marker.
    const distinctPreprocessed = path.join(root, "_build", "default", "src", "ast_editor.pp.ml");
    const contextPreprocessed = path.join(project, "_build", context, "editor_context.pp.ml");

    process.env.DUNE_WORKSPACE = workspace;
    await Promise.all([
      fs.writeFile(path.join(project, "dune-project"), "(lang dune 3.20)\n"),
      fs.writeFile(path.join(project, "dune"), "(library (name editor_context))\n"),
      fs.writeFile(source, "let editor_context = ()\n"),
      fs.writeFile(
        workspace,
        `(lang dune 3.20)\n(context (default (name default)))\n(context (default (name ${context}) (merlin)))\n`,
      ),
    ]);
    await runDune(project, ["build", `@_build/${context}/check`]);
    await fs.copyFile(distinctPreprocessed, contextPreprocessed);

    const preprocessed = await showPreprocessedDocument(source);
    assert.match(preprocessed.getText(), /let get_nonce/);
  });

  test("honours DUNE_WORKSPACE with a named context", async function () {
    this.timeout(60_000);

    const project = await fs.mkdtemp(path.join(os.tmpdir(), "ocaml-platform-workspace-env-"));
    cleanupDirs.push(project);
    const workspace = path.join(project, "dune-workspace.editor-test");
    const source = path.join(project, "env_context.ml");
    const builtPreprocessedSource = path.join(root, "_build", "default", "src", "ast_editor.pp.ml");
    const namedPreprocessedSource = path.join(
      project,
      "_build",
      "env_context",
      "env_context.pp.ml",
    );

    process.env.DUNE_WORKSPACE = workspace;
    await Promise.all([
      fs.writeFile(path.join(project, "dune-project"), "(lang dune 3.0)\n"),
      fs.writeFile(workspace, "(lang dune 3.0)\n(context (default (name env_context)))\n"),
      fs.writeFile(source, "let env_context = ()\n"),
      fs.mkdir(path.dirname(namedPreprocessedSource), { recursive: true }),
    ]);
    await fs.copyFile(builtPreprocessedSource, namedPreprocessedSource);

    const preprocessed = await showPreprocessedDocument(source);
    assert.match(preprocessed.getText(), /let get_nonce/);
  });

  test("honours DUNE_ROOT and an absolute DUNE_BUILD_DIR", async function () {
    this.timeout(60_000);
    if (!(await duneVersionAtLeast(3, 21))) this.skip();

    // Both directories carry a dune-project, so automatic root discovery
    // picks the outer one; only honouring DUNE_ROOT (the inner one) and the
    // custom build directory leads to the artifact placed below.
    const project = await fs.mkdtemp(path.join(os.tmpdir(), "ocaml-platform-root-"));
    cleanupDirs.push(project);
    const customBuildDir = await fs.mkdtemp(path.join(os.tmpdir(), "ocaml-platform-build-"));
    cleanupDirs.push(customBuildDir);
    const nested = path.join(project, "nested");
    const source = path.join(nested, "env_root.ml");
    const builtPreprocessedSource = path.join(root, "_build", "default", "src", "ast_editor.pp.ml");
    const customPreprocessedSource = path.join(customBuildDir, "default", "env_root.pp.ml");

    await fs.mkdir(nested, { recursive: true });
    await Promise.all([
      fs.writeFile(path.join(project, "dune-project"), "(lang dune 3.0)\n"),
      fs.writeFile(path.join(nested, "dune-project"), "(lang dune 3.0)\n"),
      fs.writeFile(source, "let env_root = ()\n"),
      fs.mkdir(path.dirname(customPreprocessedSource), { recursive: true }),
    ]);
    await fs.copyFile(builtPreprocessedSource, customPreprocessedSource);
    process.env.DUNE_BUILD_DIR = customBuildDir;
    process.env.DUNE_ROOT = nested;

    const preprocessed = await showPreprocessedDocument(source);
    assert.match(preprocessed.getText(), /let get_nonce/);
  });

  test("resolves a relative DUNE_BUILD_DIR and DUNE_CROSS_TARGET", async function () {
    this.timeout(60_000);
    if (!(await duneVersionAtLeast(3, 22))) this.skip();

    const source = path.join(root, "src", "dune_workspace.ml");
    // The cross-target context holds a different module's artifact, so
    // falling back to the default context cannot produce the expected marker.
    const builtPreprocessedSource = path.join(root, "_build", "default", "src", "ast_editor.pp.ml");
    const customBuildDir = await fs.mkdtemp(path.join(root, ".ocaml-platform-build-"));
    cleanupDirs.push(customBuildDir);
    const customPreprocessedSource = path.join(
      customBuildDir,
      "default.extension_test",
      "src",
      "dune_workspace.pp.ml",
    );

    await fs.mkdir(path.dirname(customPreprocessedSource), { recursive: true });
    await fs.copyFile(builtPreprocessedSource, customPreprocessedSource);
    process.env.DUNE_BUILD_DIR = path.basename(customBuildDir);
    process.env.DUNE_ROOT = root;
    process.env.DUNE_CROSS_TARGET = "extension_test";

    const preprocessed = await showPreprocessedDocument(source);
    assert.match(preprocessed.getText(), /let get_nonce/);
  });
});
