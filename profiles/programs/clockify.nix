{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.clockify;

in
{
  options = {
    profile = {
      programs = {
        clockify = {
          enable = mkEnableOption "Clockify";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        clockify
      ];
    };
  };
}
