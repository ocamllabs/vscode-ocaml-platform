const { defineConfig } = require("@vscode/test-cli");

module.exports = defineConfig({
  files: "tests/suite/**/*.test.js",
});
