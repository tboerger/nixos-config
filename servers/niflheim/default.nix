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
      tailscale = {
        enable = config.personal.services.enable;
      };
    };
  };

  system = {
    stateVersion = "21.11";
  };
}
