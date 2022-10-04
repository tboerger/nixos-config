{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.services.caffeine;

in
{
  options = {
    profile = {
      services = {
        caffeine = {
          enable = mkEnableOption "Caffeine";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      services = {
        caffeine = {
          enable = true;
        };
      };
    };
  };
}
