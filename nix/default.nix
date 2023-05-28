{ pkgs, stdenv, fetchFromGitHub, opam2nix }:
let
  strings = pkgs.lib.strings;
  args = {
    inherit (pkgs.ocaml-ng.ocamlPackages_4_14) ocaml;
    selection = ./opam-selection.nix;
    override = {pkg, selection}: {
	    dune = super: super.overrideAttrs (attrs: {
		    buildInputs =
          (attrs.buildInputs or [])
          ++ pkgs.lib.optionals stdenv.isDarwin
            [ pkgs.darwin.apple_sdk.frameworks.CoreServices];
      });
    };
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
          vscode = default;
          "vscode-ocaml-platform" = default;
        };

  };
  opam-selection = opam2nix.build args;
  localPackages = let contents = builtins.attrNames (builtins.readDir ../.);
  in builtins.filter (strings.hasSuffix ".opam") contents;
  resolve = opam2nix.resolve args localPackages;

in (builtins.listToAttrs (builtins.map (fname:
  let packageName = strings.removeSuffix ".opam" fname;
  in {
    name = packageName;
    value = builtins.getAttr packageName opam-selection;
  }) localPackages)) // {
    inherit resolve;
    opam = opam-selection;
  }
