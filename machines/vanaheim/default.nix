{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules
    ../services

    ./filesystems.nix
    ./boot.nix
    ./networking.nix
  ];

  powerManagement = {
    enable = lib.mkDefault false;
  };

  personal = {
    services = {

    };
  };

  system = {
    stateVersion = "21.11";
  };
}
