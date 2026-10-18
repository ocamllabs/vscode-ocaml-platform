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

for (const extension of ["ml", "mlx"]) {
  examples.push({
    filename: `declaration-continuations.${extension}`,
    source: [
      "type first_type = int",
      "and second_type = string",
      "class first_class = let helper = 1 and sibling = 2 in object method value = helper end",
      "and second_class = object end",
      "class type first_class_type = object end",
      "and second_class_type = object end",
      "let first_value = 1 and second_value = 2",
    ].join("\n"),
    assertions: [
      { text: "second_type", scope: "entity.name.type.ocaml" },
      { text: "second_class", scope: "entity.name.type.class.ocaml", exact: true },
      { text: "second_class_type", scope: "entity.name.type.class.ocaml" },
      {
        text: "sibling",
        scope: "entity.name.binding.ocaml",
        absent: "entity.name.type",
        exact: true,
      },
      { text: "second_value", scope: "entity.name.binding.ocaml", absent: "entity.name.type" },
    ],
  });
}
for (const extension of ["ml", "mlx"]) {
  examples.push({
    filename: `class-jsx.${extension}`,
    source: "class c = object method render = <div /> end\n",
    assertions: [
      extension === "mlx"
        ? { text: "div", scope: "entity.name.tag", exact: true }
        : { text: "div", scope: "source.ocaml", absent: "entity.name.tag", exact: true },
    ],
  });
}
examples.push({
  filename: "binding-roles.ml",
  source: "let apply f x = f x\nlet value = float 1\ntype t = int\n",
  assertions: [
    { text: "apply", scope: "entity.name.function.binding.ocaml", exact: true },
    {
      text: "value",
      scope: "entity.name.binding.ocaml",
      absent: "entity.name.function",
      exact: true,
    },
    { text: "float", scope: "source.ocaml", absent: "support.type", exact: true },
    { text: "int", scope: "support.type.ocaml", exact: true },
  ],
});
examples.push({
  filename: "binding-roles.mli",
  source: "val length : string -> int\nval count : int\n",
  assertions: [
    { text: "length", scope: "entity.name.function.binding.ocaml", exact: true },
    {
      text: "count",
      scope: "entity.name.binding.ocaml",
      absent: "entity.name.function",
      exact: true,
    },
    { text: "string", scope: "support.type.ocaml", exact: true },
    { text: "int", scope: "support.type.ocaml", exact: true },
  ],
});
examples.push({
  filename: "field-labels.atd",
  source: "type t = { string : int }\n",
  assertions: [
    { text: "string", scope: "source.atd", absent: "support.type", exact: true },
    { text: "int", scope: "support.type.ocaml.atd", exact: true },
  ],
});
examples.push({
  filename: "declaration-prefixes.ml",
  source: [
    "type +'a positive = 'a list and -'b negative = 'b -> unit",
    "class local_open = let open M in c and following_class = object end",
    "class type local_open_type = let open! M in c and following_class_type = object end",
  ].join("\n"),
  assertions: [
    { text: "+", scope: "keyword.operator.ocaml", exact: true },
    { text: "-", scope: "keyword.operator.ocaml", exact: true },
    { text: "open", scope: "keyword", absent: "entity.name.binding", exact: true },
    { text: "following_class", scope: "entity.name.type.class.ocaml", exact: true },
    { text: "following_class_type", scope: "entity.name.type.class.ocaml" },
  ],
});
examples.push({
  filename: "declaration-continuations.mli",
  source: [
    "type first_type = int",
    "and second_type = string",
    "class first_class : object end",
    "and second_class : object end",
    "class type first_class_type = object end",
    "and second_class_type = object end",
    "val next_value : int",
  ].join("\n"),
  assertions: [
    { text: "second_type", scope: "entity.name.type.ocaml" },
    { text: "second_class", scope: "entity.name.type.class.ocaml", exact: true },
    { text: "second_class_type", scope: "entity.name.type.class.ocaml" },
    { text: "next_value", scope: "entity.name.binding.ocaml", absent: "entity.name.type" },
  ],
});

