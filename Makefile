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
