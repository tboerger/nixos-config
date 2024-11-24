{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.gomplate;

in
{
  options = {
    profile = {
      programs = {
        gomplate = {
          enable = mkEnableOption "Gomplate";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        gomplate
      ];
    };
  };
}
