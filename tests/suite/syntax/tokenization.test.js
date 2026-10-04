const assert = require("node:assert/strict");
const fs = require("node:fs/promises");
const os = require("node:os");
const path = require("node:path");
const vscode = require("vscode");

const examples = [
  {
    filename: "sample.ml",
    source: "let \\#effect = 1\nlet f () = match () with | effect E, k -> ()\n",
    assertions: [
      { text: "\\#effect", scope: "entity.name.binding.ocaml" },
      { text: "effect", scope: "keyword.other.ocaml", exact: true },
    ],
  },
  {
    filename: "sample.mli",
    source: 'external ( + ) : int -> int -> int = "%addint"\n',
    assertions: [{ text: "%addint", scope: "string.quoted.double.ocaml" }],
  },
  {
    filename: "sample.mly",
    source: '%token A\n%%\nmain: A { ($startpos, "$endpos") }\n',
    assertions: [
      { text: "$startpos", scope: "keyword.other.menhir" },
      { text: "$endpos", scope: "string.quoted.double.ocaml", absent: "keyword.other.menhir" },
    ],
  },
  {
    filename: "sample.opam",
    source: 'opam-version: "2.0"\n(* outer (* nested *) hidden *)\navailable: true\n',
    assertions: [
      { text: "hidden", scope: "comment.block.opam" },
      { text: "true", scope: "constant.language.opam", absent: "comment" },
    ],
  },
  {
    filename: "sample.install",
    source: 'bin: [ "%{name}%" ]\n',
    assertions: [
      { text: "%{name}%", scope: "string.quoted.double.opam-install", absent: "constant.variable" },
    ],
  },
  {
    filename: "ocaml.md",
    source: "```ocaml\nlet \\#effect = 1\n````\nOutsideAfterFence\n",
    assertions: [
      { text: "\\#effect", scope: "meta.embedded.block.ocaml" },
      { text: "OutsideAfterFence", scope: "text.html.markdown", absent: "meta.embedded.block" },
    ],
  },
  {
    filename: "reason.md",
    source: "~~~reason\nlet value = 1;\n~~~~\nOutsideAfterFence\n",
    assertions: [
      { text: "value", scope: "meta.embedded.block.reason" },
      { text: "OutsideAfterFence", scope: "text.html.markdown", absent: "meta.embedded.block" },
    ],
  },
];

suite("editor syntax tokenisation", () => {
  let directory;
  suiteSetup(async () => {
    directory = await fs.mkdtemp(path.join(os.tmpdir(), "ocaml-platform-syntax-"));
  });
  suiteTeardown(async () => {
    await fs.rm(directory, { recursive: true });
  });

  for (const example of examples) {
    test(example.filename, async function () {
      this.timeout(30000);
      const filename = path.join(directory, example.filename);
      await fs.writeFile(filename, example.source);
      const tokens = await vscode.commands.executeCommand(
        "_workbench.captureSyntaxTokens",
        vscode.Uri.file(filename),
      );
      assert.ok(tokens.length, "The editor must produce syntax tokens");
      for (const expected of example.assertions) {
        const matching = tokens.filter((token) =>
          expected.exact ? token.c === expected.text : token.c.includes(expected.text),
        );
        assert.ok(matching.length, `Missing token ${expected.text}`);
        for (const token of matching) {
          assert.ok(token.t.includes(expected.scope), `${expected.text}: ${token.t}`);
          if (expected.absent) {
            assert.ok(!token.t.includes(expected.absent), `${expected.text}: ${token.t}`);
          }
        }
      }
    });
  }
});
