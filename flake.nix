{
  description = "Shakoh's NixOS and Home-manager flake";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; }
    {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      imports = [
        ./hosts
        ./lib
        ./modules
        ./pkgs
        ./users
      ];

      perSystem = { pkgs, ... }:
      {
        devShells.default = pkgs.mkShell {
          name = "deployment-shell";
          formatter = pkgs.nixfmt-rfc-style;
          packages = with pkgs; [
            just
            git
          ];
        };
      };
    };

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
  };

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      ref = "main";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    utils = {
      type = "github";
      owner = "sh-koh";
      repo = "nix-utils";
      ref = "main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mysecrets = {
      type = "git";
      url = "ssh://git@github.com/sh-koh/nix-secrets.git";
      ref = "main";
      shallow = true;
      flake = false;
    };
    # Dependencies (in alphabetical order)
    agenix = {
      type = "github";
      owner = "ryantm";
      repo = "agenix";
      ref = "main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      type = "github";
      owner = "aylur";
      repo = "ags";
      ref = "v2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      type = "github";
      owner = "kirottu";
      repo = "anyrun";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    nixvim = {
      type = "github";
      owner = "nix-community";
      repo = "nixvim";
      ref = "main";
      #inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    raspberry-pi = {
      type = "github";
      owner = "nix-community";
      repo = "raspberry-pi-nix";
      ref = "master";
      #inputs.nixpkgs.follows = "nixpkgs"; # Do not override nixpkgs to use the cache.
    };
    stylix = {
      type = "github";
      owner = "danth";
      repo = "stylix";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    umu = {
      type = "git";
      url = "https://github.com/Open-Wine-Components/umu-launcher";
      ref = "main";
      dir = "packaging/nix";
      submodules = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
