{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.services.syncthing;

in
{
  options = {
    profile = {
      services = {
        syncthing = {
          enable = mkEnableOption "Syncthing";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      syncthing = {
        enable = true;
      };
    };
  };
}
