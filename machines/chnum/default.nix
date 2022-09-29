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
        enable = true;
      };
      desktop = {
        enable = true;
      };
      docker = {
        enable = true;
      };
      libvirt = {
        enable = true;
      };
    };
  };

  system = {
    stateVersion = "21.11";
  };
}
