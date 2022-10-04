{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.slack;

in
{
  options = {
    profile = {
      programs = {
        slack = {
          enable = mkEnableOption "Slack";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        slack
      ];
    };
  };
}
