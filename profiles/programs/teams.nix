{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.teams;

in
{
  options = {
    profile = {
      programs = {
        teams = {
          enable = mkEnableOption "Teams";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        teams
      ];
    };
  };
}
