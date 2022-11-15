{ config, lib, pkgs, ... }:

{
  imports = [
    ../../shared/modules
    ../../shared/programs
    ../../shared/services

    ./filesystems.nix
    ./boot.nix
    ./networking.nix
    ./hardware.nix
  ];

  personal = {
    services = {
      authentik = {
        enable = config.personal.services.enable;
      };
      dst = {
        enable = config.personal.services.enable;
      };
      mediang = {
        enable = config.personal.services.enable;
      };
      minecraft = {
        enable = config.personal.services.enable;
      };
      owncloud = {
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
