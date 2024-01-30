{ pkgs, lib, config, options, desktopSystem, ... }:
with lib;

let
  username = "anna";
  homeDirectory = "/home/anna";
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
