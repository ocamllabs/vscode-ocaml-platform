OCAML_SRCFILES = $(shell git ls-files "*.ml" "*.mli")
REASON_SRCFILES = $(shell git ls-files "*.re" "*.rei")

build:
	yarn build
.PHONY: build

fmt:
	ocamlformat --inplace --enable-outside-detected-project $(OCAML_SRCFILES)
	refmt --in-place $(REASON_SRCFILES)
	yarn fmt
.PHONY: fmt
