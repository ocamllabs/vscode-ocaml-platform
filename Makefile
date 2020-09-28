OCAML_SRCFILES = $(shell git ls-files "*.ml" "*.mli")
REASON_SRCFILES = $(shell git ls-files "*.re" "*.rei")

build:
	yarn build
.PHONY: build

test:
	yarn test
.PHONY: test

fmt:
	ocamlformat --inplace --enable-outside-detected-project $(OCAML_SRCFILES)
	refmt --in-place $(REASON_SRCFILES)
	yarn fmt
.PHONY: fmt

# builds and packages the extension for installment
pkg:
	vsce package --out ./test_extension.vsix --yarn
.PHONY: pkg

# builds, packages, and installs the extension to your VS Code
install: pkg
	code --force --install-extension test_extension.vsix
