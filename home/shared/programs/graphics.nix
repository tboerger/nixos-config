{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.graphics;

in
{
  options = {
    profile = {
      programs = {
        graphics = {
          enable = mkEnableOption "Graphics";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        gimp
      ];
    };
  };
}
