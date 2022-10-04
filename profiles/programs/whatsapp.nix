{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.whatsapp;

in
{
  options = {
    profile = {
      programs = {
        whatsapp = {
          enable = mkEnableOption "Whatsapp";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        whatsapp-for-linux
      ];
    };
  };
}
