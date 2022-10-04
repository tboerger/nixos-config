{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.services.blueman;

in
{
  options = {
    profile = {
      services = {
        blueman = {
          enable = mkEnableOption "Blueman";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      services = {
        blueman-applet = {
          enable = true;
        };
      };
    };
  };
}
