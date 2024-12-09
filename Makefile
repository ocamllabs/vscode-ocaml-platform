.DEFAULT_GOAL := all

.PHONY: all
all:
	dune build

.PHONY: npm-deps
npm-deps:
	yarn install --immutable

.PHONY: deps
deps: ## Install development dependencies
	$(MAKE) npm-deps
	opam install --deps-only --with-test --with-doc --with-dev-setup --yes .

.PHONY: create_switch
create_switch:
	opam switch create . 5.2.1 --no-install

.PHONY: switch
switch: create_switch deps ## Create an opam switch and install development dependencies

.PHONY: build
build: clean ## Build the project
	dune build src/vscode_ocaml_platform.bc.js --profile=release
	yarn workspace astexplorer build
	yarn esbuild _build/default/src/vscode_ocaml_platform.bc.js \
		--bundle \
		--external:vscode \
		--minify \
		--outdir=dist \
		--packages=bundle \
		--platform=node \
		--target=es2022 \
		--analyze

.PHONY: test
test: ## Run the unit tests
	dune build @runtest
	yarn test

.PHONY: clean
clean: ## Clean build artifacts and other generated files
	dune clean
	$(RM) -r astexplorer/dist dist

.PHONY: doc
doc: ## Generate odoc documentation
	dune build @doc

.PHONY: fmt
fmt: ## Format the codebase with ocamlformat
	dune build --auto-promote @fmt
	yarn biome format --write

.PHONY: watch
watch: ## Watch for the filesystem and rebuild on every change
	dune build @all -w --terminal-persistence=clear-on-rebuild

.PHONY: pkg
pkg: build # Builds and packages the extension for installment
	yarn package

.PHONY: install
install: pkg # Builds, packages, and installs the extension to your VS Code
	code --force --install-extension ocaml-platform.vsix

.PHONY:
nix-tests:
	dune build @runtest @all
