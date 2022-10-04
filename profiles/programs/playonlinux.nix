{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.playonlinux;

in
{
  options = {
    profile = {
      programs = {
        playonlinux = {
          enable = mkEnableOption "Playonlinux";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        playonlinux
      ];
    };
  };
}
