{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.zsh;

in

{
  options = with lib; {
    my = {
      modules = {
        zsh = {
          enable = mkEnableOption ''
            Whether to enable zsh module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      home-manager.users."${config.my.username}" = { config, ... }: {
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
