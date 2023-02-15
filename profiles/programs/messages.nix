{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.messages;

in
{
  options = {
    profile = {
      programs = {
        messages = {
          enable = mkEnableOption "Messages";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        discord
        ferdium
        signal-desktop
        slack
        teams
      ];
    };
  };
}
