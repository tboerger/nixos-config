{ pkgs, lib, config, options, ... }:

let
  cfg = config.profile.programs.starship;

in
{
  options = with lib; {
    profile = {
      programs = {
        starship = {
          enable = mkEnableOption "Starship";
        };
      };
    };
  };

  config = with lib; mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
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
