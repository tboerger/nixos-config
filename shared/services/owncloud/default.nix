{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.owncloud;

in
{
  options = {
    personal = {
      services = {
        owncloud = {
          enable = mkEnableOption "ownCloud";
        };
      };
    };
  };

  config = mkIf cfg.enable { };
}
