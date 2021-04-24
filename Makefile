build:
	dune build @all --profile=release
	yarn esbuild _build/default/src/vscode_ocaml_platform.bc.js --bundle --external:vscode --outdir=dist --platform=node --target=es6 --minify-whitespace --minify-syntax
.PHONY: build

watch:
	dune build @all -w
.PHONY: watch

clean:
	dune clean
.PHONY: clean

test:
	yarn test
.PHONY: test

fmt:
	dune build @fmt --auto-promote;
	yarn fmt
.PHONY: fmt

# builds and packages the extension for installment
pkg: build
	vsce package --out ./test_extension.vsix --yarn
.PHONY: pkg

# builds, packages, and installs the extension to your VS Code
install: pkg
	code --force --install-extension test_extension.vsix
