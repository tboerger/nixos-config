{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.thunderbird;

in
{
  options = {
    profile = {
      programs = {
        thunderbird = {
          enable = mkEnableOption "Thunderbird";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        thunderbird-bin
      ];
    };
  };
}
