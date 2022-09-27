{
  description = "NixOS configurations by tboerger";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-22.05";
    };

    master = {
      url = "github:nixos/nixpkgs/master";
    };

    unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    hardware = {
      url = "github:nixos/nixos-hardware/master";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homemanager = {
      url = "github:nix-community/home-manager/release-22.05";
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
            "https://thefloweringash-armv7.cachix.org"
          ];

          binaryCachePublicKeys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
            "tboerger.cachix.org-1:3Q1gyqgA9NsOshOgknDvc6fhA8gw0PFAf2qs5vJpeLU="
            "thefloweringash-armv7.cachix.org-1:v+5yzBD2odFKeXbmC+OPWVqx4WVoIVO6UXgnSAWFtso="
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
        rpi1 = inputs.nixpkgs.lib.nixosSystem {
          system = "armv7l-linux";

          modules = [
            "${inputs.nixpkgs}/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix"
            {
              nixpkgs = {
                config = {
                  allowUnsupportedSystem = true;
                  allowUnfree = true;
                };

                crossSystem = {
                  system = "armv7l-linux";
                };
              };
            }
          ];
        };

        rpi4 = inputs.nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";

          modules = [
            "${inputs.nixpkgs}/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix"
            {
              nixpkgs = {
                config = {
                  allowUnsupportedSystem = true;
                  allowUnfree = true;
                };

                crossSystem = {
                  system = "aarch64-linux";
                };
              };
            }
          ];
        };

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

          modules = [
            ({ pkgs, ... }:
              let
                nur-no-pkgs = import nur {
                  nurpkgs = import inputs.nixpkgs { system = "aarch64-linux"; };
                };
              in {
                imports = [
                  nur-no-pkgs.repos.tboerger.modules
                ];
            })
            inputs.hardware.nixosModules.raspberry-pi-4
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

        vanaheim = inputs.nixpkgs.lib.nixosSystem {
          system = "armv7l-linux";

          modules = [
            ({ pkgs, ... }:
              let
                nur-no-pkgs = import nur {
                  nurpkgs = import inputs.nixpkgs { system = "armv7l-linux"; };
                };
              in {
                imports = [
                  nur-no-pkgs.repos.tboerger.modules
                ];
            })
            inputs.homemanager.nixosModules.home-manager
            inputs.agenix.nixosModules.age
            sharedNixosConfiguration
            ./machines/vanaheim
            ./profiles/thomas
          ];

          specialArgs = {
            inherit inputs;
          };
        };

        niflheim = inputs.nixpkgs.lib.nixosSystem {
          system = "armv7l-linux";

          modules = [
            ({ pkgs, ... }:
              let
                nur-no-pkgs = import nur {
                  nurpkgs = import inputs.nixpkgs { system = "armv7l-linux"; };
                };
              in {
                imports = [
                  nur-no-pkgs.repos.tboerger.modules
                ];
            })
            inputs.homemanager.nixosModules.home-manager
            inputs.agenix.nixosModules.age
            sharedNixosConfiguration
            ./machines/niflheim
            ./profiles/thomas
          ];

          specialArgs = {
            inherit inputs;
          };
        };
      };

      images = {
        rpi1 = self.nixosConfigurations.rpi1.config.system.build.sdImage;
        rpi4 = self.nixosConfigurations.rpi4.config.system.build.sdImage;
      };

      utgard = self.nixosConfigurations.utgard.config.system.build.toplevel;
      asgard = self.nixosConfigurations.asgard.config.system.build.toplevel;
      midgard = self.nixosConfigurations.midgard.config.system.build.toplevel;
      vanaheim = self.nixosConfigurations.vanaheim.config.system.build.toplevel;
      niflheim = self.nixosConfigurations.niflheim.config.system.build.toplevel;
    };
}
