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
      desktop = {
        enable = true;
      };
      develop = {
        enable = true;
      };
      docker = {
        enable = true;
      };
      kube = {
        enable = true;
      };
      libvirt = {
        enable = true;
      };
      minecraft = {
        enable = true;
      };
    };
  };

  system = {
    stateVersion = "21.11";
  };
}
