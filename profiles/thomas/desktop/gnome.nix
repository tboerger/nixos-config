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
        xclip

        gnomeExtensions.app-icons-taskbar
        gnomeExtensions.appindicator
        gnomeExtensions.calc
        gnomeExtensions.custom-hot-corners-extended
        gnomeExtensions.espresso
        gnomeExtensions.gtile
        gnomeExtensions.vitals
      ];

      gnome = {
        excludePackages = with pkgs; [
          gnome-tour
        ];
      };
    };

    home-manager.users."${config.profile.username}" = { config, ... }: {
      services = {
        mpris-proxy = {
          enable = true;
        };
      };

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

          "org/gnome/mutter" = {
            attach-modal-dialogs = true;
            dynamic-workspaces = true;
            edge-tiling = true;
            focus-change-on-pointer-rest = true;
            workspaces-only-on-primary = true;
          };

          "org/gnome/shell" = {
            enabled-extensions = [
              "appindicatorsupport@rgcjonas.gmail.com"
              "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
              "aztaskbar@aztaskbar.gitlab.com"
              "calc@danigm.wadobo.com"
              "custom-hot-corners-extended@G-dH.github.com"
              "drive-menu@gnome-shell-extensions.gcampax.github.com"
              "espresso@coadmunkee.github.com"
              "gTile@vibou"
              "native-window-placement@gnome-shell-extensions.gcampax.github.com"
              "Vitals@CoreCoding.com"
              "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
            ];
          };

          "org/gnome/shell/extensions/custom-hot-corners-extended/misc" = {
            show-osd-monitor-indexes = false;
          };

          "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-bottom-left-6" = {
            ctrl = true;
          };

          "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-bottom-right-6" = {
            ctrl = true;
          };

          "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-left-0" = {
            action = "toggle-overview";
          };

          "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-left-6" = {
            ctrl = true;
          };

          "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-right-0" = {
            action = "toggle-overview";
          };

          "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-right-6" = {
            ctrl = true;
          };

          "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-1-top-left-0" = {
            action = "toggle-overview";
          };

          "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-1-top-left-6" = {
            ctrl = true;
          };

          "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-1-top-right-0" = {
            action = "toggle-overview";
          };

          "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-1-top-right-6" = {
            ctrl = true;
          };

          "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-2-top-left-0" = {
            action = "toggle-overview";
          };

          "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-2-top-left-6" = {
            ctrl = true;
          };

          "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-2-top-right-0" = {
            action = "toggle-overview";
          };

          "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-2-top-right-6" = {
            ctrl = true;
          };

          "org/gnome/shell/extensions/auto-move-windows" = {
            application-list = [
              # "org.gnome.Console.desktop:1"
              # "google-chrome.desktop:2"
              # "Mailspring.desktop:3"
              # "com.yktoo.ymuse.desktop:4"
              # "discord.desktop:5"
              # "element-desktop.desktop:5"
              # "Mattermost.desktop:5"
              # "rocketchat-desktop.desktop:5"
              # "signal-desktop.desktop:5"
              # "skypeforlinux.desktop:5"
              # "slack.desktop:5"
              # "teams.desktop:5"
              # "telegramdesktop.desktop:5"
              # "whatsapp-for-linux.desktop:5"
            ];
          };

          "org/gnome/shell/extensions/aztaskbar" = {
            main-panel-height = (mkTuple [ true 40 ]);
            show-apps-button = (mkTuple [ true 0 ]);
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

          "org/gnome/tweaks" = {
            show-extensions-notice = false;
          };

          "system/locale" = {
            region = "de_DE.UTF-8";
          };
        };
      };

      systemd = {
        user = {
          targets = {
            "tray" = {
              Unit = {
                Description = "Tray target";
                BindsTo = ["gnome-session.target"];
              };
              Install = {
                WantedBy = ["gnome-session.target"];
              };
            };
          };
        };
      };
    };
  };
}
