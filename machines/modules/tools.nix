{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.tools;
in

{
  options = with lib; {
    my = {
      modules = {
        tools = {
          enable = mkEnableOption ''
            Whether to enable tools module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      environment = {
        systemPackages = with pkgs; [
          coreutils
          htop
          jq
          nmap
          rsync
          tmux
          tree
          vim
          wget
          yq
        ];
      };
    };
}
