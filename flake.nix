{
  description = "heads flake, mostly for devshell for now";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    gnat6nixpkgs.url = "nixpkgs/19cb612405c82c7f4fb3ce4497e24c1efa0b1935";
    devshell.inputs.flake-utils.follows = "flake-utils";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    devshell,
    gnat6nixpkgs,
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
      gnat6pkgs = gnat6nixpkgs.legacyPackages.${system};
    in
      with pkgs; rec {
        devShell = pkgs.mkShellNoCC {
          packages = [
            bison
            flex
            gnat6pkgs.gnat6
            #gnat6
            #gnat9
            #gnat10
            #gnat11
            #gnat12
            gnumake
            isl
            m4
            zlib
          ];
        };
      });
}
