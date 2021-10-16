# TODO

Dune Syntax.

## Dune project

- [ ] name
- [ ] version
- [ ] implicit_transitive_deps
- [ ] wrapped_executables
- [ ] explicit_js_mode
- [ ] dialect
- [ ] formatting
- [ ] generate_opam_files
- [ ] package
- [ ] use_standard_c_and_cxx_flags

## Dune

Stanzas:

- [X] jbuild_version
- [X] library
- [X] foreign_library
- [X] deprecated_library_name
- [X] executable
- [X] executables
- [X] rule
- [X] ocamllex
- [X] ocamlyacc
- [X] menhir
- [X] cinaps
- [X] documentation
- [X] alias
- [X] install
- [X] copy_files
- [X] include
- [X] tests
- [X] test
- [X] env
- [X] dirs
- [X] data_only_dirs
- [X] ignored_subdirs
- [X] vendored_dirs
- [X] include_subdirs
- [X] toplevel
- [X] subdir
- [X] external_variant
- [X] coq.theory
- [X] coq.pp
- [X] coq.extraction
- [X] mdx
- [X] plugin
- [X] generate_sites_module

Scopes:

- [X] Library/executable/test stanzas

- [X] Ordered set language
- [X] Boolean language
- [X] Predicate language
- [X] Variables
- [X] Library dependencies
  - [X] Alternative dependencies
  - [X] Re-exported dependencies
- [X] Preprocessing specification
  - [X] Preprocessing with actions
  - [ ] Preprocessing with ppx rewriters
  - [ ] Per module preprocessing specification
- [X] Dependency specification
  - [X] Named Dependencies
  - [ ] Glob
- [ ] OCaml flags
- [X] User actions
- [ ] Locks
- [ ] Foreign sources and archives
  - [] Foreign stubs
  - [] Foreign archives
  - [ ] Flags

## Dune workspace

- [ ] profile
- [ ] env
- [ ] context

# Notes

To complete the Dune syntax highlighting PR:

- Highlighting for boolean literals
- Check if we support glob syntax
- Write the action specification
- Mode in rule (https://dune.readthedocs.io/en/stable/dune-files.html#modes)