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
    home-manager.users."${config.profile.username}" = { config, ... }: {
      services = {
        nextcloud-client = {
          enable = true;
        };
      };
    };
  };
}
