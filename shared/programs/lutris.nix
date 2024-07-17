{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.programs.lutris;

in
{
  options = {
    personal = {
      programs = {
        lutris = {
          enable = mkEnableOption "Lutris";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        lutris
      ];
    };
  };
}
