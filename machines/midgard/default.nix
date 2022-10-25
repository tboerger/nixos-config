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
      adguard = {
        enable = true;
      };
      coredns = {
        enable = true;
      };
      docker = {
        enable = true;
      };
      tailscale = {
        enable = true;
      };
    };
  };

  system = {
    stateVersion = "21.11";
  };
}
