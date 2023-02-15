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

    hardware = {
      url = "github:nixos/nixos-hardware";
    };
  };

  outputs = { self, nixpkgs, nur, utils, agenix, homemanager, hardware, ... }@inputs:
    let
      mkComputer = configurationNix: systemName: extraModules: nixpkgs.lib.nixosSystem {
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
          agenix.nixosModules.default
          configurationNix
        ] ++ extraModules;

        specialArgs = {
          inherit inputs;
        };
      };

    in
    {
      nixosConfigurations = {
        anubis = mkComputer
          ./desktops/anubis
          "x86_64-linux"
          [
            ./profiles/thomas
            # ./profiles/anna
            # ./profiles/adrian
            # ./profiles/tabea
          ];

        chnum = mkComputer
          ./desktops/chnum
          "x86_64-linux"
          [
            ./profiles/thomas
            # ./profiles/anna
            # ./profiles/adrian
            # ./profiles/tabea
          ];

        osiris = mkComputer
          ./desktops/osiris
          "x86_64-linux"
          [
            ./profiles/thomas
            # ./profiles/anna
            # ./profiles/adrian
            # ./profiles/tabea
          ];

        asgard = mkComputer
          ./servers/asgard
          "x86_64-linux"
          [
            ./profiles/thomas
            # ./profiles/anna
            # ./profiles/adrian
            # ./profiles/tabea
          ];

        utgard = mkComputer
          ./servers/utgard
          "x86_64-linux"
          [
            ./profiles/thomas
            # ./profiles/anna
            # ./profiles/adrian
            # ./profiles/tabea
          ];

        midgard = mkComputer
          ./servers/midgard
          "aarch64-linux"
          [
            hardware.nixosModules.raspberry-pi-4
            ./profiles/thomas
            # ./profiles/anna
            # ./profiles/adrian
            # ./profiles/tabea
          ];
      };

      anubis = self.nixosConfigurations.anubis.config.system.build.toplevel;
      chnum = self.nixosConfigurations.chnum.config.system.build.toplevel;
      osiris = self.nixosConfigurations.osiris.config.system.build.toplevel;

      asgard = self.nixosConfigurations.asgard.config.system.build.toplevel;
      utgard = self.nixosConfigurations.utgard.config.system.build.toplevel;
      midgard = self.nixosConfigurations.midgard.config.system.build.toplevel;
    } // utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            agenix.packages.${system}.default
            nixpkgs-fmt
            gnumake
            nixUnstable
          ];
        };
      }
    );
}
