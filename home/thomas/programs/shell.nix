{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.shell;

in
{
  options = {
    profile = {
      programs = {
        shell = {
          enable = mkEnableOption "Shell" // {
            default = true;
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";

        netstat = "sudo netstat -tulpen";

        rgrep = "grep -Rn";
        hgrep = "fc -El 0 | grep";
        history = "fc -l 1";
        sha256sum = "shasum -a 256";
      };
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
        enableAutosuggestions = true;

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
  };
}
