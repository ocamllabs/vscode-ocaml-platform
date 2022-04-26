.DEFAULT_GOAL := all

.PHONY: all
all:
	dune build --root .

.PHONY: deps
deps: ## Install development dependencies
	opam install -y ocamlformat.0.21.0 ocamlformat-rpc ocaml-lsp-server $(DEV_DEPS)
	yarn --frozen-lockfile
	yarn --frozen-lockfile --cwd astexplorer
	opam install --deps-only --with-test --with-doc -y .

.PHONY: create_switch
create_switch:
	opam switch create . 4.14.0 --no-install

.PHONY: switch
switch: create_switch deps ## Create an opam switch and install development dependencies

.PHONY: build
build: ## Build the project
	dune build src/vscode_ocaml_platform.bc.js
	yarn --cwd astexplorer start
	yarn esbuild _build/default/src/vscode_ocaml_platform.bc.js \
		--bundle \
		--external:vscode \
		--outdir=dist \
		--platform=node \
		--target=es6 \
		--sourcemap

.PHONY: build-release
build-release:
	dune build src/vscode_ocaml_platform.bc.js --profile=release
	yarn --cwd astexplorer build
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

.PHONY: test
test: ## Run the unit tests
	dune build --root . @runtest
	yarn test

.PHONY: clean
clean: ## Clean build artifacts and other generated files
	dune clean --root .
	rm -r dist/

.PHONY: doc
doc: ## Generate odoc documentation
	dune build --root . @doc

.PHONY: fmt
fmt: ## Format the codebase with ocamlformat
	dune build --root . --auto-promote @fmt
	yarn fmt

.PHONY: watch
watch: ## Watch for the filesystem and rebuild on every change
	dune build @all -w --terminal-persistence=clear-on-rebuild

.PHONY: pkg
pkg: build # Builds and packages the extension for installment
	yarn vsce package --out ./test_extension.vsix

.PHONY: install
install: pkg # Builds, packages, and installs the extension to your VS Code
	code --force --install-extension test_extension.vsix

.PHONY: nix/opam-selection.nix
nix/opam-selection.nix:
	nix-shell -A resolve default.nix

.PHONY:
nix-tests:
	dune build @runtest @all
