.DEFAULT_GOAL := all

.PHONY: all
all:
	dune build

.PHONY: npm-deps
npm-deps:
	bun install --frozen-lockfile

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
	bun run --filter astexplorer build
	bun build \
		--production \
		--target=node \
		--outdir=dist \
		--format=cjs \
		--external vscode \
		_build/default/src/vscode_ocaml_platform.bc.js

.PHONY: test
test:
	dune build @runtest
	bun run test

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
	bunx biome format --write

.PHONY: watch
watch:
	dune build @all -w --terminal-persistence=clear-on-rebuild

.PHONY: pkg
pkg: clean build
	bun run package

.PHONY: install
install: pkg
	code --force --install-extension ocaml-platform.vsix

.PHONY:
nix-tests:
	dune build @runtest @all
