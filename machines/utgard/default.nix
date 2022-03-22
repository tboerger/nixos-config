{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules

    ./filesystems.nix
    ./boot.nix
    ./hardware.nix
    ./networking.nix
  ];

  my = {
    modules = {
      acme = {
        enable = true;
      };
    };
  };

  system = {
    stateVersion = "21.11";
  };
}
