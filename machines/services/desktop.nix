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
        element-desktop
        google-chrome
        lastpass-cli
        lens
        mattermost
        owncloud-client
        rambox
        rocketchat-desktop
        skypeforlinux
        slack
        steam
        tilda
        vscode
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
      light = {
        enable = true;
      };

      dconf = {
        enable = true;
      };
    };

    hardware = {
      bluetooth = {
        enable = true;
        package = pkgs.bluezFull;
      };

      pulseaudio = {
        enable = true;
        package = pkgs.pulseaudioFull;
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
        source-code-pr
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
            ];
          };
        };
      };
    };
  };
}
