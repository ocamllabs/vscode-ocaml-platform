"use strict";

const path = require("path");

module.exports = (_env, argv) => {
  const isProduction = argv.mode == "production";

  return {
    target: "node",
    entry: "./src/Extension.bs.js",
    output: {
      libraryTarget: "commonjs",
      path: path.resolve(__dirname, "dist"),
      filename: "extension.js"
    },
    devtool: isProduction ? false : "source-map",
    externals: {
      vscode: "commonjs vscode"
    },
    resolve: {
      extensions: [".js"]
    }
  };
};
