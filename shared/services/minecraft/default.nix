{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.minecraft;

in
{
  options = {
    personal = {
      services = {
        minecraft = {
          enable = mkEnableOption "Minecraft";
        };
      };
    };
  };

  config = mkIf cfg.enable { };
}
