const path = require("path");
const Mocha = require("mocha");

function run() {
  // Create the mocha test
  const mocha = new Mocha({
    ui: "tdd",
  });
  // Use any mocha API
  mocha.color(true);

  const testsRoot = path.resolve(__dirname, "..");

  return new Promise((c, e) => {
    const files = ["opam.test.js"].map((f) =>
      path.resolve(testsRoot, "suite", f)
    );

    // Add files to the test suite
    files.forEach((f) => mocha.addFile(path.resolve(testsRoot, f)));

    try {
      // Run the mocha test
      mocha.run((failures) => {
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
  run,
};
