const path = require("node:path");

const { globSync } = require("glob");
const Mocha = require("mocha");
// @ts-ignore
const register = require("@swc-node/register");

async function run() {
  const mocha = new Mocha({
    ui: "tdd",
    color: true,
    require: [register],
    timeout: Infinity,
  });

  const testsRoot = __dirname;

  return new Promise((resolve, reject) => {
    const files = globSync("**/*.test.ts", { cwd: testsRoot });

    for (const file of files) {
      mocha.addFile(path.resolve(testsRoot, file));
    }

    try {
      mocha.run((failures) => {
        if (failures > 0) {
          reject(new Error(`${failures} tests failed.`));
        } else {
          resolve(void 0);
        }
      });
    } catch (err) {
      reject(err);
    }
  });
}

module.exports = { run };
