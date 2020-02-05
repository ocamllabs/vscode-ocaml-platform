const path = require("path");
const Mocha = require("mocha");
const glob = require("glob");

function run() {
  // Create the mocha test
  const mocha = new Mocha({
    ui: "tdd"
  });
  // Use any mocha API
  mocha.useColors(true);

  const testsRoot = path.resolve(__dirname);

  return new Promise((c, e) => {
    let files = ["integration.test.js"].map(f => path.resolve(testsRoot, f));

    // Add files to the test suite
    files.forEach(f => mocha.addFile(path.resolve(testsRoot, f)));

    try {
      // Run the mocha test
      mocha.run(failures => {
        if (failures > 0) {
          e(new Error(`${failures} tests failed.`));
        } else {
          c();
        }
      });
    } catch (err) {
      e(err);
    }
  });
}

module.exports = {
  run
};
