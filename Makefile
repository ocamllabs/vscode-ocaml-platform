build:
	dune build src/vscode_ocaml_platform.bc.js
	yarn esbuild _build/default/src/vscode_ocaml_platform.bc.js \
		--bundle \
		--external:vscode \
		--outdir=dist \
		--platform=node \
		--target=es6 \
		--sourcemap
.PHONY: build

release-build:
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
.PHONY: release-build

view-build:
	npm run --prefix astexplorer build
.PHONY: view-build

watch:
	dune build @all -w --terminal-persistence=clear-on-rebuild
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
	yarn exec -- vsce package --out ./test_extension.vsix
.PHONY: pkg

# builds, packages, and installs the extension to your VS Code
install: pkg
	code --force --install-extension test_extension.vsix

.PHONY: nix/opam-selection.nix
nix/opam-selection.nix:
	nix-shell -A resolve default.nix
