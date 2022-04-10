{ pkgs, lib, config, options, ... }:

let
  cfg = config.profile.programs.readline;

in
{
  options = with lib; {
    profile = {
      programs = {
        readline = {
          enable = mkEnableOption "Readline" // {
            default = true;
          };
        };
      };
    };
  };

  config = with lib; mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
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
