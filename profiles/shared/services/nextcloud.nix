{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.services.nextcloud;

in
{
  options = {
    profile = {
      services = {
        nextcloud = {
          enable = mkEnableOption "Nextcloud";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      nextcloud-client = {
        enable = true;
        startInBackground = true;
      };
    };
  };
}
