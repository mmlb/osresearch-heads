{
  description = "heads flake, mostly for devshell for now";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    devshell,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      /*
      pkgs = import nixpkgs {
        inherit system;
        overlays = [devshell.overlay];
      };
      */
      pkgs = nixpkgs.legacyPackages.${system};
    in
      with pkgs; rec {
        devShell = pkgs.mkShellNoCC {
          packages = [
            bison
            flex
            #gcc12
            gnat12
            gnumake
            isl
            m4
            zlib
          ];
        };
      });
}
