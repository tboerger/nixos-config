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
    username = username;

    desktop = {
      gnome = {
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
      clickup = {
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
      joplin = {
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
      mail = {
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
      telegram = {
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

      autorandr = {
        enable = desktop;
      };
      hacking = {
        enable = desktop;
      };
      ghtoken = {
        enable = desktop;
      };
      kustomize = {
        enable = desktop;
      };
      minio = {
        enable = desktop;
      };
      netrc = {
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
      mopidy = {
        enable = desktop;
      };
      nextcloud = {
        enable = desktop;
      };
      udiskie = {
        enable = desktop;
      };

      tailscale = {
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
        passwordFile = config.age.secrets."users/${username}/password".path;
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

      sessionVariables = {
        LC_ALL = "en_US.UTF-8";
      };

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

        ".face" = {
          source = ./face.jpg;
        };
      } else { });

      stateVersion = "22.11";
    };
  };

  age.secrets."users/${username}/password" = {
    file = ../../secrets/users/${username}/password.age;
  };
}
