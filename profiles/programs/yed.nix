{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.yed;

in
{
  options = {
    profile = {
      programs = {
        yed = {
          enable = mkEnableOption "Yed";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        yed
      ];
    };
  };
}
