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
      docker = {
        enable = true;
      };
      samba = {
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
