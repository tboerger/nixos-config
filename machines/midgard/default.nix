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
      acme = {
        enable = config.personal.services.enable;
      };
      adguard = {
        enable = config.personal.services.enable;
      };
      coredns = {
        enable = config.personal.services.enable;
      };
      docker = {
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
