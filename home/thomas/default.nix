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
      gnome = {
        enable = desktop;
      };
    };

    programs = {
      act = {
        enable = desktop;
      };
      banking = {
        enable = desktop;
      };
      citrix = {
        enable = desktop;
      };
      clouds = {
        enable = desktop;
      };
      develop = {
        enable = desktop;
      };
      gnupg = {
        enable = desktop;
      };
      golang = {
        enable = desktop;
      };
      gomplate = {
        enable = desktop;
      };
      graphics = {
        enable = desktop;
      };
      helm = {
        enable = desktop;
      };
      joplin = {
        enable = desktop;
      };
      jq = {
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
      network = {
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
      streaming = {
        enable = desktop;
      };
      terminal = {
        enable = desktop;
      };
      terraform = {
        enable = desktop;
      };
      wine = {
        enable = desktop;
      };
      yq = {
        enable = desktop;
      };
      zathura = {
        enable = desktop;
      };

      autorandr = {
        enable = desktop;
      };
      git = {
        enable = desktop;
      };
      github = {
        enable = desktop;
      };
      gopass = {
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
      nextcloud = {
        enable = desktop;
      };
      syncthing = {
        enable = desktop;
      };
      udiskie = {
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

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";

      netstat = "sudo netstat -tulpen";

      rgrep = "grep -Rn";
      hgrep = "fc -El 0 | grep";
      history = "fc -l 1";
      sha256sum = "shasum -a 256";

      # molecule = "docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):$(pwd) -w $(pwd) toolhippie/molecule:latest molecule";
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

  programs = {
    bash = {
      enable = true;
      enableCompletion = true;

      profileExtra = ''
        [ -r ~/.nix-profile/etc/profile.d/nix.sh ] && source  ~/.nix-profile/etc/profile.d/nix.sh
      '';

      logoutExtra = ''

      '';

      sessionVariables = {
        EDITOR = "vim";
        PAGER = "less";
        CLICOLOR = "1";
        GREP_COLOR = "mt=1;33";
        IGNOREEOF = "1";
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;

      autosuggestion = {
        enable = true;
      };

      syntaxHighlighting = {
        enable = true;
      };

      profileExtra = ''
        [ -r ~/.nix-profile/etc/profile.d/nix.sh ] && source  ~/.nix-profile/etc/profile.d/nix.sh
      '';

      history = {
        size = 10000000;
        save = 10000000;
        extended = true;
        path = "${config.home.homeDirectory}/.zhistory";
      };

      sessionVariables = {
        EDITOR = "vim";
        PAGER = "less";
        CLICOLOR = "1";
        GREP_COLOR = "mt=1;33";
        IGNOREEOF = "1";
      };

      oh-my-zsh = {
        enable = true;
        custom = "${pkgs.zcustom}";
        theme = "tboerger";

        plugins = [
          "direnv"
          "encode64"
          "git-prompt"
          "history-substring-search"
          "kube-ps1"
          "rsync"
          "sudo"
          "systemd"
          "tfenv"
          "tmux"
          "transfer"
        ];
      };
    };
  };
}
