{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.libvirt;

in
{
  options = {
    personal = {
      services = {
        libvirt = {
          enable = mkEnableOption "Libvirt";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
      };
    };
  };
}
