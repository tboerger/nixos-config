{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.starship;

in

{
  options = with lib; {
    my = {
      modules = {
        starship = {
          enable = mkEnableOption ''
            Whether to enable starship module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      home-manager.users."${config.my.username}" = { config, ... }: {
        programs = {
          starship = {
            enable = true;

            settings = {
              add_newline = true;
              battery = {
                disabled = true;
              };
              directory = {
                truncation_length = 5;
                truncate_to_repo = false;
                truncation_symbol = "…/";
              };
            };
          };
        };
      };
    };
}
