{
  description = "NixOS configurations by tboerger";

  inputs = {
    nixpkgs = {
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

  outputs = { self, nixpkgs, hardware, nur, utils, deployrs, agenix, homemanager, ... }@inputs:
    let

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
      };

      chnum = self.nixosConfigurations.chnum.config.system.build.toplevel;
      midgard = self.nixosConfigurations.midgard.config.system.build.toplevel;
      utgard = self.nixosConfigurations.utgard.config.system.build.toplevel;
      asgard = self.nixosConfigurations.asgard.config.system.build.toplevel;

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
