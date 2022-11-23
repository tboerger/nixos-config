{ pkgs, lib, config, options, inputs, ... }:
with lib;
with inputs.homemanager.lib.hm.gvariant;

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
        gnomeExtensions.espresso
        gnomeExtensions.gsnap
        gnomeExtensions.gtile
        gnomeExtensions.keyman
        gnomeExtensions.vitals
      ];

      gnome = {
        excludePackages = with pkgs; [
          gnome-tour

          gnomeExtensions.applications-menu
          gnomeExtensions.launch-new-instance
          gnomeExtensions.places-status-indicator
          gnomeExtensions.screenshot-window-sizer
          gnomeExtensions.user-themes
          gnomeExtensions.weather
          gnomeExtensions.window-list
          gnomeExtensions.workspace-indicator
        ];
      };
    };

    home-manager.users."${config.profile.username}" = { config, ... }: {
      dconf = {
        settings = {
          "org/gnome/desktop/calendar" = {
            show-weekdate = true;
          };

          "org/gnome/desktop/input-sources" = {
            sources = [ (mkTuple [ "xkb" "de" ]) ];
            xkb-options = [ "eurosign:e" ];
          };

          "org/gnome/desktop/interface" = {
            clock-show-weekday = true;
            show-battery-percentage = true;
          };

          "org/gnome/desktop/peripherals/touchpad" = {
            tap-to-click = true;
            two-finger-scrolling-enabled = true;
          };

          "org/gnome/desktop/wm/preferences" = {
            button-layout = "appmenu:minimize,maximize,close";
          };

          "org/gnome/login-screen" = {
            disable-user-list = true;
          };

          "org/gnome/mutter" = {
            attach-modal-dialogs = true;
            dynamic-workspaces = true;
            edge-tiling = true;
            focus-change-on-pointer-rest = true;
            workspaces-only-on-primary = true;
          };

          "org/gnome/shell" = {
            enabled-extensions = [
              "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
              "calc@danigm.wadobo.com"
              "clipman@popov895.ukr.net"
              "drive-menu@gnome-shell-extensions.gcampax.github.com"
              "espresso@coadmunkee.github.com"
              "gSnap@micahosborne"
              "gTile@vibou"
              "keyman@dpoetzsch.github.com"
              "native-window-placement@gnome-shell-extensions.gcampax.github.com"
              "Vitals@CoreCoding.com"
              "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
            ];
          };

          "org/gnome/shell/extensions/espresso" = {
            has-battery = true;
          };

          "org/gnome/shell/extensions/vitals" = {
            show-fan = true;
            show-storage = false;
            show-temperature = true;
            show-voltage = true;
          };

          "org/gnome/tweaks" = {
            show-extensions-notice = false;
          };

          "system/locale" = {
            region = "de_DE.UTF-8";
          };
        };
      };
    };
  };
}
