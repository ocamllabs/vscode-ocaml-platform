const { defineConfig } = require("@vscode/test-cli");
const path = require("node:path");

module.exports = defineConfig({
  files: "tests/suite/**/*.test.js",
  workspaceFolder: path.join(__dirname, "tests", "fixtures", "lsp"),
  launchArgs: ["--disable-workspace-trust"],
  mocha: {
    timeout: 20000,
  },
});
