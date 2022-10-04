{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.wine;

in
{
  options = {
    profile = {
      programs = {
        wine = {
          enable = mkEnableOption "Wine";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        winetricks
        wineWowPackages.full
      ];
    };
  };
}
