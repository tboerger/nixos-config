{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.element;

in
{
  options = {
    profile = {
      programs = {
        element = {
          enable = mkEnableOption "Element";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        element-desktop
      ];
    };
  };
}
