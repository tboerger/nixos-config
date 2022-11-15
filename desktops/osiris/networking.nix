{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "osiris";

    networkmanager = {
      enable = true;
    };
  };
}
