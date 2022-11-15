{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.dst;

in
{
  options = {
    personal = {
      services = {
        dst = {
          enable = mkEnableOption "Don't Starve Together";
        };
      };
    };
  };

  config = mkIf cfg.enable { };
}
