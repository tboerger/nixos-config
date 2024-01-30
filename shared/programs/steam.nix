{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.programs.steam;

in
{
  options = {
    personal = {
      programs = {
        steam = {
          enable = mkEnableOption "Steam";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
      };
    };
  };
}
