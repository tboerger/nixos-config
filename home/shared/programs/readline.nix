{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.readline;

in
{
  options = {
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

  config = mkIf cfg.enable {
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
}
