{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules
    ../services

    ./filesystems.nix
    ./boot.nix
    ./networking.nix
    ./hardware.nix
  ];

  personal = {
    services = {
      citrix = {
        enable = config.personal.services.enable;
      };
      desktop = {
        enable = config.personal.services.enable;
      };
      docker = {
        enable = config.personal.services.enable;
      };
      hacking = {
        enable = config.personal.services.enable;
      };
      libvirt = {
        enable = config.personal.services.enable;
      };
      tailscale = {
        enable = config.personal.services.enable;
      };
    };
  };

  system = {
    stateVersion = "21.11";
  };
}
