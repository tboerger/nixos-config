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
    nixpkgs = {
      config = {
        packageOverrides = pkgs: {
          polybar = pkgs.polybar.override {
            i3Support = true;
            mpdSupport = true;
            iwSupport = true;
            pulseSupport = true;
            githubSupport = true;
          };
        };
      };
    };

    environment = {
      systemPackages = with pkgs; [
        alacritty
        authy
        discord
        discord
        element-desktop
        element-desktop
        google-chrome
        lastpass-cli
        mattermost
        owncloud-client
        rambox
        rocketchat-desktop
        signal-desktop
        skypeforlinux
        slack
        steam
        teams
        whatsapp-for-linux
      ];

      pathsToLink = [
        "/libexec"
      ];
    };

    console = {
      font = "Lat2-Terminus16";
      keyMap = "de";
    };

    boot = {
      plymouth = {
        enable = false;
      };
    };

    programs = {
      _1password = {
        enable = true;
      };

      _1password-gui = {
        enable = true;
      };

      dconf = {
        enable = true;
      };

      light = {
        enable = true;
      };
    };

    hardware = {
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

      powertop = {
        enable = false;
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
      fstrim = {
        enable = true;
      };

      tlp = {
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
        };

        desktopManager = {
          xterm = {
            enable = false;
          };
        };

        displayManager = {
          defaultSession = "none+i3";

          lightdm = {
            enable = true;
          };
        };

        windowManager = {
          i3 = {
            enable = true;
            extraPackages = with pkgs; [
              lxappearance
              dmenu
              rofi
              i3lock
              polybar
              feh
              caffeine-ng
            ];
          };
        };
      };
    };
  };
}
