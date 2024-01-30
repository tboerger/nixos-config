{ pkgs, lib, config, options, desktopSystem, ... }:
with lib;

let
  username = "tabea";
  homeDirectory = "/home/tabea";
  desktop = desktopSystem;

in
{
  imports = [
    ../shared/global
    ../shared/modules
    ./desktop

    ../shared/programs
    ./programs

    ../shared/services
    ./services
  ];

  profile = {
    desktop = {
      gnome = {
        enable = desktop;
      };
    };

    programs = {
      minecraft = {
        enable = desktop;
      };
      wine = {
        enable = desktop;
      };
      zathura = {
        enable = desktop;
      };
    };

    services = {
      nextcloud = {
        enable = desktop;
      };
    };
  };

  home = {
    inherit username homeDirectory;

    sessionVariables = {
      LC_ALL = "de_DE.UTF-8";
    };

    file = { } // (if desktop then {
      ".face" = {
        source = ./face.jpg;
      };
    } else { });

    stateVersion = "23.11";
  };
}
