{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.minecraft;

in
{
  options = {
    profile = {
      programs = {
        minecraft = {
          enable = mkEnableOption "Minecraft";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        mcrcon
        packwiz
        prismlauncher
      ];
    };
  };
}
