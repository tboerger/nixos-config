{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./heimdall.nix
    ./network.nix
    ./shells.nix
    ./tools.nix
    ./users.nix
    ./prowlarr.nix
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

    hardware = {
      enableAllFirmware = true;
      enableRedistributableFirmware = true;
    };

    security = {
      sudo = {
        wheelNeedsPassword = false;
      };
    };
  };
}
