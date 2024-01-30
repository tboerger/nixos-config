{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.hass;

in
{
  options = {
    personal = {
      services = {
        hass = {
          enable = mkEnableOption "Home Assistant";
        };
      };
    };
  };

  config = mkIf cfg.enable { };
}
