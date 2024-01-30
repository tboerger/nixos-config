{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.services.udiskie;

in
{
  options = {
    profile = {
      services = {
        udiskie = {
          enable = mkEnableOption "Udiskie";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      udiskie = {
        enable = true;
        automount = true;
        notify = true;
      };
    };
  };
}
