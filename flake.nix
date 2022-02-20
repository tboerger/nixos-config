{
  description = "NixOS configurations by tboerger";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homemanager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nur, ... }@inputs:
    let
      sharedNixosConfiguration = { config, pkgs, ... }: {
        nix = {
          package = pkgs.nixFlakes;

          extraOptions = ''
            experimental-features = nix-command flakes
          '';

          binaryCaches = [
            "https://cache.nixos.org"
            "https://nix-community.cachix.org"
            "https://nixpkgs.cachix.org"
            "https://tboerger.cachix.org"
          ];

          binaryCachePublicKeys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
            "tboerger.cachix.org-1:3Q1gyqgA9NsOshOgknDvc6fhA8gw0PFAf2qs5vJpeLU="
          ];

          gc = {
            automatic = true;
            persistent = true;
            dates = "weekly";
            options = "--delete-older-than 2w";
          };
        };

        nixpkgs = {
          config = {
            allowUnfree = true;
          };

          overlays = [
            self.overlay
            nur.overlay
          ];
        };
      };
    in
    {
      overlay = import ./overlays;

      nixosConfigurations = {
        utgard = {
          system = "x86_64-linux";
          inherit inputs;

          modules = [
            inputs.homemanager.nixosModules.home-manager
            inputs.agenix.nixosModules.age
            sharedNixosConfiguration
            ./machines/utgard
            ./profiles/thomas
          ];
        };
        asgard = {
          system = "x86_64-linux";
          inherit inputs;

          modules = [
            inputs.homemanager.nixosModules.home-manager
            inputs.agenix.nixosModules.age
            sharedNixosConfiguration
            ./machines/asgard
            ./profiles/thomas
          ];
        };
        midgard = {
          system = "aarch64-linux";
          inherit inputs;

          modules = [
            inputs.homemanager.nixosModules.home-manager
            inputs.agenix.nixosModules.age
            sharedNixosConfiguration
            ./machines/midgard
            ./profiles/thomas
          ];
        };
      };

      midgard = self.nixosConfigurations.midgard.system;
      utgard = self.nixosConfigurations.utgard.system;
      asgard = self.nixosConfigurations.asgard.system;
    };
}
