{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.services.flameshot;

in
{
  options = {
    profile = {
      services = {
        flameshot = {
          enable = mkEnableOption "Flameshot";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      services = {
        flameshot = {
          enable = true;
        };
      };
    };
  };
}
