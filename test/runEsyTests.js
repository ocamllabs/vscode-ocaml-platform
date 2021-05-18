const path = require("path");
const os = require("os");
const fs = require("fs-extra");
const cp = require("child_process");

const { runTests } = require("vscode-test");

const root = path.dirname(__dirname);
const sampleEsySrc = path.join(root, "fixtures", "sample-esy");
const projectPath = path.join(os.tmpdir(), "sample-esy");

async function main() {
  try {
    fs.copySync(sampleEsySrc, projectPath);
    console.log("Running in", projectPath);
    cp.execSync("esy", { cwd: projectPath });

    fs.writeFileSync(
      path.join(projectPath, ".vscode", "settings.json"),
      JSON.stringify({
        "ocaml.sandbox": {
          root: projectPath,
          kind: "esy",
        },
      })
    );
    // The folder containing the Extension Manifest package.json
    // Passed to `--extensionDevelopmentPath`
    const extensionDevelopmentPath = path.resolve(__dirname, "../");

    // The path to the extension test script
    // Passed to --extensionTestsPath
    const extensionTestsPath = path.resolve(__dirname, "./suite/esy");

    // Download VS Code, unzip it and run the integration test
    await runTests({
      extensionDevelopmentPath,
      extensionTestsPath,
      launchArgs: ["--disable-extensions"],
    });
  } catch (err) {
    console.error("Failed to run tests");
    process.exit(1);
  }
}

main();
