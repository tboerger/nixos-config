{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.lutris;

in
{
  options = {
    profile = {
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

    hardware = {
      opengl = {
        driSupport32Bit = true;
      };
    };
  };
}
