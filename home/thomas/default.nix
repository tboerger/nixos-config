{ pkgs, lib, config, options, desktopSystem, ... }:
with lib;

let
  username = "thomas";
  homeDirectory = "/home/thomas";
  desktop = desktopSystem;

in
{
  imports = [
    ../shared/global
    ../shared/modules
    ./desktop

    ../shared/programs
    ./programs

    ../shared/services
    ./services
  ];

  profile = {
    desktop = {
      sway = {
        enable = desktop;
      };
    };

    programs = {
      act = {
        enable = desktop;
      };
      authy = {
        enable = desktop;
      };
      banking = {
        enable = desktop;
      };
      clouds = {
        enable = desktop;
      };
      develop = {
        enable = desktop;
      };
      git = {
        enable = desktop;
      };
      github = {
        enable = desktop;
      };
      gnupg = {
        enable = desktop;
      };
      golang = {
        enable = desktop;
      };
      gopass = {
        enable = desktop;
      };
      helm = {
        enable = desktop;
      };
      joplin = {
        enable = desktop;
      };
      jsonnet = {
        enable = desktop;
      };
      kubectl = {
        enable = desktop;
      };
      kustomize = {
        enable = desktop;
      };
      latex = {
        enable = desktop;
      };
      lens = {
        enable = desktop;
      };
      messages = {
        enable = desktop;
      };
      minecraft = {
        enable = desktop;
      };
      minio = {
        enable = desktop;
      };
      netrc = {
        enable = desktop;
      };
      ngrok = {
        enable = desktop;
      };
      nodejs = {
        enable = desktop;
      };
      office = {
        enable = desktop;
      };
      shortwave = {
        enable = desktop;
      };
      ssh = {
        enable = desktop;
      };
      terminal = {
        enable = desktop;
      };
      terraform = {
        enable = desktop;
      };
      vscode = {
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

      jq = {
        enable = true;
      };
      network = {
        enable = true;
      };
      yq = {
        enable = true;
      };
    };

    services = {
      nextcloud = {
        enable = desktop;
      };
      udiskie = {
        enable = desktop;
      };
      syncthing = {
        enable = desktop;
      };
    };
  };

  home = {
    inherit username homeDirectory;

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
      ".local/bin/secrets-encrypt" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          for FOLDER in $(find . -iname secrets -type d); do
              for FILE in $(find $FOLDER -type f -iname \*.txt); do
                  echo "-> encrypting $FILE"
                  echo bin/vault encrypt $FILE
              done
          done
        '';
      };
      ".local/bin/secrets-decrypt" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          for FOLDER in $(find . -iname secrets -type d); do
              for FILE in $(find $FOLDER -type f -iname \*.txt); do
                  echo "-> decrypting $FILE"
                  echo bin/vault decrypt $FILE
              done
          done
        '';
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

    stateVersion = "23.11";
  };
}
