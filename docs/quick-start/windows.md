# Important Notes for Windows Users

## Cygwin

Install [OCaml for Windows](https://fdopen.github.io/opam-repository-mingw/) and
make sure the `ocaml-env` program is accessible on the PATH (`ocaml-env` is in
the `usr/local/bin` folder relative to the installation directory).

## Windows Subsystem for Linux

- WSL1

  There are some incompatibilities with **_WSL1_** (but they are strictly in
  Microsoft's court), and you need to disable the opam sandboxing because
  sandboxing cannot be used
  [due to bubblewrap](https://github.com/ocaml/opam-repository/issues/12050).
  Except for such pitfalls, there are no blocking factors for the use of this
  extension itself.

- WSL2

  **_WSL2_** is a complete Linux kernel (like Docker Desktop for Mac/Windows),
  so everything just works.
