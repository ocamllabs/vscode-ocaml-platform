{ pkgs, stdenv, fetchFromGitHub, opam2nix }:
let
  strings = pkgs.lib.strings;
  ppxlib = fetchFromGitHub {
    owner = "ocaml-ppx";
    repo = "ppxlib";
    rev = "b0c3aeb640d1978777e086e21bab24f999926d49";
    sha256 = "z/Ly7GpHjJVNBDyoFWmahcRrrx8fKNB9xflARkNcNb0=";
  };
  args = {
    inherit (pkgs.ocaml-ng.ocamlPackages_4_13) ocaml;
    selection = ./opam-selection.nix;
    src =
      let
        default = builtins.filterSource (path: type:
          let name = baseNameOf path;
          in
            if type == "directory" then
              name != ".git" && name != "_build" && name != "node_modules" && name
              != ".log" && name != ".vscode-test" && name != "dist"
            else
              strings.hasSuffix ".opam" name) ../.;
        in
        {
          inherit ppxlib;
          vscode = default;
          "vscode-ocaml-platform" = default;
        };

  };
  opam-selection = opam2nix.build args;
  localPackages = let contents = builtins.attrNames (builtins.readDir ../.);
  in builtins.filter (strings.hasSuffix ".opam") contents;
  resolve = opam2nix.resolve args (localPackages ++ ["${ppxlib}/ppxlib.opam"]);

in (builtins.listToAttrs (builtins.map (fname:
  let packageName = strings.removeSuffix ".opam" fname;
  in {
    name = packageName;
    value = builtins.getAttr packageName opam-selection;
  }) localPackages)) // {
    inherit resolve;
    opam = opam-selection;
  }
