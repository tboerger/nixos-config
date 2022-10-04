{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.rocketchat;

in
{
  options = {
    profile = {
      programs = {
        rocketchat = {
          enable = mkEnableOption "RocketChat";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        rocketchat-desktop
      ];
    };
  };
}
