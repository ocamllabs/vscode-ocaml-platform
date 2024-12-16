{
  description = "vscode-ocaml-platform Nix Flake";

  inputs.nix-filter.url = "github:numtide/nix-filter";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.jsonoo.url = "github:mnxn/jsonoo";
  inputs.jsonoo.flake = false;

  outputs = { self, nixpkgs, flake-utils, nix-filter, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
        inherit (pkgs.ocamlPackages) buildDunePackage;
        jsonoo = buildDunePackage {
          pname = "jsonoo";
          version = "n/a";
          src = inputs.jsonoo;
          nativeBuildInputs = [ pkgs.ocamlPackages.gen_js_api ];
          propagatedBuildInputs =
            (with pkgs.ocamlPackages; [
              gen_js_api
              js_of_ocaml
              js_of_ocaml-ppx
            ]);
          duneVersion = "3";
        };
      in
      rec {
        packages = rec {
          default = vscode-ocaml-platform;
          vscode = buildDunePackage {
            pname = "vscode";
            version = "n/a";
            src = ./.;
            duneVersion = "3";
            propagatedBuildInputs = with pkgs.ocamlPackages; [
              gen_js_api
              js_of_ocaml
              jsonoo
              promise_jsoo
            ];
            checkInputs = with pkgs.ocamlPackages; [ ];
            doCheck = true;
          };
          vscode-ocaml-platform = buildDunePackage {
            pname = "vscode-ocaml-platform";
            inherit (packages.vscode) src version;
            propagatedBuildInputs = [ packages.vscode jsonoo ] ++
              (with pkgs.ocamlPackages; [
                base
                gen_js_api
                js_of_ocaml
                ocaml-version
                opam-file-format
                ppxlib
                promise_jsoo
              ]);
            duneVersion = "3";
          };
        };
        devShells.default = pkgs.mkShell {
          inputsFrom = pkgs.lib.attrValues packages;
          buildInputs = with pkgs.ocamlPackages; [
            jsonoo
            ocaml-lsp
            pkgs.ocamlformat_0_27_0
            pkgs.vscode
            pkgs.yarn-berry
          ];
          shellHook = ''
            make npm-deps
          '';
        };
      });
}
