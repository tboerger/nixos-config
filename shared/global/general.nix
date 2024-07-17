{ pkgs, lib, config, options, ... }:
with lib;

{
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

    console = {
      keyMap = "de";
    };
  };
}
