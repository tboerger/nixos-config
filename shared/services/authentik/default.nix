{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.authentik;

in
{
  options = {
    personal = {
      services = {
        authentik = {
          enable = mkEnableOption "Authentik";
        };
      };
    };
  };

  config = mkIf cfg.enable { };
}
