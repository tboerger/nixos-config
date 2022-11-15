{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.coredns;

in
{
  options = {
    personal = {
      services = {
        coredns = {
          enable = mkEnableOption "CoreDNS";
        };
      };
    };
  };

  config = mkIf cfg.enable { };
}
