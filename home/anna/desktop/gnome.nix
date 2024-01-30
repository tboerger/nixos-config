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
        gnome.adwaita-icon-theme
        gnomeExtensions.espresso
      ];
    };

    dconf = {
      settings = {
        "org/gnome/desktop/calendar" = {
          show-weekdate = true;
        };

        "org/gnome/desktop/input-sources" = {
          sources = [ (lib.hm.gvariant.mkTuple [ "xkb" "de" ]) ];
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

        "org/gnome/mutter" = {
          attach-modal-dialogs = true;
          dynamic-workspaces = true;
          edge-tiling = true;
          focus-change-on-pointer-rest = true;
          workspaces-only-on-primary = true;
        };

        "org/gnome/shell" = {
          enabled-extensions = [
            "espresso@coadmunkee.github.com"
          ];
        };

        "org/gnome/shell/extensions/espresso" = {
          has-battery = true;
        };

        "system/locale" = {
          region = "de_DE.UTF-8";
        };
      };
    };
  };
}
