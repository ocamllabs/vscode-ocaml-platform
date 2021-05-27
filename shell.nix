let
  pkgs = (import <nixpkgs> { });
  local = (import ./default.nix { });
  strings = pkgs.lib.strings;
  inherit (pkgs) stdenv lib;
in with local;

pkgs.mkShell {
  inputsFrom = [ vscode vscode-ocaml-platform ];
  buildInputs = (with pkgs; [
    yarn
    nodejs-14_x
    gnumake
    ocamlformat
    ocamlPackages.ocaml-lsp
  ]);
}
