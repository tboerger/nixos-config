{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.joplin;

in
{
  options = {
    profile = {
      programs = {
        joplin = {
          enable = mkEnableOption "Joplin";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        joplin-desktop
      ];
    };
  };
}
