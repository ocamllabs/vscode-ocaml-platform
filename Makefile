.DEFAULT_GOAL := all

.PHONY: all
all:
	dune build

.PHONY: npm-deps
npm-deps:
	yarn install --immutable

.PHONY: deps
deps:
	$(MAKE) npm-deps
	opam install --deps-only --with-test --with-doc --with-dev-setup --yes .

.PHONY: create_switch
create_switch:
	opam switch create . 5.3.0 --no-install

.PHONY: switch
switch: create_switch deps

.PHONY: build
build: # https://github.com/ewanharris/vscode-versions
	dune build src/vscode_ocaml_platform.bc.js --profile=release
	yarn workspace astexplorer build
	yarn esbuild _build/default/src/vscode_ocaml_platform.bc.js \
		--bundle \
		--external:vscode \
		--minify \
		--outdir=dist \
		--packages=bundle \
		--platform=node \
		--target=node22 \
		--analyze

.PHONY: test
test:
	dune build @runtest
	yarn test

.PHONY: clean
clean:
	dune clean
	$(RM) -r astexplorer/dist dist

.PHONY: doc
doc:
	dune build @doc

.PHONY: fmt
fmt:
	dune build --auto-promote @fmt
	yarn biome format --write

.PHONY: watch
watch:
	dune build @all -w --terminal-persistence=clear-on-rebuild

.PHONY: pkg
pkg: clean build
	yarn package

.PHONY: install
install: pkg
	code --force --install-extension ocaml-platform.vsix

.PHONY:
nix-tests:
	dune build @runtest @all
