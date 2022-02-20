{ pkgs, lib, config, options, ... }:

{
  options = with lib; {
    my = {
      modules = { };
    };
  };

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
