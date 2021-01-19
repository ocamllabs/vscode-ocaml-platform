build:
	dune build @vscode
.PHONY: build

watch:
	dune build @vscode -w
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

lock:
	opam lock .
.PHONY: lock

# builds and packages the extension for installment
pkg: build
	vsce package --out ./test_extension.vsix --yarn
.PHONY: pkg

# builds, packages, and installs the extension to your VS Code
install: pkg
	code --force --install-extension test_extension.vsix
.PHONY: install
