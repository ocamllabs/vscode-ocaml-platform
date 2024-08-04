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
              js_of_ocaml
              js_of_ocaml-ppx
              gen_js_api
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
              js_of_ocaml
              gen_js_api
              promise_jsoo
              jsonoo
            ];
            checkInputs = with pkgs.ocamlPackages; [ ];
            doCheck = true;
          };
          vscode-ocaml-platform = buildDunePackage {
            pname = "vscode-ocaml-platform";
            inherit (packages.vscode) src version;
            propagatedBuildInputs = [ packages.vscode jsonoo ] ++
              (with pkgs.ocamlPackages; [
                js_of_ocaml
                gen_js_api
                base
                promise_jsoo
                ocaml-version
                ppxlib
                opam-file-format
              ]);
            duneVersion = "3";
          };
        };
        devShells.default = pkgs.mkShell {
          inputsFrom = pkgs.lib.attrValues packages;
          buildInputs = with pkgs.ocamlPackages; [
            pkgs.yarn
            jsonoo
            ocaml-lsp
            pkgs.ocamlformat_0_26_1
            pkgs.vscode
            pkgs.nodePackages.parcel
          ];
          shellHook = ''
            make npm-deps
          '';
        };
      });
}
