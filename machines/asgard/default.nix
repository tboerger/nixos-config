{ config, lib, pkgs, ... }:

{
  imports = [
    ../../shared/modules
    ../../shared/programs
    ../../shared/services

    ./disko.nix
    ./boot.nix
    ./networking.nix
    ./hardware.nix
    ./extras.nix
  ];

  personal = {
    services = {
      shares = {
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
