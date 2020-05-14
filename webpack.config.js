const { CleanWebpackPlugin } = require("clean-webpack-plugin");
const path = require("path");
const TerserPlugin = require("terser-webpack-plugin");
const WebpackBar = require("webpackbar");

module.exports = (_env, argv) => {
  const isProduction = argv.mode == "production";
  return {
    entry: "./src/Extension.bs.js",
    output: {
      filename: "extension.js",
      path: path.resolve(__dirname, "dist"),
      libraryTarget: "commonjs",
    },
    optimization: {
      minimizer: [
        new TerserPlugin({
          cache: true,
          parallel: true,
          extractComments: false,
        }),
      ],
    },
    plugins: [new CleanWebpackPlugin(), new WebpackBar()],
    devtool: isProduction ? false : "source-map",
    target: "node",
    externals: { vscode: "commonjs vscode" },
    stats: "errors-only",
  };
};
