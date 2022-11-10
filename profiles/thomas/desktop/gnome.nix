{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.desktop.gnome;


in
{
  options = {
    profile = {
      desktop = {
        gnome = {
          enable = mkEnableOption "Gnome";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      udev = {
        packages = with pkgs; [
          gnome.gnome-settings-daemon
        ];
      };

      xserver = {
        displayManager = {
          gdm = {
            enable = true;
          };
        };

        desktopManager = {
          gnome = {
            enable = true;
          };
        };
      };

      gnome = {
        evolution-data-server = {
          enable = true;
        };

        gnome-online-accounts = {
          enable = true;
        };

        gnome-keyring = {
          enable = true;
        };
      };
    };

    environment = {
      systemPackages = with pkgs; [
        gnome.adwaita-icon-theme
        gnome.gnome-tweaks

        gnomeExtensions.calc
        gnomeExtensions.clipman
        gnomeExtensions.ddterm
        gnomeExtensions.docker
        gnomeExtensions.gsnap
        gnomeExtensions.gtile
        gnomeExtensions.keyman
        gnomeExtensions.vitals
        gnomeExtensions.weather
        gnomeExtensions.zilence
      ];

      gnome = {
        excludePackages = with pkgs; [
          gnome-tour

          gnome.atomix
          gnome.cheese
          gnome.epiphany
          gnome.geary
          gnome.gnome-music
          gnome.gnome-terminal
          gnome.hitori
          gnome.iagno
          gnome.tali
        ];
      };
    };
  };
}
