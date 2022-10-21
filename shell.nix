let
  _pkgs = import <nixpkgs> {};
in
  {
    pkgs ?
      import (_pkgs.fetchFromGitHub {
        owner = "NixOS";
        repo = "nixpkgs";
        #branch@date: nixpkgs-unstable@2023-01-03
        rev = "298add347c2bbce14020fcb54051f517c391196b";
        sha256 = "0q0c6gf21rbfxvb9fvcmybvz9fxskbk324xbvqsh1dz2wzgylrja";
      }) {},
  }:
    (pkgs.buildFHSUserEnv {
      name = "heads-build-env";
      targetPkgs = pkgs: (with pkgs; [
        bison # Generate flashmap descriptor parser
        curl
        flex
        git
        gnat11 # gcc with ada
        gnumake
        m4
        ncurses # make menuconfig
        nss # ca-certs
        perl
        pkgconfig
        qemu # test the image
        zlib.dev
        wget
      ]);
      runScript = ''
        #!/usr/bin/env bash
        unset NIX_SSL_CERT_FILE
        unset SSL_CERT_FILE
        bash
      '';
    })
    .env
