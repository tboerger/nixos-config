{
  description = "NixOS configurations by tboerger";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-21.11";
    };

    master = {
      url = "github:nixos/nixpkgs/master";
    };

    unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
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
      overlay-master = final: prev: {
        master = inputs.master.legacyPackages.${prev.system};
      };

      overlay-unstable = final: prev: {
        unstable = inputs.unstable.legacyPackages.${prev.system};
      };

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
            overlay-master
            overlay-unstable
          ];
        };
      };
    in
    {
      overlay = import ./overlays;

      nixosConfigurations = {
        utgard = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            ({ pkgs, ... }:
              let
                nur-no-pkgs = import nur {
                  nurpkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
                };
              in {
                imports = [
                  nur-no-pkgs.repos.tboerger.modules
                ];
            })
            inputs.homemanager.nixosModules.home-manager
            inputs.agenix.nixosModules.age
            sharedNixosConfiguration
            ./machines/utgard
            ./profiles/thomas
          ];

          specialArgs = {
            inherit inputs;
          };
        };
        asgard = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          inherit inputs;

          modules = [
            ({ pkgs, ... }:
              let
                nur-no-pkgs = import nur {
                  nurpkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
                };
              in {
                imports = [
                  nur-no-pkgs.repos.tboerger.modules
                ];
            })
            inputs.homemanager.nixosModules.home-manager
            inputs.agenix.nixosModules.age
            sharedNixosConfiguration
            ./machines/asgard
            ./profiles/thomas
          ];

          specialArgs = {
            inherit inputs;
          };
        };
        midgard = inputs.nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          inherit inputs;

          modules = [
            ({ pkgs, ... }:
              let
                nur-no-pkgs = import nur {
                  nurpkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
                };
              in {
                imports = [
                  nur-no-pkgs.repos.tboerger.modules
                ];
            })
            inputs.homemanager.nixosModules.home-manager
            inputs.agenix.nixosModules.age
            sharedNixosConfiguration
            ./machines/midgard
            ./profiles/thomas
          ];

          specialArgs = {
            inherit inputs;
          };
        };
      };

      midgard = self.nixosConfigurations.midgard.config.system.build.toplevel;
      utgard = self.nixosConfigurations.utgard.config.system.build.toplevel;
      asgard = self.nixosConfigurations.asgard.config.system.build.toplevel;
    };
}