for (const language of ["ocaml", "reason"]) {
  const fence = language === "ocaml" ? "```" : "~~~";
  for (const [name, indent] of [
    ["spaces", "    "],
    ["tab", "\t"],
  ]) {
    examples.push({
      filename: `${language}-indented-${name}.md`,
      source: [indent + fence + language, indent + "IndentedCode", indent + fence].join("\n"),
      assertions: [
        { text: "IndentedCode", scope: "text.html.markdown", absent: "meta.embedded.block" },
      ],
    });
  }
  examples.push({
    filename: `${language}-indented-closer.md`,
    source: [
      fence + language,
      "let value = 1",
      "\t" + fence,
      "StillEmbedded",
      fence,
      "Outside",
    ].join("\n"),
    assertions: [
      { text: "StillEmbedded", scope: `meta.embedded.block.${language}` },
      { text: "Outside", scope: "text.html.markdown", absent: "meta.embedded.block" },
    ],
  });
  examples.push({
    filename: `${language}-container-tabs.md`,
    source: [
      "> \t" + fence + language,
      "> \tQuotedCode",
      "> \t" + fence,
      "",
      "- item",
      "",
      "  \t" + fence + language,
      "  \tListedCode",
      "  \t" + fence,
    ].join("\n"),
    assertions: [
      { text: "QuotedCode", scope: `meta.embedded.block.${language}` },
      { text: "ListedCode", scope: `meta.embedded.block.${language}` },
    ],
  });
}

for (const language of ["ocaml", "reason"]) {
  for (const [name, fence] of [
    ["backtick", "```"],
    ["tilde", "~~~"],
  ]) {
    examples.push({
      filename: `${language}-${name}-closing-whitespace.md`,
      source: [
        fence + "\u00a0" + language + "\u00a0attrs",
        "RootEmbedded",
        fence + "\u00a0",
        "RootStillEmbedded",
        fence + " \t",
        "RootOutside",
        "",
        "> " + fence + language,
        "> QuotedEmbedded",
        "> " + fence + "\u2003",
        "> QuotedStillEmbedded",
        "> " + fence + "\t",
        "> QuotedOutside",
        "",
        "- item",
        "",
        "  " + fence + language,
        "  ListedEmbedded",
        "  " + fence + "\u0085",
        "  ListedStillEmbedded",
        "  " + fence + " ",
        "  ListedOutside",
      ].join("\r\n"),
      assertions: [
        { text: "RootEmbedded", scope: `meta.embedded.block.${language}` },
        { text: "RootStillEmbedded", scope: `meta.embedded.block.${language}` },
        { text: "QuotedEmbedded", scope: `meta.embedded.block.${language}` },
        { text: "QuotedStillEmbedded", scope: `meta.embedded.block.${language}` },
        { text: "ListedEmbedded", scope: `meta.embedded.block.${language}` },
        { text: "ListedStillEmbedded", scope: `meta.embedded.block.${language}` },
        { text: "Outside", scope: "text.html.markdown", absent: "meta.embedded.block" },
      ],
    });
  }
}

examples.push({
  filename: "doc-comment-boundaries.ml",
  source: [
    "(** silly bracket [(] *)",
    "let after_code = 1",
    "(** {% $ %} *)",
    "let after_latex = 2",
    '(** [ "a',
    ' b" ] *)',
    "let after_span = 3",
  ].join("\n"),
  assertions: [
    { text: "after_code", scope: "entity.name.binding.ocaml", absent: "comment", exact: true },
    { text: "after_latex", scope: "entity.name.binding.ocaml", absent: "comment", exact: true },
    { text: ' b"', scope: "string.quoted.double.ocaml", exact: true },
    { text: "after_span", scope: "entity.name.binding.ocaml", absent: "comment", exact: true },
  ],
});

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
