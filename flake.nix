{
  description = "heads flake, mostly for devshell for now";

  inputs = {
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    gnat6nixpkgs.url = "github:mmlb/NixOS-nixpkgs/gnat6";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
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
      pkgs = nixpkgs.legacyPackages.${system};
      gnat6pkgs = gnat6nixpkgs.legacyPackages.${system};
    in
      with pkgs; rec {
        devShell = pkgs.mkShellNoCC {
          packages = [
            bison # Generate flashmap descriptor parser
            curl
            flex
            #gcc
            git
            gnat6pkgs.gnat6
            gnumake
            isl
            m4
            ncurses # make menuconfig
            nss # ca-certs
            perl
            pkgconfig
            qemu #test image
            rsync #needed by 5.x linux kernels
            swtpm #test image with qemu and BOARD=qemu-(fb)whiptail-tpm(1/2) targets
            texinfo
            wget
            which
            zlib.dev
          ];
        };
      });
}
