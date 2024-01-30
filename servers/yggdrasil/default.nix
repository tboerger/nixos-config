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
    ./extras.nix
  ];

  personal = {
    services = {
      homedns = {
        enable = config.personal.services.enable;
      };
      tailscale = {
        enable = config.personal.services.enable;
      };
    };
  };

  system = {
    stateVersion = "23.11";
  };
}
