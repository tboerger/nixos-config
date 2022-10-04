{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.services.nmapplet;

in
{
  options = {
    profile = {
      services = {
        nmapplet = {
          enable = mkEnableOption "Network Manager Applet";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      services = {
        network-manager-applet = {
          enable = true;
        };
      };
    };
  };
}
