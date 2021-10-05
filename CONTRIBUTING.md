# Contributing

## Setup your development environment

You need Opam, you can install it by following [Opam's documentation](https://opam.ocaml.org/doc/Install.html).

With Opam installed, you can install the dependencies in a new local switch with:

```bash
make switch
```

Or globally, with:

```bash
make deps
```

Then, build the project with:

```bash
make build
```

### Running the extension

After building the project, you can run the extension from VSCode by going in the "Run and Debug" tab (`Shift + Cmd + D`) and running the `Extension` task. This will open a new VSCode window with only the `vscode-ocaml` extension activated.

### Running Tests

You can run the test compiled with:

```bash
make test
```

This will run both the OCaml tests and the JavaScript ones.


### Format code

To format the code, you can run:

```
make fmt
```

This will format the OCaml source code with `ocamlformat` and the JavaScript source code with `prettier`.

## Submitting a PR

To submit a PR make sure you create a new branch, add the code and commit it. 

```
git checkout -b my-bug-fix
git add fixed-file.ml
git commit -m "fix a bug"
git push -u origin my-bug-fix
```

From here you can then open a PR from GitHub. Before committing your code it is very useful to:

 - Format the code: this should be as simple as `make fmt`
 - Make sure it builds: running `make build`, this is also very important if you add data to the repository as it will "crunch" the data into the static OCaml modules (more information below)
 - Run the tests: this will check that all the data is correctly formatted and can be invoked with `make test`

## Repository Structure

The following snippet describes VSCode OCaml's repository structure.

```text
.
│
├── assets/
|   Static assets included in the packaged extension.
│
├── astexplorer/
|   Vendored version of `astexplorer` used to provide the AST explorer for OCaml source code.
│
├── doc/
|   Assets and files used for documentation.
│
├── languages/
|   Definitions of the languages supported in the extension.
│
├── src/
|   Source for VSCode OCaml extension.
│
├── src-bindings/
|   Source for VSCode OCaml's bindings to JavaScript libraries.
│
├── syntaxes/
|   Definitions of the syntaxes supported in the extension.
│
├── test/
|   Unit tests and integration tests for VSCode OCaml.
|
├── dune
├── dune-project
|   Dune file used to mark the root of the project and define project-wide parameters.
|   For the documentation of the syntax, see https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
|
├── Makefile
|   Make file containing common development command.
│
├── package-lock.json
├── package.json
|   Package file for NPM packages. This is used to defined the JavaScript dependencies of the project.
│
├── README.md
|   The documentation included in the extension's overview on the VSCode Marketplace.
│
├── vscode-ocaml.opam
└── vscode.opam
    Opam package definitions.
    To know more about creating and publishing opam packages, see https://opam.ocaml.org/doc/Packaging.html.
```
