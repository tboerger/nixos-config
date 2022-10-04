{ pkgs, lib, config, options, ... }:
with lib;

let
  username = "thomas";
  fullname = "Thomas Boerger";
  desktop = config.personal.services.desktop.enable;

in
{
  imports = [
    ../modules
    ./desktop

    ../programs
    ./programs

    ../services
    ./services
  ];

  profile = {
    username = "${username}";

    desktop = {
      i3 = {
        enable = desktop;
      };
    };

    programs = {
      authy = {
        enable = desktop;
      };
      browser = {
        enable = desktop;
      };
      clockify = {
        enable = desktop;
      };
      develop = {
        enable = desktop;
      };
      discord = {
        enable = desktop;
      };
      element = {
        enable = desktop;
      };
      gnupg = {
        enable = desktop;
      };
      golang = {
        enable = desktop;
      };
      kube = {
        enable = desktop;
      };
      lastpass = {
        enable = desktop;
      };
      latex = {
        enable = desktop;
      };
      lens = {
        enable = desktop;
      };
      lutris = {
        enable = desktop;
      };
      mattermost = {
        enable = desktop;
      };
      minecraft = {
        enable = desktop;
      };
      onepassword = {
        enable = desktop;
      };
      owncloud = {
        enable = desktop;
      };
      playonlinux = {
        enable = desktop;
      };
      rocketchat = {
        enable = desktop;
      };
      signal = {
        enable = desktop;
      };
      skype = {
        enable = desktop;
      };
      slack = {
        enable = desktop;
      };
      steam = {
        enable = desktop;
      };
      teams = {
        enable = desktop;
      };
      whatsapp = {
        enable = desktop;
      };
      wine = {
        enable = desktop;
      };
      yed = {
        enable = desktop;
      };
      zathura = {
        enable = desktop;
      };

      alacritty = {
        enable = desktop;
      };
      autorandr = {
        enable = desktop;
      };
      rofi = {
        enable = desktop;
      };
      ssh = {
        enable = desktop;
      };
      vscode = {
        enable = desktop;
      };
    };

    services = {
      blueman = {
        enable = desktop;
      };
      caffeine = {
        enable = desktop;
      };
      flameshot = {
        enable = desktop;
      };
      nmapplet = {
        enable = desktop;
      };
      owncloud = {
        enable = desktop;
      };
      udiskie = {
        enable = desktop;
      };

      dunst = {
        enable = desktop;
      };
      polybar = {
        enable = desktop;
      };
    };
  };

  users = {
    users = {
      "${username}" = {
        description = "${fullname}";
        shell = pkgs.zsh;
        isNormalUser = true;
        hashedPassword = "$6$yuwsoikF5utqohar$fdcvq0iXdmiioiRyBGeVZICzQm4nKlv6.pj9AWh13VRCsE07dN9StDnXV0aslIBb0SWRFC4dY5Um2MYiAMfmH0";
        openssh = {
          authorizedKeys = {
            keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINaQYR0/Oj6k1H03kshz2J7rlGCaDSuaGPhhOs9FcZfn thomas@osiris"
            ];
          };
        };
        extraGroups = [
          "wheel"
          "docker"
          "libvirtd"
          "audio"
          "video"
          "networkmanager"
        ];
      };
    };
  };

  home-manager.users."${username}" = { config, ... }: {
    home = {
      homeDirectory = "/home/${username}";
      sessionPath = [ "$HOME/.local/bin" ];

      file = {
        ".local/bin/git-gh-pages" = {
          executable = true;
          source = ./scripts/git-gh-pages.sh;
        };
        ".local/bin/git-promote" = {
          executable = true;
          source = ./scripts/git-promote.sh;
        };
        ".local/bin/search-and-replace" = {
          executable = true;
          source = ./scripts/search-and-replace.sh;
        };

        ".local/bin/each-dir" = {
          executable = true;
          source = ./scripts/each-dir.sh;
        };
      } // (if desktop then {
        ".local/bin/sort-requirements" = {
          executable = true;
          source = ./scripts/sort-requirements.rb;
        };

        ".wallpapers/dark.jpg" = {
          source = ./wallpapers/dark.jpg;
        };
        ".wallpapers/light.jpg" = {
          source = ./wallpapers/light.jpg;
        };
        ".wallpapers/tower.jpg" = {
          source = ./wallpapers/tower.jpg;
        };
      } else { });

      stateVersion = "18.09";
    };
  };
}
