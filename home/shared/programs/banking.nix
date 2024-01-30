{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.banking;

in
{
  options = {
    profile = {
      programs = {
        banking = {
          enable = mkEnableOption "Banking";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        homebank
      ];
    };
  };
}
