.DEFAULT_GOAL := all

.PHONY: all
all:
	dune build

.PHONY: yarn-deps
yarn-deps:
	yarn --immutable

.PHONY: deps
deps: ## Install development dependencies
	$(MAKE) yarn-deps
	opam install --deps-only --with-test --with-doc --with-dev-setup --yes .

.PHONY: create_switch
create_switch:
	opam switch create . 4.14.0 --no-install

.PHONY: switch
switch: create_switch deps ## Create an opam switch and install development dependencies

.PHONY: build
build: ## Build the project
	dune build src/vscode_ocaml_platform.bc.js
	yarn workspace astexplorer build
	yarn esbuild _build/default/src/vscode_ocaml_platform.bc.js \
		--bundle \
		--external:vscode \
		--outdir=dist \
		--platform=node \
		--target=es2022 \
		--sourcemap

.PHONY: build-release
build-release:
	dune build src/vscode_ocaml_platform.bc.js --profile=release
	yarn workspace astexplorer build
	yarn esbuild _build/default/src/vscode_ocaml_platform.bc.js \
		--bundle \
		--external:vscode \
		--outdir=dist \
		--platform=node \
		--target=es2022 \
		--minify-whitespace \
		--minify-syntax \
		--sourcemap \
		--sources-content=false

.PHONY: test
test: ## Run the unit tests
	dune build @runtest
	yarn test

.PHONY: clean
clean: ## Clean build artifacts and other generated files
	dune clean
	rm -r dist/

.PHONY: doc
doc: ## Generate odoc documentation
	dune build @doc

.PHONY: fmt
fmt: ## Format the codebase with ocamlformat
	dune build --auto-promote @fmt
	yarn fmt

.PHONY: watch
watch: ## Watch for the filesystem and rebuild on every change
	dune build @all -w --terminal-persistence=clear-on-rebuild

.PHONY: pkg
pkg: build # Builds and packages the extension for installment
	yarn vsce package --out ./test_extension.vsix --yarn --no-dependencies

.PHONY: install
install: pkg # Builds, packages, and installs the extension to your VS Code
	code --force --install-extension test_extension.vsix

.PHONY:
nix-tests:
	dune build @runtest @all
