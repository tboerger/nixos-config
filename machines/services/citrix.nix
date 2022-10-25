{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.citrix;

in
{
  options = {
    personal = {
      services = {
        citrix = {
          enable = mkEnableOption "Citrix";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        citrix_workspace
      ];
    };
  };
}
