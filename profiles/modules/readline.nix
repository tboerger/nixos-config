{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.readline;

in

{
  options = with lib; {
    my = {
      modules = {
        readline = {
          enable = mkEnableOption ''
            Whether to enable readline module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      home-manager.users."${config.my.username}" = { config, ... }: {
        programs = {
          readline = {
            enable = true;

            bindings = {
              "\e[5~" = "history-search-backward";
              "\e[6~" = "history-search-forward";
            };
          };
        };
      };
    };
}
