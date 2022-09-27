{ pkgs, lib, config, options, ... }:
with lib;

{
  imports = [
    ./frpc.nix
    ./network.nix
    ./prowlarr.nix
    ./shells.nix
    ./sudo.nix
    ./tools.nix
    ./users.nix
  ];

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };

    time = {
      timeZone = "Europe/Berlin";
    };

    i18n = {
      defaultLocale = "en_US.UTF-8";
    };
  };
}
