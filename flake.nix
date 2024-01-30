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

    deploy-rs = {
      url = "github:serokell/deploy-rs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homemanager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homeage = {
      url = "github:jordanisaacs/homeage";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware = {
      url = "github:nixos/nixos-hardware";
    };
  };

  outputs = { self, nixpkgs, utils, devshell, deploy-rs, disko, homemanager, homeage, agenix, hardware, ... }@inputs:
    let
      inherit (self) outputs;

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
        anubis = import ./desktops/anubis/disko.nix;
        chnum = import ./desktops/chnum/disko.nix;
        asgard = import ./servers/asgard/disko.nix;
        utgard = import ./servers/utgard/disko.nix;
        vanaheim = import ./servers/vanaheim/disko.nix;
      };

      nixosConfigurations = {
        anubis = mkComputer
          ./desktops/anubis
          "x86_64-linux"
          [
            disko.nixosModules.disko
            ./home/thomas/user.nix
            ./home/anna/user.nix
            ./home/adrian/user.nix
            ./home/tabea/user.nix

            {
              home-manager = {
                extraSpecialArgs = {
                  desktopSystem = true;
                };

                users = {
                  thomas = {
                    imports = [
                      homeage.homeManagerModules.homeage
                      ./home/thomas
                    ];
                  };
                  anna = {
                    imports = [
                      homeage.homeManagerModules.homeage
                      ./home/anna
                    ];
                  };
                  adrian = {
                    imports = [
                      homeage.homeManagerModules.homeage
                      ./home/adrian
                    ];
                  };
                  tabea = {
                    imports = [
                      homeage.homeManagerModules.homeage
                      ./home/tabea
                    ];
                  };
                };
              };
            }
          ];

        chnum = mkComputer
          ./desktops/chnum
          "x86_64-linux"
          [
            disko.nixosModules.disko
            ./home/thomas/user.nix
            ./home/anna/user.nix
            ./home/adrian/user.nix
            ./home/tabea/user.nix

            {
              home-manager = {
                extraSpecialArgs = {
                  desktopSystem = true;
                };

                users = {
                  thomas = {
                    imports = [
                      homeage.homeManagerModules.homeage
                      ./home/thomas
                    ];
                  };
                  anna = {
                    imports = [
                      homeage.homeManagerModules.homeage
                      ./home/anna
                    ];
                  };
                  adrian = {
                    imports = [
                      homeage.homeManagerModules.homeage
                      ./home/adrian
                    ];
                  };
                  tabea = {
                    imports = [
                      homeage.homeManagerModules.homeage
                      ./home/tabea
                    ];
                  };
                };
              };
            }
          ];

        asgard = mkComputer
          ./servers/asgard
          "x86_64-linux"
          [
            disko.nixosModules.disko
            ./home/thomas/user.nix

            {
              home-manager = {
                extraSpecialArgs = {
                  desktopSystem = false;
                };

                users = {
                  thomas = {
                    imports = [
                      homeage.homeManagerModules.homeage
                      ./home/thomas
                    ];
                  };
                };
              };
            }
          ];

        utgard = mkComputer
          ./servers/utgard
          "x86_64-linux"
          [
            disko.nixosModules.disko
            ./home/thomas/user.nix

            {
              home-manager = {
                extraSpecialArgs = {
                  desktopSystem = false;
                };

                users = {
                  thomas = {
                    imports = [
                      homeage.homeManagerModules.homeage
                      ./home/thomas
                    ];
                  };
                };
              };
            }
          ];

        vanaheim = mkComputer
          ./servers/vanaheim
          "x86_64-linux"
          [
            disko.nixosModules.disko
            ./home/thomas/user.nix

            {
              home-manager = {
                extraSpecialArgs = {
                  desktopSystem = false;
                };

                users = {
                  thomas = {
                    imports = [
                      homeage.homeManagerModules.homeage
                      ./home/thomas
                    ];
                  };
                };
              };
            }
          ];

        # yggdrasil = mkComputer
        #   ./servers/yggdrasil
        #   "aarch64-linux"
        #   [
        #     hardware.nixosModules.raspberry-pi-4
        #     ./home/thomas/user.nix

        #     {
        #       home-manager = {
        #         extraSpecialArgs = {
        #           desktopSystem = false;
        #         };

        #         users = {
        #           thomas = {
        #             imports = [
        #               homeage.homeManagerModules.homeage
        #               ./home/thomas
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
              gnumake
              home-manager
              nixpkgs-fmt
              nixUnstable
              rage
            ];
          };
        }
      );
}
