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
    };

    boot = {
      plymouth = {
        enable = true;
      };
    };

    programs = {
      dconf = {
        enable = true;
      };

      light = {
        enable = true;
      };
    };

    hardware = {
      opengl = {
        enable = true;
      };

      bluetooth = {
        enable = true;
        package = pkgs.bluez;
      };

      pulseaudio = {
        enable = true;
        package = pkgs.pulseaudio;
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

      powertop = {
        enable = true;
      };
    };

    fonts = {
      enableDefaultFonts = true;

      fontDir = {
        enable = true;
      };

      fonts = with pkgs; [
        corefonts
        fira-code
        font-awesome
        nerdfonts
        noto-fonts
        noto-fonts-emoji
        noto-fonts-extra
        roboto
        siji
        source-code-pro
      ];
    };

    services = {
      avahi = {
        enable = true;
        nssmdns = true;
      };

      blueman = {
        enable = true;
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

      printing = {
        enable = true;
      };

      logind = {
        lidSwitch = "suspend";
        extraConfig = "IdleAction=lock";
      };

      xserver = {
        enable = true;
        autorun = true;
        layout = "de";
        xkbOptions = "eurosign:e";

        libinput = {
          enable = true;

          touchpad = {
            disableWhileTyping = true;
            tapping = true;
            tappingDragLock = false;
            middleEmulation = true;
            naturalScrolling = true;
            scrollMethod = "twofinger";
          };
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
