let
  pkgs = import
    (fetchTarball "https://github.com/NixOS/nixpkgs/archive/master.tar.gz") { };
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
