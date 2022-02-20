{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules

    ./filesystems.nix
    ./boot.nix
    ./hardware.nix
    ./networking.nix
  ];

  system = {
    stateVersion = "21.11";
  };
}
