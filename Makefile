build:
	dune build src/vscode_ocaml_platform.bc.js --profile=release
	yarn esbuild _build/default/src/vscode_ocaml_platform.bc.js \
		--bundle \
		--external:vscode \
		--outdir=dist \
		--platform=node \
		--target=es6 \
		--minify-whitespace \
		--minify-syntax \
		--sourcemap \
		--sources-content=false
.PHONY: build

watch:
	dune build @all -w
.PHONY: watch

clean:
	dune clean
	rm -r dist
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

.PHONY: nix/opam-selection.nix
nix/opam-selection.nix:
	nix-shell -A resolve default.nix
