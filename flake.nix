{
  description = "NixOS configurations by tboerger";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    utils = {
      url = "github:numtide/flake-utils";
    };

    devshell = {
      url = "github:numtide/devshell";
    };

    homemanager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware = {
      url = "github:nixos/nixos-hardware";
    };
  };

  outputs = { self, nixpkgs, utils, devshell, homemanager, agenix, deploy-rs, disko, hardware, ... }@inputs:
    let
      inherit (self) outputs;

      sharedConfiguration = { config, pkgs, ... }: {
        nix = {
          package = pkgs.nixVersions.stable;

          extraOptions = ''
            experimental-features = nix-command flakes
          '';

          settings = {
            substituters = [
              "https://cache.nixos.org"
              "https://nix-community.cachix.org"
              "https://nixpkgs.cachix.org"
              "https://tboerger.cachix.org"
            ];

            trusted-public-keys = [
              "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
              "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
              "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
              "tboerger.cachix.org-1:3Q1gyqgA9NsOshOgknDvc6fhA8gw0PFAf2qs5vJpeLU="
            ];
          };

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
        };
      };

      mkComputer = configurationNix: systemName: extraModules: nixpkgs.lib.nixosSystem {
        system = systemName;

        modules = [
          ({ pkgs, ... }:
            {
              nixpkgs = {
                overlays = [
                  (import ./overlays)
                ];
              };
            }
          )
          sharedConfiguration
          homemanager.nixosModules.home-manager
          agenix.nixosModules.default
          configurationNix
        ] ++ extraModules;

        specialArgs = {
          inherit inputs;
        };
      };

    in
    {
      diskoConfigurations = {
        asgard = import ./machines/asgard/disko.nix;
        utgard = import ./machines/utgard/disko.nix;
        vanaheim = import ./machines/vanaheim/disko.nix;
      };

      nixosConfigurations = {
        asgard = mkComputer
          ./machines/asgard
          "x86_64-linux"
          [
            disko.nixosModules.disko
            ./profiles/thomas/user.nix

            {
              home-manager = {
                extraSpecialArgs = {
                  desktopSystem = false;
                };

                users = {
                  thomas = {
                    imports = [
                      agenix.homeManagerModules.default
                      ./profiles/thomas
                    ];
                  };
                };
              };
            }
          ];

        utgard = mkComputer
          ./machines/utgard
          "x86_64-linux"
          [
            disko.nixosModules.disko
            ./profiles/thomas/user.nix

            {
              home-manager = {
                extraSpecialArgs = {
                  desktopSystem = false;
                };

                users = {
                  thomas = {
                    imports = [
                      agenix.homeManagerModules.default
                      ./profiles/thomas
                    ];
                  };
                };
              };
            }
          ];

        vanaheim = mkComputer
          ./machines/vanaheim
          "x86_64-linux"
          [
            disko.nixosModules.disko
            ./profiles/thomas/user.nix

            {
              home-manager = {
                extraSpecialArgs = {
                  desktopSystem = false;
                };

                users = {
                  thomas = {
                    imports = [
                      agenix.homeManagerModules.default
                      ./profiles/thomas
                    ];
                  };
                };
              };
            }
          ];

        # yggdrasil = mkComputer
        #   ./machines/yggdrasil
        #   "aarch64-linux"
        #   [
        #     hardware.nixosModules.raspberry-pi-4
        #     ./profiles/thomas/user.nix

        #     {
        #       home-manager = {
        #         extraSpecialArgs = {
        #           desktopSystem = false;
        #         };

        #         users = {
        #           thomas = {
        #             imports = [
        #               agenix.homeManagerModules.default
        #               ./profiles/thomas
        #             ];
        #           };
        #         };
        #       };
        #     }
        #   ];
      };

      deploy = {
        nodes = {
          asgard = {
            sshOpts = [ "-p" "22" ];
            hostname = "asgard.boerger.ws";
            fastConnection = true;
            profiles = {
              system = {
                sshUser = "thomas";
                path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.asgard;
                user = "root";
              };
            };
          };
          utgard = {
            sshOpts = [ "-p" "22" ];
            hostname = "utgard.boerger.ws";
            fastConnection = true;
            profiles = {
              system = {
                sshUser = "thomas";
                path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.utgard;
                user = "root";
              };
            };
          };
          vanaheim = {
            sshOpts = [ "-p" "22" ];
            hostname = "vanaheim.boerger.ws";
            fastConnection = true;
            profiles = {
              system = {
                sshUser = "thomas";
                path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.vanaheim;
                user = "root";
              };
            };
          };
          # yggdrasil = {
          #   sshOpts = [ "-p" "22" ];
          #   hostname = "yggdrasil.boerger.ws";
          #   fastConnection = true;
          #   profiles = {
          #     system = {
          #       sshUser = "thomas";
          #       path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.yggdrasil;
          #       user = "root";
          #     };
          #   };
          # };
        };
      };

      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    } // utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ devshell.overlays.default ];
          };

        in
        {
          devShells.default = pkgs.devshell.mkShell {
            commands = [
              {
                name = "age-encrypt";
                category = "secrets commands";
                help = "Encrypt secret with age";
                command = "${pkgs.rage}/bin/rage -e -a -i ~/.ssh/id_ed25519";
              }
              {
                name = "age-decrypt";
                category = "secrets commands";
                help = "Decrypt secret with age";
                command = "${pkgs.rage}/bin/rage -d -i ~/.ssh/id_ed25519";
              }
              {
                name = "agenix-rekey";
                category = "secrets commands";
                help = "Rekey agenix secrets";
                command = "cd secrets && agenix -r";
              }

              {
                package = "nixpkgs-fmt";
                category = "formatter commands";
              }
            ];

            packages = with pkgs; [
              inputs.agenix.packages.${system}.default
              inputs.deploy-rs.packages.${system}.default

              git
              home-manager
              nixpkgs-fmt
              rage
            ];
          };
        }
      );
}
