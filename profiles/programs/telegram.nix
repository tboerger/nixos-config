{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.telegram;

in
{
  options = {
    profile = {
      programs = {
        telegram = {
          enable = mkEnableOption "Telegram";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        tdesktop
      ];
    };
  };
}
