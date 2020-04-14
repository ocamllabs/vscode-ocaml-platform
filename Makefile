OCAML_SRCFILES = $(shell git ls-files "*.ml" "*.mli")
REASON_SRCFILES = $(shell git ls-files "*.re" "*.rei")

build:
	yarn build
.PHONY: build

fmt:
	esy ocamlformat --inplace --enable-outside-detected-project $(OCAML_SRCFILES)
	esy refmt --in-place $(REASON_SRCFILES)
	yarn fmt
.PHONY: fmt
