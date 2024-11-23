{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.desktop;

in
{
  options = {
    personal = {
      services = {
        desktop = {
          enable = mkEnableOption "Desktop";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      pathsToLink = [
        "/libexec"
      ];

      gnome = {
        excludePackages = with pkgs; [
          gnome-tour
        ];
      };

      systemPackages = with pkgs; [
        gnome.adwaita-icon-theme
        gnome.eog
        gnome.geary
        gnome.gnome-tweaks
      ];
    };

    boot = {
      plymouth = {
        enable = true;
      };
    };

    security = {
      polkit = {
        enable = true;
      };
    };

    programs = {
      dconf = {
        enable = true;
      };

      evince = {
        enable = true;
      };

      geary = {
        enable = true;
      };

      light = {
        enable = true;
      };
    };

    hardware = {
      graphics = {
        enable = true;
      };

      bluetooth = {
        enable = true;
      };

      pulseaudio = {
        enable = true;
      };
    };

    sound = {
      enable = true;

      mediaKeys = {
        enable = true;
      };
    };

    powerManagement = {
      enable = true;
      cpuFreqGovernor = "powersave";
    };

    fonts = {
      enableDefaultPackages = true;

      fontDir = {
        enable = true;
      };

      packages = with pkgs; [
        corefonts
        fira-code
        font-awesome
        nerdfonts
        noto-fonts
        noto-fonts-emoji
        noto-fonts-extra
        roboto
      ];
    };

    services = {
      gnome = {
        core-utilities = {
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

      avahi = {
        enable = true;
        nssmdns4 = true;
      };

      fstrim = {
        enable = true;
      };

      fwupd = {
        enable = true;
      };

      thermald = {
        enable = true;
      };

      libinput = {
        enable = true;

        touchpad = {
          disableWhileTyping = false;
          tapping = true;
          tappingDragLock = false;
          middleEmulation = true;
          naturalScrolling = true;
          scrollMethod = "twofinger";
        };
      };

      xserver = {
        enable = true;
        autorun = true;

        xkb = {
          options = "eurosign:e";
          layout = "de";
        };

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
    };
  };
}
