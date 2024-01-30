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

        gnomeExtensions.alphabetical-app-grid
        gnomeExtensions.app-icons-taskbar
        gnomeExtensions.auto-move-windows
        gnomeExtensions.calc
        gnomeExtensions.clipboard-indicator
        gnomeExtensions.custom-hot-corners-extended
        gnomeExtensions.espresso
        gnomeExtensions.gtile
        gnomeExtensions.removable-drive-menu
        gnomeExtensions.tailscale-status
        gnomeExtensions.tray-icons-reloaded
        gnomeExtensions.vitals

        # gnomeExtensions.appindicator
      ];
    };

    programs = { };

    services = { };

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

        "org/gnome/desktop/background" = {
          color-shading-type = "solid";
          picture-options = "zoom";
          picture-uri = "file://${config.home.homeDirectory}/.wallpapers/tower.jpg";
          picture-uri-dark = "file://${home.homedirectory}/.wallpapers/tower.jpg";
          show-desktop-icons = true;
        };

        "org/gnome/desktop/screensaver" = {
          color-shading-type = "solid";
          picture-options = "zoom";
          picture-uri = "file://${config.home.homeDirectory}/.wallpapers/tower.jpg";
          picture-uri-dark = "file://${home.homedirectory}/.wallpapers/tower.jpg";
          lock-delay = mkUint32 0;
        };

        "org/gnome/desktop/notifications" = {
          show-in-lock-screen = false;
        };

        "org/gnome/desktop/privacy" = {
          old-files-age = mkUint32 1;
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

          enabled-extensions = with pkgs; [
            gnomeExtensions.alphabetical-app-grid.uuid # AlphabeticalAppGrid@stuarthayhurst
            gnomeExtensions.app-icons-taskbar.uuid # "aztaskbar@aztaskbar.gitlab.com"
            gnomeExtensions.auto-move-windows.uuid # "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
            gnomeExtensions.calc.uuid # "calc@danigm.wadobo.com"
            gnomeExtensions.clipboard-indicator # "clipboard-indicator@tudmotu.com"
            gnomeExtensions.custom-hot-corners-extended.uuid # "custom-hot-corners-extended@G-dH.github.com"
            gnomeExtensions.espresso.uuid # "espresso@coadmunkee.github.com"
            gnomeExtensions.gtile.uuid # "gTile@vibou"
            gnomeExtensions.removable-drive-menu.uuid # "drive-menu@gnome-shell-extensions.gcampax.github.com"
            gnomeExtensions.tailscale-status.uuid # "tailscale-status@maxgallup.github.com"
            gnomeExtensions.tray-icons-reloaded.uuid # "trayIconsReloaded@selfmade.pl"
            gnomeExtensions.vitals # "Vitals@CoreCoding.com"

            # gnomeExtensions.appindicator.uuid # "appindicatorsupport@rgcjonas.gmail.com"
          ];
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

        "org/gnome/shell/extensions/aztaskbar" = {
          main-panel-height = (lib.hm.gvariant.mkTuple [ true 40 ]);
          show-apps-button = (lib.hm.gvariant.mkTuple [ true 0 ]);
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

        "system/locale" = {
          region = "de_DE.UTF-8";
        };
      };
    };
  };
}
