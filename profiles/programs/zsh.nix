{ pkgs, lib, config, options, ... }:

let
  cfg = config.profile.programs.zsh;

in
{
  options = with lib; {
    profile = {
      programs = {
        zsh = {
          enable = mkEnableOption "Zsh";
        };
      };
    };
  };

  config = with lib; mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
          enableAutosuggestions = true;
          enableSyntaxHighlighting = true;

          history = {
            size = 10000000;
            save = 10000000;
            extended = true;
          };

          shellAliases = {
            ".." = "cd ..";
            "..." = "cd ../..";

            rgrep = "grep -Rn";
            hgrep = "fc -El 0 | grep";
            history = "fc -l 1";
            sha256sum = "shasum -a 256";
          };

          sessionVariables = {
            EDITOR = "vim";
            PAGER = "less";
            CLICOLOR = "1";
            GREP_COLOR = "1;33";
            IGNOREEOF = "1";
          };

          oh-my-zsh = {
            enable = true;

            plugins = [
              "systemd"
              "sudo"
              "history-substring-search"
              "encode64"
              "rsync"
              "tmux"
            ];
          };
        };
      };
    };
  };
}
