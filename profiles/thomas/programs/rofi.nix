{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.rofi;

in
{
  options = {
    profile = {
      programs = {
        rofi = {
          enable = mkEnableOption "Rofi";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      programs = {
        rofi = {
          enable = true;

          font = "DejaVu Sans Mono 14";
          terminal = "alacritty";
          theme = "solarized";

          plugins = [
            pkgs.rofi-calc
            pkgs.rofi-file-browser
            pkgs.rofi-mpd
            pkgs.rofi-power-menu
            pkgs.rofi-pulse-select
            pkgs.rofi-systemd
            pkgs.rofi-vpn
          ];

          extraConfig = {
            modi = "window,drun,ssh";
          };
        };
      };
    };
  };
}
