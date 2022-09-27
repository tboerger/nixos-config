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
    ../programs
    ../services
  ];

  profile = {
    username = "${username}";

    programs = {
      develop = {
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
      minecraft = {
        enable = desktop;
      };
    };

    services = { };
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
          "networkmanager"
          "docker"
          "libvirtd"
          "audio"
          "video"
        ];
      };
    };
  };

  home-manager.users."${username}" = { config, ... }: {
    home = {
      homeDirectory = "/home/${username}";

      sessionPath = ["$HOME/.local/bin"]
        ++ (optional desktop ["$HOME/.krew/bin" "$HOME/Golang/bin"]);

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
      } // (mkIf desktop {
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
      });

      stateVersion = "18.09";
    };

    programs = {
      alacritty = import ./programs/alacritty.nix { inherit pkgs config; } // {
        enable = mkForce desktop;
      };
      dircolors = import ./programs/dircolors.nix { inherit pkgs config; };
      git = import ./programs/git.nix { inherit pkgs config; };
      ssh = import ./programs/ssh.nix { inherit pkgs config; } // {
        enable = mkForce desktop;
      };
      starship = import ./programs/starship.nix { inherit pkgs config; };
      vscode = import ./programs/vscode.nix { inherit pkgs config; } // {
        enable = mkForce desktop;
      };
      zsh = import ./programs/zsh.nix { inherit pkgs config; };
    };
  };
}
