{
  description = "NixOS configurations by tboerger";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    utils = {
      url = "github:numtide/flake-utils";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homemanager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deployrs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    arion = {
      url = "github:hercules-ci/arion";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware = {
      url = "github:nixos/nixos-hardware";
    };
  };

  outputs = { self, nixpkgs, nur, utils, agenix, homemanager, deployrs, arion, hardware, ... }@inputs:
    let
      mkComputer = configurationNix: systemName: enableServices: extraModules: nixpkgs.lib.nixosSystem {
        system = systemName;

        modules = [
          ({ pkgs, ... }:
            let
              nur-no-pkgs = import nur {
                nurpkgs = import nixpkgs { system = systemName; };
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
          arion.nixosModules.arion
          configurationNix
          {
            personal = {
              services = {
                enable = enableServices;
              };
            };
          }
        ] ++ extraModules;

        specialArgs = {
          inherit inputs;
        };
      };

    in
    {
      nixosConfigurations = {
        chnum = mkComputer
          ./machines/chnum
          "x86_64-linux"
          true
          [
            ./profiles/thomas
            # ./profiles/anna
            # ./profiles/adrian
            # ./profiles/tabea
          ];

        chnum-bootstrap = mkComputer
          ./machines/chnum
          "x86_64-linux"
          false
          [ ];

        asgard = mkComputer
          ./machines/asgard
          "x86_64-linux"
          true
          [
            ./profiles/thomas
            # ./profiles/anna
            # ./profiles/adrian
            # ./profiles/tabea
          ];

        asgard-bootstrap = mkComputer
          ./machines/asgard
          "x86_64-linux"
          false
          [ ];

        utgard = mkComputer
          ./machines/utgard
          "x86_64-linux"
          true
          [
            ./profiles/thomas
            # ./profiles/anna
            # ./profiles/adrian
            # ./profiles/tabea
          ];

        utgard-bootstrap = mkComputer
          ./machines/utgard
          "x86_64-linux"
          false
          [ ];

        midgard = mkComputer
          ./machines/midgard
          "aarch64-linux"
          true
          [
            hardware.nixosModules.raspberry-pi-4
            ./profiles/thomas
            # ./profiles/anna
            # ./profiles/adrian
            # ./profiles/tabea
          ];

        midgard-bootstrap = mkComputer
          ./machines/midgard
          "aarch64-linux"
          false
          [
            hardware.nixosModules.raspberry-pi-4
          ];
      };

      chnum = self.nixosConfigurations.chnum.config.system.build.toplevel;
      chnum-bootstrap = self.nixosConfigurations.chnum-bootstrap.config.system.build.toplevel;
      asgard = self.nixosConfigurations.asgard.config.system.build.toplevel;
      asgard-bootstrap = self.nixosConfigurations.asgard-bootstrap.config.system.build.toplevel;
      utgard = self.nixosConfigurations.utgard.config.system.build.toplevel;
      utgard-bootstrap = self.nixosConfigurations.utgard-bootstrap.config.system.build.toplevel;
      midgard = self.nixosConfigurations.midgard.config.system.build.toplevel;
      midgard-bootstrap = self.nixosConfigurations.midgard-bootstrap.config.system.build.toplevel;

      deploy = {
        nodes = {
          asgard = {
            sshOpts = [ "-p" "22" ];
            hostname = "192.168.1.10";
            fastConnection = true;

            profiles.system = {
              sshUser = "admin";
              user = "root";
              path = deployrs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.asgard;
            };
          };

          utgard = {
            sshOpts = [ "-p" "22" ];
            hostname = "192.168.1.11";
            fastConnection = true;

            profiles.system = {
              sshUser = "admin";
              user = "root";
              path = deployrs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.utgard;
            };
          };

          midgard = {
            sshOpts = [ "-p" "22" ];
            hostname = "192.168.1.5";
            fastConnection = true;

            profiles.system = {
              sshUser = "admin";
              user = "root";
              path = deployrs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.midgard;
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
