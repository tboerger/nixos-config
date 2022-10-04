{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.discord;

in
{
  options = {
    profile = {
      programs = {
        discord = {
          enable = mkEnableOption "Discord";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        discord
      ];
    };
  };
}
