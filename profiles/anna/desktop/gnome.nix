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
    home = {
      packages = with pkgs; [
        xclip
        gnome.adwaita-icon-theme

        gnomeExtensions.alphabetical-app-grid
        gnomeExtensions.calc
        gnomeExtensions.custom-hot-corners-extended
        gnomeExtensions.espresso
        gnomeExtensions.vitals
      ];
    };

    dconf = {
      settings = {
        "org/gnome/desktop/input-sources" = {
          sources = [ (lib.hm.gvariant.mkTuple [ "xkb" "de" ]) ];
          xkb-options = [ "eurosign:e" ];
        };

        "org/gnome/desktop/calendar" = {
          show-weekdate = true;
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

        "org/gnome/desktop/notifications" = {
          show-in-lock-screen = false;
        };

        "org/gnome/desktop/privacy" = {
          old-files-age = lib.hm.gvariant.mkUint32 1;
          remember-recent-files = false;
          remove-old-temp-files = true;
          remove-old-trash-files = true;
          report-technical-problems = false;
        };

        "org/gnome/settings-daemon/peripherals/touchpad" = {
          natural-scroll = true;
          disable-while-typing = false;
          tap-to-click = true;
          touchpad-enabled = true;
        };

        "org/gnome/mutter" = {
          attach-modal-dialogs = true;
          dynamic-workspaces = true;
          edge-tiling = true;
          focus-change-on-pointer-rest = true;
          workspaces-only-on-primary = true;
        };

        "org/gnome/shell" = {
          favorite-apps = [
            "org.gnome.Calendar.desktop"
            "org.gnome.Nautilus.desktop"
          ];

          enabled-extensions = [
            "AlphabeticalAppGrid@stuarthayhurst"
            "calc@danigm.wadobo.com"
            "custom-hot-corners-extended@G-dH.github.com"
            "espresso@coadmunkee.github.com"
            "Vitals@CoreCoding.com"
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

        "org/gnome/shell/weather" = {
          automatic-location = true;
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/misc" = {
          show-osd-monitor-indexes = false;
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-bottom-left-0" = {
          action = "show-desktop";
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-bottom-right-0" = {
          action = "show-desktop";
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-left-0" = {
          action = "toggle-overview";
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-right-0" = {
          action = "toggle-overview";
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-1-bottom-left-0" = {
          action = "show-desktop";
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-1-bottom-right-0" = {
          action = "show-desktop";
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-1-top-left-0" = {
          action = "toggle-overview";
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-1-top-right-0" = {
          action = "toggle-overview";
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-2-bottom-left-0" = {
          action = "show-desktop";
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-2-bottom-right-0" = {
          action = "show-desktop";
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-2-top-left-0" = {
          action = "toggle-overview";
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-2-top-right-0" = {
          action = "toggle-overview";
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-3-bottom-left-0" = {
          action = "show-desktop";
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-3-bottom-right-0" = {
          action = "show-desktop";
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-3-top-left-0" = {
          action = "toggle-overview";
        };

        "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-3-top-right-0" = {
          action = "toggle-overview";
        };

        "system/locale" = {
          region = "de_DE.UTF-8";
        };
      };
    };
  };
}
