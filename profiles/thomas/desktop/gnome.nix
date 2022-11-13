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
        core-utilities = {
          enable = true;
        };

        evolution-data-server = {
          enable = true;
        };

        gnome-keyring = {
          enable = true;
        };

        gnome-online-accounts = {
          enable = true;
        };

        gnome-remote-desktop = {
          enable = true;
        };

        gnome-settings-daemon = {
          enable = true;
        };

        sushi = {
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
        gnomeExtensions.espresso
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
        ];
      };
    };
  };
}
