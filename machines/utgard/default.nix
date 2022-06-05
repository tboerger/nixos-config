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
        enable = true;
      };
      dyndns = {
        enable = true;
      };
      media = {
        enable = true;
      };
      unifi = {
        enable = true;
      };
    };
  };

  system = {
    stateVersion = "21.11";
  };
}
