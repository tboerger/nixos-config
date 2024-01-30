{ nixpkgs, inputs, ... }:

{
  imports = [
    inputs.profile-parts.flakeModules.nixos
  ];

  profile-parts = {
    default.nixos = {
      inherit (inputs) nixpkgs;

      enable = true;
      system = "x86_64-linux";

      exposePackages = true;
    };

    global.nixos = {
      modules =
        { name
        , profile
        ,
        }: [
          ({ pkgs, ... }:
          {
            nixpkgs = {
              overlays = [
                (import ./overlays)
              ];
            };
          }
          )
          inputs.homemanager.nixosModules.home-manager
          inputs.agenix.nixosModules.default
        ];

      specialArgs = {
        inherit inputs;
      };
    };

    nixos = {
      anubis = {
        hostname = "anubis";
        nixpkgs = inputs.nixpkgs;
        system = "x86_64-linux";

        modules = [
          inputs.disko.nixosModules.disko
          ./desktops/anubis
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
                    inputs.homeage.homeManagerModules.homeage
                    ./home/thomas
                  ];
                };
                anna = {
                  imports = [
                    inputs.homeage.homeManagerModules.homeage
                    ./home/anna
                  ];
                };
                adrian = {
                  imports = [
                    inputs.homeage.homeManagerModules.homeage
                    ./home/adrian
                  ];
                };
                tabea = {
                  imports = [
                    inputs.homeage.homeManagerModules.homeage
                    ./home/tabea
                  ];
                };
              };
            };
          }
        ];
      };

      chnum = {
        hostname = "chnum";
        nixpkgs = inputs.nixpkgs;
        system = "x86_64-linux";

        modules = [
          inputs.disko.nixosModules.disko
          ./desktops/chnum
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
                    inputs.homeage.homeManagerModules.homeage
                    ./home/thomas
                  ];
                };
                anna = {
                  imports = [
                    inputs.homeage.homeManagerModules.homeage
                    ./home/anna
                  ];
                };
                adrian = {
                  imports = [
                    inputs.homeage.homeManagerModules.homeage
                    ./home/adrian
                  ];
                };
                tabea = {
                  imports = [
                    inputs.homeage.homeManagerModules.homeage
                    ./home/tabea
                  ];
                };
              };
            };
          }
        ];
      };

      asgard = {
        hostname = "asgard";
        nixpkgs = inputs.nixpkgs;
        system = "x86_64-linux";

        modules = [
          inputs.disko.nixosModules.disko
          ./desktops/asgard
          ./home/thomas/user.nix

          {
            home-manager = {
              extraSpecialArgs = {
                desktopSystem = true;
              };

              users = {
                thomas = {
                  imports = [
                    inputs.homeage.homeManagerModules.homeage
                    ./home/thomas
                  ];
                };
              };
            };
          }
        ];
      };

      utgard = {
        hostname = "utgard";
        nixpkgs = inputs.nixpkgs;
        system = "x86_64-linux";

        modules = [
          inputs.disko.nixosModules.disko
          ./desktops/utgard
          ./home/thomas/user.nix

          {
            home-manager = {
              extraSpecialArgs = {
                desktopSystem = true;
              };

              users = {
                thomas = {
                  imports = [
                    inputs.homeage.homeManagerModules.homeage
                    ./home/thomas
                  ];
                };
              };
            };
          }
        ];
      };

      vanaheim = {
        hostname = "vanaheim";
        nixpkgs = inputs.nixpkgs;
        system = "x86_64-linux";

        modules = [
          inputs.disko.nixosModules.disko
          ./desktops/vanaheim
          ./home/thomas/user.nix

          {
            home-manager = {
              extraSpecialArgs = {
                desktopSystem = true;
              };

              users = {
                thomas = {
                  imports = [
                    inputs.homeage.homeManagerModules.homeage
                    ./home/thomas
                  ];
                };
              };
            };
          }
        ];
      };

      yggdrasil = {
        hostname = "yggdrasil";
        nixpkgs = inputs.nixpkgs;
        system = "aarch64-linux";

        modules = [
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
          ./desktops/yggdrasil
          ./home/thomas/user.nix

          {
            home-manager = {
              extraSpecialArgs = {
                desktopSystem = true;
              };

              users = {
                thomas = {
                  imports = [
                    inputs.homeage.homeManagerModules.homeage
                    ./home/thomas
                  ];
                };
              };
            };
          }
        ];
      };
    };
  };
}
