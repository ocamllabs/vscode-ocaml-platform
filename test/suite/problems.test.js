const assert = require("assert");

const problemLocations = {
  'File "file.ml", line 4, characters 6-7:': [
    "file.ml",
    "4",
    undefined,
    "6",
    "7",
  ],

  'File "helloworld.ml", lines 4-7, characters 6-3:': [
    "helloworld.ml",
    "4",
    "7",
    "6",
    "3",
  ],

  'File "src/intf_error.ml", line 1:': [
    "src/intf_error.ml",
    "1",
    undefined,
    undefined,
    undefined,
  ],
};

const problemMessages = {
  "Error: This expression has type int": [
    "Error",
    undefined,
    "This expression has type int",
  ],

  "Warning: Cannot safely evaluate the definition of the following cycle": [
    "Warning",
    undefined,
    "Cannot safely evaluate the definition of the following cycle",
  ],

  "Warning 26: unused variable y.": ["Warning", "26", "unused variable y."],

  "Error (warning 8): this pattern-matching is not exhaustive.": [
    "Error",
    "8",
    "this pattern-matching is not exhaustive.",
  ],
};

suite("Basic tests", () => {
  test("Problem Matcher tests", async () => {
    const locationRegex = new RegExp(
      '^\\s*\\bFile\\b\\s*"(.*)",\\s*\\blines?\\b\\s*(\\d+)(?:-(\\d+))?(?:,\\s*\\bcharacters\\b\\s*(\\d+)-(\\d+)\\s*)?:\\s*$'
    );

    const messageRegex = new RegExp(
      "^(?:\\s*\\bParse\\b\\s*)?\\s*\\b([Ee]rror|Warning)\\b\\s*(?:(?:\\(\\s*\\bwarning\\b\\s*)?(\\d+)\\)?)?\\s*:\\s*(.*)$"
    );

    for (const [problem, expected] of Object.entries(problemLocations)) {
      const captures = problem.match(locationRegex);
      assert.notStrictEqual(
        captures,
        null,
        "Location regex should match: " + problem
      );
      assert.deepStrictEqual(captures.slice(1), expected);
    }

    for (const [problem, expected] of Object.entries(problemMessages)) {
      const captures = problem.match(messageRegex);
      assert.notStrictEqual(
        captures,
        null,
        "Message regex should match: " + problem
      );
      assert.deepStrictEqual(captures.slice(1), expected);
    }
  });
});
