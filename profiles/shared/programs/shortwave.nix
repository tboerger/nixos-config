{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.shortwave;

in
{
  options = {
    profile = {
      programs = {
        shortwave = {
          enable = mkEnableOption "Shortwave";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        shortwave
      ];
    };
  };
}
