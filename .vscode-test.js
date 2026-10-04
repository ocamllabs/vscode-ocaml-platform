const { defineConfig } = require("@vscode/test-cli");
const path = require("node:path");

module.exports = defineConfig([
  {
    files: ".test-out/suite/**/*.test.js",
  },
  {
    files: ".test-out/e2e/**/*.test.js",
    workspaceFolder: path.join(__dirname, "tests", "fixtures", "lsp"),
    launchArgs: ["--disable-workspace-trust"],
    mocha: {
      timeout: 30000,
    },
  },
]);
