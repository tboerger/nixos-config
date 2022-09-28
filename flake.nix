{
  description = "NixOS configurations by tboerger";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-22.05";
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

    utils = {
      url = "github:numtide/flake-utils";
    };

    deployrs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
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

  outputs = { self, nixpkgs, unstable, hardware, nur, utils, deployrs, agenix, homemanager, ... }@inputs:
    let
      unstable-overlay = final: prev: {
        unstable = import unstable {
          system = prev.system;
          config.allowUnfree = true;
        };
      };

    in
    {
      nixosConfigurations = {
        chnum = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            ({ pkgs, ... }:
              let
                nur-no-pkgs = import nur {
                  nurpkgs = import nixpkgs { system = "x86_64-linux"; };
                };
              in
              {
                imports = [
                  nur-no-pkgs.repos.tboerger.modules
                ];

                nixpkgs = {
                  overlays = [
                    (import ./overlays)
                    nur.overlay
                    unstable-overlay
                  ];
                };
              })
            homemanager.nixosModules.home-manager
            agenix.nixosModules.age
            ./machines/chnum
            ./profiles/thomas
          ];

          specialArgs = {
            inherit inputs;
          };
        };

        midgard = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";

          modules = [
            ({ pkgs, ... }:
              let
                nur-no-pkgs = import nur {
                  nurpkgs = import nixpkgs { system = "aarch64-linux"; };
                };
              in
              {
                imports = [
                  nur-no-pkgs.repos.tboerger.modules
                ];

                nixpkgs = {
                  overlays = [
                    (import ./overlays)
                    nur.overlay
                    unstable-overlay
                  ];
                };
              })
            hardware.nixosModules.raspberry-pi-4
            homemanager.nixosModules.home-manager
            agenix.nixosModules.age
            ./machines/midgard
            ./profiles/thomas
          ];

          specialArgs = {
            inherit inputs;
          };
        };

        vanaheim = nixpkgs.lib.nixosSystem {
          system = "armv6l-linux";

          modules = [
            ({ pkgs, ... }:
              let
                nur-no-pkgs = import nur {
                  nurpkgs = import nixpkgs { system = "armv6l-linux"; };
                };
              in
              {
                imports = [
                  nur-no-pkgs.repos.tboerger.modules
                ];

                nixpkgs = {
                  overlays = [
                    (import ./overlays)
                    nur.overlay
                    unstable-overlay
                  ];
                };
              })
            homemanager.nixosModules.home-manager
            agenix.nixosModules.age
            ./machines/vanaheim
            ./profiles/thomas
          ];

          specialArgs = {
            inherit inputs;
          };
        };

        niflheim = nixpkgs.lib.nixosSystem {
          system = "armv6l-linux";

          modules = [
            ({ pkgs, ... }:
              let
                nur-no-pkgs = import nur {
                  nurpkgs = import nixpkgs { system = "armv6l-linux"; };
                };
              in
              {
                imports = [
                  nur-no-pkgs.repos.tboerger.modules
                ];

                nixpkgs = {
                  overlays = [
                    (import ./overlays)
                    nur.overlay
                    unstable-overlay
                  ];
                };
              })
            homemanager.nixosModules.home-manager
            agenix.nixosModules.age
            ./machines/niflheim
            ./profiles/thomas
          ];

          specialArgs = {
            inherit inputs;
          };
        };

        utgard = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            ({ pkgs, ... }:
              let
                nur-no-pkgs = import nur {
                  nurpkgs = import nixpkgs { system = "x86_64-linux"; };
                };
              in
              {
                imports = [
                  nur-no-pkgs.repos.tboerger.modules
                ];

                nixpkgs = {
                  overlays = [
                    (import ./overlays)
                    nur.overlay
                    unstable-overlay
                  ];
                };

                nixpkgs.config.allowUnfree = true;
              })
            homemanager.nixosModules.home-manager
            agenix.nixosModules.age
            ./machines/utgard
            ./profiles/thomas
          ];

          specialArgs = {
            inherit inputs;
          };
        };

        asgard = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            ({ pkgs, ... }:
              let
                nur-no-pkgs = import nur {
                  nurpkgs = import nixpkgs { system = "x86_64-linux"; };
                };
              in
              {
                imports = [
                  nur-no-pkgs.repos.tboerger.modules
                ];

                nixpkgs = {
                  overlays = [
                    (import ./overlays)
                    nur.overlay
                    unstable-overlay
                  ];
                };
              })
            homemanager.nixosModules.home-manager
            agenix.nixosModules.age
            ./machines/asgard
            ./profiles/thomas
          ];

          specialArgs = {
            inherit inputs;
          };
        };

        rpi1 = nixpkgs.lib.nixosSystem {
          system = "armv6l-linux";

          modules = [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix"
            {
              nixpkgs = {
                config = {
                  allowUnsupportedSystem = true;
                  allowUnfree = true;
                };

                crossSystem = {
                  system = "armv6l-linux";
                };
              };

              system = {
                stateVersion = "22.05";
              };
            }
          ];
        };

        rpi4 = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";

          modules = [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix"
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

              system = {
                stateVersion = "22.05";
              };
            }
          ];
        };
      };

      chnum = self.nixosConfigurations.chnum.config.system.build.toplevel;
      midgard = self.nixosConfigurations.midgard.config.system.build.toplevel;
      vanaheim = self.nixosConfigurations.vanaheim.config.system.build.toplevel;
      niflheim = self.nixosConfigurations.niflheim.config.system.build.toplevel;
      utgard = self.nixosConfigurations.utgard.config.system.build.toplevel;
      asgard = self.nixosConfigurations.asgard.config.system.build.toplevel;

      images = {
        rpi1 = self.nixosConfigurations.rpi1.config.system.build.sdImage;
        rpi4 = self.nixosConfigurations.rpi4.config.system.build.sdImage;
      };

      deploy = {
        nodes = {
          midgard = {
            sshOpts = [ "-p" "22" ];
            hostname = "192.168.1.5";
            fastConnection = true;

            profiles.system = {
              sshUser = "thomas";
              user = "root";
              path = deployrs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.midgard;
            };
          };

          vanaheim = {
            sshOpts = [ "-p" "22" ];
            hostname = "192.168.1.6";
            fastConnection = true;

            profiles.system = {
              sshUser = "thomas";
              user = "root";
              path = deployrs.lib.armv6l-linux.activate.nixos self.nixosConfigurations.vanaheim;
            };
          };

          niflheim = {
            sshOpts = [ "-p" "22" ];
            hostname = "192.168.1.7";
            fastConnection = true;

            profiles.system = {
              sshUser = "thomas";
              user = "root";
              path = deployrs.lib.armv6l-linux.activate.nixos self.nixosConfigurations.niflheim;
            };
          };

          asgard = {
            sshOpts = [ "-p" "22" ];
            hostname = "192.168.1.10";
            fastConnection = true;

            profiles.system = {
              sshUser = "thomas";
              user = "root";
              path = deployrs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.asgard;
            };
          };

          utgard = {
            sshOpts = [ "-p" "22" ];
            hostname = "192.168.1.11";
            fastConnection = true;

            profiles.system = {
              sshUser = "thomas";
              user = "root";
              path = deployrs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.utgard;
            };
          };
        };
      };

      checks = builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy)
        deployrs.lib;
    } // utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            agenix.defaultPackage.${system}
            deployrs.defaultPackage.${system}
            nixpkgs-fmt
            gnumake
            nixUnstable
          ];
        };
      }
    );
}
