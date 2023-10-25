const path = require("node:path");

const { globSync } = require("glob");
const Mocha = require("mocha");

async function run() {
  const mocha = new Mocha({ ui: "tdd", color: true, timeout: Infinity });

  const testsRoot = __dirname;

  return new Promise((resolve, reject) => {
    const files = globSync("**/*.test.js", { cwd: testsRoot });

    for (const file of files) {
      mocha.addFile(path.resolve(testsRoot, file));
    }

    try {
      mocha.run((failures) => {
        if (failures > 0) {
          reject(new Error(`${failures} tests failed.`));
        } else {
          resolve();
        }
      });
    } catch (err) {
      reject(err);
    }
  });
}

module.exports = { run };
