{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.nextcloud;

in
{
  options = {
    personal = {
      services = {
        nextcloud = {
          enable = mkEnableOption "Nextcloud";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.arion.projects.prometheus.settings = {
      imports = [
        (import ./arion.nix)
      ];
    };
  };
}
