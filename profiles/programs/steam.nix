{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.steam;

in
{
  options = {
    profile = {
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
